assume adl=1

section .data

public x1
public y1
public dx
public dy
public sign_test
public c1
public c2
public parent

x1:=1
y1:=4
dx:=7
dy:=10
sign_test:=13
wall_type:=14
c1:=15
c2:=18
parent:=21
signal:=24


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


section .text

public _root_node
_root_node:
    db $00        ; numSectors              ; Mmn
    dl $000200    ; x1                      ; Mmn+1
    dl $000500    ; y1                      ; Mmn+4
    dl $000100    ; dx                      ; Mmn+7
    dl $000000    ; dy                      ; Mmn+10
    db 0000b      ; sign tester             ; Mmn+13
    db "A"        ; wallType                ; Mmn+14
    dl _node_a    ; - child                 ; Mmn+15
    dl _node_b    ; + child                 ; Mmn+18
    dl $000000    ; parent node pointer     ; Mmn+21
    db $00        ; signal                  ; Mmn+24

_node_a:
    db $00        ; numSectors
    dl $000400    ; x1
    dl $000300    ; y1
    dl $000400    ; dx
    dl $000000    ; dy
    db 0011b      ; sign tester
    db "A"        ; wallType
    dl _leaf_a    ; - child
    dl _leaf_b    ; + child
    dl _root_node ; parent node pointer
    db $00        ; signal
_node_b:
    db $00        ; numSectors
    dl $0002C0    ; x1
    dl $0005C0    ; y1
    dl $0000C0    ; dx
    dl $0000C0    ; dy
    db 1111b      ; sign tester
    db "A"        ; wallType
    dl _leaf_c    ; - child
    dl _leaf_d    ; + child
    dl _root_node ; parent node pointer
    db $00        ; signal

_leaf_a:
    db $02

    dl $000000    ; x1
    dl $000300    ; y1 
    dl $000000    ; dx
    dl $000200    ; dy
    db 0000b      ; sign tester
    db "A"        ; wallType

    dl $000600    ; x1
    dl $000500    ; y1 
    dl $000000    ; dx
    dl $000200    ; dy
    db 1100b      ; sign tester
    db "A"        ; wallType

    dl _node_a    ; parent node pointer
_leaf_b:
    db $04

    dl $000600    ; x1
    dl $000300    ; y1
    dl $000080    ; dx
    dl $0001E0    ; dy
    db 1100b      ; sign tester
    db "A"        ; wallType

    dl $000680    ; x1
    dl $000120    ; y1
    dl $000160    ; dx
    dl $0000C0    ; dy
    db 1111b      ; sign tester
    db "A"        ; wallType

    dl $000520    ; x1
    dl $000060    ; y1
    dl $000160    ; dx
    dl $000120    ; dy
    db 0011b      ; sign tester
    db "A"        ; wallType

    dl $0003C0    ; x1
    dl $000180    ; y1
    dl $000040    ; dx
    dl $000180    ; dy
    db 0000b      ; sign tester
    db "A"        ; wallType

    dl _node_a    ; parent node pointer
_leaf_c:
    db $02

    dl $000000    ; x2
    dl $000500    ; y2
    dl $000000    ; dx
    dl $000200    ; dy
    db 0000b      ; sign tester
    db "A"        ; wallType

    dl $000000    ; x1
    dl $000700    ; y1
    dl $000400    ; dx
    dl $000000    ; dy
    db 0000b      ; sign tester
    db "A"        ; wallType

    dl _node_b    ; parent node pointer
_leaf_d:
    db $03

    dl $000300    ; x1
    dl $000500    ; y1
    dl $000040    ; dx
    dl $0000C0    ; dy
    db 0011b      ; sign tester
    db "A"        ; wallType

    dl $000400    ; x1
    dl $000700    ; y1
    dl $000200    ; dx
    dl $000000    ; dy
    db 0000b      ; sign tester
    db "A"        ; wallType

    dl $000600    ; x1
    dl $000700    ; y1
    dl $000000    ; dx
    dl $000200    ; dy
    db 1100b      ; sign tester
    db "A"        ; wallType

    dl _node_b    ; parent node pointer




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

    ld  iy,0
    add iy,sp
    push ix             ;  needs to be preserved
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

    ld  de,(ix+x1)      ;  ray start x
    ld  hl,(iy+6)       ;  player x
    ld  bc,(ix+dy)      ;  Ay
    ld  a,(ix+sign_test)
    and a,a
    sbc hl,de           ;  Bx
    jp  p,.pos_Bx
