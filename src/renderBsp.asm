assume adl=1

section .data


numSectors:=0
x1:=1
y1:=4
dx:=7
dy:=10
x2:=13
y2:=16
c1:=19
c2:=22
parent:=26

public _root_node
_root_node:
    db $00        ; numSectors              ; Mmn
    dl $000300    ; x1                      ; Mmn+1
    dl $000500    ; y1                      ; Mmn+4
    dl $FFFF00    ; dx                      ; Mmn+7
    dl $000000    ; dy                      ; Mmn+10
    dl $000200    ; x2                      ; Mmn+13
    dl $000500    ; y2                      ; Mmn+16
    dl _node_a    ; + child                 ; Mmn+19
    dl _node_b    ; - child                 ; Mmn+22
    db "A"        ; wallType                ; Mmn+25
    dl $000000    ; parent node pointer

_node_a:
    db $00        ; numSectors
    dl $000000    ; x1
    dl $000300    ; y1 
    dl $000400    ; dx
    dl $000000    ; dy
    dl $000400    ; x2
    dl $000300    ; y2
    dl _leaf_a    ; + child
    dl _leaf_b    ; - child
    db "A"        ; wallType
    dl _root_node ; parent node pointer
_node_b:
    db $00        ; numSectors
    dl $000200    ; x1
    dl $000500    ; y1 
    dl $0000C0    ; dx
    dl $0000C0    ; dy
    dl $0002C0    ; x2
    dl $0005C0    ; y2
    dl _leaf_c    ; + child
    dl _leaf_d    ; - child
    db "A"        ; wallType
    dl _root_node ; parent node pointer

_leaf_a:
    db $02

    dl $000000    ; x1
    dl $000500    ; y1 
    dl $000000    ; dx
    dl $FFFE00    ; dy
    dl $000000    ; x2
    dl $000300    ; y2
    db "A"        ; wallType

    dl $000600    ; x1
    dl $000300    ; y1 
    dl $000000    ; dx
    dl $000200    ; dy
    dl $000600    ; x2
    dl $000500    ; y2
    db "A"        ; wallType

    dl _node_a    ; parent node pointer
_leaf_b:
    db $04

    dl $000400    ; x1
    dl $000300    ; y1 
    dl $FFFFC0    ; dx
    dl $FFFE80    ; dy
    dl $0003C0    ; x2
    dl $000180    ; y2
    db "A"        ; wallType

    dl $0003C0    ; x1
    dl $000180    ; y1 
    dl $000150    ; dx
    dl $FFFEE0    ; dy
    dl $000520    ; x2
    dl $000060    ; y2
    db "A"        ; wallType

    dl $000520    ; x1
    dl $000060    ; y1 
    dl $000160    ; dx
    dl $0000C0    ; dy
    dl $000680    ; x2
    dl $000120    ; y2
    db "A"        ; wallType

    dl $000680    ; x1
    dl $000120    ; y1 
    dl $FFFF80    ; dx
    dl $0001E0    ; dy
    dl $000600    ; x2
    dl $000300    ; y2
    db "A"        ; wallType

    dl _node_a    ; parent node pointer
_leaf_c:
    db $02

    dl $000400    ; x1
    dl $000700    ; y1 
    dl $FFFC00    ; dx
    dl $000000    ; dy
    dl $000000    ; x2
    dl $000700    ; y2
    db "A"        ; wallType

    dl $000000    ; x1
    dl $000700    ; y1 
    dl $000000    ; dx
    dl $00FE00    ; dy
    dl $000000    ; x2
    dl $000500    ; y2
    db "A"        ; wallType

    dl _node_b    ; parent node pointer
_leaf_d:
    db $03

    dl $000600    ; x1
    dl $000500    ; y1 
    dl $000000    ; dx
    dl $000200    ; dy
    dl $000600    ; x2
    dl $000700    ; y2
    db "A"        ; wallType

    dl $000600    ; x1
    dl $000700    ; y1 
    dl $FFFE00    ; dx
    dl $000000    ; dy
    dl $000400    ; x2
    dl $000700    ; y2
    db "A"        ; wallType

    dl $0002C0    ; x1
    dl $0005C0    ; y1 
    dl $000040    ; dx
    dl $FFFF40    ; dy
    dl $000300    ; x2
    dl $000500    ; y2
    db "A"        ; wallType

    dl _node_b    ; parent node pointer


section .text

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
;    arg1: door name, starts at 'a', 
; Returns:
;  None
    di                  ;  disables interrupts, these use alternate register set, which this needs
    push ix             ;  needs to be preserved

    ld  iy,0
    add iy,sp
    ld  ix,(iy+3)       ;  pointer to start of bsp tree

.check_node:
    ; ix: pointer to node
    ld  a,(ix+numSectors)
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
    jp  m,.negative


.positive:
    ld  ix,(ix+c1)
    jp  .check_node
.negative:
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
    ld  bc, 3*6+1
    add ix,bc
    dec a
    jp  nz,.loop

    

.end:
    ei
    pop ix
    ret

extern __imuls