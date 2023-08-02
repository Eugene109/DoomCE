    assume adl=1

    section .text

    public _x_walls
    public _y_walls
    public _x_walls_transposed
    public _y_walls_transposed
_x_walls:
    db  "bbbbbbbb                      bb          b b               bbb bbbbbbbb"
_y_walls:
    db  "b b  b  bb b  b  bb b  b  bb b  bb bb b  bbbbb  bb bbbb  bb bbbb  b    b"
_x_walls_transposed:
    db  "b       bb       bb    b  bb       bb    b bbb      bbb  b   bbb  b    b"
_y_walls_transposed:
    db  "bbbbbbbb        bbbbb        bbb     bb bbbbb      bbbb     bbb bbbbbbbb"

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

    public _raycast_q1_xy
_raycast_q1_xy:
; raycasts a line in a grid
; Arguments:
;    // technically arg0: return address
;    arg1: position x coordinate
;    arg2: position y coordinate
;    arg3: ray x component (dx)
;    arg4: ray y component (dy)
;    arg5: pointer to distX
;    arg6: pointer to distY
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
    inc a               ;  plus an increment
    ld  bc,(iy+12)      ;  dy
    bit 0,b
    jp  nz,.dy_is_one
    ld  b,a
    mlt bc              ;  dy*x << SHIFT
    ld  c,b
    ld  b,0
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
    ld  iy,_y_walls
    ld  ix,_x_walls
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
    inc a
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
    inc a
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

public _raycast_q1_yx
_raycast_q1_yx:
; raycasts a line in quadrant one, slope >1,
; Arguments:
;    // technically arg0: return address
;    arg1: position x coordinate
;    arg2: position y coordinate
;    arg3: ray x component (dx)
;    arg4: ray y component (dy)
;    arg5: pointer to distX
;    arg6: pointer to distY
; Returns:
;  None
    di                  ;  disables interrupts, these use alternate register set, which this needs

    ld  iy,0
    add iy,sp

    push ix             ;  needs to be preserved

    ld  hl,0

    ; hl += dx*y
    ld  bc,(iy+6)       ;  fractional part of y, must take 2's complement
    ld  a,c
    cpl                 ;  two's complement is 1's complement...
    inc a               ;  plus an increment
    ld  bc,(iy+9)       ;  dx
    bit 0,b
    jp  nz,.dx_is_one_yx
    ld  b,a
    mlt bc              ;  dx*y << SHIFT
    ld  c,b
    ld  b,0
    add hl,bc           ;  hl += dx*y
    ; hl += dy*x
    ld  bc,(iy+3)       ;  fractional part of x, keep same
    ld  a,c
    ld  bc,(iy+12)      ;  dy
    bit 0,b
    jp  nz,.dy_is_one_yx
    ld  b,a
    mlt bc              ;  dy*x
    ld  c,b
    ld  b,0
    add hl,bc           ;  hl += dy*x

.init_D_done_yx:           ;  hl is D
    ld  bc,(iy+9)       ;  bc is dx
    ld  de,(iy+12)      ;  de is dy

    exx
    ld  bc,(iy+3)       ;  x pos
    ld  de,(iy+6)       ;  y_pos
    ld  iy,_y_walls_transposed
    ld  ix,_x_walls_transposed
    ld  e,d             ;  shifting right by 8 bits
    ld  d,0
    add iy,de           ;  add offset to x_walls (gaps)
    inc de
    add ix,de           ;  add offset +1 to y_walls (dividers) (because if checking y, then it is directly in front)

    ld  e,9             ;  y_walls, 9 dividers
    ld  d,b
    mlt de              ;  9*(y offset), no increment
    add ix,de
    ld  c,8             ;  x_walls, 8 gaps
    inc b
    mlt bc              ;  8*(x offset + 1), directly above, so increment by one
    add iy,bc
    ld  bc,9            ;  x_walls increment
    ld  de,8            ;  y increment

    ld  hl,0            ;  h:x  l:y
    exx

    and a,a             ;  reset carry flag
    sbc hl,de           ;  hl = -dy + dy*x + dx*y

    jp  p,.inc_x_start  ;  must check top and side above
    ; check side (y lines)
    exx
    ld  a,(ix)          ;  retrieve side byte
    bit 6,a             ;  letter/space?
    jp  nz,.hit_x_inv
    inc ix              ;  move right 1
    inc iy              ;  move right 1
    inc l               ;  increment y
    exx
    jp  .loop_yx

