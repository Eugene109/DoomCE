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

#define NUM_FRAMES_ENEMY_WALK 4
#define NUM_FRAMES_ENEMY_DEATH 5
#define NUM_VIEWS_ENEMY 8

enum ViewDir { F = 0, FR = 1, R = 2, BR = 3, B = 4, BL = 5, L = 6, FL = 7 };

gfx_sprite_t *zombieman_walk[NUM_FRAMES_ENEMY_WALK][NUM_VIEWS_ENEMY] = {{0}};

gfx_sprite_t *zombieman_death[NUM_FRAMES_ENEMY_DEATH] = {0};

void initZombieTexArrs() {
    zombieman_walk[0][0] = zombiemanF0;
    zombieman_walk[1][0] = zombiemanF1;
    zombieman_walk[2][0] = zombiemanF2;
    zombieman_walk[3][0] = zombiemanF3;
    zombieman_walk[0][1] = zombiemanFR0;
    zombieman_walk[1][1] = zombiemanFR1;
    zombieman_walk[2][1] = zombiemanFR2;
    zombieman_walk[3][1] = zombiemanFR3;
    zombieman_walk[0][2] = zombiemanR0;
    zombieman_walk[1][2] = zombiemanR1;
    zombieman_walk[2][2] = zombiemanR2;
    zombieman_walk[3][2] = zombiemanR3;
    zombieman_walk[0][3] = zombiemanBR0;
    zombieman_walk[1][3] = zombiemanBR1;
    zombieman_walk[2][3] = zombiemanBR2;
    zombieman_walk[3][3] = zombiemanBR3;
    zombieman_walk[0][4] = zombiemanB0;
    zombieman_walk[1][4] = zombiemanB1;
    zombieman_walk[2][4] = zombiemanB2;
    zombieman_walk[3][4] = zombiemanB3;
    zombieman_walk[0][5] = zombiemanBR2;
    zombieman_walk[1][5] = zombiemanBR3;
    zombieman_walk[2][5] = zombiemanBR0;
    zombieman_walk[3][5] = zombiemanBR1;
    zombieman_walk[0][6] = zombiemanR2;
    zombieman_walk[1][6] = zombiemanR3;
    zombieman_walk[2][6] = zombiemanR0;
    zombieman_walk[3][6] = zombiemanR1;
    zombieman_walk[0][7] = zombiemanFR2;
    zombieman_walk[1][7] = zombiemanFR3;
    zombieman_walk[2][7] = zombiemanFR0;
    zombieman_walk[3][7] = zombiemanFR1;
    zombieman_death[0] = zombiemanD0;
    zombieman_death[1] = zombiemanD1;
    zombieman_death[2] = zombiemanD2;
    zombieman_death[3] = zombiemanD3;
    zombieman_death[4] = zombiemanD4;
}

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
        tex = zombieman_walk[frame_num][F];
        anim_tex_arr = zombieman_walk[frame_num];
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
        initZombieTexArrs();
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
        anim_tex_arr = zombieman_walk[(frame_num) & 0x03];
    }
    void UpdateView(fixed dotF, fixed dotR) {
        flipTex = false;
        if (dotF > 236) {
            tex = anim_tex_arr[F];
        } else if (dotF > 98) {
            if (dotR > 0) {
                tex = anim_tex_arr[FR];
            } else {
                tex = anim_tex_arr[FL];
                flipTex = true;
            }
        } else if (dotF > -98) {
            if (dotR > 0) {
                tex = anim_tex_arr[R];
            } else {
                tex = anim_tex_arr[L];
                flipTex = true;
            }
        } else if (dotF > -236) {
            if (dotR > 0) {
                tex = anim_tex_arr[BR];
            } else {
                tex = anim_tex_arr[BL];
                flipTex = true;
            }
        } else {
            tex = anim_tex_arr[B];
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
        UpdateView(dot(forward, viewDir), -dot(right, viewDir));
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
            tex = zombieman_death[(frame_num) % 5];
            if (frame_num >= 5) {
                tex = zombieman_death[4];
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
};

#endif