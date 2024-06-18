assume adl=1

section .data

public x1
public y1
public dx
public dy
public x2
public y2
public c1
public c2
public parent

x1:=1
y1:=4
dx:=7
dy:=10
x2:=13
y2:=16
c1:=19
c2:=22
parent:=26


public _cos_table_255_256
_cos_table_255_256:
    db $FF,$FE,$FE,$FE,$FD,$FD,$FC,$FB,$FA,$F8,$F7,$F5,$F4,$F2,$F0,$ED,$EB,$E9,$E6,$E3,$E0,$DD,$DA,$D7,$D4,$D0,$CC,$C9,$C5,$C1
    db $BC,$B8,$B4,$AF,$AB,$A6,$A1,$9C,$97,$92,$8D,$88,$83,$7D,$78,$72,$6D,$67,$61,$5B,$55,$4F,$4A,$44,$3D,$37,$31,$2B,$25,$1F
    db $18,$12,$0C,$06,$00,$06,$0C,$12,$18,$1F,$25,$2B,$31,$37,$3D,$44,$4A,$4F,$55,$5B,$61,$67,$6D,$72,$78,$7D,$83,$88,$8D,$92
    db $97,$9C,$A1,$A6,$AB,$AF,$B4,$B8,$BC,$C1,$C5,$C9,$CC,$D0,$D4,$D7,$DA,$DD,$E0,$E3,$E6,$E9,$EB,$ED,$F0,$F2,$F4,$F5,$F7,$F8
    db $FA,$FB,$FC,$FD,$FD,$FE,$FE,$FE,$FF,$FE,$FE,$FE,$FD,$FD,$FC,$FB,$FA,$F8,$F7,$F5,$F4,$F2,$F0,$ED,$EB,$E9,$E6,$E3,$E0,$DD
    db $DA,$D7,$D4,$D0,$CC,$C9,$C5,$C1,$BC,$B8,$B4,$AF,$AB,$A6,$A1,$9C,$97,$92,$8D,$88,$83,$7D,$78,$72,$6D,$67,$61,$5B,$55,$4F
    db $4A,$44,$3D,$37,$31,$2B,$25,$1F,$18,$12,$0C,$06,$00,$06,$0C,$12,$18,$1F,$25,$2B,$31,$37,$3D,$44,$4A,$4F,$55,$5B,$61,$67
    db $6D,$72,$78,$7D,$83,$88,$8D,$92,$97,$9C,$A1,$A6,$AB,$AF,$B4,$B8,$BC,$C1,$C5,$C9,$CC,$D0,$D4,$D7,$DA,$DD,$E0,$E3,$E6,$E9
    db $EB,$ED,$F0,$F2,$F4,$F5,$F7,$F8,$FA,$FB,$FC,$FD,$FD,$FE,$FE,$FE

public _sin_table_255_256
_sin_table_255_256:
    db $00,$06,$0C,$12,$18,$1F,$25,$2B,$31,$37,$3D,$44,$4A,$4F,$55,$5B,$61,$67,$6D,$72,$78,$7D,$83,$88,$8D,$92,$97,$9C,$A1,$A6
    db $AB,$AF,$B4,$B8,$BC,$C1,$C5,$C9,$CC,$D0,$D4,$D7,$DA,$DD,$E0,$E3,$E6,$E9,$EB,$ED,$F0,$F2,$F4,$F5,$F7,$F8,$FA,$FB,$FC,$FD
    db $FD,$FE,$FE,$FE,$FF,$FE,$FE,$FE,$FD,$FD,$FC,$FB,$FA,$F8,$F7,$F5,$F4,$F2,$F0,$ED,$EB,$E9,$E6,$E3,$E0,$DD,$DA,$D7,$D4,$D0
    db $CC,$C9,$C5,$C1,$BC,$B8,$B4,$AF,$AB,$A6,$A1,$9C,$97,$92,$8D,$88,$83,$7D,$78,$72,$6D,$67,$61,$5B,$55,$4F,$4A,$44,$3D,$37
    db $31,$2B,$25,$1F,$18,$12,$0C,$06,$00,$06,$0C,$12,$18,$1F,$25,$2B,$31,$37,$3D,$44,$4A,$4F,$55,$5B,$61,$67,$6D,$72,$78,$7D
    db $83,$88,$8D,$92,$97,$9C,$A1,$A6,$AB,$AF,$B4,$B8,$BC,$C1,$C5,$C9,$CC,$D0,$D4,$D7,$DA,$DD,$E0,$E3,$E6,$E9,$EB,$ED,$F0,$F2
    db $F4,$F5,$F7,$F8,$FA,$FB,$FC,$FD,$FD,$FE,$FE,$FE,$FF,$FE,$FE,$FE,$FD,$FD,$FC,$FB,$FA,$F8,$F7,$F5,$F4,$F2,$F0,$ED,$EB,$E9
    db $E6,$E3,$E0,$DD,$DA,$D7,$D4,$D0,$CC,$C9,$C5,$C1,$BC,$B8,$B4,$AF,$AB,$A6,$A1,$9C,$97,$92,$8D,$88,$83,$7D,$78,$72,$6D,$67
    db $61,$5B,$55,$4F,$4A,$44,$3D,$37,$31,$2B,$25,$1F,$18,$12,$0C,$06

