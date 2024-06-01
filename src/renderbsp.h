#ifndef RENDER_BSP_H
#define RENDER_BSP_H

#include <graphx.h>

#include "fixed.h"

#ifdef __cplusplus
extern "C" {
#endif

int fmuls(int a, int b);

void root_node();
void render_bsp(unsigned char *root, fixed playerX, fixed playerY, fixed fX, fixed fY);

#ifdef __cplusplus
};
#endif

#endif