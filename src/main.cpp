#include <graphx.h>
#include <keypadc.h>

#include <sys/timers.h>
#include <ti/getcsc.h>

// should probably rotate images 90deg clockwise because row-major order
// then can just memcpy into different sprite;
#include "gfx/gfx.h"

#include <cassert>
#include <cstring>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#include "fixed.h"
#include "matrixMath.h"
#include "vectorMath.h"

#include "drawStrip.h"
#include "raycast.h"

#include "enemy.h"
#include "thing.h"

// #define DEBUG
#ifdef DEBUG
#include <debug.h>
#endif

#define RENDER_H 180

void draw();

class Player {
  public:
    ivec2 pos;
    ivec2 forward;
    uint8_t rot;
    uint8_t health;
    Player(ivec2 position, uint8_t rotation) : pos(position), rot(rotation) {
        forward = rotate(rot) * ivec2(0, 1 << SHIFT);
    }
    void Update() {
        // movement & collision detection
        if (kb_Data[7] & kb_Up) {
            int incX = forward.x >> 3;
            int incY = forward.y >> 3;
            DetectCollisions(incX, incY);
            pos.x += incX;
            pos.y += incY;
        }
        if (kb_Data[7] & kb_Down) {
            int incX = -forward.x >> 3;
            int incY = -forward.y >> 3;
            DetectCollisions(incX, incY);
            pos.x += incX;
            pos.y += incY;
        }
        if (kb_Data[4] & kb_Prgm) {
            int incX = forward.y >> 3;
            int incY = -forward.x >> 3;
            DetectCollisions(incX, incY);
            pos.x += incX;
            pos.y += incY;
        }
        if (kb_Data[3] & kb_Apps) {
            int incX = -forward.y >> 3;
            int incY = forward.x >> 3;
            DetectCollisions(incX, incY);
            pos.x += incX;
            pos.y += incY;
        }

        // rotation
        if (kb_Data[7] & kb_Right) {
            rot -= 8;
        }
        if (kb_Data[7] & kb_Left) {
            rot += 8;
        }
    }

  private:
#define SPACE 64
    void DetectCollisions(fixed &incX, fixed &incY) {
        if (incX > 0) {
            char *y_walls_ptr = (char *)(&y_walls) + (pos.y >> SHIFT) * 9 + (pos.x >> SHIFT) + 1;
            if (*y_walls_ptr != ' ') {
                if (((pos.x) >> SHIFT) != ((pos.x + SPACE + incX) >> SHIFT)) {
                    incX = (255 - SPACE) - int(pos.x & int(255));
                }
            }
        } else {
            char *y_walls_ptr = (char *)(&y_walls) + (pos.y >> SHIFT) * 9 + (pos.x >> SHIFT);
            if (*y_walls_ptr != ' ') {
                if (((pos.x) >> SHIFT) != ((pos.x - SPACE + incX) >> SHIFT)) {
                    incX = SPACE - int(pos.x & int(255));
                }
            }
        }
        if (incY > 0) {
            char *x_walls_ptr = (char *)(&x_walls) + ((pos.y >> SHIFT) + 1) * 8 + (pos.x >> SHIFT);
            if (*x_walls_ptr != ' ') {
                if (((pos.y) >> SHIFT) != ((pos.y + SPACE + incY) >> SHIFT)) {
                    incY = (255 - SPACE) - int(pos.y & int(255));
                }
            }
        } else {
            char *x_walls_ptr = (char *)(&x_walls) + (pos.y >> SHIFT) * 8 + (pos.x >> SHIFT);
            if (*x_walls_ptr != ' ') {
                if (((pos.y) >> SHIFT) != ((pos.y - SPACE + incY) >> SHIFT)) {
                    incY = SPACE - int(pos.y & int(255));
                }
            }
        }
    }
};

#define NUM_FRAMES_PISTOL 7

const gfx_rletsprite_t *pistol_anim[NUM_FRAMES_PISTOL] = {
    pistol_1, pistol_2, pistol_4, pistol_5, pistol_5, pistol_7, pistol_8,
};

const uint8_t *textures[2] = {&(brick_wall->data[0]), &(portrait->data[0])};

