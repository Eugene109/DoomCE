    assume adl=1

    section .text

    public _x_walls
    public _y_walls
    public _x_walls_transposed
    public _y_walls_transposed
    public _x_walls_q2
    public _y_walls_q2
    public _x_walls_transposed_q2
    public _y_walls_transposed_q2
    public _x_walls_q3
    public _y_walls_q3
    public _x_walls_transposed_q3
    public _y_walls_transposed_q3
    public _x_walls_q4
    public _y_walls_q4
    public _x_walls_transposed_q4
    public _y_walls_transposed_q4

    divs := 17
    gaps := 16

_x_walls:
    db  "AAACAAAAAAAAAAAA                                                  A A             A0A                                                                                                 AAA         A A  AA                                           AA          AAAAAAAAAAAAAAAA"
_y_walls:
    db  "B B  B          BB D  D          BB B  B          BB D  D          BB  BB           BB D  D          BB B  B          BB D  D          BB B  B          BB D  D          BB B  B          BB D  DB         BB  BB BB        BB  BB BB        BB  BB BB        BB  B   B        B"
_y_walls_transposed:
    db  "BBBBBBBBBBBBBBBB                BDBD DBDBDBD        B       BBBB    B       BBB BDBD DBDBDBD               BBBB             BBBB                                                                                                                                BBBBBBBBBBBBBBBB"
_x_walls_transposed:
    db  "A               AA               AA   AA      A   AC    0          AA   AA      A  AAA              AAA          A    AA          AA   AA          AA   AA               AA               AA               AA               AA               AA               AA               A"



_x_walls_q2:
    db  "AAAAAAAAAAAACAAA                                                           A A             A0A                                                                                         AAA             AA  A A                                            AA    AAAAAAAAAAAAAAAA"
_y_walls_q2:
    db  "B          B  B BB          D  D BB          B  B BB          D  D BB           BB  BB          D  D BB          B  B BB          D  D BB          B  B BB          D  D BB          B  B BB         BD  D BB        BB BB  BB        BB BB  BB        BB BB  BB        B   B  B"
_y_walls_transposed_q2:
    db  "BBBBBBBBBBBBBBBB                                                                                                                                            BBBB           BBBB BDBD DBDBDBD        B       BBB     B       BBBBBDBD DBDBDBD                    BBBBBBBBBBBBBBBB"
_x_walls_transposed_q2:
    db  "A               AA               AA               AA               AA               AA               AA               AA          AA   AA          AA   AA          A    AA              AAA   AA      A  AAC    0          AA   AA      A   AA               AA               A"



_x_walls_q3:
    db  "AAAAAAAAAAAAAAAA          AA                                           AA  A A         AAA                                                                                                 A0A             A A                                                  AAAAAAAAAAAACAAA"
_y_walls_q3:
    db  "B        B   B  BB        BB BB  BB        BB BB  BB        BB BB  BB         BD  D BB          B  B BB          D  D BB          B  B BB          D  D BB          B  B BB          D  D BB           BB  BB          D  D BB          B  B BB          D  D BB          B  B B"
_y_walls_transposed_q3:
    db  "BBBBBBBBBBBBBBBB                                                                                                                                BBBB             BBBB               DBDBDBD DBDB BBB       B    BBBB       B        DBDBDBD DBDB                BBBBBBBBBBBBBBBB"
_x_walls_transposed_q3:
    db  "A               AA               AA               AA               AA               AA               AA               AA   AA          AA   AA          AA    A          AAA              AAA  A      AA   AA          0    CA   A      AA   AA               AA               A"



_x_walls_q4:
    db  "AAAAAAAAAAAAAAAA    AA                                            A A  AA             AAA                                                                                         A0A             A A                                                           AAACAAAAAAAAAAAA"
_y_walls_q4:
    db  "B  B   B        BB  BB BB        BB  BB BB        BB  BB BB        BB D  DB         BB B  B          BB D  D          BB B  B          BB D  D          BB B  B          BB D  D          BB  BB           BB D  D          BB B  B          BB D  D          BB B  B          B"
_y_walls_transposed_q4:
    db  "BBBBBBBBBBBBBBBB                    DBDBDBD DBDBBBBB       B     BBB       B        DBDBDBD DBDB BBBB           BBBB                                                                                                                                            BBBBBBBBBBBBBBBB"