public _sign_table_fx_fy
_sign_table_fx_fy:
    db 0000b,0000b,0000b,0000b,0000b,0000b,0000b,0000b,0000b,0000b,0000b,0000b,0000b,0000b,0000b,0000b,0000b,0000b,0000b,0000b
    db 0000b,0000b,0000b,0000b,0000b,0000b,0000b,0000b,0000b,0000b,0000b,0000b,0000b,0000b,0000b,0000b,0000b,0000b,0000b,0000b
    db 0000b,0000b,0000b,0000b,0000b,0000b,0000b,0000b,0000b,0000b,0000b,0000b,0000b,0000b,0000b,0000b,0000b,0000b,0000b,0000b
    db 0000b,0000b,0000b,0000b,0000b,1010b,1010b,1010b,1010b,1010b,1010b,1010b,1010b,1010b,1010b,1010b,1010b,1010b,1010b,1010b
    db 1010b,1010b,1010b,1010b,1010b,1010b,1010b,1010b,1010b,1010b,1010b,1010b,1010b,1010b,1010b,1010b,1010b,1010b,1010b,1010b
    db 1010b,1010b,1010b,1010b,1010b,1010b,1010b,1010b,1010b,1010b,1010b,1010b,1010b,1010b,1010b,1010b,1010b,1010b,1010b,1010b
    db 1010b,1010b,1010b,1010b,1010b,1010b,1010b,1010b,0000b,1111b,1111b,1111b,1111b,1111b,1111b,1111b,1111b,1111b,1111b,1111b
    db 1111b,1111b,1111b,1111b,1111b,1111b,1111b,1111b,1111b,1111b,1111b,1111b,1111b,1111b,1111b,1111b,1111b,1111b,1111b,1111b
    db 1111b,1111b,1111b,1111b,1111b,1111b,1111b,1111b,1111b,1111b,1111b,1111b,1111b,1111b,1111b,1111b,1111b,1111b,1111b,1111b
    db 1111b,1111b,1111b,1111b,1111b,1111b,1111b,1111b,1111b,1111b,1111b,1111b,0000b,0101b,0101b,0101b,0101b,0101b,0101b,0101b
    db 0101b,0101b,0101b,0101b,0101b,0101b,0101b,0101b,0101b,0101b,0101b,0101b,0101b,0101b,0101b,0101b,0101b,0101b,0101b,0101b
    db 0101b,0101b,0101b,0101b,0101b,0101b,0101b,0101b,0101b,0101b,0101b,0101b,0101b,0101b,0101b,0101b,0101b,0101b,0101b,0101b
    db 0101b,0101b,0101b,0101b,0101b,0101b,0101b,0101b,0101b,0101b,0101b,0101b,0101b,0101b,0101b,0101b

public _root_node
_root_node:
    db $00        ; numSectors              ; Mmn
    dl $000200    ; x1                      ; Mmn+1
    dl $000500    ; y1                      ; Mmn+4
    dl $000100    ; dx                      ; Mmn+7
    dl $000000    ; dy                      ; Mmn+10
    dl _node_a    ; - child                 ; Mmn+19
    dl _node_b    ; + child                 ; Mmn+22
    db "A"        ; wallType                ; Mmn+25
    dl $000000    ; parent node pointer

