#ifndef RENDER_BSP_H
#define RENDER_BSP_H

#include <graphx.h>

#include "fixed.h"

#ifdef __cplusplus
extern "C" {
#endif

fixed fmuls(fixed a, fixed b);
fixed fdivs(fixed a, fixed b, unsigned char *sLUT_ptr);

void root_node();
void test_wall();
void test_wall2();
int render_bsp(unsigned char *root, fixed playerX, fixed playerY, fixed forward_angle, uint8_t *unified_buff,
               unsigned char *sLUT_ptr);
fixed render_wall(unsigned char *wall, fixed playerX, fixed playerY, fixed forward_angle, uint8_t *unified_buff,
                  unsigned char *sLUT_ptr);

#ifdef __cplusplus
};
#endif

#endif