_x_walls_transposed_q4:
    db  "A               AA               AA   A      AA   AA          0    CAA  A      AA   AAA              AA    A          AA   AA          AA   AA          AA               AA               AA               AA               AA               AA               AA               A"



    section .text

    ; public _raycast
; _raycast:
; raycasts a line in a grid
; Arguments:
;    // technically arg0: return address
;    arg1: position x coordinate
;    arg2: position y coordinate
;    arg3: ray x component (dx)
;    arg4: ray y component (dy)
;    arg5: pointer to distX
;    arg6: pointer to distY
;    arg7: pointer to texCoord
;    arg8: pointer to texType
; Returns:
;  None

    public _raycast_asm
_raycast_asm:
; raycasts a line in a grid
; Arguments:
;    // technically arg0: return address
;    arg1: position x coordinate
;    arg2: position y coordinate
;    arg3: ray x component (dx)
;    arg4: ray y component (dy)
;    arg5: pointer to distX
;    arg6: pointer to distY
;    arg7: pointer to texCoord
;    arg8: pointer to texType
;    arg9: pointer to x_walls
; Returns:
;  None
    di                  ;  disables interrupts, these use alternate register set, which this needs

    ld  iy,0
    add iy,sp

    push ix             ;  needs to be preserved

    ld  hl,0

    ; hl += dy*x
    ld  a,(iy+3)        ;  fractional part of x, must take 2's complement
    cpl                 ;  two's complement is 1's complement...
    add a,1             ;  plus an increment
    ld  de,(iy+12)      ;  dy
    jp  c,.x_is_one     ;  carry/overflow, aka 256
    bit 0,d
    jp  nz,.dy_is_one
    ld  d,a
    mlt de              ;  dy*x << SHIFT
    ld  e,d
    ld  d,0
.x_is_one:
    add hl,de           ;  hl += dy*x
    ; hl += dx*y
    ld  a,(iy+6)       ;  fractional part of y, keep same
    ld  de,(iy+9)       ;  dx
    bit 0,d
    jp  nz,.dx_is_one
    ld  d,a
    mlt de              ;  dx*y
    ld  e,d
    ld  d,0
    add hl,de           ;  hl += dx*y

.init_D_done:           ;  hl is D
    ld  bc,(iy+9)       ;  bc is dx
    ld  de,(iy+12)      ;  de is dy

    exx
    ld  bc,(iy+3)       ;  x pos
    ld  de,(iy+6)       ;  y pos
    ld  ix,(iy+27)
    lea iy,ix+72
    lea iy,iy+100       ;  iy = ix + 272 // 16*17
    lea iy,iy+100
    ld  c,b             ;  shifting right by 8 bits
    ld  b,0
    add ix,bc           ;  add offset to x_walls (gaps)
    inc bc
    add iy,bc           ;  add offset +1 to y_walls (dividers) (because if checking y, then it is directly in front)

    ld  c,divs          ;  y_walls, dividers
    ld  b,d
    mlt bc              ;  dividers*(y offset), no increment
    add iy,bc
    ld  e,gaps          ;  x_walls, gaps
    inc d
    mlt de              ;  gaps*(x offset + 1), directly above, so increment by one
    add ix,de
    ld  bc,gaps         ;  x_walls increment
    ld  de,divs         ;  y increment

    ld  hl,0            ;  h:x  l:y
    exx

    and a,a             ;  reset carry flag
    sbc hl,bc           ;  hl = -dx + dy*x + dx*y

    jp  p,.inc_y_start  ;  must check top and side above
    ; check side (y lines)
    exx
    ld  a,(iy)          ;  retrieve side byte
    bit 6,a             ;  letter/space?
    jp  nz,.hit_y
    inc iy              ;  move right 1
    inc ix              ;  move right 1
    inc h               ;  increment x
    exx
    jp  .loop

.inc_y_start:
    and a,a
    sbc hl,bc           ;  if D > 0:  D -= dx
    exx
    ld  a,(ix)          ;  check x walls(above)
    bit 6,a
    jp  nz,.hit_x
    add ix,bc           ;  + gaps (go up one row)
    inc l               ;  go up
    
    add iy,de           ;  + divs (go up one row)
    ld  a,(iy)          ;  check y-aligned walls
    bit 6,a
    jp  nz,.hit_y

    inc ix
    inc iy
    inc h               ;  increment x, go sideways
    exx
    ; jp  .loop