_node_a:
    db $00        ; numSectors
    dl $000400    ; x1
    dl $000300    ; y1 
    dl $FFFC00    ; dx
    dl $000000    ; dy
    dl _leaf_a    ; - child
    dl _leaf_b    ; + child
    db "A"        ; wallType
    dl _root_node ; parent node pointer
_node_b:
    db $00        ; numSectors
    dl $0002C0    ; x1
    dl $0005C0    ; y1
    dl $FFFF40    ; dx
    dl $FFFF40    ; dy
    dl _leaf_c    ; - child
    dl _leaf_d    ; + child
    db "A"        ; wallType
    dl _root_node ; parent node pointer

_leaf_a:
    db $02

    dl $000000    ; x1
    dl $000300    ; y1 
    dl $000000    ; dx
    dl $000200    ; dy
    db "A"        ; wallType

    dl $000600    ; x1
    dl $000500    ; y1 
    dl $000000    ; dx
    dl $FFFE00    ; dy
    db "A"        ; wallType

    dl _node_a    ; parent node pointer
_leaf_b:
    db $04

    dl $000600    ; x1
    dl $000300    ; y1
    dl $000080    ; dx
    dl $FFFE20    ; dy
    dl $000680    ; x2
    dl $000120    ; y2
    db "A"        ; wallType

    dl $000680    ; x1
    dl $000120    ; y1
    dl $FFFEA0    ; dx
    dl $FFFF40    ; dy
    dl $000520    ; x2
    dl $000060    ; y2
    db "A"        ; wallType

    dl $000520    ; x1
    dl $000060    ; y1
    dl $FFFEA0    ; dx
    dl $000120    ; dy
    dl $0003C0    ; x2
    dl $000180    ; y2
    db "A"        ; wallType

    dl $0003C0    ; x1
    dl $000180    ; y1
    dl $000040    ; dx
    dl $000180    ; dy
    dl $000400    ; x2
    dl $000300    ; y2
    db "A"        ; wallType

    dl _node_a    ; parent node pointer
_leaf_c:
    db $02

    dl $000000    ; x2
    dl $000500    ; y2
    dl $000000    ; dx
    dl $000200    ; dy
    dl $000000    ; x1
    dl $000700    ; y1
    db "A"        ; wallType

    dl $000000    ; x1
    dl $000700    ; y1
    dl $000400    ; dx
    dl $000000    ; dy
    dl $000400    ; x2
    dl $000700    ; y2
    db "A"        ; wallType

    dl _node_b    ; parent node pointer
_leaf_d:
    db $03

    dl $000300    ; x1
    dl $000500    ; y1
    dl $FFFFC0    ; dx
    dl $0000C0    ; dy
    dl $0002C0    ; x2
    dl $0005C0    ; y2
    db "A"        ; wallType

    dl $000400    ; x1
    dl $000700    ; y1
    dl $000200    ; dx
    dl $000000    ; dy
    dl $000600    ; x2
    dl $000700    ; y2
    db "A"        ; wallType

    dl $000600    ; x1
    dl $000700    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    dl $000600    ; x2
    dl $000500    ; y2
    db "A"        ; wallType

    dl _node_b    ; parent node pointer


section .text


public _fdivs
_fdivs:
    ld  iy,0
    add iy,sp
    ld  hl,(iy+3)
    ld  de,(iy+6)


; v1:   ++: 75cc, -+: 87cc, +- : 89cc, --: 89cc
    ; hl & de input
    bit 7,h
    ld  a,0
    jp  z,.pos_m1
    ; negate hl
    ld  sp,hl
    sbc hl,hl     ;  (add iy,sp) reset carry bit
    sbc hl,sp     ;  should not have had to borrow
    inc a
.pos_m1:
    bit 7,d
    jp  z,.pos_m2
    ; negate de
    ex  de,hl
    ld  sp,hl
    and a,a
    sbc hl,hl
    sbc hl,sp     ;  should not have had to borrow
    inc a
.pos_m2:
    ex  af,af'

    ld  a,0
.fdivs_loop:
    srl h
    rr  l
    srl d
    rr  e

    cp  a,d
    jp  nz,.fdivs_loop

    ld  d,e
    inc d
    mlt de
    srl d
    rr  e         ;  divide by 2
    add hl,de
    ld  bc,(iy+9) ;  address of LUT
    add hl,bc
    ld  a,(hl)    ;  use the LUT

    ; 16 cc if negate   10 cc if not
    ex  af,af'
    bit 0,a
    jp  z,.ret_fdivs
    ; negate hl
    ex  af, af'
    and a,a
    sbc hl,hl
    neg
    ld  l,a
                                                    ld sp,iy
    ret

