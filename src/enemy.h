#ifndef ENEMY_H
#define ENEMY_H

#include "drawStrip.h"
#include "matrixMath.h"
#include "thing.h"
#include "vectorMath.h"
#include <graphx.h>

#include "gfx/gfx.h"

#include "gfx/zombieman_pt1.h"
#include "gfx/zombieman_pt2.h"

#define NUM_FRAMES_ENEMY 4

gfx_sprite_t *zombiemanF[NUM_FRAMES_ENEMY] = {0};
gfx_sprite_t *zombiemanFR[NUM_FRAMES_ENEMY] = {0};
gfx_sprite_t *zombiemanR[NUM_FRAMES_ENEMY] = {0};
gfx_sprite_t *zombiemanBR[NUM_FRAMES_ENEMY] = {0};
gfx_sprite_t *zombiemanB[NUM_FRAMES_ENEMY] = {0};
gfx_sprite_t *zombiemanBL[NUM_FRAMES_ENEMY] = {0};
gfx_sprite_t *zombiemanL[NUM_FRAMES_ENEMY] = {0};
gfx_sprite_t *zombiemanFL[NUM_FRAMES_ENEMY] = {0};

gfx_sprite_t *zombiemanD[NUM_FRAMES_ENEMY] = {0};

//      b
//  bl     br
// l    E    r
//  fl     fr
//      f

//  d: death sequence

class Enemy : public Thing {
  public:
    inline static vector<Enemy *> enemies;
    Enemy(const ivec2 &p) {
        if (EnemyPt1_init() == 0) {
            return;
        }
        if (EnemyPt2_init() == 0) {
            return;
        }
        zombiemanF[0] = zombiemanF0;
        zombiemanF[1] = zombiemanF1;
        zombiemanF[2] = zombiemanF2;
        zombiemanF[3] = zombiemanF3;
        zombiemanFR[0] = zombiemanFR0;
        zombiemanFR[1] = zombiemanFR1;
        zombiemanFR[2] = zombiemanFR2;
        zombiemanFR[3] = zombiemanFR3;
        zombiemanR[0] = zombiemanR0;
        zombiemanR[1] = zombiemanR1;
        zombiemanR[2] = zombiemanR2;
        zombiemanR[3] = zombiemanR3;
        zombiemanBR[0] = zombiemanBR0;
        zombiemanBR[1] = zombiemanBR1;
        zombiemanBR[2] = zombiemanBR2;
        zombiemanBR[3] = zombiemanBR3;
        zombiemanB[0] = zombiemanB0;
        zombiemanB[1] = zombiemanB1;
        zombiemanB[2] = zombiemanB2;
        zombiemanB[3] = zombiemanB3;
        zombiemanBL[0] = zombiemanBR2;
        zombiemanBL[1] = zombiemanBR3;
        zombiemanBL[2] = zombiemanBR0;
        zombiemanBL[3] = zombiemanBR1;
        zombiemanL[0] = zombiemanR2;
        zombiemanL[1] = zombiemanR3;
        zombiemanL[2] = zombiemanR0;
        zombiemanL[3] = zombiemanR1;
        zombiemanFL[0] = zombiemanFR2;
        zombiemanFL[1] = zombiemanFR3;
        zombiemanFL[2] = zombiemanFR0;
        zombiemanFL[3] = zombiemanFR1;
        pos = p;
        frame_num = 0;
        tex = zombiemanF[frame_num];
        prev_frame_time = 0;
        forward = ivec2(0, 1 << SHIFT);
        enemies.push_back(this);
    }
    static void RenderAll() {}

