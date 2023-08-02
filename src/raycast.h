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

void raycast(fixed playerX, fixed playerY, fixed rayX, fixed rayY, int *distX, int *distY, uint8_t *texCoord,
             char *texType);
void raycast_q1_xy(fixed playerX, fixed playerY, fixed rayX, fixed rayY, int *distX, int *distY, uint8_t *texCoord,
                   char *texType);
void raycast_q1_yx(fixed playerX, fixed playerY, fixed rayX, fixed rayY, int *distX, int *distY, uint8_t *texCoord,
                   char *texType);

void raycast_q2_xy(fixed playerX, fixed playerY, fixed rayX, fixed rayY, int *distX, int *distY, uint8_t *texCoord,
                   char *texType); // dx & dy are absolute value
void raycast_q2_yx(fixed playerX, fixed playerY, fixed rayX, fixed rayY, int *distX, int *distY, uint8_t *texCoord,
                   char *texType); // dx & dy are absolute value

void raycast_q3_xy(fixed playerX, fixed playerY, fixed rayX, fixed rayY, int *distX, int *distY, uint8_t *texCoord,
                   char *texType); // dx & dy are absolute value
void raycast_q3_yx(fixed playerX, fixed playerY, fixed rayX, fixed rayY, int *distX, int *distY, uint8_t *texCoord,
                   char *texType); // dx & dy are absolute value

void raycast_q4_xy(fixed playerX, fixed playerY, fixed rayX, fixed rayY, int *distX, int *distY, uint8_t *texCoord,
                   char *texType); // dx & dy are absolute value
void raycast_q4_yx(fixed playerX, fixed playerY, fixed rayX, fixed rayY, int *distX, int *distY, uint8_t *texCoord,
                   char *texType); // dx & dy are absolute value

void raycast(fixed playerX, fixed playerY, fixed rayX, fixed rayY, int *distX, int *distY, uint8_t *texCoord,
             char *texType) {
    if (rayY > 0) {
        if (rayX > 0) {
            if (rayX > rayY) {
                raycast_q1_xy(playerX, playerY, rayX, rayY, distX, distY, texCoord, texType);
            } else {
                raycast_q1_yx(playerX, playerY, rayX, rayY, distX, distY, texCoord, texType);
            }
        } else {
            if (-1 * rayX > rayY) {
                raycast_q2_xy(playerX, playerY, -1 * (rayX), rayY, distX, distY, texCoord, texType);
            } else {
                raycast_q2_yx(playerX, playerY, -1 * (rayX), rayY, distX, distY, texCoord, texType);
            }
            *distX = (*distX) * -1;
        }
    } else {
        if (rayX > 0) {
            if (rayX > -1 * rayY) {
                raycast_q4_xy(playerX, playerY, rayX, -1 * (rayY), distX, distY, texCoord, texType);
            } else {
                raycast_q4_yx(playerX, playerY, rayX, -1 * (rayY), distX, distY, texCoord, texType);
            }
        } else {
            if (rayX < rayY) { // -x>-y
                raycast_q3_xy(playerX, playerY, -1 * (rayX), -1 * (rayY), distX, distY, texCoord, texType);
            } else {
                raycast_q3_yx(playerX, playerY, -1 * (rayX), -1 * (rayY), distX, distY, texCoord, texType);
            }
            *distX = (*distX) * -1;
        }
        *distY = (*distY) * -1;
    }
}

void x_walls();
void y_walls();

#ifdef __cplusplus
};
#endif