.ret_fdivs:
    ex  af, af'
    and a,a
    sbc hl,hl
    ld  l,a
                                                    ld sp,iy
    ret
; v1 end


public _fmuls
_fmuls:
    ld  iy,0
    add iy,sp
    ld  hl,(iy+3)
    ld  de,(iy+6)


; v5:   ++: 75cc, -+: 87cc, +- : 89cc, --: 89cc
    ; hl & de input
    bit 7,h
    ld  a,0
    jp  z,.pos_m1
    ; negate hl
    ld  sp,hl
    sbc hl,hl     ;  (add iy,sp) reset carry bit
    sbc hl,sp     ;  should not have had to borrow
    inc a
.pos_m1:
    bit 7,d
    jp  z,.pos_m2
    ; negate de
    ex  de,hl
    ld  sp,hl
    and a,a
    sbc hl,hl
    sbc hl,sp     ;  should not have had to borrow
    inc a
.pos_m2:
    ex  af,af'

    ld  b,l
    ld  c,e
    mlt bc        ;  bc = e*l
    ld  a,b       ;  a = e*l >> 8, only taking 1st byte

    ld  b,d
    ld  c,l       ;  bc = d l
    ld  d,h       ;  de = h e
    ld  l,b ; b=d ;  hl = h d
    mlt hl        ;  hl = h*d
    mlt de        ;  de = h*e
    mlt bc        ;  bc = d*l
    add a,c
    ld  c,a       ;  adding msb of e*l>>8 to bc, which goes to hl
    ld  a,0
    adc a,l
    ld  l,a       ;  adding carry bit from before, and hoping it doesn't overflow
            ld  a,0
            adc a,h
            ld  h,a       ;  This part would fix the hoping bit for 3 cc

    add hl,hl     ;  hl << 8
    add hl,hl
    add hl,hl
    add hl,hl
    add hl,hl
    add hl,hl
    add hl,hl
    add hl,hl

    add hl,bc
    add hl,de     ;  hl = h*d<<8 + h*e + d*l + l*e>>8

    ; 16 cc if negate   10 cc if not
    ex  af,af'
    bit 0,a
    jp  z,.ret_fmuls
    ; negate hl
    ld  sp,hl
    and a,a
    sbc hl,hl
    sbc hl,sp     ;  should not have had to borrow

.ret_fmuls:
                                                    ld sp,iy
    ret
; v5 end


; ------------------ idk
    ; hl contains screenspace x-coord [-1.0, 1.0]
    inc h
    srl h
    ld  a,l
    rra
    ; (hl+1)/2 -> [h][a]
    rr  h        ;  will put set carry if hl >= 1, else reset
    sbc a,0      ;  subs 1 from 256 if carry
    ; a now contains ndc x-coord [0,1.0)
    ld  h,80
    ld  l,a
    mlt hl       ;  contains pixel group number
            ;  alternative to find exact pixel x-coord
            ; ld  h,240
            ; ld  l,a
            ; mlt hl       ;  contains pixel line number

















; -----------------















; v4: 46cc     (accounts for l*c>>16)
    ; hl & bc input
    ld  d,l
    ld  e,c
    mlt de
    ld  a,d

    ld  d,b
    ld  e,l       ;  de = b l
    ld  b,h       ;  bc = h c
    ld  l,d ; d=b ;  hl = h b
    mlt hl        ;  hl = h*b
    mlt bc        ;  bc = h*c
    mlt de        ;  de = b*l
    add a,e
    ld  e,a       ;  adding msb of e*l>>8 to de, which goes to hl
    ld  a,0
    adc a,l
    ld  l,a       ;  adding carry bit from before, and hoping it doesn't overflow
            ; ld  a,0
            ; adc a,h
            ; ld  h,a       ;  This part would fix the hoping bit for 3 ccs

    add hl,hl     ;  hl << 8
    add hl,hl
    add hl,hl
    add hl,hl
    add hl,hl
    add hl,hl
    add hl,hl
    add hl,hl

    add hl,bc
    add hl,de     ;  hl = d*b<<8 + b*c + d*e

    ret
; v4 end


