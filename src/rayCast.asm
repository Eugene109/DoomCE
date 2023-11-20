    assume adl=1

    section .data

    public _x_walls_q1
    public _y_walls_q1
    public _x_walls_transposed_q1
    public _y_walls_transposed_q1
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

_x_walls_q1:
    db  "AAAAAAAAAAAAAAAA ACA A AA ACA   A    CA      A  A   A  A A A A  A   A A CAA  A  A    A ACA A  A  AdA  A   A      A A A  A   ACA     A    C   A      A  A AA  AA  AdA A A A d   A A AA A   A A  A     AAA A    A  A  C  AA     A   A C    A  AAA    AAAAAAAAA    AAAAAAAAAAAAAAAA"
_y_walls_q1:
    db  "B DD       DD   BBB  BDDB BB  B  BBD  BB   BB  DD BBB  a  BB  BBB  BBD  BBB DD  B B BBB  B  B  BB   BBB BB  B        BBBB  BB  BB  BDD BBB  a   BDD B   BBB  BB B   BBB BBB BB  B BBBBBB  BBB   B BBB     BBBB     B  B   B BB B DD   BB    BBB  B        B   BB               B"
_y_walls_transposed_q1:
    db  "BBBBBBBBBBBBBBBB BDBDB BBB BB   D     B   B  B  D     B   B   B  BBdBB BdB   D   DB B  B B B D   D  B B   B      B B B   B BB      BD  BB BB     BB D  BD BB B   BB  B  D B BB  D  B B   BB     D  BB  BBBB   B  BDB   D BB       D B  D    B        BB  B B B  BBBBBBBBBBBBBBBB"
_x_walls_transposed_q1:
    db  "A AAAA          AAA    AA  AA A  AAC    a   a   A AAA    AA  AA   AAA  AA   AA A CCAAAAC  A A  A A  AAA A A A    AA  AAAA A A   AA AA AAAA  CC A     A AAA  AAA  CAA A AAAAA  A A  A A   AAAC A A    a    AAAA     A   A  A AA AAA  CAA    A AA    A A A  AAA AA         AA    A"




_x_walls_q2:
    db  "AAAAAAAAAAAAAAAA   ACA AA A ACA   A      AC    A  A A A A  A   A  A  AAC A A   A A  A ACA A    A     A   A  AdA  ACA   A  A A A   A   C    A     AA  AA A  A    A   d A A A AdA A  A A   A AA A  A    A AAA      A     AA  C  A  AAA  A    C A      AAAAAAAAA   AAAAAAAAAAAAAAAA"
_y_walls_q2:
    db  "B   DD       DD BB  B  BB BDDB  BBB DD  BB   BB  DBB  BBB  BB a   BBB B B  DD BBB  DBBB   BB  B  B  BBBB        B  BB BB DDB  BB  BB  BBB   B DDB  a   BBBB BBB   B BB  BBB  BBBBBB B  BB BBB     BBB B   BBB B   B  B     BBBB    BB   DD B BB   B        B  BB               B"
_y_walls_transposed_q2:
    db  "BBBBBBBBBBBBBBBB     BB  B B B    D B  D    B    BDB   D BB     D  BB  BBBB   B D  B B   BB      BB  B  D B BB   BB D  BD BB B     BD  BB BB     B B B   B BB    D  B B   B      DBdB  BdB B D   BB BB B B   D  D     B   B   B D     B   B  B   BDBDB BBB BB   BBBBBBBBBBBBBBBB"
_x_walls_transposed_q2:
    db  "A         AA    AA    A A A  AAA AA AAA  CAA    A AAA     A   A  A AAC A A    a    AAAA  A A  A A   AAA  AAA  CAA A AAAAA  CC A     A AAAA A A   AA AA AAA A A A    AA  AAAAC  A A  A A  AAA  AA   AA A CCAAAA    AA  AA   AAAC    a   a   A AAA    AA  AA A  AA AAAA          A"




_x_walls_q3:
    db  "AAAAAAAAAAAAAAAA    AAAAAAAAA    AAA  A    C A   A     AA  C  A  A    A AAA     A  AdA   A AAdA A     A A A A A  AA  AA A  A      A   C    A     ACA   A  A AdA      A   A  A A  A  A ACA A    A  A  AAC A A   A  A A A A  A   A  A      AC    A   ACA AA A ACA AAAAAAAAAAAAAAAA"
_y_walls_q3:
    db  "B               BB   B        B  BBB    BB   DD B BB B   B  B     BBBB     BBB B   BBB  BBBBBB B  BB BBB BBB   B BB  BBB   B DDB  a   BBB DDB  BB  BB  BBBB        B  BB BBB   BB  B  B  BBB B B  DD BBB  DBB  BBB  BB a   BBB DD  BB   BB  DBB  B  BB BDDB  BBB   DD       DD B"
