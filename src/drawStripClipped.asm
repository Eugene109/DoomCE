
    assume adl=1
    ;https://youtube.com/shorts/f0--ib8HpOM?feature=share

    section .rodata
    ; public lcdWidth
    lcdWidth := 320
    ; public lcdHeight
    lcdHeight := 240

    section .text

; scales a vertical texture strip using the bresenham line algorithm
    public _draw_strip_clipped
_draw_strip_clipped:           ; this is most likely at D1E3BE
; draws a strip of texture, scaled, as fast as possible(hopefully)
; strip will be centered in future, for now will center before calling
; Arguments:
;    // technically arg0: return address
;    arg1: pointer to destination
;    arg2: pointer to texture structure
;    arg3: x coordinate
;    arg4: y coordinate
;    arg5: target height
;    arg6: texcoord
; Returns:
;  None
    di                  ;  disables interrupts, these use alternate register set, which this needs

    ld  iy,0            ;  set iy to stack pointer
    add iy,sp

    ; must save state of C++ stuff
    push ix             ;  ix must be preserved

    ld  ix,(iy+3)       ;  destination
    ld  de,(iy+9)       ;  load x coord
    add ix,de           ;  add x coord to dest pointer

; finding offset for source
    ld  de,(iy+12)      ;  y coord (negative)
    ld  hl,0
    and a,a             ;  reset carry
    sbc hl,de           ;  abs of y coord

    ld  de,(iy+15)      ;  target height
    ld  iy,_64_divis_lut
    add iy,de
    add iy,de
    add iy,de
    ld  bc,(iy-3)
    call _imulu         ;  64/target_height  *  abs(y_coord)    =  abs(y_coord)/target_height *  64
    ex  af, af'
    ld  a,l             ;  fractional part of hl
    ex  af, af'
    ld  c,h             ;  integer part of hl
    ld  b,0

    ld  hl,(iy+6)       ;  source
; figure out texture coordinate offset
    ld  e,(iy+18)       ;  texCoord, 0-255
    ld  d,64            ;  source size
    mlt de              ;  size scaled by texCoord in d, fixed point arithemetic
    ld  e,64
    mlt de              ;  de is now offset for source texCoord
    add hl,de           ;  add offset

    add hl,bc
    ld  b,e             ;  64/target_height
    ld  de,0

    exx
    ld  de,320          ;  screen width
    exx
    ld  c,180           ;  target height

;----end of init-----
.loop:
    ld  a,(hl)
    ld  (ix),a
    ld  (ix+1),a
    ld  (ix+2),a
    ld  (ix+3),a

    exx
    add ix,de
    exx

    ex  af,af'
    add a,b
    adc hl,de
    ex  af,af'

    dec c               ;  c is counter
    jp  nz,.loop        ;  jump back to loop while more than 0

    pop ix              ;  ix must be preserved

    ei
    ret                 ;  if c is 0, return

.end:
    pop ix              ;  ix must be preserved before exit

    ei
    ret                 ;  if c is 0, return

    extern __imuls
    extern __imulu
    extern __irems
    extern __idivs
    extern _64_divis_lut

    assume adl=1