; v3: 32cc     (does not account for l*c>>16, max error <= 255ish)
    ; hl & bc input
    ld  d,b
    ld  e,l       ;  de = b l
    ld  b,h       ;  bc = h c
    ld  l,d ; d=b ;  hl = h b
    mlt hl        ;  hl = h*b
    add hl,hl     ;  hl << 8
    add hl,hl
    add hl,hl
    add hl,hl
    add hl,hl
    add hl,hl
    add hl,hl
    add hl,hl
    mlt bc        ;  bc = h*c
    mlt de        ;  de = b*l
    add hl,bc
    add hl,de     ;  hl = d*b<<8 + b*c + d*e
    
    ret
; v3 end









public _render_bsp
_render_bsp:
; renders the binary space partition tree
; Arguments:
;    // technically arg0: return address
;    arg1: pointer to wall
;    arg2: player x
;    arg3: player y
;    arg4: forward x
;    arg5: forward y
; Returns:
;  None
    di                  ;  disables interrupts, these use alternate register set, which this needs
    push ix             ;  needs to be preserved

    ld  iy,0
    add iy,sp
    ld  ix,(iy+3)       ;  pointer to start of bsp tree

.check_node:
    ; ix: pointer to node
    ld  a,(ix)          ;  numSectors
    cp  a,0
    jp  nz,.leaf_node

.parent_node:




;  cross product edge func
    ; iy: pointer to stack
    ; ix: pointer to node

    ld  bc,(ix+x1)       ;  ray start x
    ld  hl,(iy+6)       ;  player x
    and a,a
    sbc hl,bc           ;  Bx
    ld  bc,(ix+dy)      ;  Ay

;   mult Ay, Bx
   ;call _fmuls
        ld  d,b
        ld  e,l       ;  de = b l
        ld  b,h       ;  bc = h c
        ld  l,d ; d=b ;  hl = h b
        mlt hl        ;  hl = h*b
        add hl,hl     ;  hl << 8
        add hl,hl
        add hl,hl
        add hl,hl
        add hl,hl
        add hl,hl
        add hl,hl
        add hl,hl
        mlt bc        ;  bc = h*c
        mlt de        ;  de = b*l
        add hl,bc
        add hl,de     ;  hl = d*b<<8 + b*c + d*e
    push hl             ;  stack contains Ay*Bx        SP+0

    ld  bc,(ix+y1)       ;  ray start y
    ld  hl,(iy+9)       ;  player y
    and a,a
    sbc hl,bc           ;  By
    ld  bc,(ix+dx)       ;  Ax

; mult Ax, By
   ;call _fmuls
        ld  d,b
        ld  e,l       ;  de = b l
        ld  b,h       ;  bc = h c
        ld  l,d ; d=b ;  hl = h b
        mlt hl        ;  hl = h*b
        add hl,hl     ;  hl << 8
        add hl,hl
        add hl,hl
        add hl,hl
        add hl,hl
        add hl,hl
        add hl,hl
        add hl,hl
        mlt bc        ;  bc = h*c
        mlt de        ;  de = b*l
        add hl,bc
        add hl,de     ;  hl = d*b<<8 + b*c + d*e
    pop  de             ;  de contains Ay*Bx           SP+0

    and a,a
    sbc hl,de           ;  Ax*By - Ay*Bx
    jp  p,.positive

.negative:
    ld  ix,(ix+c1)
    jp  .check_node

.positive:
    ld  ix,(ix+c2)
    jp  .check_node

.leaf_node:

    inc ix
.loop:

    ; begin by culling backfaces
;  cross product edge func
    ; iy: pointer to stack
    ; ix: pointer to node

    ld  bc,(ix)       ;  ray start x
    ld  hl,(iy+6)     ;  player x
    and a,a
    sbc hl,bc         ;  Bx
    ld  bc,(ix+9)     ;  Ay

;   mult Ay, Bx
   ;call _fmuls
        ld  d,b
        ld  e,l       ;  de = b l
        ld  b,h       ;  bc = h c
        ld  l,d ; d=b ;  hl = h b
        mlt hl        ;  hl = h*b
        add hl,hl     ;  hl << 8
        add hl,hl
        add hl,hl
        add hl,hl
        add hl,hl
        add hl,hl
        add hl,hl
        add hl,hl
        mlt bc        ;  bc = h*c
        mlt de        ;  de = b*l
        add hl,bc
        add hl,de     ;  hl = d*b<<8 + b*c + d*e
    push hl           ;  stack contains Ay*Bx        SP+0

    ld  bc,(ix+3)     ;  ray start y
    ld  hl,(iy+9)     ;  player y
    and a,a
    sbc hl,bc         ;  By
    ld  bc,(ix+6)     ;  Ax

