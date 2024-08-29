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
;    dl $000680    ; x2
;    dl $000120    ; y2
    db "A"        ; wallType

    dl $000680    ; x1
    dl $000120    ; y1
    dl $FFFEA0    ; dx
    dl $FFFF40    ; dy
;    dl $000520    ; x2
;    dl $000060    ; y2
    db "A"        ; wallType

    dl $000520    ; x1
    dl $000060    ; y1
    dl $FFFEA0    ; dx
    dl $000120    ; dy
;    dl $0003C0    ; x2
;    dl $000180    ; y2
    db "A"        ; wallType

    dl $0003C0    ; x1
    dl $000180    ; y1
    dl $000040    ; dx
    dl $000180    ; dy
;    dl $000400    ; x2
;    dl $000300    ; y2
    db "A"        ; wallType

    dl _node_a    ; parent node pointer
_leaf_c:
    db $02

    dl $000000    ; x2
    dl $000500    ; y2
    dl $000000    ; dx
    dl $000200    ; dy
;    dl $000000    ; x1
;    dl $000700    ; y1
    db "A"        ; wallType

    dl $000000    ; x1
    dl $000700    ; y1
    dl $000400    ; dx
    dl $000000    ; dy
;    dl $000400    ; x2
;    dl $000700    ; y2
    db "A"        ; wallType

    dl _node_b    ; parent node pointer
_leaf_d:
    db $03

    dl $000300    ; x1
    dl $000500    ; y1
    dl $FFFFC0    ; dx
    dl $0000C0    ; dy
;    dl $0002C0    ; x2
;    dl $0005C0    ; y2
    db "A"        ; wallType

    dl $000400    ; x1
    dl $000700    ; y1
    dl $000200    ; dx
    dl $000000    ; dy
;    dl $000600    ; x2
;    dl $000700    ; y2
    db "A"        ; wallType

    dl $000600    ; x1
    dl $000700    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
;    dl $000600    ; x2
;    dl $000500    ; y2
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
    scf
    sbc hl,hl     ;  $FFFFFF
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


public _x1_proj
_x1_proj:
    dl $000000    ; x1
public _pixel_num
_pixel_num:
    dl $000000    ; pixel number
public _y1_proj
_y1_proj:
    dl $000000    ; y1
public _wall_height
_wall_height:
    dl $000000    ; height

public _render_wall
_render_wall:
; renders just one wall
; Arguments:
;    // technically arg0: return address
;    arg1: pointer to wall
;    arg2: player x
;    arg3: player y
;    arg4: forward angle
;    arg5: pointer to unified buffer
;    arg6: division lut address
; Returns:
;  None
    di                  ;  disables interrupts to enable the alternate register set

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
    ld  de,$000100
    ld  hl,_cos_table_255_256
    add hl,bc
        ld  a,(hl)          ;  forward x
    ex  af,af'
    add hl,de
        ld  c,(hl)          ;  forward y
    add hl,de
        ld  a,(hl)          ;  quadrant
    xor a,1000b         ;  m4 is subtracted, so negate it


    ld  hl,(ix)         ;  segment start x
    ld  de,(iy+6)       ;  player x
    and a,a
    sbc hl,de           ;  seg x1 with origin at player

; multiply x*fy
        jp  p,.pos_x1 ;  testing sign of x1(with player-centric coords)
    ; negate hl
        add hl,de
        ex  de,hl
        xor a,0011b   ;  resets carry
        sbc hl,de
    .pos_x1:
    ; back up x1
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
; multiply x1*fx
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

; multiply y1*fy
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

    jp  p,.positive_y1

.negative_y1:
    ;  sooooo
    ;  this is awkward
    ;  idk what to do here except like crazy algebra
    ; so this is a problem for future me


    ; good luck!
; you'll need it
    jp .ret_val        ; temp return



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
                ld  (_x1_proj),hl
    jp  p,.positive_x1

    add hl,de
    ex  de,hl
    sbc hl,de
    jp  .negative_x1
.both_neg_x1:
            sbc hl,de
            and a,a
            sbc hl,sp
                ld  (_x1_proj),hl
        ex  de,hl
        ld  hl,0
        and a,a
        sbc hl,de
    jp  .negative_x1
