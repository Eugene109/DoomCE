#include <graphx.h>
#include <keypadc.h>

#include <sys/timers.h>
#include <ti/getcsc.h>

// should probably rotate images 90° clockwise because row-major order
// then can just memcpy into different sprite;
#include "gfx/gfx.h"

#include "gfx/textures.h"

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

#include "font.h"

#include "enemy.h"
#include "thing.h"

// #define DEBUG
#ifdef DEBUG
#include <debug.h>
#endif

void draw();

class Player {
  public:
    ivec2 pos;
    ivec2 forward;
    uint8_t rot;
    uint8_t health;
    uint8_t armour;
    Player(ivec2 position, uint8_t rotation) : pos(position), rot(rotation) {
        forward = rotate(rot) * ivec2(0, 1 << SHIFT);
        health = 100;
        armour = 0;
    }
    // protected:
    void dealDamage(uint8_t dmg) { health -= dmg; }
    uint8_t getHealth() { return health; }
    uint8_t getArmour() { return armour; }
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
            char *y_walls_ptr = (char *)(&y_walls_q1) + (pos.y >> SHIFT) * 17 + (pos.x >> SHIFT) + 1;
            if (*y_walls_ptr >> 6 && !(*y_walls_ptr & 32)) {
                if (((pos.x) >> SHIFT) != ((pos.x + SPACE + incX) >> SHIFT)) {
                    incX = (255 - SPACE) - int(pos.x & int(255));
                }
            }
        } else {
            char *y_walls_ptr = (char *)(&y_walls_q1) + (pos.y >> SHIFT) * 17 + (pos.x >> SHIFT);
            if (*y_walls_ptr >> 6 && !(*y_walls_ptr & 32)) {
                if (((pos.x) >> SHIFT) != ((pos.x - SPACE + incX) >> SHIFT)) {
                    incX = SPACE - int(pos.x & int(255));
                }
            }
        }
        if (incY > 0) {
            char *x_walls_ptr = (char *)(&x_walls_q1) + ((pos.y >> SHIFT) + 1) * 16 + (pos.x >> SHIFT);
            if (*x_walls_ptr >> 6 && !(*x_walls_ptr & 32)) {
                if (((pos.y) >> SHIFT) != ((pos.y + SPACE + incY) >> SHIFT)) {
                    incY = (255 - SPACE) - int(pos.y & int(255));
                }
            }
        } else {
            char *x_walls_ptr = (char *)(&x_walls_q1) + (pos.y >> SHIFT) * 16 + (pos.x >> SHIFT);
            if (*x_walls_ptr >> 6 && !(*x_walls_ptr & 32)) {
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

void drawNumBigRed(int num, int xPos) {
    draw_font(&(gfx_vbuffer[240 - 29][xPos - 14]), &(numbers_big_data[0]), 15, 16, num % 10);
    if (num < 10)
        return;
    draw_font(&(gfx_vbuffer[240 - 29][xPos - 14 * 2]), &(numbers_big_data[0]), 15, 16, num % 100 / 10);
    if (num < 100)
        return;
    draw_font(&(gfx_vbuffer[240 - 29][xPos - 14 * 3]), &(numbers_big_data[0]), 15, 16, num % 1000 / 100);
}

int main(void) {
    gfx_Begin();
    gfx_SetDrawBuffer();
    gfx_SetTransparentColor(1);
    gfx_SetTextTransparentColor(1);
    gfx_SetTextBGColor(1);
    gfx_SetPalette(global_palette, sizeof_global_palette, 0);

    clock_t start_t;
    int total_t = 1;

    Player player(ivec2(256 * 2 + 128, 256 * 3), 0);

    uint8_t pistol_current_frame = 0;
    bool alpha_key, alpha_prevkey;

    const uint8_t SKIP = 4;
    const uint8_t NUM_RAYS = GFX_LCD_WIDTH / SKIP;

    ivec2 rayOffsets[NUM_RAYS] = {0};
    for (uint8_t a = 0; a < NUM_RAYS; a++) {
        rayOffsets[a] = normalize(ivec2((a * 512) / (NUM_RAYS - 1) - 256, 256));
    }
    imat2 rot = imat2();

    Enemy test_thing(ivec2((3 << SHIFT) + 128, (1 << SHIFT) + 128));
    gfx_ZeroScreen();
    if (!Enemy::InitTextures()) {
        gfx_SetTextFGColor(2);
        gfx_PrintStringXY("Zombieman textures not found, please load", 5, 5);
        gfx_PrintStringXY("EnemyPt1.8xv and EnemyPt2.8xv", 5, 15);
        gfx_SwapDraw();
        while (!os_GetCSC()) {
            usleep(1000);
        }
        gfx_End();
        return -1;
    }

    if (textures_init() == 0) {
        gfx_SetTextFGColor(2);
        gfx_PrintStringXY("Wall textures not found, ", 5, 5);
        gfx_PrintStringXY("please load textures.8xv", 5, 15);
        gfx_SwapDraw();
        while (!os_GetCSC()) {
            usleep(1000);
        }
        gfx_End();
        return -1;
    }
    const uint8_t *textures[3] = {&(brick_wall->data[0]), &(portrait->data[0]), &(door_gray->data[0])};

    // render buffers
    int dists[NUM_RAYS] = {0};
    uint8_t texCoords[NUM_RAYS] = {0};
    char texTypes[NUM_RAYS] = {0};

    char currentDoor = 'a';
    uint8_t doorState = 0;
    do {
        if (doorState && doorState < 255) {
            set_door_state(currentDoor, doorState += 5);
        }
        start_t = clock();
        gfx_ZeroScreen();

        player.Update();
        rot = rotate(player.rot);
        player.forward = rot * ivec2(0, 1 << SHIFT);
        ivec2 ray;

        for (uint8_t a = 0; a < NUM_RAYS; ++a) {
            ray = rot * rayOffsets[a];

            ivec2 hit = ivec2();

            raycast(player.pos.x, player.pos.y, ray.x, ray.y, &hit.x, &hit.y, &(texCoords[a]), &(texTypes[a]));
            dists[a] = dot(hit, player.forward);
        }

        for (uint8_t a = 0; a < NUM_RAYS; ++a) {
            int stripLen = ((1 << (SHIFT + SHIFT)) / dists[a]) * 160;

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
        Enemy::RenderAll(total_t, rotate(uint8_t(-player.rot)), player.pos, &(dists[0]));

        // draw hud;
        memcpy(&(gfx_vbuffer[208][0]), HUD_data, HUD_width * HUD_height);
        // gfx_TransparentSprite(numbers_small, 123, 240 - 18);
        draw_font(&(gfx_vbuffer[240 - 28][111]), &(numbers_small_selected_data[0]), 5, 6, 2);
        draw_font(&(gfx_vbuffer[240 - 28][123]), &(numbers_small_data[0]), 5, 6, 3);
        draw_font(&(gfx_vbuffer[240 - 28][135]), &(numbers_small_data[0]), 5, 6, 4);
        draw_font(&(gfx_vbuffer[240 - 18][111]), &(numbers_small_data[0]), 5, 6, 5);
        draw_font(&(gfx_vbuffer[240 - 18][123]), &(numbers_small_data[0]), 5, 6, 6);
        draw_font(&(gfx_vbuffer[240 - 18][135]), &(numbers_small_data[0]), 5, 6, 7);

        // ammo
        drawNumBigRed(50, 44);

        // health
        draw_font(&(gfx_vbuffer[240 - 29][104 - 14]), &(numbers_big_data[0]), 15, 16, 10);
        drawNumBigRed(player.getHealth(), 90);

        // armour
        draw_font(&(gfx_vbuffer[240 - 29][235 - 14]), &(numbers_big_data[0]), 15, 16, 10);
        drawNumBigRed(player.getArmour(), 235 - 14);

        char str[100];
        total_t = clock() - start_t;
        sprintf(str, "rev 0.3.7  fps:%d, %fs", int(CLOCKS_PER_SEC / total_t), double(total_t) / double(CLOCKS_PER_SEC));
        gfx_SetTextFGColor(255);
        uint8_t offsetX = (GFX_LCD_WIDTH - gfx_GetStringWidth(str)) >> 1;
        gfx_PrintStringXY(str, offsetX, 4);
// #define PRINT_NAME
#ifdef PRINT_NAME
        sprintf(str, "Built by Eugene Choi using ASM & C++");
        offsetX = (GFX_LCD_WIDTH - gfx_GetStringWidth(str)) / 2;
        gfx_PrintStringXY(str, offsetX, 20);
#endif
        if (kb_Data[1] & kb_2nd) {
            doorState = 5;
        }

        if (pistol_current_frame) {
            ++pistol_current_frame;
            ++pistol_current_frame;
            pistol_current_frame = pistol_current_frame * (pistol_current_frame < NUM_FRAMES_PISTOL);
        }

        alpha_key = kb_Data[2] & kb_Alpha;

        if (alpha_key && !alpha_prevkey) {
            pistol_current_frame = 1;
            Enemy::registerShot(rand() % 10 + 5);
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