_y_walls_transposed_q3:
    db  "BBBBBBBBBBBBBBBB  B B B  BB        B    D  B D       BB D   BDB  B   BBBB  BB  D     BB   B B  D  BB B D  B  BB   B BB DB  D BB     BB BB  DB      BB B   B B B      B   B B  D   D B BdB  BdBD   D   B B BB BB  B   B   B     D  B  B   B     D   BB BBB BDBDB BBBBBBBBBBBBBBBB"
_x_walls_transposed_q3:
    db  "A    AA         AA AAA  A A A    AA A    AAC  AAA AA A  A   A     AAAA   a     A A CAAA   A A  A A  AAAAA A AAC  AAA  AAA A     A CC  AAAA AA AA   A A AAAA  AA    A A A AAA  A A  A A  CAAAACC A AA   AA  AAA   AA  AA    AAA A  a   a     CAA  A AA  AA    AAA          AAAA A"




_x_walls_q4:
    db  "AAAAAAAAAAAAAAAA   AAAAAAAAA      A C    A  AAA  A  C  AA     A      AAA A    A  AdAA A   AdA  A A A A A A     A    A  A AA  AA     A    C   A   AdA A  A   ACA  A A  A   A     A    A ACA A  A A   A A CAA  A  A   A  A A A A  A    CA      A   ACA A AA ACA   AAAAAAAAAAAAAAAA"
_y_walls_q4:
    db  "B               BB  B        B   BB B DD   BB    BBBB     B  B   B BBB   B BBB     BBB BB  B BBBBBB  BBB  BB B   BBB BBBB  a   BDD B   BBB  BB  BB  BDD BB BB  B        BBBB  B  B  BB   BBBD  BBB DD  B B BBB  a  BB  BBB  BBD  BB   BB  DD BBB  BDDB BB  B  BB DD       DD   B"
_y_walls_transposed_q4:
    db  "BBBBBBBBBBBBBBBB   BB BBB BDBDB   B  B   B     D B   B   B     D  D   BdB BBdBB   D B B B  B BD      B   B B  D    BB B   B B B     BB BB  DB     B BB DB  D BB   BB B D  B  BB      BB   B B  D B   BBBB  BB  D     BB D   BDB    B    D  B D    B B B  BB     BBBBBBBBBBBBBBBB"
_x_walls_transposed_q4:
    db  "A          AAAA AA  A AA  AA    AAA A  a   a     CAAA   AA  AA    AAAACC A AA   AA  AAA  A A  A A  CAAAA  AA    A A A AAA AA AA   A A AAAA A     A CC  AAAAA A AAC  AAA  AAA   A A  A A  AAAA   a     A A CAA A  A   A     AAA A    AAC  AAA AA AAA  A A A    AA    AA         A"


_door_states:
    dl $000000,$000000,$000000,$000000,$000000,$000000
    public _set_door_state
_set_door_state:
; sets the state of a door
; Arguments:
;    // technically arg0: return address
;    arg1: door name, starts at 'a', 
; Returns:
;  None
    ld  iy,0
    add iy,sp
    ld  a,(iy+3)
    sub a,'a'
    ld  l,a
    ld  h,3
    mlt hl
    ld  de,_door_states
    add hl,de
    ld  bc,(iy+6)
    ld  (hl),bc
    ret
_xy_save:
    dl $000000
_dx_save:
    dl $000000
_dy_save:
    dl $000000
_D_save:
    dl $000000
_iy_save:
    dl $000000
