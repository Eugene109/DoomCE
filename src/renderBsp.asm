    assume adl=1

    section .data

_root_node:
    db $00        ; numSectors              ; Mmn
    dl $000300    ; x1                      ; Mmn+1
    dl $000500    ; y1                      ; Mmn+4
    dl $FFFF00    ; dx                      ; Mmn+7
    dl $000000    ; dy                      ; Mmn+10
    dl _node_a    ; + child                 ; Mmn+13
    dl _node_b    ; - child                 ; Mmn+16
    db "A"        ; wallType

_node_a:
    db $00        ; numSectors
    dl $000000    ; x1
    dl $000300    ; y1 
    dl $000400    ; dx
    dl $000000    ; dy
    dl _leaf_a    ; + child
    dl _leaf_b    ; - child
    db "A"        ; wallType
_node_b:
    db $00        ; numSectors
    dl $000200    ; x1
    dl $000500    ; y1 
    dl $0000C0    ; dx
    dl $0000C0    ; dy
    dl _leaf_c    ; + child
    dl _leaf_d    ; - child
    db "A"        ; wallType

_leaf_a:
    db $02

    dl $000000    ; x1
    dl $000500    ; y1 
    dl $000000    ; dx
    dl $FFFE00    ; dy
    db "A"        ; wallType

    dl $000600    ; x1
    dl $000300    ; y1 
    dl $000000    ; dx
    dl $000200    ; dy
    db "A"        ; wallType
_leaf_b:
    db $04

    dl $000400    ; x1
    dl $000300    ; y1 
    dl $FFFFC0    ; dx
    dl $FFFE80    ; dy
    db "A"        ; wallType

    dl $0003C0    ; x1
    dl $000180    ; y1 
    dl $000150    ; dx
    dl $FFFEE0    ; dy
    db "A"        ; wallType

    dl $000520    ; x1
    dl $000060    ; y1 
    dl $000160    ; dx
    dl $0000C0    ; dy
    db "A"        ; wallType

    dl $000680    ; x1
    dl $000120    ; y1 
    dl $FFFF80    ; dx
    dl $0001E0    ; dy
    db "A"        ; wallType
_leaf_c:
    db $02

    dl $000400    ; x1
    dl $000700    ; y1 
    dl $FFFC00    ; dx
    dl $000000    ; dy
    db "A"        ; wallType

    dl $000000    ; x1
    dl $000700    ; y1 
    dl $000000    ; dx
    dl $00FE00    ; dy
    db "A"        ; wallType
_leaf_d:
    db $03

    dl $000600    ; x1
    dl $000500    ; y1 
    dl $000000    ; dx
    dl $000200    ; dy
    db "A"        ; wallType

    dl $000600    ; x1
    dl $000700    ; y1 
    dl $FFFE00    ; dx
    dl $000000    ; dy
    db "A"        ; wallType

    dl $0002C0    ; x1
    dl $0005C0    ; y1 
    dl $000040    ; dx
    dl $FFFF40    ; dy
    db "A"        ; wallType


    section .text

    public _fmuls
    _fmuls:

; v3: 32 cc
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


; v2: 33 cc
    ld  h,d
    ld  l,b
    mlt hl        ;  hl = d*b
    add hl,hl     ;  hl << 8
    add hl,hl
    add hl,hl
    add hl,hl
    add hl,hl
    add hl,hl
    add hl,hl
    add hl,hl
    ld  a,d
    ld  d,b
    ld  b,a
    mlt bc        ;  bc = d*c
    mlt de        ;  de = b*e
    add hl,bc
    add hl,de     ;  hl = d*b<<8 + b*c + d*e
    ret
; v2 end


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
    ld  ix,(iy+3)

.check_node:
    ; ix: pointer to node
    ld  a,(ix)
    cp  a,0
    jp  nz,.leaf_node

.parent_node:




;  cross product edge func
    ; iy: pointer to stack
    ; ix: pointer to node

    ld  bc,(ix+1)       ;  ray start x
    ld  hl,(iy+6)       ;  player x
    and a,a
    sbc hl,bc           ;  Bx
    ld  bc,(ix+10)      ;  Ay

;   mult hl,bc
    call _fmuls
    push hl             ;  stack contains Ay*Bx        SP+0

    ld  bc,(ix+4)       ;  ray start y
    ld  hl,(iy+9)       ;  player y
    and a,a
    sbc hl,bc           ;  By
    ld  bc,(ix+7)       ;  Ax

; mult
    call _fmuls         ;  hl now contains Ax*By
    pop  de             ;  de contains Ay*Bx           SP+0

    and a,a
    sbc hl,de           ;  Ax*By - Ay*Bx
    jp  m,.negative


.positive:
    ld  ix,(ix+13)
.negative:
    ld  ix,(ix+16)


.leaf_node:



.end:
    ei
    pop ix
    ret

    extern __imuls