.m4_pos:
    bit 1-1,a
    jp  nz,.m1_neg
    add hl,sp
    add a,0          ;  set sign to +

                ld  (_x1_proj),hl
    jp  .positive_x1
.m1_neg:
    and a,a
    sbc hl,sp
                ld  (_x1_proj),hl
    jp  p,.positive_x1
    add hl,sp
    ex  de,hl
    and a,a
    sbc hl,hl
    add hl,sp
    sbc hl,de

.negative_x1:
    ; idk man deal with the negative
    xor a,10000b


.positive_x1:
    ; working in main register set
    ;  hl contains x1*fy - y1*fx          ;  m1
    ;  hl' now contains y1*fy + x1*fx
    ;  c' contains  abs(fy)
    ;  b contains  abs(fx)

    ;  compare x & y
    exx
    ld  sp,hl
    exx
    and a,a
    sbc hl,sp        ;  x - y
    jp  p,.x_greater_than_y

    ;  reset hl to x
    add hl,sp
    ex  de,hl
    ;  move over y into main register set
    and a,a
    sbc hl,hl
    add hl,sp
    ex  de,hl
    ;  divide!
    ;  x/y

    ; v1:   ++: 75cc, -+: 87cc, +- : 89cc, --: 89cc
        ; hl & de input
        ex  af,af'
        ld  a,0
.fdivs_x_y_loop:
        srl h
        rr  l
        srl d
        rr  e

        cp  a,d
        jp  nz,.fdivs_x_y_loop

        ld  d,e
        inc d
        mlt de
        srl d
        rr  e         ;  divide by 2
        add hl,de
        ld  bc,(iy+18);  address of LUT
        add hl,bc
        ld  a,(hl)    ;  use the LUT

        ; 16 cc if negate   10 cc if not
        ex  af,af'
        bit 4,a
        jp  z,.ret_fdivs_x_y
        ; negate hl
        ex  af, af'
            and a,a   ;  tests a for zero, also resets carry
            jp  z,.fdivs_0
        neg
        scf
.fdivs_0:
        ex  af, af'

.ret_fdivs_x_y:
    ex  af, af'
    sbc hl,hl     ;  $FFFFFF
    ld  l,a
    ;  yay!
    ;  hl now contains x/y

    ;  hl contains screenspace x-coord [-1.0, 1.0]
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
        mlt hl       ;  contains pixel group number (array index)
        ld  l,h
        ld  h,0
    ;  hl now contains array index

; saving progress for pixel num & y1
                                                                ld  a,l
                                                                ld  (_pixel_num),a

            ;  hl' still contains y!
            ;  lets GOO
            exx
    
                                                                ld  (_y1_proj),hl
        ;  find wall height
        ex  de,hl
        ld  l,160
            ; hl & de input
            ld  a,0
.fdivs_wall_height_loop:
            srl l
            srl d
            rr  e

            cp  a,d
            jp  nz,.fdivs_wall_height_loop

            ld  d,e
            inc d
            mlt de
            srl d
            rr  e         ;  divide by 2
            add hl,de
            ld  bc,(iy+18);  address of LUT
            add hl,bc
            ld  a,(hl)    ;  use the LUT

    ld  hl,0
    ld  h,a               ;  shift over << 8
                                                                ld  (_wall_height),hl












;
;
;     Start of line segment is done
;
;





