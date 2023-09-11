#ifndef THING_H
#define THING_H

#include "drawStrip.h"
#include "matrixMath.h"
#include "std_vector.h"
#include "vectorMath.h"
#include <graphx.h>

#include "gfx/gfx.h"

#define SCR_W 320

class Thing {
  public:
    Thing(const ivec2 &p) {
        pos = p;
        tex = thing_tex;
    }
    Thing() {}
    virtual void render(const imat2 &inv_cam_rot, const ivec2 &cam_pos, int *dists_arr_ptr) {
        ivec2 viewSpacePos = inv_cam_rot * (pos - cam_pos);
        if (viewSpacePos.y <= 69) { //  less than 240 <- height of screen
            return;
        }
        int texHeight = (160 << SHIFT) / viewSpacePos.y;

        int screenSpaceX = ((((((viewSpacePos.x << SHIFT) / viewSpacePos.y) + (1 << SHIFT)) >> 1) * SCR_W) >> SHIFT) -
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
    }
    ivec2 pos;
    gfx_sprite_t *tex; // this is a sprite with height = 64
    inline static vector<Thing> all_things_everywhere = vector<Thing>();
};

#endif