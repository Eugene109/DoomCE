#include <graphx.h>

#include "fixed.h"

#ifdef __cplusplus
extern "C" {
#endif

struct HitInfo {
    int distX;
    int distY;
    char wallType;
};

void raycast_asm(fixed playerX, fixed playerY, fixed rayX, fixed rayY, int *distX, int *distY, uint8_t *texCoord,
                 char *texType, void *x_walls_ptr);

void x_walls();
void y_walls();
void y_walls_transposed();
void x_walls_transposed();
void x_walls_q2();
void y_walls_q2();
void y_walls_transposed_q2();
void x_walls_transposed_q2();
void x_walls_q3();
void y_walls_q3();
void y_walls_transposed_q3();
void x_walls_transposed_q3();
void x_walls_q4();
void y_walls_q4();
void y_walls_transposed_q4();
void x_walls_transposed_q4();

const int MAP_SIZE = 16;

void raycast(fixed playerX, fixed playerY, fixed rayX, fixed rayY, int *distX, int *distY, uint8_t *texCoord,
             char *texType) {
    if (rayY > 0) {
        if (rayX > 0) {
            if (rayX > rayY) {
                raycast_asm(playerX, playerY, rayX, rayY, distX, distY, texCoord, texType, (void *)&x_walls);
            } else {
                raycast_asm(playerY, playerX, rayY, rayX, distY, distX, texCoord, texType, (void *)&y_walls_transposed);
            }
        } else {
            if (-1 * rayX > rayY) {
                raycast_asm((MAP_SIZE * 256) - playerX, playerY, -1 * (rayX), rayY, distX, distY, texCoord, texType,
                            (void *)&x_walls_q2);
            } else {
                raycast_asm(playerY, (MAP_SIZE * 256) - playerX, rayY, -1 * (rayX), distY, distX, texCoord, texType,
                            (void *)&y_walls_transposed_q2);
            }
            *distX = (*distX) * -1;
            *texCoord = (*texCoord) * -1;
        }
    } else {
        if (rayX > 0) {
            if (rayX > -1 * rayY) {
                raycast_asm(playerX, (MAP_SIZE * 256) - playerY, rayX, -1 * (rayY), distX, distY, texCoord, texType,
                            (void *)&x_walls_q4);
            } else {
                raycast_asm((MAP_SIZE * 256) - playerY, playerX, -1 * (rayY), rayX, distY, distX, texCoord, texType,
                            (void *)&y_walls_transposed_q4);
            }
            *texCoord = (*texCoord) * -1;
        } else {
            if (rayX < rayY) { // -x>-y
                raycast_asm((MAP_SIZE * 256) - playerX, (MAP_SIZE * 256) - playerY, -1 * (rayX), -1 * (rayY), distX,
                            distY, texCoord, texType, (void *)&x_walls_q3);
            } else {
                raycast_asm((MAP_SIZE * 256) - playerY, (MAP_SIZE * 256) - playerX, -1 * (rayY), -1 * (rayX), distY,
                            distX, texCoord, texType, (void *)&y_walls_transposed_q3);
            }
            *distX = (*distX) * -1;
        }
        *distY = (*distY) * -1;
    }
}

#ifdef __cplusplus
};
#endif