;     now calculating the orientation and size of the wall in screenspace:

    ld  bc,(iy+12)          ;  forward angle
    ld  de,$000100
    ld  hl,_cos_table_255_256
    add hl,bc
        ld  a,(hl)          ;  forward x
    ex  af,af'
    add hl,de
        ld  c,(hl)          ;  forward y
    add hl,de
        ld  a,(hl)          ;  quadrant
    xor a,1000b         ;  m4 is subtracted, so negate it

    xor a,(ix+12)      ;  dx & dy signs
    ex  af,af'


    ; put dx into both hl & hl'
    ld  hl,(ix+6)         ;  segment dx

    ; multiply dx*fy
        ; backup dx
        ld  sp,hl
        exx
        sbc hl,hl         ;  carry reset by xor a
        add hl,sp
        exx
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

    ;  hl now contains dx*fy
    ;  c contains fy
    ;  hl' contains  dx
    ;  a' contains  fx

    exx
    ; multiply dx*fx
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
    ;  hl' now contains dx*fx
    ;  a' contains  fx
    ;  c contains fy
    ;  hl contains dx*fy



    exx
    ld  b,a
    ld  a,c
    exx

    ex  de,hl
    ld  hl,(ix+9)       ;  seg dy

    ; working in alt register set
    ;  hl' now contains dy
    ;  sp now contains dx*fx
    ;  a' contains  fy
    ;  b contains fx
    ;  hl contains dx*fy
    ; multiply dy*fy
        ld  c,a
            ld  a,l
            exx
            ld  de,0
            ld  e,a
            exx
            ld  a,h
            exx
            ld  d,a
            exx           ;  puts dy into main de
        ld  a,c

        ; working in alt register set
        ;  hl' now contains y1
        ;  sp now contains dx*fx
        ;  c' contains fy
        ;  b contains fx
        ;  hl contains dx*fy
        ;  de contains dy
        ; multiply
        ld  c,l
        ld  b,a
        ld  l,a
        mlt hl
        mlt bc

        ld  c,b       ;  bc >> 8
        ld  b,0
        add hl,bc

        ; ld  b,0     ;  already 0
        ld  c,h
        add hl,bc     ;  mult by ~ 256/255    (hl+0h)


    ; working in alt register set (alt af)
    ;  hl' now contains dy*fy     ;  m3
    ;  de' now contains dx*fx     ;  m2
    ;  a' contains  fy
    ;  b contains fx
    ;  hl contains dx*fy          ;  m1
    ;  de contains dy

; test sign of dy
    ex af,af'
    bit 3-1,a
    jp  z,.d_m3_pos
    ex  de,hl
    bit 2-1,a
    jp  nz,.both_neg_dy
    and a,a
    sbc hl,de

    jp  .test_dy_sign

.both_neg_dy:
    ld  sp,hl
    and a,a
    sbc hl,hl
    sbc hl,sp
    sbc hl,de

    jp  .negative_dy
.d_m3_pos:
    bit 2-1,a
    jp  nz,.d_m2_neg
    add hl,de

    jp  .positive_dy
.d_m2_neg:
    and a,a
    sbc hl,de
.test_dy_sign:
    ; unneeded?
    ; jp  p,.positive_dy

.negative_dy:
    ;  sooooo
    ;  I think this should just work? maybe

.positive_dy:

    ; working in alt register set
    ;  hl' now contains dy*fy + dx*fx
    ;  a contains  fy
    ;  b contains fx
    ;  hl contains dx*fy          ;  m1
    ;  de contains dy
    ; multiply dy*fx
        exx
        ld  sp,hl

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

; test m1 & m4
    bit 4-1,a
    jp  z,.d_m4_pos

    ex  de,hl
    and a,a
    sbc hl,hl

    bit 1-1,a
    jp  nz,.both_neg_dx

    add hl,sp
    sbc hl,de
    jp  p,.positive_dx

    add hl,de
    ex  de,hl
    sbc hl,de
    jp  .negative_dx
.both_neg_dx:
            ; and a,a
            ; sbc hl,de
            ; and a,a
            ; sbc hl,sp
    add hl,de
    add hl,sp
    jp  .negative_dx
.d_m4_pos:
    bit 1-1,a
    jp  nz,.d_m1_neg
    add hl,sp

    jp  .positive_dx
.d_m1_neg:
    and a,a
    sbc hl,sp
    jp  p,.positive_dx
    add hl,sp
    ex  de,hl
    and a,a
    sbc hl,hl
    add hl,sp
    sbc hl,de

.negative_dx:
    ; idk man deal with the negative
    ex  de,hl
    ld  hl,(_x1_proj)
    and a,a
    sbc hl,de
    jp  p,.positive_x2
    xor a,10000b      ;  make note of negative
    add hl,de     ; negate
    ex  de,hl
    sbc hl,de
    jp  .positive_x2

