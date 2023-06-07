#include <graphx.h>
#include <keypadc.h>

#include <sys/timers.h>
#include <ti/getcsc.h>

// should probably rotate images 90deg clockwise because row-major order
// then can just memcpy into different sprite;
#include "gfx/gfx.h"

#include <cassert>
#include <cstring>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#include "aa_lines.h"
#include "fixed.h"
#include "matrixMath.h"
#include "vectorMath.h"

#include "drawStrip.h"

// #define DEBUG
#ifdef DEBUG
#include <debug.h>
#endif

#ifndef PI
#define PI 3.14159265359 * (1 << SHIFT)
#endif

#define RENDER_H 180

inline void bresenhamLine(unsigned x0, unsigned y0, unsigned x1, unsigned y1) {
    unsigned dx = x1 - x0;
    unsigned dy = y1 - y0;
    int D = 2 * dy - dx;
    unsigned y = y0;

    for (unsigned x = x0; x <= x1; ++x) {
        // plot(x, y);
        if (D > 0) {
            y = y + 1;
            D = D - 2 * dx;
        }
        D = D + 2 * dy;
    }
}

inline uint8_t *writeTexStripToBuffer(const unsigned char *start_arr_ptr, uint8_t *dest, uint8_t pxl_scl, unsigned xPos,
                                      int yPos, fixed tex_pos, unsigned dest_height, unsigned darken_factor) {
    unsigned SRC_H = 32;
    unsigned SRC_H_SHIFT = 5;
    unsigned img_offset = (((1 << ((SRC_H_SHIFT - 1) << 1)) << (SHIFT + 2)) / 3) >> SHIFT;
    const uint8_t *strip_arr_ptr =
        start_arr_ptr + img_offset + ((((tex_pos % (1 << SHIFT)) << SRC_H_SHIFT) >> SHIFT) << SRC_H_SHIFT);

    unsigned x0 = yPos;
    unsigned x1 = x0 + dest_height;
    unsigned dx = x1 - x0;
    unsigned dy = SRC_H;
    int D = 2 * dy - dx;

    dest += xPos + yPos * GFX_LCD_WIDTH;

    for (unsigned x = x0; x <= x1; ++x) {
        for (int i = 0; i < pxl_scl; ++i) {
            // *(dest) = *(strip_arr_ptr);
            memset(dest, max(int(*(strip_arr_ptr)) - (darken_factor << 5), 0), 4);
        }
        if (D > 0) {
            ++strip_arr_ptr;
            D = D - 2 * dx;
        }
        D = D + 2 * dy;
        dest += GFX_LCD_WIDTH;
    }
    return dest;
}

gfx_UninitedSprite(img_strip, 1, RENDER_H);

inline void drawTexStrip(const unsigned char *start_arr_ptr, uint8_t pxl_scl, unsigned xPos, int yPos, fixed tex_pos,
                         unsigned dest_height, unsigned darken_factor) {
    // handle this later:
    if (yPos < 0 || dest_height > RENDER_H) {
        return;
    }

    // code to set background to black
    // memset(img_strip->data, 0, GFX_LCD_HEIGHT);
    // img_strip->height = GFX_LCD_HEIGHT;
    // img_strip->width = 1;

    // copy in floor texture
    memcpy(img_strip, ceiling_floor_tex, RENDER_H + 2);
    unsigned SRC_H = 64;
    unsigned SRC_H_SHIFT = 6;
    for (uint8_t a = 0; a < 6; a++) {
        if (dest_height > (SRC_H >>= a)) {
            break;
        }
        --SRC_H_SHIFT;
    }

    // ( [ 2^{SRC_H_SHIFT-1} ]^2)*4/3
    // ( [ 2^((SRC_H_SHIFT-1)*2)]*4/3
    unsigned img_offset = (((1 << ((SRC_H_SHIFT - 1) << 1)) << (2)) / 3);
    const uint8_t *strip_arr_ptr =
        start_arr_ptr + img_offset + (((((tex_pos) % (1 << SHIFT)) << SRC_H_SHIFT) >> SHIFT) << SRC_H_SHIFT);
    // gfx_sprite_t *img_strip = gfx_MallocSprite(1, dest_height); // maybe use gfx_tempSprite with set height
    // for (unsigned i = 0; i < dest_height; ++i) {
    //     img_strip->data[i] = *(strip_arr_ptr + (((i << SRC_H_SHIFT) / dest_height)));
    // }
    unsigned x0 = yPos;
    unsigned x1 = x0 + dest_height;
    unsigned dx = x1 - x0;
    unsigned dy = SRC_H;
    int D = 2 * dy - dx;
    unsigned y = 0;

    uint8_t *ptr = &(img_strip->data[x0 - 1]);
    for (unsigned x = x0; x <= x1; ++x) {
        *(++ptr) = max(int(*(strip_arr_ptr)) - (darken_factor << 5), 0);
        if (D > 0) {
            ++strip_arr_ptr;
            D = D - 2 * dx;
        }
        D = D + 2 * dy;
    }

    // if ((xPos + pxl_scl) <= GFX_LCD_WIDTH && (yPos + dest_height) < GFX_LCD_HEIGHT && xPos >= 0 && yPos >= 0) {
    gfx_ScaledSprite_NoClip(img_strip, xPos, 0, pxl_scl, 1);
    // } else {
    //     gfx_SetColor(1);
    //     gfx_Rectangle(xPos, yPos, pxl_scl, dest_height);
    //     // continue;
    // }
}