_ix_save:
    dl $000000


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
;    arg9: pointer to x_walls_q1
;    arg10: flipTexCoord
; Returns:
;  None
    di                  ;  disables interrupts, these use alternate register set, which this needs

    ld  iy,0
    add iy,sp

    push ix             ;  needs to be preserved

    ld  hl,0

    ; hl += dy*x
    ld  a,(iy+3)        ;  fractional part of x, must take 2's complement
    cpl                 ;  two's complement
    add a,1             ;  set cary flag

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
.main_loop_continue:

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
    bit 5,a             ;  1 at bit 5 means lowercase letter (>= 97)
    jp  nz,.dark_matter_x_wall

    ld  iy,3
    add iy,sp
    ld  ix,(iy+24)
    ld  (ix),a          ;  texture type

    ld  bc,(iy+6)       ;  fractional part of y, must be inverted +1 (2's complement)
    ld  a,c
    ; neg
    cpl
    add a,1
.hit_x_jumpInLate:
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
    
    bit 0,(iy+30)
    jp  z, .hit_keepTexCoord
    neg
.hit_keepTexCoord:

    ld  ix,(iy+21)      ;  texcoord
    ld  (ix),a

    ei
    pop ix
    ret
.hit_y:                 ;  hit at vertical wall
    ; h is total accumulated x increase
    bit 5,a             ;  1 at bit 5 means lowercase letter (>= 97)
    jp  nz,.dark_matter_y_wall

    ld  iy,3
    add iy,sp
    ld  ix,(iy+24)
    ld  (ix),a          ;  texture type

    ld  bc,(iy+3)       ;  fractional part of x, must be inverted +1 (2's complement)
    ld  a,c
    ; neg
    cpl
    add a,1
.hit_y_jumpInLate:
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

    bit 0,(iy+30)
    jp  z, .hit_keepTexCoord
    neg

    ld  ix,(iy+21)      ;  texCoord
    ld  (ix),a

    ei
    pop ix
    ret

;                                                               
;             --------                     --------             
;            [ y-door ]                   [ x-door ]            
;             --------                     --------             
;                                                               
;                                                               
;            [   2   ]                         6                
;            [   b   ]                         f                
;            [_______]              _______ _______ _______     
;            {   :   }                     ]       [            
;       1 a  {   :   }  c 3             0  ]-------[  e 5       
;            {___:___}              _______]_______[_______     
;            [       ]                                          
;            [   0   ]                         d                
;            [       ]                         4                
;                                                               
;                                                               
;    --------------------------    -------------------------    
;     a-c / 1-3 (bit 2 is off)      d-f / 4-6 (bit 2 is on)     
;                                                               
;                                                               
;        (maybe adding moving walls, use letters  h-k)          
;                                                               

.dark_matter_x_wall:
    ;  this is a hit on a x-wall, so letters b and d are possible
    ;  check bit 2 for y-door or x-door
    exx
    sra b
    rr  c
    and a,a
    adc hl,bc           ;  D += 1/2 dy            // WRONG MATH IDIOT add half of bc and test if positive, 
    exx
    jp  p,.door_hit

.jump_to_hit_y:
    ; inc iy
    add iy,de
    ld  a,(iy)
    jp  .hit_y

.door_hit:
    ld  (_xy_save),hl
    ld  (_iy_save),iy

    ld  iy,3
    add iy,sp
    ld  ix,(iy+24)
    ld  (ix),'E'        ;  texture type

    ld  bc,(iy+6)       ;  fractional part of x, must be inverted +1 (2's complement)
    ld  a,c
    cpl
    add a,129

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
    
    bit 0,(iy+30)
    jp  z, .dark_matter_keepTexCoord_x_door
    neg
.dark_matter_keepTexCoord_x_door:
    ld  ix,(iy+21)      ;  texCoord
    ld  hl,_door_states
    add a, (hl)
    ld  (ix),a
    jp  nc,.return_to_hit_y

    ei
    pop ix
    ret

.return_to_hit_y:
    ld  iy,(_iy_save)
    ld  hl,(_xy_save)
    ld  de,divs
    add iy,de
    ld  a,(iy)
    jp  .hit_y

.dark_matter_y_wall:
    ;  this is a hit on a y-wall, so letters a and e are possible
    ;  check bit 2 for y-door or x-door
.dark_matter_a:
    ld  (_xy_save),hl
    exx
    ld  (_D_save),hl
    ld  (_dx_save),bc   ;  can move to back for better performance, not really
    ld  (_dy_save),de
    and a,a
    rr d
    rr e
    and a,a
    adc hl,de           ;  D += 1/2 dy
    exx
    jp  p,.jump_to_hit_x

    ld  (_iy_save),iy
    ld  (_ix_save),ix

    ld  iy,3
    add iy,sp
    ld  ix,(iy+24)
    ld  (ix),'E'        ;  texture type

    ld  bc,(iy+3)       ;  fractional part of x, must be inverted +1 (2's complement)
    ld  a,c
    cpl
    add a,129

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

    bit 0,(iy+30)
    jp  z, .dark_matter_keepTexCoord_y_wall
    neg
.dark_matter_keepTexCoord_y_wall:
    ld  ix,(iy+21)      ;  texCoord
    ld  hl,_door_states
    add a, (hl)
    ld  (ix),a
    jp  nc,.return_to_main_loop

    ei
    pop ix
    ret

.return_to_main_loop:
    ld  hl,(_xy_save)
    ld  bc,gaps         ;  x_walls increment
    ld  de,divs         ;  y increment
    exx
    ld  hl,(_D_save)
    ld  bc,(iy+9)   ;  arg 3, dx
    ld  de,(iy+12)  ;  arg 4, dy
    exx
    ld  iy,(_iy_save)
    ld  ix,(_ix_save)
    jp  .main_loop_continue

.jump_to_hit_x:
    inc ix
    ld  a,(ix)
    jp  .hit_x

.notDoneYet:
    ld  iy,3
    add iy,sp

    ld  ix,(iy+24)
    ld  (ix),'E'        ;  texture type
    ld  ix,(iy+21)
    ld  (ix),0          ;  texcoord
    ld  ix,(iy+15)      ;  x pos
    ld  (ix),255
    ld  ix,(iy+18)      ;  y pos
    ld  (ix),255

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

