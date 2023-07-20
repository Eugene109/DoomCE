1. run genGlobalPalette.py         ;  reads colormap.png and inputs them into the palette for convimg

2. "make gfx" with convimg.yaml    ;  generates all sprites
    IMPORTANT: make gfx will erase < #include "brick_wall.h" > from gfx.h, MUST include back in

4. run genOneBuffer.py             ;  generates unified buffer for brick wall texture
