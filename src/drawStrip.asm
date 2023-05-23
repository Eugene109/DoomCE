

;-------------------------------------------------------------------------------
; include 'library.inc'
;-------------------------------------------------------------------------------
    assume adl=1

    ; section .rodata
    ; public lcdWidth
    ; lcdWidth := 320
    ; public lcdHeight
    ; lcdHeight := 240

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
    ld iy, 0
    add iy, sp
    
    ld  hl,(iy+3)       ;  destination
    ld  bc,(iy + 9)     ;  x coordinate
    add	hl,bc
    ld  d, 160 ;lcdWidth / 2
    ld  e,(iy + 12)      ;  y coordinate
    mlt de
    add hl,de
    add hl,de
    ex  de,hl           ; de = start draw location

    ld a, (iy + 15) ; might be wrong, but a is target height?

    ld  hl,(iy+6)       ; hl = sprite structure
    ; find correct offset for strip
    ; then, add hl, //offset idk
    ; .loop:
    ; ld (de), (hl)
    ; // add lcd width to de, maybe done by halving and doing twice? idk
    ; // bresenham for hl
    ; dec a
    ; jr

    push de
    ret

    assume adl=1