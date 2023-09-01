
    assume adl=1
    ;https://youtube.com/shorts/f0--ib8HpOM?feature=share

    section .rodata
    public lcdWidth
lcdWidth:=320
    public lcdHeight
    lcdHeight := 240

    section .text
    public _64_divis_lut
_64_divis_lut:
    dl  $004000, $002000, $001555, $001000, $000CCC, $000AAA, $000924, $000800, $00071C, $000666
    dl  $0005D1, $000555, $0004EC, $000492, $000444, $000400, $0003C3, $00038E, $00035E, $000333
    dl  $00030C, $0002E8, $0002C8, $0002AA, $00028F, $000276, $00025E, $000249, $000234, $000222
    dl  $000210, $000200, $0001F0, $0001E1, $0001D4, $0001C7, $0001BA, $0001AF, $0001A4, $000199
    dl  $00018F, $000186, $00017D, $000174, $00016C, $000164, $00015C, $000155, $00014E, $000147
    dl  $000141, $00013B, $000135, $00012F, $000129, $000124, $00011F, $00011A, $000115, $000111
    dl  $00010C, $000108, $000104, $000100, $0000FC, $0000F8, $0000F4, $0000F0, $0000ED, $0000EA
    dl  $0000E6, $0000E3, $0000E0, $0000DD, $0000DA, $0000D7, $0000D4, $0000D2, $0000CF, $0000CC
    dl  $0000CA, $0000C7, $0000C5, $0000C3, $0000C0, $0000BE, $0000BC, $0000BA, $0000B8, $0000B6
    dl  $0000B4, $0000B2, $0000B0, $0000AE, $0000AC, $0000AA, $0000A8, $0000A7, $0000A5, $0000A3
    dl  $0000A2, $0000A0, $00009F, $00009D, $00009C, $00009A, $000099, $000097, $000096, $000094
    dl  $000093, $000092, $000090, $00008F, $00008E, $00008D, $00008C, $00008A, $000089, $000088
    dl  $000087, $000086, $000085, $000084, $000083, $000082, $000081, $000080, $00007F, $00007E
    dl  $00007D, $00007C, $00007B, $00007A, $000079, $000078, $000077, $000076, $000075, $000075
    dl  $000074, $000073, $000072, $000071, $000070, $000070, $00006F, $00006E, $00006D, $00006D
    dl  $00006C, $00006B, $00006B, $00006A, $000069, $000069, $000068, $000067, $000067, $000066
    dl  $000065, $000065, $000064, $000063, $000063, $000062, $000062, $000061, $000060, $000060
    dl  $00005F, $00005F, $00005E, $00005E, $00005D, $00005D, $00005C, $00005C, $00005B, $00005B


; scales a vertical texture strip using the bresenham line algorithm
    public _draw_strip
_draw_strip:           ; this is most likely at D1E3BE
; draws a strip of texture, scaled, as fast as possible(hopefully)
; strip will be centered in future, for now will center before calling
; Arguments:
;    // technically arg0: return address
;    arg1: pointer to destination
;    arg2: pointer to texture structure
;    arg3: x coordinate
;    arg4: y coordinate
;    arg5: target height
;    arg6: texcoord
;    arg7: darkening factor
; Returns:
;  None
    di                  ;  disables interrupts, these use alternate register set, which this needs

    ld  iy,0            ;  set iy to stack pointer
    add iy,sp

    ; must save state of C++ stuff
    push ix             ;  ix must be preserved

    ld  ix,(iy+3)       ;  destination
    ld  hl,(iy+6)       ;  source

    ld  de,(iy+9)       ;  load x coord
    add ix,de           ;  add x coord to dest pointer

    ld  b,(iy+12)       ;  load y pos
    ld  c,160           ;  load 1/2 screen width
    mlt bc              ;  mult to find 1/2 offset
    add ix,bc           ;  add twice to add offset to dest
    add ix,bc

; figure out texture coordinate offset
    ld  e,(iy+18)       ;  texCoord, 0-255
    ld  d,64            ;  source size
    mlt de              ;  size scaled by texCoord in d, fixed point arithemetic (shifted 8 bits)
    ld  e,64
    mlt de              ;  de is now offset for source texCoord
    add hl,de           ;  add offset

    ld  de,(iy+15)      ;  target height
    ld  c,e             ;  loop counter
    ld  iy,_64_divis_lut
    add iy,de
    add iy,de
    add iy,de           ;  3*target height: byte offset for LUT
    ld  de,(iy-3)
    ld  b,e             ;  fractional
    ld  e,d
    ld  d,0             ;  integer part

    exx
    ld  de,320
    exx

    ex  af,af'
    ld  a,0
    ex  af,af'

;----end of init----
.loop:
    ld  a,(hl)
    ; sub a,c
    ld  (ix),a
    ld  (ix+1),a
    ld  (ix+2),a
    ld  (ix+3),a

    exx
    add ix,de
    exx

    ex  af,af'
    add a,b
    adc hl,de
    ex  af,af'

    dec c               ;  c is counter
    jp  nz,.loop        ;  jump back to loop while more than 0

    pop ix              ;  ix must be preserved

    ei
    ret                 ;  if c is 0, return

.end:
    pop ix              ;  ix must be preserved before exit

    ei
    ret                 ;  if c is 0, return

    extern __sdvrmu
    assume adl=1