
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

    ld  iy, 0           ;  set iy to stack pointer
    add iy, sp

    ; must save state of C++ stuff
    push ix             ;  ix must be preserved

    ld  ix,(iy+3)       ;  destination

; finding offset for source
    ld  bc,(iy+12)      ;  y coord (negative)
    ld  hl,1
    and a,a             ;  reset carry
    sbc hl,bc           ;  abs of y coord + 1
    push hl                                                ;  stack:(k+1)
    ld  bc,64
    call __imuls
    ld  bc,(iy+15)      ;  target height
    call __idivs

    ld  bc,(iy+6)       ;  source
    add hl,bc

    ld  bc,(iy+9)       ;  load x coord
    add ix,bc           ;  add x coord to dest pointer

; figure out texture coordinate offset
    ld  e,(iy+18)       ;  texCoord, 0-255
    ld  d,64             ;  source size
    mlt de              ;  size scaled by texCoord in d, fixed point arithemetic
    ld  e,64
    mlt de              ;  de is now offset for source texCoord
    add hl,de           ;  add offset

    ld  de,320          ;  screen width
    ld  c,180           ;  target height


;---bresenham algorithm init---
    ; x is dest, y is source

    exx                 ;  swap to alternate register set
                        ;  (from before)                   ;  stack:(k+1)
    pop bc              ;  k+1                             ;  stack:
    ld  hl,128
    call __imuls        ;  hl is (k+1)*2*dy

    ld  bc,(iy+15)      ;  dx = target height
    push bc                                                ;  stack:(dx)
    ld  a,0
    sla c               ;  mult 2 for c(LSB)
    ex af,af'           ;  save carry bit to af'
    sla b               ;  mult 2 for b(MSB)
    ex af,af'           ;  retrieve carry bit from af'
    adc a,b             ;  add carry bit to b
    ld  b,a             ;  bc is now 2dx

    call __irems        ;  hl%bc, or ((k+1)*2*dy)%(2*dx)
    pop de              ;  dx                              ;  stack:
    and a,a             ;  reset carry
    sbc hl,de           ;  hl is D, D = (((k+1)*2*dy)%(2*dx))-dx

    ld  de,128          ;  2dy
    ; reminder: de = 2dy, bc = 2dx,     <-same as non-clipped drawStrip

    exx                 ;  swap back for loop
;----end of bresenham init-----
.loop:
    ld  a,(hl)
    ld  (ix),a
    ld  (ix+1),a
    ld  (ix+2),a
    ld  (ix+3),a

    add ix,de            ;  move down layer, aka jump by width

; now for bresenham part
; C code looks like this:
;plot(x, y);  <-- already done
;D = D + 2 * dy;
;if (D > 0) {
;    y = y + 1;
;    D = D - 2 * dx;
;}

    exx                 ;  bresenham data is stored on alt registers

;  D = D + 2*dy
    and a,a             ;  reset carry
    adc hl,de           ;  hl is D, de is dy

    ; if( D > 0 ) {
    jp  p,.positive     ;  jump to positive control

.negative:
    exx                 ;  swap back

    dec c               ;  c is counter
    jp  nz,.loop        ;  jump back to loop while more than 0

    pop ix              ;  ix must be preserved

    ei
    ret                 ;  if c is 0, return

; y is automatically incremented; no need for change
.positive:              ;  D = D - 2*dx;

    and a,a
    sbc hl,bc

    exx                 ;  swap back
    inc hl              ;  increment source

    dec c               ;  c is counter
    jp  nz,.loop        ;  jump back to loop while more than 0

    pop ix              ;  ix must be preserved before exit

    ei
    ret                 ;  if c is 0, return

.end:
    pop ix              ;  ix must be preserved before exit

    ei
    ret                 ;  if c is 0, return

    extern __imuls
    extern __irems
    extern __idivs

    assume adl=1