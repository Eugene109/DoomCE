#include <graphx.h>

#include "fixed.h"

#ifdef __cplusplus
extern "C" {
#endif

#define RENDER_H 208

void draw_strip(const uint8_t *dest, const uint8_t *texturePtr, int xPos, int yPos, int height, fixed texCoord);

void draw_strip_clipped(const uint8_t *dest, const uint8_t *texturePtr, int xPos, int yPos, int height, fixed texCoord);

void draw_strip_transparent(const uint8_t *dest, const uint8_t *texturePtr, int xPos, int yPos, int height,
                            fixed texCoord);

void draw_strip_transparent_clipped(const uint8_t *dest, const uint8_t *texturePtr, int xPos, int yPos, int height,
                                    fixed texCoord);

#ifdef __cplusplus
};
#endif