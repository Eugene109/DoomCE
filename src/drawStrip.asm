
    assume adl=1

    section .rodata
    ; public lcdWidth
    lcdWidth := 320
    ; public lcdHeight
    lcdHeight := 240

    section .text

; scales a vertical texture strip using the bresenham line algorithm
    public _draw_strip
_draw_strip:
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
;    arg7: ???
; Returns:
;  None
    di
    ld  iy, 0           ;  set iy to stack pointer
    add iy, sp

    ; must save state of C++ stuff
    push bc
    push de
    push hl
    push ix

    ld  ix,(iy+3)       ;  destination
    ld  hl,(iy+6)       ;  source

    ld  bc,(iy+9)       ;  load x coord
    add ix,bc           ;  add x coord to dest pointer

    ld  b,(iy+12)       ;  load y pos
    ld  c, 160          ;  load 1/2 screen width
    mlt bc              ;  mult to find 1/2 offset
    add ix,bc           ;  add twice to add offset to dest
    add ix,bc
    ld  de,320          ;  screen width
    ld  c,(iy+15)       ;  target height

;---bresenham algorithm init---
    ; x is dest, y is source

    exx                 ;  swap to alternate register set
    ld  bc,(iy+15)      ;  dx = target height
    ld  de,64           ;  dy = source size
    ; hl is D,  D= 2dy-dx
    ld  hl,0
    add hl,de
    add hl,de
    and a,a             ; reset carry?
    sbc hl,bc

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
    add hl,de           ;  hl is D, de is dy
    add hl,de

    ; if( D > 0 ) {
    scf                 ;  set carry flag
    adc hl,de
    scf                 ;  set carry flag
    sbc hl,de
    jp  p,.positive     ;  jump to positive control

.negative:
    exx                 ;  swap back

    dec c               ;  c is counter
    jp  nz,.loop        ;  jump back to loop while more than 0

    pop ix
    pop hl
    pop de
    pop bc

    ei
    ret                 ;  if c is 0, return

; y is automatically incremented; no need for change
.positive:              ;  D = D - 2*dx;

    scf
    sbc hl,bc
    inc hl
    scf
    sbc hl,bc
    inc hl

    exx                 ;  swap back
    inc hl              ;  increment source

    dec c               ;  c is counter
    jp  nz,.loop        ;  jump back to loop while more than 0

    pop ix
    pop hl
    pop de
    pop bc

    ei
    ret                 ;  if c is 0, return

    assume adl=1