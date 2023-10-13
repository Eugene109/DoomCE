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

gfx_sprite_t *zombiemanD[5] = {0};

//      b
//  bl     br
// l    E    r
//  fl     fr
//      f

//  d: death sequence

class Enemy : public Thing {
  public:
    inline static vector<Enemy *> enemies;
    inline static bool shotFired;
    inline static vector<int> shots;
    inline static void registerShot(int dmg) {
        shotFired = true;
        shots.push_back(dmg);
    }
    inline static void deregisterShots() {
        shotFired = false;
        shots = vector<int>();
    }
    void deregisterShot(int index) { shots[index] = 0; }
    Enemy(const ivec2 &p) {
        pos = p;
        frame_num = 0;
        tex = zombiemanF[frame_num];
        prev_frame_time = 0;
        forward = ivec2(0, 1 << SHIFT);
        enemies.push_back(this);
        shotFired = false;
        dead = false;
        health = 20;
    }
    static bool InitTextures() {
        if (EnemyPt1_init() == 0) {
            return false;
        }
        if (EnemyPt2_init() == 0) {
            return false;
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
        zombiemanD[0] = zombiemanD0;
        zombiemanD[1] = zombiemanD1;
        zombiemanD[2] = zombiemanD2;
        zombiemanD[3] = zombiemanD3;
        zombiemanD[4] = zombiemanD4;
        return true;
    }
    static void RenderAll(unsigned long delta_time, const imat2 &inv_cam_rot, const ivec2 &cam_pos,
                          int *dists_arr_ptr) {
        for (int i = 0; i < enemies.size(); i++) {
            enemies[i]->Render(delta_time, inv_cam_rot, cam_pos, dists_arr_ptr);
        }
        deregisterShots();
    }

    void UpdateFrame(unsigned long delta_time) {
        prev_frame_time += delta_time;
        if (prev_frame_time > (CLOCKS_PER_SEC >> 3)) {
            frame_num++;

            prev_frame_time = 0;
        }
    }
    void UpdateAnim(fixed dotF, fixed dotR) {
        flipTex = false;
        if (dotF > 236) {
            tex = zombiemanF[(frame_num)&0x03];
        } else if (dotF > 98) {
            if (dotR > 0) {
                tex = zombiemanFR[(frame_num)&0x03];
            } else {
                tex = zombiemanFL[(frame_num)&0x03];
                flipTex = true;
            }
        } else if (dotF > -98) {
            if (dotR > 0) {
                tex = zombiemanR[(frame_num)&0x03];
            } else {
                tex = zombiemanL[(frame_num)&0x03];
                flipTex = true;
            }
        } else if (dotF > -236) {
            if (dotR > 0) {
                tex = zombiemanBR[(frame_num)&0x03];
            } else {
                tex = zombiemanBL[(frame_num)&0x03];
                flipTex = true;
            }
        } else {
            tex = zombiemanB[(frame_num)&0x03];
        }
    }
    void Render(unsigned long delta_time, const imat2 &inv_cam_rot, const ivec2 &cam_pos, int *dists_arr_ptr) {
        ivec2 viewSpacePos = inv_cam_rot * (pos - cam_pos);
        if (!dead && lengthSQ(cam_pos - pos) > 128) {
            forward = normalize(cam_pos - pos);
            pos += forward * 16;
        }
        if (viewSpacePos.y <= 69) { //  less than 240 <- height of screen
            return;
        }
        UpdateFrame(delta_time);
        ivec2 viewDir = normalize(cam_pos - pos);
        ivec2 right = ivec2(forward.y, -forward.x);
        UpdateAnim(dot(forward, viewDir), -dot(right, viewDir));
        bool painState = false;
        if (shotFired && !dead) {
            for (int c = 0; c < shots.size(); c++) {
                if (abs((viewSpacePos.x * inv_sqrt(viewSpacePos.y)) >> SHIFT) < 32 &&
                    dists_arr_ptr[40] > viewSpacePos.y && shots[c]) {
                    health -= shots[c];
                    deregisterShot(c);
                    if (uint8_t(rand()) < 200)
                        tex = zombiemanD0;
                    if (health < 0) {
                        dead = true;
                        frame_num = 0;
                        prev_frame_time = 0;
                    }
                }
            }
        }
        if (dead) {
            tex = zombiemanD[(frame_num) % 5];
            if (frame_num >= 5) {
                tex = zombiemanD[4];
            }
            flipTex = false;
        }
        // Thing::render(inv_cam_rot, cam_pos, dists_arr_ptr);

        int texHeight = (160 << SHIFT) / viewSpacePos.y;

        int screenSpaceX = ((((((viewSpacePos.x << SHIFT) / viewSpacePos.y) + (1 << SHIFT)) >> 1) * SCR_W) >> SHIFT) -
                           (texHeight >> 1);
        if (screenSpaceX + texHeight < 0 || screenSpaceX >= SCR_W) {
            return;
        }
        // just centered on screen
        int screenSpaceY = (RENDER_H - (texHeight)) >> 1;
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
                                           texHeight, ((int(flipTex) << 1) - 1) * (a << SHIFT) / texHeight);
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
                                                   screenSpaceY, texHeight,
                                                   ((int(flipTex) << 1) - 1) * (a << SHIFT) / texHeight);
                }
            }
        }
    }
    ivec2 forward;
    uint8_t frame_num;
    unsigned long prev_frame_time;
    gfx_sprite_t **anim_tex_arr;
    bool dead;
    bool flipTex;
    int health;
    enum State {
        STATE_IDLE,
        STATE_WALK,
        STATE_SHOOT,
        STATE_PAIN,
        STATE_DYING,
        STATE_DEAD,
    };
    State state;
};

#endif