#ifndef PLAYER_H
#define PLAYER_H

#include <graphx.h>
#include <keypadc.h>

#include <sys/timers.h>
#include <ti/getcsc.h>

// should probably rotate images 90° clockwise because row-major order
// then can just memcpy into different sprite;
#include "gfx/gfx.h"

#include "gfx/textures.h"

#include "fixed.h"
#include "matrixMath.h"
#include "vectorMath.h"

#include "drawStrip.h"
#include "raycast.h"

class Player {
  public:
    ivec2 pos;
    ivec2 forward;
    uint8_t rot;
    uint8_t health;
    uint8_t armour;
    uint8_t ammo;
    Player(ivec2 position, uint8_t rotation) : pos(position), rot(rotation) {
        forward = rotate(rot) * ivec2(0, 1 << SHIFT);
        health = 100;
        armour = 0;
        ammo = 50;
    }
    void dealDamage(uint8_t dmg) { health -= dmg; }
    uint8_t getHealth() { return health; }
    uint8_t getArmour() { return armour; }
    bool hasAmmo() { return ammo; }
    uint8_t getAmmo() { return ammo; }
    void shoot() { ammo--; }
    ivec2 getPos() { return pos; }
    ivec2 getRot() { return rot; }
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
        return;
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

#endif