    void Update(unsigned long delta_time) {
        prev_frame_time += delta_time;
        if (prev_frame_time > (CLOCKS_PER_SEC >> 3)) {
            frame_num++;

            prev_frame_time = 0;
        }
    }
    void Render(const imat2 &inv_cam_rot, const ivec2 &cam_pos, int *dists_arr_ptr) {
        ivec2 viewDir = normalize(cam_pos - pos);
        ivec2 right = ivec2(forward.y, -forward.x);
        bool flip = false;
        if (dot(forward, viewDir) > 236) {
            tex = zombiemanF[(frame_num)&0x03];
        } else if (dot(forward, viewDir) > 98) {
            if (dot(right, viewDir) > 0) {
                tex = zombiemanFR[(frame_num)&0x03];
            } else {
                tex = zombiemanFL[(frame_num)&0x03];
                flip = true;
            }
        } else if (dot(forward, viewDir) > -98) {
            if (dot(right, viewDir) > 0) {
                tex = zombiemanR[(frame_num)&0x03];
            } else {
                tex = zombiemanL[(frame_num)&0x03];
                flip = true;
            }
        } else if (dot(forward, viewDir) > -236) {
            if (dot(right, viewDir) > 0) {
                tex = zombiemanBR[(frame_num)&0x03];
            } else {
                tex = zombiemanBL[(frame_num)&0x03];
                flip = true;
            }
        } else {
            tex = zombiemanB[(frame_num)&0x03];
        }
        // Thing::render(inv_cam_rot, cam_pos, dists_arr_ptr);
        if (!flip) {

            ivec2 viewSpacePos = inv_cam_rot * (pos - cam_pos);
            if (viewSpacePos.y <= 69) { //  less than 240 <- height of screen
                return;
            }
            int texHeight = (160 << SHIFT) / viewSpacePos.y;

            int screenSpaceX =
                ((((((viewSpacePos.x << SHIFT) / viewSpacePos.y) + (1 << SHIFT)) >> 1) * SCR_W) >> SHIFT) -
                (texHeight >> 1);
            if (screenSpaceX + texHeight < 0 || screenSpaceX >= SCR_W) {
                return;
            }
            // just centered on screen
            int screenSpaceY = (180 - (texHeight)) >> 1;
            int a = 0;
            if (screenSpaceX < 0) {
                a = -screenSpaceX;
            }
            if (screenSpaceY >= 0) {
                for (; a < texHeight; a++) {
                    if (a + screenSpaceX > SCR_W) {
                        break;
                    }
                    if (viewSpacePos.y < dists_arr_ptr[(a + screenSpaceX) >> 2]) {
                        draw_strip_transparent(&(gfx_vbuffer[0][0]), &(tex->data[0]), screenSpaceX + a, screenSpaceY,
                                               texHeight, (a << SHIFT) / texHeight);
                    }
                }
            } else {
                // will skip by 4 for larger sizes
                for (; a < texHeight; a += 4) {
                    if (a + screenSpaceX > SCR_W - 4) {
                        break;
                    }
                    if (viewSpacePos.y < dists_arr_ptr[(a + screenSpaceX) >> 2]) {
                        draw_strip_transparent_clipped(&(gfx_vbuffer[0][0]), &(tex->data[0]), screenSpaceX + a,
                                                       screenSpaceY, texHeight, (a << SHIFT) / texHeight);
                    }
                }
            }
        } else {

            ivec2 viewSpacePos = inv_cam_rot * (pos - cam_pos);
            if (viewSpacePos.y <= 69) { //  less than 240 <- height of screen
                return;
            }
            int texHeight = (160 << SHIFT) / viewSpacePos.y;

            int screenSpaceX =
                ((((((viewSpacePos.x << SHIFT) / viewSpacePos.y) + (1 << SHIFT)) >> 1) * SCR_W) >> SHIFT) -
                (texHeight >> 1);
            if (screenSpaceX + texHeight < 0 || screenSpaceX >= SCR_W) {
                return;
            }
            // just centered on screen
            int screenSpaceY = (180 - (texHeight)) >> 1;
            int a = 0;
            if (screenSpaceX < 0) {
                a = -screenSpaceX;
            }
            if (screenSpaceY >= 0) {
                for (; a < texHeight; a++) {
                    if (a + screenSpaceX > SCR_W) {
                        break;
                    }
                    if (viewSpacePos.y < dists_arr_ptr[(a + screenSpaceX) >> 2]) {
                        draw_strip_transparent(&(gfx_vbuffer[0][0]), &(tex->data[0]), screenSpaceX + a, screenSpaceY,
                                               texHeight, -(a << SHIFT) / texHeight);
                    }
                }
            } else {
                // will skip by 4 for larger sizes
                for (; a < texHeight; a += 4) {
                    if (a + screenSpaceX > SCR_W - 4) {
                        break;
                    }
                    if (viewSpacePos.y < dists_arr_ptr[(a + screenSpaceX) >> 2]) {
                        draw_strip_transparent_clipped(&(gfx_vbuffer[0][0]), &(tex->data[0]), screenSpaceX + a,
                                                       screenSpaceY, texHeight, -(a << SHIFT) / texHeight);
                    }
                }
            }
        }
    }
    ivec2 forward;
    uint8_t frame_num;
    unsigned long prev_frame_time;
};

#endif