.positive_dx:
    ld  de,(_x1_proj)
    and a,a
    adc hl,de
    jp  p,.positive_x2
    xor a,10000b      ;  make note of negative
    ex  de,hl
    and a,a
    sbc hl,hl
    and a,a
    sbc hl,de

.positive_x2:

    ; working in main register set
    ;  hl contains dx*fy - dy*fx          ;  dx'
    ;  hl' now contains dy*fy + dx*fx     ;  dy'
    ;  c' contains  abs(fy)
    ;  b contains  abs(fx)


    ;  compare x2 & y2
    exx
    ld  sp,hl
    exx
    ex  de,hl
    ld  hl,(_y1_proj)
    add hl,sp        ;  y2 = y1+dy
    ld  sp,hl
    ex  de,hl

    and a,a
    sbc hl,de        ;  x2 - y2
    jp  p,.x2_greater_than_y2

    ;  reset hl to dx
    add hl,de
    ;  divide!
    ;  dx/y

    ; v1:   ++: 75cc, -+: 87cc, +- : 89cc, --: 89cc
        ; hl & de input
        ex  af,af'
        ld  a,0
.fdivs_dx_y_loop:
        srl h
        rr  l
        srl d
        rr  e

        cp  a,d
        jp  nz,.fdivs_dx_y_loop

        ld  d,e
        inc d
        mlt de
        srl d
        rr  e         ;  divide by 2
        add hl,de
        ld  bc,(iy+18);  address of LUT
        add hl,bc
        ld  a,(hl)    ;  use the LUT

        ; 16 cc if negate   10 cc if not
        ex  af,af'
        bit 4,a
        jp  z,.ret_fdivs_dx_y
        ; negate hl
        ex  af, af'
            and a,a   ;  tests a for zero, also resets carry
            jp  z,.d_fdivs_0
        neg
        scf
.d_fdivs_0:
        ex  af, af'

.ret_fdivs_dx_y:
    ex  af, af'
    sbc hl,hl     ;  $FFFFFF
    ld  l,a
    ;  yay!
    ;  hl now contains x/y

    ;  hl contains screenspace x-coord [-1.0, 1.0]
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
        mlt hl       ;  contains pixel group number (array index)
        ld  l,h
        ld  h,0
    ;  hl now contains array index

        ;  hl' still contains y!
        ;  lets GOO
        ;  find wall height
        ld sp,hl
        exx
        ld  bc,(_y1_proj)
        add hl,bc
        ex  de,hl
        ld  hl,160
            ; hl & de input
            ld  a,0
.fdivs_wall_height_loop_2:
            srl l
            srl d
            rr  e

            cp  a,d
            jp  nz,.fdivs_wall_height_loop_2

            ld  d,e
            inc d
            mlt de
            srl d
            rr  e         ;  divide by 2
            add hl,de
            ld  bc,(iy+18);  address of LUT
            add hl,bc
            ld  a,(hl)    ;  use the LUT

    ld  hl,0
    ld  h,a               ;  shift over << 8
    ; hl now contains wall height #2
    ; sp contains pixel col number



; now interpolating between point 1 & point 2
    ; pt2 - pt1
    ex  de,hl
    ld  hl,0
    add hl,sp
    ld  sp,(_pixel_num)
    sbc hl,sp
                ld  a,l
                ex  af,af'
    ld  bc,0
    ld  c,l
    ex  de,hl
    ld  de,(_wall_height)

    ld  a,d
    exx
    ld  e,a
    exx
    sbc hl,de

    jp  m,.negative_delta_wall_height

    ; hl is change in wall height (in fixed point)
    ; bc is horizontal pixel width

; call __idvrmu
  ; slight problem, i'm abusing the stack pointer for some algebra, so I can't use any stack operations like push or pop or call
  ; stack ops are slow anyways
  ; who needs them
    ; __idvrmu:
    ; I: UHL=dividend, UBC=divisor
    ; O: ude=UHL/UBC, uhl=UHL%UBC

        ex  de, hl

        ld  a, 24

        or  a, a
        sbc hl, hl

    .loop_idvrmu:
        ex  de, hl
        add hl, hl
        ex  de, hl
        adc hl, hl

        sbc hl, bc
        inc e

        jr  nc, .restore_skip_idvrmu
        add hl, bc
        dec e
    .restore_skip_idvrmu:

        dec a
        jr  nz, .loop_idvrmu
