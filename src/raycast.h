#ifndef RAYCAST_H
#define RAYCAST_H

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
                 uint8_t *texType, void *x_walls_ptr, int flipTexCoord);

void x_walls_q1();
void y_walls_q1();
void y_walls_transposed_q1();
void x_walls_transposed_q1();
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

void door_states();

void set_door_state(char name, int state);

const int MAP_SIZE = 16;

void raycast(fixed playerX, fixed playerY, fixed rayX, fixed rayY, int *distX, int *distY, uint8_t *texCoord,
             uint8_t *texType) {
    if (rayY > 0) {
        if (rayX > 0) {
            if (rayX > rayY) {
                raycast_asm(playerX, playerY, rayX, rayY, distX, distY, texCoord, texType, (void *)&x_walls_q1, false);
            } else {
                raycast_asm(playerY, playerX, rayY, rayX, distY, distX, texCoord, texType,
                            (void *)&y_walls_transposed_q1, false);
            }
        } else {
            if (-1 * rayX > rayY) {
                raycast_asm((MAP_SIZE << SHIFT) - playerX, playerY, -1 * (rayX), rayY, distX, distY, texCoord, texType,
                            (void *)&x_walls_q2, true);
            } else {
                raycast_asm(playerY, (MAP_SIZE << SHIFT) - playerX, rayY, -1 * (rayX), distY, distX, texCoord, texType,
                            (void *)&y_walls_transposed_q2, true);
            }
            *distX = (*distX) * -1;
            // *texCoord = (*texCoord) * -1;
        }
    } else {
        if (rayX > 0) {
            if (rayX > -1 * rayY) {
                raycast_asm(playerX, (MAP_SIZE << SHIFT) - playerY, rayX, -1 * (rayY), distX, distY, texCoord, texType,
                            (void *)&x_walls_q4, true);
            } else {
                raycast_asm((MAP_SIZE << SHIFT) - playerY, playerX, -1 * (rayY), rayX, distY, distX, texCoord, texType,
                            (void *)&y_walls_transposed_q4, true);
            }
            // *texCoord = (*texCoord) * -1;
        } else {
            if (rayX < rayY) { // -x>-y
                raycast_asm((MAP_SIZE << SHIFT) - playerX, (MAP_SIZE << SHIFT) - playerY, -1 * (rayX), -1 * (rayY),
                            distX, distY, texCoord, texType, (void *)&x_walls_q3, false);
            } else {
                raycast_asm((MAP_SIZE << SHIFT) - playerY, (MAP_SIZE << SHIFT) - playerX, -1 * (rayY), -1 * (rayX),
                            distY, distX, texCoord, texType, (void *)&y_walls_transposed_q3, false);
            }
            *distX = (*distX) * -1;
        }
        *distY = (*distY) * -1;
    }
}

#ifdef __cplusplus
};
#endif

#endif