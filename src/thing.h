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
        if (viewSpacePos.y <= 69) { //  less than 240 <- height of screen
            return;
        }
        int texHeight = (64 << SHIFT) / viewSpacePos.y;

        int screenSpaceX = ((((((viewSpacePos.x << SHIFT) / viewSpacePos.y) + (1 << SHIFT)) >> 1) * SCR_W) >> SHIFT) -
                           (texHeight >> 1);
        // 90 is half of RENDER_H, 80 is half of standard unit-pixel conversion(160)
        int screenSpaceY = (90 + ((80 << SHIFT) / viewSpacePos.y)) - (texHeight);
        if (screenSpaceX + texHeight < 0 || screenSpaceX >= SCR_W || screenSpaceY < 0) {
            return;
        }
        gfx_SetTransparentColor(2);
        gfx_sprite_t *tex_conv = gfx_MallocSprite(texHeight, texHeight);
        gfx_ScaleSprite(tex, tex_conv);
        if (screenSpaceY + texHeight > 180) {
            tex_conv->height = 180 - screenSpaceY;
        }
        gfx_TransparentSprite(tex_conv, screenSpaceX, screenSpaceY);
        delete tex_conv;
        // gfx_RotatedScaledTransparentSprite_NoClip(tex, 0, 0, 0, texHeight);
    }
    ivec2 pos;
    gfx_sprite_t *tex; // this is a sprite with height = 64
};

#endif