; mult Ax, By
   ;call _fmuls
        ld  d,b
        ld  e,l       ;  de = b l
        ld  b,h       ;  bc = h c
        ld  l,d ; d=b ;  hl = h b
        mlt hl        ;  hl = h*b
        add hl,hl     ;  hl << 8
        add hl,hl
        add hl,hl
        add hl,hl
        add hl,hl
        add hl,hl
        add hl,hl
        add hl,hl
        mlt bc        ;  bc = h*c
        mlt de        ;  de = b*l
        add hl,bc
        add hl,de     ;  hl = d*b<<8 + b*c + d*e
    pop  de           ;  de contains Ay*Bx           SP+0

    and a,a
    sbc hl,de         ;  Ax*By - Ay*Bx
    jp  m,.continue   ;  backface culling
    ;



.continue:
    lea ix, ix+3*6+1
    dec a
    jp  nz,.loop

    

.end:
    ei
    pop ix
    ret

public _render_wall
_render_wall:
; renders just one wall
; Arguments:
;    // technically arg0: return address
;    arg1: pointer to wall
;    arg2: player x
;    arg3: player y
;    arg4: forward angle
; Returns:
;  None
    di                  ;  disables interrupts, these use alternate register set, which this needs

    ld  iy,0
    add iy,sp

    push ix             ;  needs to be preserved
    ld  ix,(iy+3)       ;  pointer to start of line seg

;    a will be used to determine if the product needs to be negated
;    %0000[m4][m3][m2][m1]
;    m1: x1*fy
;    m2: x1*fx
;    m3: y1*fy
;    m4: y1*fx

;    x1: |= 0011
;    fy: |= 0101
;    y1: |= 1100
;    fx: |= 1010
    ld  bc,(iy+12)
    ld  hl,_cos_table_255_256
    add hl,bc
    ld  a,(hl)          ;  forward x
    ex  af,af'
    inc h
    ld  c,(hl)          ;  forward y
    inc h
    ld  a,(hl)          ;  quadrant
    xor a,1000b         ;  m4 is subtracted, so negate it


    ld  hl,(ix)         ;  segment start x
    ld  de,(iy+6)       ;  player x
    and a,a
    sbc hl,de           ;  seg x1 with origin at player

    ; multiply x*fy
        jp  p,.pos_x1 ;  testing sign of (sbc hl,bc)
    ; negate hl
        add hl,de
        ex  de,hl
        xor a,0011b   ;  resets carry
        sbc hl,de
    .pos_x1:
        ld  sp,hl
        exx
        and a,a
        sbc hl,hl
        add hl,sp     ;  this x1 onto hl'
        exx
    .x1_done:
        ; now multiply 0.c * h.l
        ld  e,l
        ld  d,c
        ld  l,c
        mlt hl        ;  (h.c)
        mlt de        ;  (.cl)

        ld  e,d       ;  de >> 8
        ld  d,0
        add hl,de

        ; ld  d,0     ;  already 0
        ld  e,h
        add hl,de     ;  mult by ~ 256/255    (hl+0h)

    ;  hl now contains x1*fy
    ;  c contains fy
    ;  hl' contains  abs(x1)
    ;  a' contains  abs(fx)

    ex  af,af'
    exx
    ;  multiply x1*fx
        ld  e,l
        ld  d,a
        ld  l,a
        mlt hl
        mlt de

        ld  e,d       ;  de >> 8
        ld  d,0
        add hl,de

        ; ld  d,0     ;  already 0
        ld  e,h
        add hl,de     ;  mult by ~ 256/255    (hl+0h)
    ;  hl' now contains x1*fx
    ;  a' contains  abs(fx)
    ;  c contains fy
    ;  hl contains x1*fy



    exx
    ld  b,a
    ld  a,c
    exx
    ex  af,af'

    ld  sp,hl
    ld  hl,(ix+3)       ;  seg y1
    ld  de,(iy+9)       ;  player y
    sbc hl,de           ;  carry reset by (add hl,de)

    ; abs of y1
        jp  p,.pos_y1 ;  testing sign of (sbc hl,bc)
    ; negate hl
        add hl,de
        ex  de,hl
        xor a,1100b   ;  resets carry
        sbc hl,de
    .pos_y1:
        ex  af,af'
        ; working in alt register set
        ;  hl' now contains abs(y1)
        ;  sp now contains x1*fx
        ;  a' contains  abs(fy)
        ;  b contains fx
        ;  hl contains x1*fy
        ld  c,a
        ld  a,l
        exx
        ld  de,0
        ld  e,a
        exx
        ld  a,h
        exx
        ld  d,a
        exx           ;  puts hl' into de
    .y1_done:
        ex  af,af'

        ; working in alt register set
        ;  hl' now contains abs(y1)
        ;  sp now contains x1*fx
        ;  c' contains  abs(fy)
        ;  b contains fx
        ;  hl contains x1*fy
        ;  de contains abs(y1)

    ;  multiply x1*fx
        ld  e,l
        ld  d,c
        ld  l,c
        mlt hl
        mlt de

        ld  e,d       ;  de >> 8
        ld  d,0
        add hl,de

        ; ld  d,0     ;  already 0
        ld  e,h
        add hl,de     ;  mult by ~ 256/255    (hl+0h)


    ; working in alt register set
    ;  hl' now contains y1*fy     ;  m3
    ;  sp now contains x1*fx      ;  m2
    ;  c' contains  abs(fy)
    ;  b contains fx
    ;  hl contains x1*fy          ;  m1
    ;  de contains abs(y1)

    bit 3-1,a
    jp  z,.m3_pos
    ex  de,hl
    and a,a
    sbc hl,hl
    bit 2-1,a
    jp  nz,.both_neg_y1
    add hl,sp
    sbc hl,de

    jp  .test_y1_sign