; end of __idvrmu

    ; end of calculations!
        ; a' contains the number of loops to do
        ; sp contains the starting pixel
        ; e' contains the starting wall height
        ; d  contains the integer component of the change in wall height
        ; e  contains the fractional


; setting up writing loop

    ; hl  
    ; d   contains the integer component of the change in wall height
    ; e   contains the integer component of the change in texcoord
    ; b   contains the counter for the loop
    ; c   contains the wall type
    ; a   contains the integer component of the wall height

    ; ix  contains wall height write address, texture coordinate write address is 80 higher, wall type adress is 80 lower
            ; ld (ix),r
            ; ld (ix+80),r
            ; ld (ix-80),r

    ; hl' contains whatever
    ; de' contains the fractional component of the change in wall height
    ; bc' contains the fractional component of the change in texcoord
    ; a'  contains the integer component of the texture coordinate
    ex  af,af'
    ld  b,a             ;  number of loops
    ld  a,e
    exx
    ld  d,a             ;  fractional component of the change in wall height
    ld  a,e             ;  starting integer component of wall height
    ld  e,0
    ld  l,0
    exx
    
    ld  c,(ix+13)       ;  wall type

    ld  ix,(iy+15)
    lea ix,ix        ;  unified buffer
    add ix,sp           ;  starting pixel number

.output_loop:

    ld  (ix+80),a          ;  wall height
    ld  (ix),c
    exx
    ld    h,e           ;  reloading saved fractional comp
    ld    e,0
    and a,a             ;  reset carry
    adc.s hl,de         ;  adding h + d, fractional comp of wall height
    ld    e,h           ;  save
    exx
    adc a,d             ;  add with carry, counting for carry from frac

    inc ix
    djnz .output_loop   ;  decrements b


    ld  hl,0
    ld  h,a



.ret_val:
    lea iy,iy-3
    ld  sp,iy
    pop ix
    ei
    ret

.negative_delta_wall_height:
; negate hl
    add hl,de
    ex  de,hl
    sbc hl,de

    ; jp .ret_val

; call __idvrmu
  ; slight problem, i'm abusing the stack pointer for some algebra, so I can't use any stack operations like push or pop or call
  ; stack ops are slow anyways
  ; who needs them
    ; __idvrmu:
    ; I: UHL=dividend, UBC=divisor
    ; O: ude=UHL/UBC, uhl=UHL%UBC

        ex  de, hl

        ld  a, 24

        or  a, a
        sbc hl, hl

    .loop_idvrmu_neg:
        ex  de, hl
        add hl, hl
        ex  de, hl
        adc hl, hl

        sbc hl, bc
        inc e

        jr  nc, .restore_skip_idvrmu_neg
        add hl, bc
        dec e
    .restore_skip_idvrmu_neg:

        dec a
        jr  nz, .loop_idvrmu_neg
; end of __idvrmu

    ; end of calculations!
; writing out
    ex  af,af'
    ld  b,a             ;  number of loops
    ld  a,e
    exx
    ld  d,a             ;  fractional component of the change in wall height
    ld  a,e             ;  starting integer component of wall height
    ld  e,0
    ld  l,0
    exx
    
    ld  c,(ix+13)       ;  wall type

    ld  ix,(iy+15)
    lea ix,ix        ;  unified buffer
    add ix,sp           ;  starting pixel number

.output_loop_neg:

    ld  (ix+80),a          ;  wall height
    ld  (ix),c
    exx
    ld    h,e           ;  reloading saved fractional comp
    ld    e,0
    and a,a             ;  reset carry
    adc.s hl,de         ;  adding h + d, fractional comp of wall height
    ld    e,h           ;  save
    exx
    sbc a,d             ;  sub with carry, counting for carry from frac

    inc ix
    djnz .output_loop_neg   ;  decrements b


    ld  hl,420*256
    jp  .ret_val



.x_greater_than_y:
; need to clip here
    ld  hl,42*256
    jp  .ret_val            ;temporary


