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
_x_walls:
    db  "bbbbbbbb                      bb          b b               bbb bbbbbbbb"
_y_walls:
    db  "b b  b  bb b  b  bb b  b  bb b  bb bb b  bbbbb  bb bbbb  bb bbbb  b    b"
_y_walls_transposed:
    db  "bbbbbbbb        bbbbb        bbb     bb bbbbb      bbbb     bbb bbbbbbbb"
_x_walls_transposed:
    db  "b       bb       bb    b  bb       bb    b bbb      bbb  b   bbb  b    b"



_x_walls_q2:
    db  "bbbbbbbb                bb                 b b           bbb    bbbbbbbb"
_y_walls_q2:
    db  "b  b  b bb  b  b bb  b  b bb bb  b bbbbb  b bbbb bb  bbbb bb  bb    b  b"
_y_walls_transposed_q2:
    db  "bbbbbbbb    bbb    bbbb bbbbb        bb      bbbbbbbb           bbbbbbbb"
_x_walls_transposed_q2:
    db  "b  b    bb  b   bbb      bbb    b bbb       bb    b  bb       bb       b"



_x_walls_q3:
    db  "bbbbbbbb bbb               b b          bb                      bbbbbbbb"
_y_walls_q3:
    db  "b    b  bbbb bb  bbbb bb  bbbbb  b bb bb  b bb  b  b bb  b  b bb  b  b b"
_y_walls_transposed_q3:
    db  "bbbbbbbb bbb     bbbb      bbbbb bb     bbb        bbbbb        bbbbbbbb"
_x_walls_transposed_q3:
    db  "b    b  bbb   b  bbb      bbb b    bb       bb  b    bb       bb       b"



_y_walls_q4:
    db  "b  b    bb  bb bbbb  bb bbbb b  bbbbb b  bb bb b  b  bb b  b  bb b  b  b"
_x_walls_q4:
    db  "bbbbbbbb    bbb           b b                 bb                bbbbbbbb"
_y_walls_transposed_q4:
    db  "bbbbbbbb           bbbbbbbb      bb        bbbbb bbbb    bbb    bbbbbbbb"
_x_walls_transposed_q4:
    db  "b       bb       bb  b    bb       bbb b    bbb      bbb   b  bb    b  b"

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
    ld  bc,(iy+3)       ;  fractional part of x, must take 2's complement
    ld  a,c
    cpl                 ;  two's complement is 1's complement...
    add a,1             ;  plus an increment
    ld  bc,(iy+12)      ;  dy
    jp  c,.x_is_one     ;  carry/overflow, aka 256
    bit 0,b
    jp  nz,.dy_is_one
    ld  b,a
    mlt bc              ;  dy*x << SHIFT
    ld  c,b
    ld  b,0
.x_is_one:
    add hl,bc           ;  hl += dy*x
    ; hl += dx*y
    ld  bc,(iy+6)       ;  fractional part of y, keep same
    ld  a,c
    ld  bc,(iy+9)       ;  dx
    bit 0,b
    jp  nz,.dx_is_one
    ld  b,a
    mlt bc              ;  dx*y
    ld  c,b
    ld  b,0
    add hl,bc           ;  hl += dx*y

.init_D_done:           ;  hl is D
    ld  bc,(iy+9)       ;  bc is dx
    ld  de,(iy+12)      ;  de is dy

    exx
    ld  bc,(iy+3)       ;  x pos
    ld  de,(iy+6)       ;  y_pos
    ld  ix,(iy+27)
    lea iy,ix+72
    ld  c,b             ;  shifting right by 8 bits
    ld  b,0
    add ix,bc           ;  add offset to x_walls (gaps)
    inc bc
    add iy,bc           ;  add offset +1 to y_walls (dividers) (because if checking y, then it is directly in front)

    ld  c,9             ;  y_walls, 9 dividers
    ld  b,d
    mlt bc              ;  9*(y offset), no increment
    add iy,bc
    ld  e,8             ;  x_walls, 8 gaps
    inc d
    mlt de              ;  8*(x offset + 1), directly above, so increment by one
    add ix,de
    ld  bc,8            ;  x_walls increment
    ld  de,9            ;  y increment

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
    add ix,bc           ;  + 8 (go up one row)
    inc l               ;  go up
    
    add iy,de           ;  + 9 (go up one row)
    ld  a,(iy)          ;  check y-aligned walls
    bit 6,a
    jp  nz,.hit_y

    inc ix
    inc iy
    inc h               ;  increment x, go sideways
    exx
    jp  .loop

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
    ld  bc,100h         ;  256
    call __idivu        ;  essentially >> SHIFT
    ; hl now contains total change in x
    ld  ix,(iy+15)
    ld  (ix),hl         ;  total change in x
    ld  bc,(iy+3)       ;  x position
    ld  a,c
    add a,l
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
    ld  bc,100h         ;  256
    call __idivu        ;  essentially >> SHIFT
    ; hl now contains total change in y
    ld  ix,(iy+18)
    ld  (ix),hl         ;  total change in y
    ld  bc,(iy+6)       ;  y position
    ld  a,c
    add a,l
    cpl
    inc a
    ld  ix,(iy+21)
    ld  (ix),a

    ei
    pop ix
    ret

.dx_is_one:
    ld  bc,0
    ld  c,a
    add hl,bc           ;  hl += y
    jp  .init_D_done

.dy_is_one:             ;  means that dy is 0, can skip
    ld  bc,0
    ld  c,a             ;  a stores x
    add hl,bc           ;  hl += x
    jp  .init_D_done

    extern __idivs
    extern __imuls
    extern __idivu
    extern __imulu

    assume adl=1