; negative:
    xor a,1100b
    add hl,de
    ex  de,hl
    add hl,de

.pos_Bx:
;   mult Ay, Bx
   ;call _fmuls
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
                ld  a,0
                adc a,h
                ld  h,a       ;  This part would fix the hoping bit for 3 ccs
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
    push hl             ;  stack contains Ay*Bx        SP+0

    ld  de,(ix+y1)      ;  ray start y
    ld  hl,(iy+9)       ;  player y
    ld  bc,(ix+dx)      ;  Ax
    and a,a
    sbc hl,de           ;  By
    jp  p,.pos_By
; negative:
    xor a,0011b
    add hl,de
    ex  de,hl
    add hl,de

.pos_By:
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

    bit 0,a
    jp  nz,.neg_Ax_By
    ;positive Ax*By
    bit 2,a
    jp  nz,.positive_node    ;  + minus - equals +

    and a,a
    sbc hl,de           ;  -Ax*By - -Ay*Bx = Ay*Bx-Ax*By
    jp  p,.positive_node
    jp  .negative_node



.neg_Ax_By:
    ;negative Ax*By
    bit 2,a
    jp  z,.negative_node     ;  - minus + equals -

    ex de, hl
    and a,a
    sbc hl,de           ;  -Ax*By - -Ay*Bx = Ay*Bx-Ax*By
    jp  p,.positive_node

.negative_node:
    ld  (ix+24),01b
    ld  ix,(ix+c1)
    jp  .check_node

.positive_node:
    ld  (ix+24),11b
    ld  ix,(ix+c2)
    jp  .check_node

.leaf_node:

    ; ;blah blah

    inc ix
.loop:
    ex  af,af'

    ; begin by culling backfaces
;  cross product edge func
    ; iy: pointer to stack
    ; ix: pointer to node

    ld  de,(ix+x1-1)      ;  ray start x
    ld  hl,(iy+6)       ;  player x
    ld  bc,(ix+dy-1)      ;  Ay
    ld  a,(ix+sign_test-1)
    and a,a
    sbc hl,de           ;  Bx
    jp  p,.pos_Bx_leaf
; negative:
    xor a,1100b
    add hl,de
    ex  de,hl
    add hl,de

.pos_Bx_leaf:
;   mult Ay, Bx
   ;call _fmuls
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
                ld  a,0
                adc a,h
                ld  h,a       ;  This part would fix the hoping bit for 3 ccs
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
    push hl           ;  stack contains Ay*Bx        SP+0

    ld  de,(ix+y1-1)      ;  ray start y
    ld  hl,(iy+9)       ;  player y
    ld  bc,(ix+dx-1)      ;  Ax
    and a,a
    sbc hl,de           ;  By
    jp  p,.pos_By_leaf
; negative:
    xor a,0011b
    add hl,de
    ex  de,hl
    add hl,de

.pos_By_leaf:
; mult Ax, By
   ;call _fmuls
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
                ld  a,0
                adc a,h
                ld  h,a       ;  This part would fix the hoping bit for 3 ccs
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

    pop  de             ;  de contains Ay*Bx           SP+0
    
    bit 0,a
    jp  nz,.neg_Ax_By_leaf
    ;positive Ax*By
    bit 2,a
    jp  nz,.backface    ;  + minus - equals +

    and a,a
    sbc hl,de           ;  -Ax*By - -Ay*Bx = Ay*Bx-Ax*By
    jp  p,.backface
    jp  .negative_face



.neg_Ax_By_leaf:
    ;negative Ax*By
    bit 2,a
    jp  z,.negative_face     ;  - minus + equals -

    ex de, hl
    and a,a
    sbc hl,de           ;  -Ax*By - -Ay*Bx = Ay*Bx-Ax*By
    jp  p,.backface