;  let control fall through

.loop:
    and a,a
    adc hl,de           ;  D += dy
    jp  p,.inc_y_start
    ; check side (y lines)
    exx
    ld  a,(iy)          ;  check side
    bit 6,a
    jp  nz,.hit_y

    inc iy
    inc ix
    inc h               ;  increment x
    exx
    jp  .loop


.hit_x:                 ;  hit at horizontal wall
    ;  h is x increase
    ;  l is y increase
    ld  iy,3
    add iy,sp
    ld  ix,(iy+24)
    ld  (ix),a          ;  texture type

    ld  bc,(iy+6)       ;  fractional part of y, must be inverted +1 (2's complement)
    ld  a,c
    cpl
    add a,1
    ld  bc,0
    adc hl,bc           ;  add carry to l
    ld  h,l             ;  total increase in y grid lines
    ld  l,a
    ld  ix,(iy+18)
    ld  (ix),hl         ;  total change in y

    add hl,hl           ;  *2, or shift left
    add hl,hl           ;  #2
    add hl,hl           ;  #3
    add hl,hl           ;  #4
    add hl,hl           ;  #5
    add hl,hl           ;  #6
    add hl,hl           ;  #7
    add hl,hl           ;  #8  (8 bits shifted left)

    ld  bc,(iy+12)      ;  dy
    call __idivu        ;  hl = (total change in y << SHIFT)/(dy),   <- scale factor
    ld  bc,(iy+9)       ;  dx
    call __imulu        ;  hl = total change in y << SHIFT
    ;  >> SHIFT
    push hl
    ld  hl, 2
    add hl, sp
    ld  a,(hl)
    pop hl
    ld  de,0
    ld  e,h
    ld  d,a

    ; de now contains total change in x
    ld  ix,(iy+15)
    ld  (ix),de         ;  total change in x
    ld  bc,(iy+3)       ;  x position
    ld  a,c
    add a,e
    ld  ix,(iy+21)
    ld  (ix),a

    ei
    pop ix
    ret
.hit_y:                 ;  hit at vertical wall
    ; h is total accumulated x increase
    ld  iy,3
    add iy,sp
    ld  ix,(iy+24)
    ld  (ix),a          ;  texture type

    ld  bc,(iy+3)       ;  fractional part of x, must be inverted +1 (2's complement)
    ld  a,c
    cpl
    add a,1
    ld  l,h
    ld  bc,0
    adc hl,bc           ;  add carry to h
    ld  h,l
    ld  l,a
    ld  ix,(iy+15)
    ld  (ix),hl         ;  total change in x

    add hl,hl           ;  *2, or shift left
    add hl,hl           ;  #2
    add hl,hl           ;  #3
    add hl,hl           ;  #4
    add hl,hl           ;  #5
    add hl,hl           ;  #6
    add hl,hl           ;  #7
    add hl,hl           ;  #8  (8 bits shifted left)

    ld  bc,(iy+9)       ;  dx
    call __idivu        ;  hl = (total change in x << SHIFT)/(dx),   <- scale factor
    ld  bc,(iy+12)      ;  dy
    call __imulu        ;  hl = total change in y << SHIFT
    ;  >> SHIFT
    push hl
    ld  hl, 2
    add hl, sp
    ld  a,(hl)
    pop hl
    ld  de,0
    ld  e,h
    ld  d,a

    ; de now contains total change in y
    ld  ix,(iy+18)
    ld  (ix),de         ;  total change in y
    ld  bc,(iy+6)       ;  y position
    ld  a,c
    add a,e
    ; cpl
    ; inc a
    ld  ix,(iy+21)      ;  texCoord
    ld  (ix),a

    ei
    pop ix
    ret

.dx_is_one:
    ld  de,0
    ld  e,a
    add hl,de           ;  hl += y
    jp  .init_D_done

.dy_is_one:             ;  means that dx is 0, can skip
    ld  de,0
    ld  e,a             ;  a stores x
    add hl,de           ;  hl += x
    jp  .init_D_done

    extern __idivs
    extern __imuls
    extern __idivu
    extern __imulu

    assume adl=1