void draw();

// placeholders
ivec2 playerPos = ivec2(0);

// maybe do something like this in future?
// class Player {
//   public:
//     Player() : pos(0) {}
//     ivec2 pos;
// };

#define NUM_FRAMES_PISTOL 7

const gfx_rletsprite_t *pistol_anim[NUM_FRAMES_PISTOL] = {
    pistol_1, pistol_2, pistol_4, pistol_5, pistol_5, pistol_7, pistol_8,
};

int main(void) {
    gfx_Begin();
    gfx_SetDrawBuffer();

#include "maze1_lvl.h"

    uint8_t count = 16;

    clock_t start_t, end_t;
    double total_t = 1;

    int counter = 0;

    uint8_t pistol_current_frame = 0;
    bool alpha_key, alpha_prevkey;

    const uint8_t SKIP = 4;
    const uint8_t NUM_RAYS = GFX_LCD_WIDTH / SKIP;

    // will want to make const later
    ivec2 rayOffsets[NUM_RAYS];
    for (uint8_t i = 0; i < NUM_RAYS; ++i) {
        rayOffsets[i] =
            (ivec2((((double(i * SKIP) / double(GFX_LCD_WIDTH - 1.0)) * 2.0) - 1.0) * (1 << SHIFT), (1 << SHIFT)));
    }

    imat2 rot = rotate(0);
    ivec2 cam_forward = rot * ivec2(0, 1 << SHIFT);

    do {
        start_t = clock();
        gfx_ZeroScreen();

        if (kb_Data[7] & kb_Up) {
            count += 2;
            playerPos.x += cam_forward.x >> 3;
            playerPos.y += cam_forward.y >> 3;
            // loop through lines, find ones with pos < certain value, limit playerPos
        }
        if (kb_Data[7] & kb_Down) {
            count -= 2;
            playerPos.x -= cam_forward.x >> 3;
            playerPos.y -= cam_forward.y >> 3;
        }
        for (uint8_t i = 0; i < MAZE1_NUM_X_LINES; ++i) {
            maze1_x_lines[i].pos = maze1_x_lines[i].wPos - playerPos.y;
            maze1_x_lines[i].min_value = maze1_x_lines[i].wMin_value - playerPos.x;
            maze1_x_lines[i].max_value = maze1_x_lines[i].wMax_value - playerPos.x;
        }
        for (uint8_t i = 0; i < MAZE1_NUM_Y_LINES; ++i) {
            maze1_y_lines[i].pos = maze1_y_lines[i].wPos - playerPos.x;
            maze1_y_lines[i].min_value = maze1_y_lines[i].wMin_value - playerPos.y;
            maze1_y_lines[i].max_value = maze1_y_lines[i].wMax_value - playerPos.y;
        }
        // sort list of aa-lines:
        qsort(&(maze1_x_lines[0]), MAZE1_NUM_X_LINES, sizeof(maze1_x_lines[0]), aa_single_comp);
        qsort(&(maze1_y_lines[0]), MAZE1_NUM_Y_LINES, sizeof(maze1_y_lines[0]), aa_single_comp);

        if (kb_Data[7] & kb_Right) {
            ++counter;
        }
        if (kb_Data[7] & kb_Left) {
            --counter;
        }
        rot = rotate(int(-0.05 * counter * PI));
        ivec2 ray;

        ivec2 current_hit = ivec2();
        int current_dist = 0;
        fixed current_texCoord = 0;

        cam_forward = rot * ivec2(0, 1 << SHIFT);

        // dist, texCoord, maybe add a texture index
        // fixed rayCastBuff[NUM_RAYS * 2];
        // fixed *rayCastBuffPtr = &(rayCastBuff[0]);

        for (uint8_t a = 0; a < NUM_RAYS; ++a) {
            ray = rot * rayOffsets[a];

            ivec2 hit = ivec2();
            int dist = 100 * (1 << SHIFT);
            fixed texCoord = 0;

            for (uint8_t i = 0; i < MAZE1_NUM_X_LINES; ++i) {
                if (maze1_x_lines[i].rayIntersection(ray, &hit, &texCoord)) {
                    dist = dot(hit, cam_forward);
                    break;
                }
            }
            for (uint8_t i = 0; i < MAZE1_NUM_Y_LINES; ++i) {
                if (maze1_y_lines[i].rayIntersection(ray, &current_hit, &current_texCoord)) {
                    current_dist = dot(current_hit, cam_forward);
                    if (current_dist < dist) {
                        dist = current_dist;
                        hit = current_hit;
                        texCoord = current_texCoord;
                    }
                    break;
                }
            }
            int stripLen = ((1 << SHIFT) * (1 << SHIFT) / dist) * 100;
#ifdef DEBUG
            dbg_printf("striplen: %d\n", stripLen);
#endif

// #define LOW_RES
#ifdef LOW_RES
            // striplen>>2 for skip of 4
            drawTexStrip_scl_h(brick_wall_arr_data, SKIP, a * SKIP, (RENDER_H - (((stripLen >> 2) >> SHIFT) << 2)) >> 1,
                               texCoord, ((stripLen >> 2) >> SHIFT));
#else
            // writeTexStripToBuffer(brick_wall_arr_data, &(gfx_vbuffer[0][0]), SKIP, a * SKIP,
            //                       (RENDER_H - ((stripLen) >> SHIFT)) >> 1, texCoord, (stripLen >> SHIFT),
            //                       (dist / 3) >> SHIFT);
            drawTexStrip(brick_wall_arr_data, SKIP, a * SKIP, (RENDER_H - ((stripLen) >> SHIFT)) >> 1, texCoord << 1,
                         (stripLen >> SHIFT), (dist) >> SHIFT);

#endif
        }
        gfx_SetPalette(global_palette, sizeof_global_palette, 0);

        end_t = clock();
        total_t = (double)(end_t - start_t) / CLOCKS_PER_SEC;
        char str[100];
        // sprintf(str, "REV 0.1.6 render time: %f, asm_test: %d", total_t,
        //         draw_strip(&(gfx_vbuffer[0][0]), &(brick_wall_arr_data[0]), 0, 0, 64));
        sprintf(str, "REV 0.2.2 render time: %f", total_t);
        gfx_SetTextFGColor(254);
        uint8_t offsetX = (GFX_LCD_WIDTH - gfx_GetStringWidth(str)) >> 1;
        gfx_PrintStringXY(str, offsetX, 4);

#ifdef PRINT_NAME
        sprintf(str, "Created by Eugene Choi");
        offsetX = (GFX_LCD_WIDTH - gfx_GetStringWidth(str)) / 2;
        gfx_PrintStringXY(str, offsetX, 20);
#endif

        if (pistol_current_frame) {
            ++pistol_current_frame;
            ++pistol_current_frame;
            pistol_current_frame = pistol_current_frame * (pistol_current_frame < NUM_FRAMES_PISTOL);
        }

        alpha_key = kb_Data[2] & kb_Alpha;

        if (alpha_key && !alpha_prevkey) {
            pistol_current_frame = 1;
        }
        alpha_prevkey = alpha_key;

        gfx_RLETSprite_NoClip(pistol_anim[pistol_current_frame], (GFX_LCD_WIDTH >> 1) - (pistol_1_width >> 1),
                              RENDER_H - pistol_1_height);

        gfx_SwapDraw();
    } while (os_GetCSC() != sk_Enter);

    /* End graphics drawing */
    gfx_End();

    return 0;
}