.negative_face:

    ; draw wall
    ; idk
    nop
    ex  af,af'
    ld  (_counter_save),a
    call _render_wall_jump
    ld  a,(_counter_save)
    ex  af,af'
    nop
    nop



.backface:
.continue:
    lea ix,ix+3*4+2
    ex  af,af'
    dec a
    jp  nz,.loop

;going up
    ld  ix,(ix)
    jp  .check_revisit

.check_revisit:
    ld a,(ix+signal)
    bit 0,a
    jp z,.go_up
    bit 1,a
    jp nz,.go_neg

    ; draw wall
    ; idk
    nop
    inc ix
    call _render_wall_jump
    dec ix
    nop
    nop
;go_pos
    ld  (ix+signal),0
    ld  ix,(ix+c2)
    jp  .check_node

.go_neg:
    ld  (ix+signal),0
    ld  ix,(ix+c1)
    jp  .check_node

.go_up:
    ld  ix,(ix+parent)
    lea hl,ix
    ld  de,0
    and a,a
    adc hl,de
    jp  nz,.check_revisit

.end_bsp:
    ld hl,0
    lea iy,iy-3
    ld sp,iy
    ei
    pop ix
    ret

public _counter_save
_counter_save:
    db $00


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

public _render_wall_jump
_render_wall_jump:
                                        push ix
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

    and a,a
    sbc hl,de        ;  y2 - x2
    jp  m,.x2_greater_than_y2

    ;  reset hl to y2
    add hl,de
    ld  sp,hl        ;  store off
    
    ex  de,hl
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
    scf
    sbc hl,sp
    jp  m,.ret_val
    inc hl
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
    bit 6,(ix)
    jp  nz,.skip_write

    ld  (ix+80),a          ;  wall height
    ld  (ix),c
.skip_write:
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
                                        
                                        lea hl,iy-9
                                        ld  sp,hl
                                        pop ix
                                        ret



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
    bit 6,(ix)
    jp  nz,.skip_write_neg

    ld  (ix+80),a          ;  wall height
    ld  (ix),c
