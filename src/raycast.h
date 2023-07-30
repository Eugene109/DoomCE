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

void raycast(fixed playerX, fixed playerY, fixed rayX, fixed rayY, int *distX, int *distY);
void raycast_q1_yx(fixed playerX, fixed playerY, fixed rayX, fixed rayY, int *distX, int *distY);

#ifdef __cplusplus
};
#endif