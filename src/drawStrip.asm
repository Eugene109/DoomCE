
    assume adl=1

    section .rodata
    ; public lcdWidth
    lcdWidth := 320
    ; public lcdHeight
    lcdHeight := 240

    section .text

    public _draw_strip
_draw_strip:
; draws a strip of texture, scaled, as fast as possible(hopefully)
; strip will be centered in future, for now will center before calling
; Arguments:
;  arg0: pointer to destination
;  arg1: pointer to texture structure
;  arg2: x coordinate
;  arg3: y coordinate
;  arg4: target height
; Returns:
;  None
    ld  iy, 0
    add iy, sp

    ld a,240            ;  how tall

    ld  de,(iy+3)       ;  destination
    ld  hl,(iy+6)       ;  source
    ld  bc, 320         ;  screen width
.loop:
    ldi                 ;  send to dest (de) from src(hl) + increment hl
    dec de              ;  automatically incremented, must correct 
    inc bc              ;  same as above
    ex de,hl            ;  swap de & hl for idk reasons
    add hl,bc           ;  move down layer, aka jump by width
    ex de,hl            ;  swap back
    dec a               ;  a is counter
    jp nz,.loop         ;  jump back to loop while more than 0

    ld  bc,(iy+9)     ;  x coordinate
    ; add	hl,bc
    ; ld  d, 160 ;lcdWidth / 2
    ; ld  e,(iy + 12)      ;  y coordinate
    ; mlt de
    ; add hl,de
    ; add hl,de
    ; ex  de,hl           ; de = start draw location

    ; ld a, (iy + 15) ; might be wrong, but a is target height?

    ; ld  hl,(iy+6)       ; hl = sprite structure

    ; find correct offset for strip
    ; then, add hl, //offset idk
    ; .loop:
    ; ld (de), (hl)
    ; // add lcd width to de, maybe done by halving and doing twice? idk
    ; // bresenham for hl
    ; dec a
    ; jr
    ; ld de,(5)

    ret

    assume adl=1