int main(void) {
    gfx_Begin();
    gfx_SetDrawBuffer();
    gfx_SetTransparentColor(1);
    gfx_SetTextTransparentColor(1);
    gfx_SetTextBGColor(1);

    clock_t start_t, end_t;
    double total_t = 1;

    Player player(ivec2(256 * 3 + 128, 256 * 4), 0);

    uint8_t pistol_current_frame = 0;
    bool alpha_key, alpha_prevkey;

    const uint8_t SKIP = 4;
    const uint8_t NUM_RAYS = GFX_LCD_WIDTH / SKIP;

    // will want to make const later
    ivec2 rayOffsets[NUM_RAYS] = {
        ivec2(-181, 181), ivec2(-178, 183), ivec2(-176, 185), ivec2(-173, 187), ivec2(-171, 190), ivec2(-168, 192),
        ivec2(-165, 195), ivec2(-162, 197), ivec2(-159, 199), ivec2(-156, 202), ivec2(-153, 204), ivec2(-150, 207),
        ivec2(-146, 209), ivec2(-143, 212), ivec2(-139, 214), ivec2(-135, 217), ivec2(-131, 219), ivec2(-127, 221),
        ivec2(-123, 224), ivec2(-118, 226), ivec2(-114, 228), ivec2(-109, 231), ivec2(-105, 233), ivec2(-100, 235),
        ivec2(-95, 237),  ivec2(-89, 239),  ivec2(-84, 241),  ivec2(-79, 243),  ivec2(-73, 245),  ivec2(-67, 246),
        ivec2(-62, 248),  ivec2(-56, 249),  ivec2(-50, 251),  ivec2(-44, 252),  ivec2(-37, 253),  ivec2(-31, 254),
        ivec2(-25, 254),  ivec2(-19, 255),  ivec2(-12, 255),  ivec2(-6, 255),   ivec2(0, 256),    ivec2(6, 255),
        ivec2(12, 255),   ivec2(19, 255),   ivec2(25, 254),   ivec2(31, 254),   ivec2(37, 253),   ivec2(44, 252),
        ivec2(50, 251),   ivec2(56, 249),   ivec2(62, 248),   ivec2(67, 246),   ivec2(73, 245),   ivec2(79, 243),
        ivec2(84, 241),   ivec2(89, 239),   ivec2(95, 237),   ivec2(100, 235),  ivec2(105, 233),  ivec2(109, 231),
        ivec2(114, 228),  ivec2(118, 226),  ivec2(123, 224),  ivec2(127, 221),  ivec2(131, 219),  ivec2(135, 217),
        ivec2(139, 214),  ivec2(143, 212),  ivec2(146, 209),  ivec2(150, 207),  ivec2(153, 204),  ivec2(156, 202),
        ivec2(159, 199),  ivec2(162, 197),  ivec2(165, 195),  ivec2(168, 192),  ivec2(171, 190),  ivec2(173, 187),
        ivec2(176, 185),  ivec2(178, 183),
    };
    imat2 rot = imat2();

    Enemy test_thing(ivec2((3 << SHIFT) + 128, (1 << SHIFT) + 128));

    // render buffers
    int dists[NUM_RAYS] = {0};
    uint8_t texCoords[NUM_RAYS] = {0};
    char texTypes[NUM_RAYS] = {0};

    do {
        start_t = clock();
        gfx_ZeroScreen();

        player.Update();
        rot = rotate(player.rot);
        player.forward = rot * ivec2(0, 1 << SHIFT);
        ivec2 ray;

        end_t = clock();

        clock_t start_r_t, end_r_t;
        double total_r_t = 1;
        start_r_t = clock();
        for (uint8_t a = 0; a < NUM_RAYS; ++a) {
            ray = rot * rayOffsets[a];

            ivec2 hit = ivec2();

            raycast(player.pos.x, player.pos.y, ray.x, ray.y, &hit.x, &hit.y, &(texCoords[a]), &(texTypes[a]));
            dists[a] = dot(hit, player.forward);
        }
        end_r_t = clock();

        clock_t start_d_t, end_d_t;
        double total_d_t = 1;
        start_d_t = clock();
        for (uint8_t a = 0; a < NUM_RAYS; ++a) {
            int stripLen = ((1 << SHIFT) * (1 << SHIFT) / dists[a]) * 160;

            if ((stripLen >> SHIFT) <= RENDER_H) {
                draw_strip(&(gfx_vbuffer[0][0]),
                           textures[(texTypes[a] - 65) >> 1] + (int(uint8_t(texTypes[a] - 65) & 1) << 12), a * SKIP,
                           (RENDER_H - ((stripLen) >> SHIFT)) >> 1, (stripLen >> SHIFT), texCoords[a]);
            } else {
                draw_strip_clipped(
                    &(gfx_vbuffer[0][0]), textures[(texTypes[a] - 65) >> 1] + ((uint8_t(texTypes[a] - 65) & 1) << 12),
                    a * SKIP, (RENDER_H - ((stripLen) >> SHIFT)) >> 1, (stripLen >> SHIFT), texCoords[a]);
            }
        }
        end_d_t = clock();
        test_thing.Update(end_d_t - start_t);
        test_thing.Render(rotate(uint8_t(-player.rot)), player.pos, &(dists[0]));
        gfx_SetPalette(global_palette, sizeof_global_palette, 0);

        total_t = (double)(end_t - start_t) / CLOCKS_PER_SEC;
        total_r_t = (double)(end_r_t - start_r_t) / CLOCKS_PER_SEC;
        total_d_t = (double)(end_d_t - start_d_t) / CLOCKS_PER_SEC;
        char str[100];

        double total = (double)(clock() - start_t) / CLOCKS_PER_SEC;
        sprintf(str, "fps:%d,cpp:%fs,rc:%fs,d:%fs", int(1.0 / total), total_t, total_r_t, total_d_t);
        gfx_SetTextFGColor(255);
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
