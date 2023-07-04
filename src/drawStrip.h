#include <graphx.h>

#ifdef __cplusplus
extern "C" {
#endif

void draw_strip(const uint8_t *dest, const uint8_t *texturePtr, int xPos, int yPos, int height, fixed texCoord,
                int darken_factor);

#ifdef __cplusplus
};
#endif