.both_neg_y1:
    sbc hl,de
    and a,a
    sbc hl,sp

    jp  .negative_y1
.m3_pos:
    bit 2-1,a
    jp  nz,.m2_neg
    add hl,sp
    add a,0          ;  set sign to +

    jp  .positive_y1
.m2_neg:
    and a,a
    sbc hl,sp
.test_y1_sign:

    jp  m,.negative_y1

.negative_y1:
    ld  a,a
.positive_y1:

    ; working in alt register set
    ;  hl' now contains y1*fy + x1*fx
    ;  c' contains  abs(fy)
    ;  b contains fx
    ;  hl contains x1*fy          ;  m1
    ;  de contains abs(y1)
    exx
    ld  sp,hl
    ;  multiply y1*fx
        ld  h,d
        ld  l,b
        ld  d,b
        mlt hl
        mlt de
        ld  e,d
        ld  d,0
        add hl,de

        ld  e,h
        add hl,de

    ;  test m1 & m4
    bit 4-1,a
    jp  z,.m4_pos
    ex  de,hl
    and a,a
    sbc hl,hl
    bit 1-1,a
    jp  nz,.both_neg_x1
    add hl,sp
    sbc hl,de

    jp  .test_x1_sign
.both_neg_x1:
    sbc hl,de
    and a,a
    sbc hl,sp

    jp  .negative_x1
.m4_pos:
    bit 1-1,a
    jp  nz,.m1_neg
    add hl,sp
    add a,0          ;  set sign to +

    jp  .positive_x1
.m1_neg:
    and a,a
    sbc hl,sp
.test_x1_sign:

    jp  m,.negative_x1
.positive_x1:

    ld  a,5
.negative_x1:
    ld  a,2

    ;

    ; working in main register set
    ;  hl contains x1*fy - y1*fx          ;  m1
    ;  hl' now contains y1*fy + x1*fx
    ex  de,hl
    exx
    ld  sp,hl
    exx
    and a,a
    sbc hl,hl
    add hl,sp



.ret_val:
    lea iy,iy-3
    ld  sp,iy
    pop ix
    ei
    ret




;
; .rot
;   srl h
;   jp  z,.fin
;   rr  l
;   jp  .rot

; .fin
;   rr  l
;   do something








public _test_wall
_test_wall:
    dl $00165C    ; x1
    dl $0018A3    ; y1 
    dl $000000    ; dx
    dl $000200    ; dy
    dl $000600    ; x2
    dl $000700    ; y2
    db "A"        ; wallType




extern __imuls