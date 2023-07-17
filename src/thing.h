#ifndef THING_H
#define THING_H

#include "matrixMath.h"
#include "vectorMath.h"
#include <graphx.h>

#include "gfx/gfx.h"

#define SCR_W 320

class Thing {
  public:
    Thing(const ivec2 &p) {
        pos = p;
        tex = gfx_MallocSprite(64, 64);
        gfx_SetTransparentColor(2);
        gfx_ConvertFromRLETSprite(thing_tex, tex);
    }
    virtual void render(const imat2 &inv_cam_rot, const ivec2 &cam_pos) {
        ivec2 viewSpacePos = inv_cam_rot * (pos - cam_pos);
        if (viewSpacePos.y <= 16) {
            return;
        }
        int texHeight = (64 << SHIFT) / viewSpacePos.y;

        int screenSpaceX = ((((((viewSpacePos.x << SHIFT) / viewSpacePos.y) + (1 << SHIFT)) >> 1) * SCR_W) >> SHIFT) -
                           (texHeight >> 1);
        // 90 is half of RENDER_H, 50 is half of standard unit-pixel conversion(100)
        int screenSpaceY = (90 + ((50 << SHIFT) / viewSpacePos.y)) - (texHeight);
        if (screenSpaceX < 0 || screenSpaceX >= (SCR_W - (texHeight >> 1)) || screenSpaceY > 180 - texHeight) {
            return;
        }
        gfx_SetTransparentColor(2);
        gfx_RotatedScaledTransparentSprite_NoClip(tex, screenSpaceX, screenSpaceY, 0, texHeight);
        // gfx_RotatedScaledTransparentSprite_NoClip(tex, 0, 0, 0, texHeight);
    }
    ivec2 pos;
    gfx_sprite_t *tex; // this is a sprite with height = 64
};

#endif