.inc_x_start:
    and a,a
    sbc hl,de           ;  if D > 0:  D -= dy
    exx
    ld  a,(iy)          ;  check x walls(above)
    bit 6,a
    jp  nz,.hit_y_inv
    add iy,de           ;  + 8 (go up one row)
    inc h               ;  go up
    
    add ix,bc           ;  + 9 (go up one row)
    ld  a,(ix)          ;  check y-aligned walls
    bit 6,a
    jp  nz,.hit_x_inv

    inc ix
    inc iy
    inc l               ;  increment x, go sideways
    exx
    jp  .loop_yx

.loop_yx:
    and a,a
    adc hl,bc           ;  D += dx
    jp  p,.inc_x_start
    ; check side (y lines)
    exx
    ld  a,(ix)          ;  check side
    bit 6,a
    jp  nz,.hit_x_inv

    inc iy
    inc ix
    inc l               ;  increment y
    exx
    jp  .loop_yx


.hit_x_inv:                 ;  hit at horizontal wall
    ;  h is x increase
    ;  l is y increase
    ld  iy,3
    add iy,sp
    ld  ix,(iy+24)
    ld  (ix),a          ;  texture type

    ld  bc,(iy+6)       ;  fractional part of y, must be inverted +1 (2's complement)
    ld  a,c
    cpl
    inc a
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
.hit_y_inv:                 ;  hit at vertical wall
    ; h is total accumulated x increase
    ld  iy,3
    add iy,sp
    ld  ix,(iy+24)
    ld  (ix),a          ;  texture type

    ld  bc,(iy+3)       ;  fractional part of x, must be inverted +1 (2's complement)
    ld  a,c
    cpl
    inc a
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

.dx_is_one_yx:
    ld  bc,0
    ld  c,a
    add hl,bc           ;  hl += y
    jp  .init_D_done_yx

.dy_is_one_yx:             ;  means that dy is 0, can skip
    ld  bc,0
    ld  c,a             ;  a stores x
    add hl,bc           ;  hl += x
    jp  .init_D_done_yx




; onto Quadrant #2 below


















    public _raycast_q2_xy
_raycast_q2_xy:
; raycasts a line in a grid
; Arguments:
;    // technically arg0: return address
;    arg1: position x coordinate
;    arg2: position y coordinate
;    arg3: ray x component (dx)
;    arg4: ray y component (dy)
;    arg5: pointer to distX
;    arg6: pointer to distY
; Returns:
;  None
    di                  ;  disables interrupts, these use alternate register set, which this needs

    ld  iy,0
    add iy,sp

    push ix             ;  needs to be preserved

    ld  hl,0

    ; hl += dy*x
    ld  de,(iy+3)       ;  fractional part of x, no need to take 2's complement, flipped across y axis from q1
    ld  bc,(iy+12)      ;  dy
    bit 0,b
    jp  nz,.dy_is_one
    ld  b,e
    mlt bc              ;  dy*x << SHIFT
    ld  c,b
    ld  b,0
    add hl,bc           ;  hl += dy*x
    ; hl += dx*y
    ld  de,(iy+6)       ;  fractional part of y, keep same
    ld  bc,(iy+9)       ;  dx
    bit 0,b
    jp  nz,.dx_is_one
    ld  b,e
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
    ld  iy,_y_walls
    ld  ix,_x_walls
    ld  c,b             ;  shifting right by 8 bits
    ld  b,0
    add ix,bc           ;  add offset to x_walls (gaps)
    add iy,bc           ;  add offset to y_walls (dividers) (because if checking y, then it is directly in back)

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
    dec iy              ;  move left 1
    dec ix              ;  move left 1
    inc h               ;  just counting total displacement
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

    dec ix
    dec iy
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

    dec iy
    dec ix
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
    inc a
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
    sub a,l
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

    ld  bc,(iy+3)       ;  fractional part of x, must be kept
    ld  l,c
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
    ld  ix,(iy+21)
    ld  (ix),a

    ei
    pop ix
    ret

.dx_is_one:
    ld  bc,0
    ld  c,e
    add hl,bc           ;  hl += y
    jp  .init_D_done

.dy_is_one:             ;  means that dy is 0, can skip
    ld  bc,0
    ld  c,e             ;  e stores x
    add hl,bc           ;  hl += x
    jp  .init_D_done


public _raycast_q2_yx
_raycast_q2_yx:
; raycasts a line in quadrant one, slope >1,
; Arguments:
;    // technically arg0: return address
;    arg1: position x coordinate
;    arg2: position y coordinate
;    arg3: ray x component (dx)
;    arg4: ray y component (dy)
;    arg5: pointer to distX
;    arg6: pointer to distY
; Returns:
;  None
    di                  ;  disables interrupts, these use alternate register set, which this needs

    ld  iy,0
    add iy,sp

    push ix             ;  needs to be preserved

    ld  hl,0

    ; hl += dx*y
    ld  bc,(iy+6)       ;  fractional part of y, must take 2's complement
    ld  a,c
    cpl                 ;  two's complement is 1's complement...
    inc a               ;  plus an increment
    ld  bc,(iy+9)       ;  dx
    bit 0,b
    jp  nz,.dx_is_one_yx
    ld  b,a
    mlt bc              ;  dx*y << SHIFT
    ld  c,b
    ld  b,0
    add hl,bc           ;  hl += dx*y
    ; hl += dy*x
    ld  bc,(iy+3)       ;  fractional part of x, invert
    ld  a,c
    cpl
    inc a
    ld  bc,(iy+12)      ;  dy
    bit 0,b
    jp  nz,.dy_is_one_yx
    ld  b,a
    mlt bc              ;  dy*x
    ld  c,b
    ld  b,0
    add hl,bc           ;  hl += dy*x

.init_D_done_yx:           ;  hl is D
    ld  bc,(iy+9)       ;  bc is dx
    ld  de,(iy+12)      ;  de is dy

    exx
    ld  bc,(iy+3)       ;  x pos
    ld  de,(iy+6)       ;  y_pos
    ld  iy,_y_walls_transposed
    ld  ix,_x_walls_transposed
    ld  e,d             ;  shifting right by 8 bits
    ld  d,0
    add iy,de           ;  add offset to y_walls (dividers)
    inc de
    add ix,de           ;  add offset +1 to x_walls (gaps) (because if checking y, then it is directly in front)

    ld  e,9             ;  y_walls, 9 dividers
    ld  d,b
    mlt de              ;  9*(x offset), no increment
    add ix,de
    ld  c,8             ;  x_walls, 8 gaps
    mlt bc              ;  8*(x offset + 1), directly below, so Don't increment
    add iy,bc
    ld  bc,-9            ;  x_walls increment
    ld  de,-8            ;  y increment

    ld  hl,0            ;  h:x  l:y
    exx

    and a,a             ;  reset carry flag
    sbc hl,de           ;  hl = -dy + dy*x + dx*y

    jp  p,.inc_x_start  ;  must check top and side above
    ; check side (y lines)
    exx
    ld  a,(ix)          ;  retrieve side byte
    bit 6,a             ;  letter/space?
    jp  nz,.hit_x_inv
    inc ix              ;  move right 1
    inc iy              ;  move right 1
    inc l               ;  increment y
    exx
    jp  .loop_yx

.inc_x_start:
    and a,a
    sbc hl,de           ;  if D > 0:  D -= dy
    exx
    ld  a,(iy)          ;  check x walls(above)
    bit 6,a
    jp  nz,.hit_y_inv
    add iy,de           ;  + 8 (go up one row)
    inc h               ;  go up
    
    add ix,bc           ;  + 9 (go up one row)
    ld  a,(ix)          ;  check y-aligned walls
    bit 6,a
    jp  nz,.hit_x_inv

    inc ix
    inc iy
    inc l               ;  increment x, go sideways
    exx
    jp  .loop_yx

.loop_yx:
    and a,a
    adc hl,bc           ;  D += dx
    jp  p,.inc_x_start
    ; check side (y lines)
    exx
    ld  a,(ix)          ;  check side
    bit 6,a
    jp  nz,.hit_x_inv

    inc iy
    inc ix
    inc l               ;  increment y
    exx
    jp  .loop_yx


.hit_x_inv:                 ;  hit at horizontal wall
    ;  h is x increase
    ;  l is y increase
    ld  iy,3
    add iy,sp
    ld  ix,(iy+24)
    ld  (ix),a          ;  texture type

    ld  bc,(iy+6)       ;  fractional part of y, must be inverted +1 (2's complement)
    ld  a,c
    cpl
    inc a
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
    sub a,l
    ld  ix,(iy+21)
    ld  (ix),a

    ei
    pop ix
    ret
.hit_y_inv:                 ;  hit at vertical wall
    ; h is total accumulated x increase
    ld  iy,3
    add iy,sp
    ld  ix,(iy+24)
    ld  (ix),a          ;  texture type

    ld  bc,(iy+3)       ;  fractional part of x, not inverted
    ld  l,c
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
    ld  ix,(iy+21)
    ld  (ix),a

    ei
    pop ix
    ret

.dx_is_one_yx:
    ld  bc,0
    ld  c,a
    add hl,bc           ;  hl += y
    jp  .init_D_done_yx

.dy_is_one_yx:             ;  means that dy is 0, can skip
    ld  bc,0
    ld  c,a             ;  a stores x
    add hl,bc           ;  hl += x
    jp  .init_D_done_yx





; onto Quadrant #3 below


















    public _raycast_q3_xy
_raycast_q3_xy:
; raycasts a line in a grid
; Arguments:
;    // technically arg0: return address
;    arg1: position x coordinate
;    arg2: position y coordinate
;    arg3: ray x component (dx)
;    arg4: ray y component (dy)
;    arg5: pointer to distX
;    arg6: pointer to distY
; Returns:
;  None
    di                  ;  disables interrupts, these use alternate register set, which this needs

    ld  iy,0
    add iy,sp

    push ix             ;  needs to be preserved

    ld  hl,0

    ; hl += dy*x
    ld  de,(iy+3)       ;  fractional part of x, no need to take 2's complement, flipped across y axis from q1
    ld  a,e
    ld  bc,(iy+12)      ;  dy
    bit 0,b
    jp  nz,.dy_is_one
    ld  b,a
    mlt bc              ;  dy*x << SHIFT
    ld  c,b
    ld  b,0
    add hl,bc           ;  hl += dy*x
    ; hl += dx*y
    ld  bc,(iy+6)       ;  fractional part of y, invert
    ld  a,c
    cpl
    inc a
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
    ld  iy,_y_walls
    ld  ix,_x_walls
    ld  c,b             ;  shifting right by 8 bits
    ld  b,0
    add ix,bc           ;  add offset to x_walls (gaps)
    add iy,bc           ;  add offset to y_walls (dividers) (because if checking y, then it is directly in back)

    ld  c,9             ;  y_walls, 9 dividers
    ld  b,d
    mlt bc              ;  9*(y offset), no increment
    add iy,bc
    ld  e,8             ;  x_walls, 8 gaps
    mlt de              ;  8*(x offset + 1), directly above, so increment by one
    add ix,de
    ld  bc,-8            ;  x_walls increment
    ld  de,-9            ;  y increment

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
    dec iy              ;  move left 1
    dec ix              ;  move left 1
    inc h               ;  just counting total displacement
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

    dec ix
    dec iy
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

    dec iy
    dec ix
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

    ld  bc,(iy+6)       ;  fractional part of y, below, so no invert
    ld  a,c
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
    sub a,l
    cpl
    inc a
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

    ld  bc,(iy+3)       ;  fractional part of x, must be kept
    ld  l,c
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
    sub a,l
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
    ld  c,a             ;  e stores x
    add hl,bc           ;  hl += x
    jp  .init_D_done


public _raycast_q3_yx
_raycast_q3_yx:
; raycasts a line in quadrant one, slope >1,
; Arguments:
;    // technically arg0: return address
;    arg1: position x coordinate
;    arg2: position y coordinate
;    arg3: ray x component (dx)
;    arg4: ray y component (dy)
;    arg5: pointer to distX
;    arg6: pointer to distY
; Returns:
;  None
    di                  ;  disables interrupts, these use alternate register set, which this needs

    ld  iy,0
    add iy,sp

    push ix             ;  needs to be preserved

    ld  hl,0

    ; hl += dx*y
    ld  bc,(iy+6)       ;  fractional part of y, must keep same
    ld  a,c
    ld  bc,(iy+9)       ;  dx
    bit 0,b
    jp  nz,.dx_is_one_yx
    ld  b,a
    mlt bc              ;  dx*y << SHIFT
    ld  c,b
    ld  b,0
    add hl,bc           ;  hl += dx*y
    ; hl += dy*x
    ld  bc,(iy+3)       ;  fractional part of x, invert
    ld  a,c
    cpl
    inc a
    ld  bc,(iy+12)      ;  dy
    bit 0,b
    jp  nz,.dy_is_one_yx
    ld  b,a
    mlt bc              ;  dy*x
    ld  c,b
    ld  b,0
    add hl,bc           ;  hl += dy*x

.init_D_done_yx:           ;  hl is D
    ld  bc,(iy+9)       ;  bc is dx
    ld  de,(iy+12)      ;  de is dy

    exx
    ld  bc,(iy+3)       ;  x pos
    ld  de,(iy+6)       ;  y_pos
    ld  iy,_y_walls_transposed
    ld  ix,_x_walls_transposed
    ld  e,d             ;  shifting right by 8 bits
    ld  d,0
    add iy,de           ;  add offset to y_walls (dividers)
    add ix,de           ;  add offset +0 to x_walls (gaps) (because if checking y, then it is directly below)

    ld  e,9             ;  y_walls, 9 dividers
    ld  d,b
    mlt de              ;  9*(x offset), no increment
    add ix,de
    ld  c,8             ;  x_walls, 8 gaps
    mlt bc              ;  8*(x offset + 1), directly below, so Don't increment
    add iy,bc
    ld  bc,-9            ;  x_walls increment
    ld  de,-8            ;  y increment

    ld  hl,0            ;  h:x  l:y
    exx

    and a,a             ;  reset carry flag
    sbc hl,de           ;  hl = -dy + dy*x + dx*y

    jp  p,.inc_x_start  ;  must check top and side above
    ; check side (y lines)
    exx
    ld  a,(ix)          ;  retrieve side byte
    bit 6,a             ;  letter/space?
    jp  nz,.hit_x_inv
    dec ix              ;  move right 1
    dec iy              ;  move right 1
    inc l               ;  increment y
    exx
    jp  .loop_yx

.inc_x_start:
    and a,a
    sbc hl,de           ;  if D > 0:  D -= dy
    exx
    ld  a,(iy)          ;  check x walls(above)
    bit 6,a
    jp  nz,.hit_y_inv
    add iy,de           ;  + 8 (go up one row)
    inc h               ;  go up

    add ix,bc           ;  + 9 (go up one row)
    ld  a,(ix)          ;  check y-aligned walls
    bit 6,a
    jp  nz,.hit_x_inv

    dec ix
    dec iy
    inc l               ;  increment x, go sideways
    exx
    jp  .loop_yx

.loop_yx:
    and a,a
    adc hl,bc           ;  D += dx
    jp  p,.inc_x_start
    ; check side (y lines)
    exx
    ld  a,(ix)          ;  check side
    bit 6,a
    jp  nz,.hit_x_inv

    dec iy
    dec ix
    inc l               ;  increment y
    exx
    jp  .loop_yx


.hit_x_inv:                 ;  hit at horizontal wall
    ;  h is x increase
    ;  l is y increase
    ld  iy,3
    add iy,sp
    ld  ix,(iy+24)
    ld  (ix),a          ;  texture type

    ld  bc,(iy+6)       ;  fractional part of y, keep same
    ld  h,l             ;  total increase in y grid lines
    ld  l,c
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
    sub a,l
    cpl
    inc a
    ld  ix,(iy+21)
    ld  (ix),a

    ei
    pop ix
    ret
.hit_y_inv:                 ;  hit at vertical wall
    ; h is total accumulated x increase
    ld  iy,3
    add iy,sp
    ld  ix,(iy+24)
    ld  (ix),a          ;  texture type

    ld  bc,(iy+3)       ;  fractional part of x, not inverted
    ld  l,c
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
    sub a,l
    ld  ix,(iy+21)
    ld  (ix),a

    ei
    pop ix
    ret

.dx_is_one_yx:
    ld  bc,0
    ld  c,a
    add hl,bc           ;  hl += y
    jp  .init_D_done_yx

.dy_is_one_yx:             ;  means that dy is 0, can skip
    ld  bc,0
    ld  c,a             ;  a stores x
    add hl,bc           ;  hl += x
    jp  .init_D_done_yx



















; onto quadrant #4

    public _raycast_q4_xy
_raycast_q4_xy:
; raycasts a line in a grid
; Arguments:
;    // technically arg0: return address
;    arg1: position x coordinate
;    arg2: position y coordinate
;    arg3: ray x component (dx)
;    arg4: ray y component (dy)
;    arg5: pointer to distX
;    arg6: pointer to distY
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
    inc a               ;  plus an increment
    ld  bc,(iy+12)      ;  dy
    bit 0,b
    jp  nz,.dy_is_one
    ld  b,a
    mlt bc              ;  dy*x << SHIFT
    ld  c,b
    ld  b,0
    add hl,bc           ;  hl += dy*x
    ; hl += dx*y
    ld  bc,(iy+6)       ;  fractional part of y, take 2's complement
    ld  a,c
    cpl
    inc a
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
    ld  iy,_y_walls
    ld  ix,_x_walls
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
    mlt de              ;  8*(x offset + 0), directly below, so no increment
    add ix,de
    ld  bc,-8            ;  x_walls increment
    ld  de,-9            ;  y increment

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

    ld  bc,(iy+6)       ;  fractional part of y, no invert
    ld  a,c
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
    cpl
    inc a
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
    inc a
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
    sub a,l
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

public _raycast_q4_yx
_raycast_q4_yx:
; raycasts a line in quadrant one, slope >1,
; Arguments:
;    // technically arg0: return address
;    arg1: position x coordinate
;    arg2: position y coordinate
;    arg3: ray x component (dx)
;    arg4: ray y component (dy)
;    arg5: pointer to distX
;    arg6: pointer to distY
; Returns:
;  None
    di                  ;  disables interrupts, these use alternate register set, which this needs

    ld  iy,0
    add iy,sp

    push ix             ;  needs to be preserved

    ld  hl,0

    ; hl += dx*y
    ld  bc,(iy+6)       ;  fractional part of y, must take 2's complement
    ld  a,c
    ld  bc,(iy+9)       ;  dx
    bit 0,b
    jp  nz,.dx_is_one_yx
    ld  b,a
    mlt bc              ;  dx*y << SHIFT
    ld  c,b
    ld  b,0
    add hl,bc           ;  hl += dx*y
    ; hl += dy*x
    ld  bc,(iy+3)       ;  fractional part of x, keep same
    ld  a,c
    ld  bc,(iy+12)      ;  dy
    bit 0,b
    jp  nz,.dy_is_one_yx
    ld  b,a
    mlt bc              ;  dy*x
    ld  c,b
    ld  b,0
    add hl,bc           ;  hl += dy*x

.init_D_done_yx:           ;  hl is D
    ld  bc,(iy+9)       ;  bc is dx
    ld  de,(iy+12)      ;  de is dy

    exx
    ld  bc,(iy+3)       ;  x pos
    ld  de,(iy+6)       ;  y_pos
    ld  iy,_y_walls_transposed
    ld  ix,_x_walls_transposed
    ld  e,d             ;  shifting right by 8 bits
    ld  d,0
    add iy,de           ;  add offset to x_walls (gaps)
    add ix,de           ;  add offset

    ld  e,9             ;  y_walls, 9 dividers
    ld  d,b
    mlt de              ;  9*(y offset), no increment
    add ix,de
    ld  c,8             ;  x_walls, 8 gaps
    inc b
    mlt bc              ;  8*(x offset + 1), directly above, so increment by one
    add iy,bc
    ld  bc,9            ;  x_walls increment
    ld  de,8            ;  y increment

    ld  hl,0            ;  h:x  l:y
    exx

    and a,a             ;  reset carry flag
    sbc hl,de           ;  hl = -dy + dy*x + dx*y

    jp  p,.inc_x_start  ;  must check top and side above
    ; check side (y lines)
    exx
    ld  a,(ix)          ;  retrieve side byte
    bit 6,a             ;  letter/space?
    jp  nz,.hit_x_inv
    dec ix              ;  move right 1
    dec iy              ;  move right 1
    inc l               ;  increment y
    exx
    jp  .loop_yx

.inc_x_start:
    and a,a
    sbc hl,de           ;  if D > 0:  D -= dy
    exx
    ld  a,(iy)          ;  check x walls(above)
    bit 6,a
    jp  nz,.hit_y_inv
    add iy,de           ;  + 8 (go up one row)
    inc h               ;  go up
    
    add ix,bc           ;  + 9 (go up one row)
    ld  a,(ix)          ;  check y-aligned walls
    bit 6,a
    jp  nz,.hit_x_inv

    dec ix
    dec iy
    inc l               ;  increment x, go sideways
    exx
    jp  .loop_yx

.loop_yx:
    and a,a
    adc hl,bc           ;  D += dx
    jp  p,.inc_x_start
    ; check side (y lines)
    exx
    ld  a,(ix)          ;  check side
    bit 6,a
    jp  nz,.hit_x_inv

    dec iy
    dec ix
    inc l               ;  increment y
    exx
    jp  .loop_yx


.hit_x_inv:                 ;  hit at horizontal wall
    ;  h is x increase
    ;  l is y increase
    ld  iy,3
    add iy,sp
    ld  ix,(iy+24)
    ld  (ix),a          ;  texture type

    ld  bc,(iy+6)       ;  fractional part of y, must be kept same
    ld  a,c
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
    cpl
    inc a
    ld  ix,(iy+21)
    ld  (ix),a

    ei
    pop ix
    ret
.hit_y_inv:                 ;  hit at vertical wall
    ; h is total accumulated x increase
    ld  iy,3
    add iy,sp
    ld  ix,(iy+24)
    ld  (ix),a          ;  texture type

    ld  bc,(iy+3)       ;  fractional part of x, must be inverted +1 (2's complement)
    ld  a,c
    cpl
    inc a
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
    sub a,l
    cpl
    inc a
    ld  ix,(iy+21)
    ld  (ix),a

    ei
    pop ix
    ret

.dx_is_one_yx:
    ld  bc,0
    ld  c,a
    add hl,bc           ;  hl += y
    jp  .init_D_done_yx

.dy_is_one_yx:             ;  means that dy is 0, can skip
    ld  bc,0
    ld  c,a             ;  a stores x
    add hl,bc           ;  hl += x
    jp  .init_D_done_yx




    extern __idivs
    extern __imuls
    extern __idivu
    extern __imulu

    assume adl=1

