#include <graphx.h>
#include <keypadc.h>

#include <sys/util.h>

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
#include "renderbsp.h"

#include "font.h"

#include "enemy.h"
#include "player.h"
#include "thing.h"

// #define DEBUG
#ifdef DEBUG
#include <debug.h>
#endif

void draw();

#define NUM_FRAMES_PISTOL 7

const gfx_rletsprite_t *pistol_anim[NUM_FRAMES_PISTOL] = {
    pistol_1, pistol_2, pistol_4, pistol_5, pistol_5, pistol_7, pistol_8,
};

void drawNumBigRed(int num, int xPos);

void drawWalls(Player &player);
void drawHUD(Player &player);
void drawWeapon(Player &player);
void draw(Player &player) {
    drawWalls(player);
    drawHUD(player);
    drawWeapon(player);
}

float f_abs(float a) {
    if (a < 0) {
        return -a;
    }
    return a;
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

    // render_bsp((unsigned char *)root_node, player.pos.x, player.pos.y, player.forward.x, player.forward.y);

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

#define TEST_FMULS 0
    if (TEST_FMULS) {
        gfx_SetTextFGColor(2);
        char str[100];
        sprintf(str, "fmuls: 0x2CE9 * 0x16C5 = 0x%X", fmuls(0x2CE9, 0x16C5));
        gfx_PrintStringXY(str, 5, 5);
        sprintf(str, "long: 0x2CE9 * 0x16C5 = 0x%X", ((long)0x2CE9 * (long)0x16C5) >> SHIFT);
        gfx_PrintStringXY(str, 5, 15);

        float fpErr = 0;
        float lErr = 0;
        srandom(clock());
        for (int i = 0; i < 500; i++) {
            int a = randInt(-32768, 32767);
            int b = randInt(-32768, 32767);
            fpErr += f_abs((fmuls(a, b) / 256.0) - (a / 256.0) * (b / 256.0));
            lErr += f_abs((((long(a) * long(b)) >> SHIFT) / 256.0) - (a / 256.0) * (b / 256.0));
        }
        sprintf(str, "Avg Err: fp:%f vs l:%f", fpErr / 500.0, lErr / 500.0);
        gfx_PrintStringXY(str, 5, 55);

        gfx_SwapDraw();
        while (!os_GetCSC()) {
            usleep(1000);
        }
        gfx_End();
        return -1;
    }
#define TEST_FDIVS 0
    if (TEST_FDIVS) {
        gfx_SetTextFGColor(2);
        char str[100];
        sprintf(str, "fdivs: 0x2CE9 / 0x16C5 = 0x%X", fdivs(0x16C5, 0x2CE9, divTable_appvar[0]));
        gfx_PrintStringXY(str, 5, 5);
        sprintf(str, "long: 0x2CE9 / 0x16C5 = 0x%X", ((long)((long)0x16C5 << SHIFT) / (long)0x2CE9));
        gfx_PrintStringXY(str, 5, 15);

        float fpErr = 0;
        float lErr = 0;
        srandom(clock());
        for (int i = 0; i < 1000; i++) {
            int b = randInt(1, 32767);
            int a = randInt(1, abs(b));
            fpErr += f_abs((fdivs(a, b, divTable_appvar[0]) / 255.0) - (a / 256.0) / (b / 256.0));
            lErr += f_abs(((((long(a) << SHIFT) / long(b))) / 256.0) - (a / 256.0) / (b / 256.0));
        }
        sprintf(str, "Avg Err: fp:%f vs l:%f", fpErr / 1000.0, lErr / 1000.0);
        gfx_PrintStringXY(str, 5, 55);

        gfx_SwapDraw();
        while (!os_GetCSC()) {
            usleep(1000);
        }
        gfx_End();
        return -1;
    }
    if (divTable_init() == 0) {
        gfx_SetTextFGColor(2);
        gfx_PrintStringXY("Needs div table Shifted Look Up Table,", 5, 5);
        gfx_PrintStringXY("please load divTables.8xv", 5, 15);
        gfx_SwapDraw();
        while (!os_GetCSC()) {
            usleep(1000);
        }
        gfx_End();
        return -1;
    }
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
#define TEST_WALL 1
    if (TEST_WALL) {
        gfx_SetTextFGColor(2);
        char str[100];
        // sprintf(str, "72.9deg y: %f",
        //         render_wall((unsigned char *)test_wall, 0x18A2, 0x2A3E, ((int)(72.9 * 256.0 / 360))) / 256.0);
        // gfx_PrintStringXY(str, 5, 5);
        // sprintf(str, "y: %f",
        //         render_wall((unsigned char *)test_wall, 0x18A2, 0x2A3E, ((int)(142.46 * 256.0 / 360))) / 256.0);
        // gfx_PrintStringXY(str, 5, 15);
        // sprintf(str, "y: %f",
        //         render_wall((unsigned char *)test_wall, 0x18A2, 0x2A3E, ((int)(205.29 * 256.0 / 360))) / 256.0);
        // gfx_PrintStringXY(str, 5, 25);
        sprintf(
            str, "wall2: y: %f",
            render_wall((unsigned char *)test_wall2, 6081, 11161, 212, dists, texCoords, texTypes, divTable_appvar[0]) /
                256.0);
        gfx_PrintStringXY(str, 5, 35);
        sprintf(
            str, "wall1: y: %f",
            render_wall((unsigned char *)test_wall, 6081, 11161, 212, dists, texCoords, texTypes, divTable_appvar[0]) /
                256.0);
        gfx_PrintStringXY(str, 5, 45);

        gfx_SwapDraw();
        while (!os_GetCSC()) {
            usleep(1000);
        }
        player.pos = ivec2(6081, 11161);
        player.rot = (int)(298.6 * 256.0 / 360.0);
        do {
            gfx_ZeroScreen();
            start_t = clock();
            gfx_SetTextFGColor(2);

            player.forward = ivec2(f_cos(player.rot), f_sin(player.rot));
            player.Update();
            sprintf(str, "rotation: %d", player.rot);
            gfx_PrintStringXY(str, 5, 45);
            sprintf(str, "pos: (%d,%d)", player.pos.x, player.pos.y);
            gfx_PrintStringXY(str, 5, 60);

            for (uint8_t a = 0; a < NUM_RAYS; ++a) {
                dists[a] = 0;
            }
            render_wall((unsigned char *)test_wall, player.pos.x, player.pos.y, player.rot, dists, texCoords, texTypes,
                        divTable_appvar[0]);
            render_wall((unsigned char *)test_wall2, player.pos.x, player.pos.y, player.rot, dists, texCoords, texTypes,
                        divTable_appvar[0]);
            // for (int a = 1; a < 80; a++) {
            //     render_wall((unsigned char *)test_wall2 + (13 * a), player.pos.x, player.pos.y, player.rot, dists,
            //                 texCoords, texTypes, divTable_appvar[0]);
            // }
            // render_wall((unsigned char *)test_wall, player.pos.x, player.pos.y, player.rot, dists, texCoords,
            // texTypes,
            //             divTable_appvar[0]);
            // render_wall((unsigned char *)test_wall, 0x18A2, 0x2A3E, (int)(298.6 * 256.0 / 360.0), dists, texCoords,
            //             texTypes, divTable_appvar[0]);
            for (uint8_t a = 0; a < NUM_RAYS; ++a) {
                if (!dists[a])
                    continue;
                int stripLen = ((160 << (SHIFT)) / dists[a]);
                int numerator = 160;
                for (; dists[a] > 256; dists[a] >>= 1) {
                    numerator >>= 1;
                }
                stripLen = divTable_appvar[0][dists[a] * (dists[a] + 1) / 2 + numerator] * 2;

                if ((stripLen) <= RENDER_H) {
                    draw_strip(&(gfx_vbuffer[0][0]),
                               textures[(texTypes[a] - 65) >> 1] + (int(uint8_t(texTypes[a] - 65) & 1) << 12), a * SKIP,
                               (RENDER_H - ((stripLen))) >> 1, (stripLen), texCoords[a]);
                } else {
                    draw_strip_clipped(&(gfx_vbuffer[0][0]),
                                       textures[(texTypes[a] - 65) >> 1] + ((uint8_t(texTypes[a] - 65) & 1) << 12),
                                       a * SKIP, (RENDER_H - ((stripLen))) >> 1, (stripLen), texCoords[a]);
                }
            }
            total_t = clock() - start_t;
            sprintf(str, "rev 0.3.9  fps:%d, %fs", int(CLOCKS_PER_SEC / total_t),
                    double(total_t) / double(CLOCKS_PER_SEC));
            gfx_SetTextFGColor(255);
            uint8_t offsetX = (GFX_LCD_WIDTH - gfx_GetStringWidth(str)) >> 1;
            gfx_PrintStringXY(str, offsetX, 4);
            gfx_SwapDraw();

        } while (os_GetCSC() != sk_Enter);
        gfx_End();
        return -1;
    }

    char currentDoor = 'a';
    uint8_t doorState = 0;
    do {
        if (doorState % 10 == 5 && doorState < 255) {
            set_door_state(currentDoor, doorState += 10);
        }
        if (doorState % 10 == 0 && doorState > 0) {
            set_door_state(currentDoor, doorState -= 10);
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

        drawHUD(player);

        char str[100];
        total_t = clock() - start_t;
        sprintf(str, "rev 0.3.9  fps:%d, %fs", int(CLOCKS_PER_SEC / total_t), double(total_t) / double(CLOCKS_PER_SEC));
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
            doorState ^= 5;
        }

        if (pistol_current_frame) {
            ++pistol_current_frame;
            ++pistol_current_frame;
            pistol_current_frame = pistol_current_frame * (pistol_current_frame < NUM_FRAMES_PISTOL);
        }

        alpha_key = kb_Data[2] & kb_Alpha;

        if (alpha_key && !alpha_prevkey && player.hasAmmo()) {
            pistol_current_frame = 1;
            player.shoot();
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

void drawNumBigRed(int num, int xPos) {
    draw_font(&(gfx_vbuffer[240 - 29][xPos - 14]), &(numbers_big_data[0]), 15, 16, num % 10);
    if (num < 10)
        return;
    draw_font(&(gfx_vbuffer[240 - 29][xPos - 14 * 2]), &(numbers_big_data[0]), 15, 16, num % 100 / 10);
    if (num < 100)
        return;
    draw_font(&(gfx_vbuffer[240 - 29][xPos - 14 * 3]), &(numbers_big_data[0]), 15, 16, num % 1000 / 100);
}

void drawWalls(Player &player) {}

void drawHUD(Player &player) {
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
    drawNumBigRed(player.getAmmo(), 44);

    // health
    draw_font(&(gfx_vbuffer[240 - 29][104 - 14]), &(numbers_big_data[0]), 15, 16, 10);
    drawNumBigRed(player.getHealth(), 90);

    // armour
    draw_font(&(gfx_vbuffer[240 - 29][235 - 14]), &(numbers_big_data[0]), 15, 16, 10);
    drawNumBigRed(player.getArmour(), 235 - 14);
}