.x2_greater_than_y2:
; need to clip here
    ld  hl,6969*256
    jp  .ret_val            ;temporary














public _test_wall
_test_wall:
    dl $00165C    ; x1
    dl $0018A3    ; y1
    dl $000200    ; dx
    dl $000100    ; dy
    db 0011b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

public _test_wall2
_test_wall2:
    dl $001F00    ; x1
    dl $002600    ; y1 
    dl $000500    ; dx
    dl $000100    ; dy
    db 1111b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $00171B    ; x1
    dl $002C44    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001F0E    ; x1
    dl $00276E    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $0011DD    ; x1
    dl $0021BF    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001513    ; x1
    dl $0025B3    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001ECB    ; x1
    dl $002113    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001F13    ; x1
    dl $0023D1    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $00127A    ; x1
    dl $002357    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $00143C    ; x1
    dl $002B2A    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001073    ; x1
    dl $0028FC    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001FA0    ; x1
    dl $0028DA    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $0014E4    ; x1
    dl $0028CF    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001198    ; x1
    dl $002482    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001355    ; x1
    dl $00235C    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $0014F1    ; x1
    dl $002F50    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001764    ; x1
    dl $002DCF    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001DF5    ; x1
    dl $002597    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001E14    ; x1
    dl $002EC0    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $00114E    ; x1
    dl $002E56    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001AAF    ; x1
    dl $002FFC    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001EC2    ; x1
    dl $002FFC    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001BA9    ; x1
    dl $00232C    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001B5F    ; x1
    dl $002A01    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $0014D6    ; x1
    dl $0023B2    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001035    ; x1
    dl $00200F    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $0019B1    ; x1
    dl $002BDE    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001510    ; x1
    dl $0022E8    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $0015A0    ; x1
    dl $002F90    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $0013CB    ; x1
    dl $002D2A    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001D9C    ; x1
    dl $002166    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $0016FF    ; x1
    dl $002A1C    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001715    ; x1
    dl $0027D0    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $0015D1    ; x1
    dl $002627    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $0013B0    ; x1
    dl $002C5F    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $0011CB    ; x1
    dl $002300    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001419    ; x1
    dl $0024F7    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001AFC    ; x1
    dl $002B0C    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $00104F    ; x1
    dl $0025C4    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001932    ; x1
    dl $0028EF    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001140    ; x1
    dl $002D6E    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001987    ; x1
    dl $0025A4    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001E28    ; x1
    dl $002422    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001390    ; x1
    dl $0022CD    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001A51    ; x1
    dl $00231E    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001357    ; x1
    dl $002C0A    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $00127F    ; x1
    dl $002448    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $0013B1    ; x1
    dl $0023E7    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001671    ; x1
    dl $002E70    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $0016CA    ; x1
    dl $00276E    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001287    ; x1
    dl $002416    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $00129B    ; x1
    dl $002DEA    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001645    ; x1
    dl $002D1A    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001F2F    ; x1
    dl $00228F    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $00113A    ; x1
    dl $002D1C    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001545    ; x1
    dl $002D42    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $0012A8    ; x1
    dl $002166    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $00129A    ; x1
    dl $002783    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001F36    ; x1
    dl $002908    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $0018D8    ; x1
    dl $002C11    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $0015C5    ; x1
    dl $002F13    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001232    ; x1
    dl $002E31    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001E90    ; x1
    dl $002A89    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $00181B    ; x1
    dl $002152    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $0012BC    ; x1
    dl $002EB5    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $0018ED    ; x1
    dl $002590    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001A12    ; x1
    dl $002F81    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $00137A    ; x1
    dl $002D05    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $00136A    ; x1
    dl $002E58    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $0016C1    ; x1
    dl $002809    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001BB1    ; x1
    dl $00289A    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001ED9    ; x1
    dl $002060    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001CA9    ; x1
    dl $002E4F    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001A21    ; x1
    dl $0029BA    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001B26    ; x1
    dl $002230    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $0019F7    ; x1
    dl $00235C    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001311    ; x1
    dl $0020BB    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $0012BA    ; x1
    dl $002D84    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $00194B    ; x1
    dl $002A00    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001D57    ; x1
    dl $002EF4    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001FDF    ; x1
    dl $002769    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001624    ; x1
    dl $002B32    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType


    dl $001378    ; x1
    dl $00256E    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001331    ; x1
    dl $0026C7    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001221    ; x1
    dl $002C4B    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $0012ED    ; x1
    dl $002813    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001F36    ; x1
    dl $002F3F    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001341    ; x1
    dl $002636    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $0012A6    ; x1
    dl $002317    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001087    ; x1
    dl $002544    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001661    ; x1
    dl $002A6B    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001D4E    ; x1
    dl $002F01    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $00139B    ; x1
    dl $002EA6    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001CB1    ; x1
    dl $002B92    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001291    ; x1
    dl $0022E7    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $0019C0    ; x1
    dl $0024F0    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001867    ; x1
    dl $002E25    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001191    ; x1
    dl $0022B3    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001EE8    ; x1
    dl $0025D0    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001C5B    ; x1
    dl $0028A5    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $0016D8    ; x1
    dl $00224A    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001966    ; x1
    dl $0024BC    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $0018AC    ; x1
    dl $002E70    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $00152B    ; x1
    dl $002F9F    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $0010A0    ; x1
    dl $002790    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001295    ; x1
    dl $002E8A    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $00150D    ; x1
    dl $002DFC    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $0019B8    ; x1
    dl $002613    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001F9E    ; x1
    dl $002986    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001368    ; x1
    dl $00249D    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001358    ; x1
    dl $0022C1    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001D3D    ; x1
    dl $002957    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $00138B    ; x1
    dl $0022C4    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001F5F    ; x1
    dl $002012    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001235    ; x1
    dl $0020F6    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001F20    ; x1
    dl $0020CA    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001E2B    ; x1
    dl $0023FC    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001165    ; x1
    dl $00218D    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $00142B    ; x1
    dl $002118    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001683    ; x1
    dl $002D59    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $0011EC    ; x1
    dl $0024BB    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001C72    ; x1
    dl $002FD5    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $0012E9    ; x1
    dl $0023F6    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $0016AD    ; x1
    dl $0024F5    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001CA0    ; x1
    dl $0020EB    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $00178F    ; x1
    dl $002954    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001B1D    ; x1
    dl $002CAC    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001A9F    ; x1
    dl $00293B    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001696    ; x1
    dl $0028EB    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $00166B    ; x1
    dl $002BCA    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001138    ; x1
    dl $002A71    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001937    ; x1
    dl $002C9D    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $00133B    ; x1
    dl $002739    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $0017B2    ; x1
    dl $002F81    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001FDA    ; x1
    dl $002D65    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001FA1    ; x1
    dl $002816    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001BB2    ; x1
    dl $0023BF    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $00131F    ; x1
    dl $002B03    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001BE3    ; x1
    dl $002012    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001876    ; x1
    dl $0022A9    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $0011A8    ; x1
    dl $00217A    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001B10    ; x1
    dl $002DC7    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001CF8    ; x1
    dl $002E77    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $0019B3    ; x1
    dl $002E51    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $00104A    ; x1
    dl $002EAC    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $0013D3    ; x1
    dl $0020F8    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $00199F    ; x1
    dl $002FDD    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001277    ; x1
    dl $0027C3    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001A82    ; x1
    dl $002BDE    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001B45    ; x1
    dl $002029    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $0012C1    ; x1
    dl $00295D    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001293    ; x1
    dl $0022FF    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001F95    ; x1
    dl $0029BF    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $0015BE    ; x1
    dl $002F69    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $0019DF    ; x1
    dl $002F9D    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001E3D    ; x1
    dl $002C77    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001872    ; x1
    dl $0021F6    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001F44    ; x1
    dl $0027A3    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001CF0    ; x1
    dl $002AEB    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $0017DA    ; x1
    dl $00222C    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $00126E    ; x1
    dl $00229E    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001327    ; x1
    dl $0020ED    ; y1
    dl $000000    ; dx
    dl $FFFE00    ; dy
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

;
;
;   void renderWall(bro idk){
;       //blah blah,
;       
;       
;       
;       
;
;
;
;
;
;



extern __imuls
extern __idivs