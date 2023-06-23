

    assume adl=1

    section .text
    
    public _asm_test_func
_asm_test_func:
    ; pop ix ; return address
    ; pop de
    ld iy, 0
    add iy, sp
    ; inc iy
    ; ld a, (iy)
    ; ld (de), a

    ld de, (iy+3)
    ld a, 69
    ld (de), a


    ; inc de
    ; push de      ; de = arg
    ; push ix  ; return address
    ret

    assume adl=1