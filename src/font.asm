
    assume adl=1

    section .rodata
    public lcdWidth
    lcdWidth := 320
    public lcdHeight
    lcdHeight := 240

    section .text
; draws a character from a font image
    public _draw_font
_draw_font:
; draws a character from a list of characters
; Arguments:
;    // technically arg0: return address
;    arg1: pointer to destination
;    arg2: pointer to font image
;    arg3: character x size
;    arg4: character y size
;    arg5: character index
; Returns:
;    None
    ld  iy,0
    add iy,sp

    di                  ;  disables interrupts, these use alternate register set, which this needs
    push ix

    ld  e,(iy+15)
    ld  d,(iy+9)
    mlt de              ;  now contains horizontal offset in pixels

    ld  hl,320
    ld  bc,(iy+9)
    sbc hl,bc           ;  amount for vertical step down in screen, also texture because texture width = 320
    ld  b,h
    ld  c,l             ;  move to hl
    ld  hl,(iy+6)       ;  start of font sprite
    add hl,de
    ld  d,(iy+9)
    ex  af,af'
    ld  a,(iy+9)
    ex  af,af'
    ld  e,(iy+12)
    ld  ix,(iy+3)
.loop:
    ld  a,(hl)
    dec a               ;  1 is transparent index
    jp  z,.skip
    inc a
    ld  (ix),a
.skip:
    inc hl
    inc ix
    dec d
    jp  nz,.loop
    add hl,bc
    add ix,bc           ;  move down
    ex  af,af'
    ld  d,a             ;  restore d(x counter)
    ex  af,af'
    dec e
    jp  nz,.loop
    pop ix
    ei
    ret