.skip_write_neg:
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
    ;  reset hl to y2
    add hl,de

    

    ; a contains x2 sign
    ; hl contains y2 (may be negative? unsure lol)
    ; de contains abs(x2)
    ; sp contains dy (signed)
    and a,a
    sbc hl,sp
    ex  de,hl
    ld  bc,(_x1_proj)
    sbc hl,bc

    ; sp contains dy
    ; hl contains dx
    ; de contains y1
    ; bc contains x1

    ; need to mult y1*dx - x1*dy




    jp .ret_val






















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
    db "B"        ; wallType


    dl $001657    ; x1
    dl $00290C    ; y1 
    dl $000530    ; dx
    dl $0006DB    ; dy
    db 0011b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "C"        ; wallType

    dl $001AF8    ; x1
    dl $00250D    ; y1
    dl $000152    ; dx
    dl $000024    ; dy
    db 1100b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $0013E8    ; x1
    dl $0026E0    ; y1
    dl $0005A5    ; dx
    dl $00040E    ; dy
    db 0000b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "C"        ; wallType

    dl $0013EC    ; x1
    dl $002539    ; y1
    dl $00001B    ; dx
    dl $00059C    ; dy
    db 1100b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "B"        ; wallType

    dl $001437    ; x1
    dl $002A21    ; y1
    dl $0005D3    ; dx
    dl $000259    ; dy
    db 1100b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "D"        ; wallType

    dl $001BB6    ; x1
    dl $002146    ; y1
    dl $00059A    ; dx
    dl $000475    ; dy
    db 1111b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "E"        ; wallType

    dl $001936    ; x1
    dl $00206C    ; y1
    dl $000510    ; dx
    dl $0001AF    ; dy
    db 1100b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "D"        ; wallType

    dl $0014C5    ; x1
    dl $002B45    ; y1
    dl $0004F4    ; dx
    dl $0007D7    ; dy
    db 0011b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $0015B4    ; x1
    dl $0028DB    ; y1
    dl $00020C    ; dx
    dl $000052    ; dy
    db 0000b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "C"        ; wallType

    dl $00157D    ; x1
    dl $002973    ; y1
    dl $000063    ; dx
    dl $0004A4    ; dy
    db 0011b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "C"        ; wallType

    dl $001710    ; x1
    dl $0027EA    ; y1
    dl $0001D4    ; dx
    dl $000670    ; dy
    db 0000b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "E"        ; wallType

    dl $001482    ; x1
    dl $002A80    ; y1
    dl $0003BA    ; dx
    dl $0001E7    ; dy
    db 0000b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $0011A5    ; x1
    dl $002D70    ; y1
    dl $0006E5    ; dx
    dl $0004C7    ; dy
    db 1111b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "B"        ; wallType

    dl $001ABE    ; x1
    dl $002369    ; y1
    dl $000110    ; dx
    dl $0006E2    ; dy
    db 0000b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "E"        ; wallType

    dl $001D5F    ; x1
    dl $0028EA    ; y1
    dl $0002CD    ; dx
    dl $000410    ; dy
    db 1100b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "D"        ; wallType

    dl $00132B    ; x1
    dl $002C68    ; y1
    dl $00075D    ; dx
    dl $000688    ; dy
    db 1111b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "C"        ; wallType

    dl $001F83    ; x1
    dl $00252C    ; y1
    dl $000408    ; dx
    dl $000550    ; dy
    db 0011b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "E"        ; wallType

    dl $001BDB    ; x1
    dl $00276E    ; y1
    dl $00054E    ; dx
    dl $0001D1    ; dy
    db 0011b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "E"        ; wallType

    dl $00112A    ; x1
    dl $002E83    ; y1
    dl $0006F1    ; dx
    dl $0004E8    ; dy
    db 0011b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "C"        ; wallType

    dl $001187    ; x1
    dl $00274D    ; y1
    dl $000513    ; dx
    dl $000004    ; dy
    db 1111b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "D"        ; wallType

    dl $001A24    ; x1
    dl $002EA5    ; y1
    dl $0007F8    ; dx
    dl $0000FA    ; dy
    db 0011b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "B"        ; wallType

    dl $0017F1    ; x1
    dl $002032    ; y1
    dl $000350    ; dx
    dl $0003C3    ; dy
    db 0011b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "C"        ; wallType

    dl $0013CE    ; x1
    dl $0020E2    ; y1
    dl $000495    ; dx
    dl $0003C1    ; dy
    db 1111b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "E"        ; wallType

    dl $001205    ; x1
    dl $0025F5    ; y1
    dl $0002A4    ; dx
    dl $0003EE    ; dy
    db 1100b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001CFB    ; x1
    dl $002505    ; y1
    dl $0006A0    ; dx
    dl $0005EE    ; dy
    db 0000b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001C69    ; x1
    dl $002E52    ; y1
    dl $000402    ; dx
    dl $000448    ; dy
    db 0011b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "B"        ; wallType

    dl $001DC1    ; x1
    dl $0028D8    ; y1
    dl $000189    ; dx
    dl $000708    ; dy
    db 0000b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "E"        ; wallType

    dl $0011C2    ; x1
    dl $002FE2    ; y1
    dl $000718    ; dx
    dl $00075D    ; dy
    db 1100b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $0019A6    ; x1
    dl $002BF3    ; y1
    dl $0003EF    ; dx
    dl $000699    ; dy
    db 1111b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "C"        ; wallType

    dl $0010D0    ; x1
    dl $0024BA    ; y1
    dl $00079D    ; dx
    dl $0005DE    ; dy
    db 1111b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "B"        ; wallType

    dl $0015BD    ; x1
    dl $002F68    ; y1
    dl $000274    ; dx
    dl $0000BB    ; dy
    db 0000b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001C31    ; x1
    dl $002475    ; y1
    dl $0002D5    ; dx
    dl $000504    ; dy
    db 0000b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "B"        ; wallType

    dl $001F24    ; x1
    dl $0022FD    ; y1
    dl $000781    ; dx
    dl $0006BD    ; dy
    db 1100b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "C"        ; wallType

    dl $001224    ; x1
    dl $0024CD    ; y1
    dl $00070B    ; dx
    dl $0001A6    ; dy
    db 0011b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "E"        ; wallType

    dl $001EA6    ; x1
    dl $0021AF    ; y1
    dl $000350    ; dx
    dl $000600    ; dy
    db 0000b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "B"        ; wallType

    dl $0019CE    ; x1
    dl $002A6A    ; y1
    dl $00072B    ; dx
    dl $0002FC    ; dy
    db 1111b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001A1D    ; x1
    dl $00256F    ; y1
    dl $0004CF    ; dx
    dl $00076B    ; dy
    db 0011b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "B"        ; wallType

    dl $0019B9    ; x1
    dl $00251E    ; y1
    dl $000544    ; dx
    dl $00076F    ; dy
    db 1100b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "C"        ; wallType

    dl $0016D6    ; x1
    dl $00240E    ; y1
    dl $000217    ; dx
    dl $0005E3    ; dy
    db 0000b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001A10    ; x1
    dl $002087    ; y1
    dl $0000B9    ; dx
    dl $000299    ; dy
    db 0000b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "C"        ; wallType

    dl $001416    ; x1
    dl $002725    ; y1
    dl $0002D4    ; dx
    dl $00069E    ; dy
    db 1111b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001447    ; x1
    dl $0022C0    ; y1
    dl $0000A4    ; dx
    dl $000701    ; dy
    db 1100b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001067    ; x1
    dl $002075    ; y1
    dl $000011    ; dx
    dl $000784    ; dy
    db 1100b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "D"        ; wallType

    dl $00195B    ; x1
    dl $00257C    ; y1
    dl $000525    ; dx
    dl $0003E3    ; dy
    db 1111b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $0012A7    ; x1
    dl $0029C2    ; y1
    dl $00068A    ; dx
    dl $000672    ; dy
    db 1111b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "D"        ; wallType

    dl $001F7A    ; x1
    dl $0028D2    ; y1
    dl $0000F6    ; dx
    dl $0004E0    ; dy
    db 0011b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "E"        ; wallType

    dl $001C0E    ; x1
    dl $0025A7    ; y1
    dl $000682    ; dx
    dl $0007D0    ; dy
    db 1111b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "E"        ; wallType

    dl $001113    ; x1
    dl $002816    ; y1
    dl $0002BE    ; dx
    dl $0005A2    ; dy
    db 0011b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "E"        ; wallType

    dl $001634    ; x1
    dl $002AF0    ; y1
    dl $0007C6    ; dx
    dl $0002AB    ; dy
    db 1100b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $0018E6    ; x1
    dl $0024BD    ; y1
    dl $000439    ; dx
    dl $0006F9    ; dy
    db 0011b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "E"        ; wallType

    dl $001CDC    ; x1
    dl $002FB0    ; y1
    dl $000258    ; dx
    dl $000320    ; dy
    db 1111b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "E"        ; wallType

    dl $0018F9    ; x1
    dl $002D32    ; y1
    dl $00071E    ; dx
    dl $0003CD    ; dy
    db 0000b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "E"        ; wallType

    dl $001FA1    ; x1
    dl $002531    ; y1
    dl $0000C0    ; dx
    dl $000234    ; dy
    db 0011b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001741    ; x1
    dl $002EC4    ; y1
    dl $0003A3    ; dx
    dl $000140    ; dy
    db 1100b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "E"        ; wallType

    dl $001623    ; x1
    dl $002FC0    ; y1
    dl $000067    ; dx
    dl $0000F0    ; dy
    db 0000b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "D"        ; wallType

    dl $0018AA    ; x1
    dl $0026C1    ; y1
    dl $00034E    ; dx
    dl $0007C3    ; dy
    db 1100b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "B"        ; wallType

    dl $0012E7    ; x1
    dl $00200F    ; y1
    dl $0000B9    ; dx
    dl $000311    ; dy
    db 1100b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "E"        ; wallType

    dl $001BE5    ; x1
    dl $002310    ; y1
    dl $00039B    ; dx
    dl $000058    ; dy
    db 1100b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "B"        ; wallType

    dl $001C51    ; x1
    dl $002418    ; y1
    dl $000754    ; dx
    dl $000706    ; dy
    db 1111b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $00181B    ; x1
    dl $002CA2    ; y1
    dl $0003C5    ; dx
    dl $0006FF    ; dy
    db 1100b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $0014D0    ; x1
    dl $002787    ; y1
    dl $0005A7    ; dx
    dl $0001D5    ; dy
    db 1111b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "B"        ; wallType

    dl $001FCA    ; x1
    dl $002B7A    ; y1
    dl $0004CE    ; dx
    dl $000276    ; dy
    db 0000b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "C"        ; wallType

    dl $0010CA    ; x1
    dl $0026AD    ; y1
    dl $000159    ; dx
    dl $000732    ; dy
    db 1111b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "E"        ; wallType

    dl $001812    ; x1
    dl $0021BB    ; y1
    dl $0000DC    ; dx
    dl $00029C    ; dy
    db 0000b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "D"        ; wallType

    dl $001643    ; x1
    dl $0024C6    ; y1
    dl $000376    ; dx
    dl $00066B    ; dy
    db 1111b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "D"        ; wallType

    dl $0014D0    ; x1
    dl $002E05    ; y1
    dl $000201    ; dx
    dl $00049A    ; dy
    db 1100b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "B"        ; wallType

    dl $001170    ; x1
    dl $002BCE    ; y1
    dl $000318    ; dx
    dl $000320    ; dy
    db 0000b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "E"        ; wallType

    dl $001B17    ; x1
    dl $002357    ; y1
    dl $0002AB    ; dx
    dl $0007F1    ; dy
    db 0011b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "C"        ; wallType

    dl $001462    ; x1
    dl $002D32    ; y1
    dl $000242    ; dx
    dl $000398    ; dy
    db 1100b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "D"        ; wallType

    dl $001936    ; x1
    dl $0023BA    ; y1
    dl $0001E6    ; dx
    dl $00000E    ; dy
    db 1111b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "C"        ; wallType

    dl $001B23    ; x1
    dl $002C90    ; y1
    dl $000257    ; dx
    dl $000087    ; dy
    db 0011b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "B"        ; wallType

    dl $0018FF    ; x1
    dl $002855    ; y1
    dl $000625    ; dx
    dl $00014A    ; dy
    db 0011b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "E"        ; wallType

    dl $0017BC    ; x1
    dl $002A22    ; y1
    dl $0003FD    ; dx
    dl $00036F    ; dy
    db 1111b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "C"        ; wallType

    dl $0014A0    ; x1
    dl $002D22    ; y1
    dl $000258    ; dx
    dl $0003CE    ; dy
    db 1111b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "E"        ; wallType

    dl $001034    ; x1
    dl $002C7E    ; y1
    dl $0005D5    ; dx
    dl $000053    ; dy
    db 0000b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $0012AC    ; x1
    dl $002602    ; y1
    dl $000351    ; dx
    dl $000594    ; dy
    db 1111b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "B"        ; wallType

    dl $001B8B    ; x1
    dl $00262B    ; y1
    dl $0002C5    ; dx
    dl $0003CA    ; dy
    db 1111b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "D"        ; wallType

    dl $001CC9    ; x1
    dl $002EB2    ; y1
    dl $00047E    ; dx
    dl $000564    ; dy
    db 1100b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "C"        ; wallType

    dl $0011A7    ; x1
    dl $002CF3    ; y1
    dl $0000D7    ; dx
    dl $0007A7    ; dy
    db 1111b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "A"        ; wallType

    dl $001FB1    ; x1
    dl $00203C    ; y1
    dl $000705    ; dx
    dl $0005F9    ; dy
    db 0011b      ; sign tester
    ; dl $000600    ; x2
    ; dl $000700    ; y2
    db "E"        ; wallType

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