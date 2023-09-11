
    assume adl=1
    ;https://youtube.com/shorts/f0--ib8HpOM?feature=share

    section .rodata
    ; public lcdWidth
    lcdWidth := 320
    ; public lcdHeight
    lcdHeight := 240

    section .text
    public _64_divis_lut_ext
_64_divis_lut_ext:
    dl  $400000, $200000, $155555, $100000, $0CCCCC, $0AAAAA, $092492, $080000, $071C71, $066666
    dl  $05D174, $055555, $04EC4E, $049249, $044444, $040000, $03C3C3, $038E38, $035E50, $033333
    dl  $030C30, $02E8BA, $02C859, $02AAAA, $028F5C, $027627, $025ED0, $024924, $0234F7, $022222
    dl  $021084, $020000, $01F07C, $01E1E1, $01D41D, $01C71C, $01BACF, $01AF28, $01A41A, $019999
    dl  $018F9C, $018618, $017D05, $01745D, $016C16, $01642C, $015C98, $015555, $014E5E, $0147AE
    dl  $014141, $013B13, $013521, $012F68, $0129E4, $012492, $011F70, $011A7B, $0115B1, $011111
    dl  $010C97, $010842, $010410, $010000, $00FC0F, $00F83E, $00F489, $00F0F0, $00ED73, $00EA0E
    dl  $00E6C2, $00E38E, $00E070, $00DD67, $00DA74, $00D794, $00D4C7, $00D20D, $00CF64, $00CCCC
    dl  $00CA45, $00C7CE, $00C565, $00C30C, $00C0C0, $00BE82, $00BC52, $00BA2E, $00B817, $00B60B
    dl  $00B40B, $00B216, $00B02C, $00AE4C, $00AC76, $00AAAA, $00A8E8, $00A72F, $00A57E, $00A3D7
    dl  $00A237, $00A0A0, $009F11, $009D89, $009C09, $009A90, $00991F, $0097B4, $00964F, $0094F2
    dl  $00939A, $009249, $0090FD, $008FB8, $008E78, $008D3D, $008C08, $008AD8, $0089AE, $008888
    dl  $008767, $00864B, $008534, $008421, $008312, $008208, $008102, $008000, $007F01, $007E07
    dl  $007D11, $007C1F, $007B30, $007A44, $00795C, $007878, $007797, $0076B9, $0075DE, $007507
    dl  $007432, $007361, $007292, $0071C7, $0070FE, $007038, $006F74, $006EB3, $006DF5, $006D3A
    dl  $006C80, $006BCA, $006B15, $006A63, $0069B4, $006906, $00685B, $0067B2, $00670B, $006666
    dl  $0065C3, $006522, $006483, $0063E7, $00634C, $0062B2, $00621B, $006186, $0060F2, $006060
    dl  $005FD0, $005F41, $005EB4, $005E29, $005D9F, $005D17, $005C90, $005C0B, $005B87, $005B05
    dl  $005A84, $005A05, $005987, $00590B, $00588F, $005816, $00579D, $005726, $0056B0, $00563B
    dl  $0055C7, $005555, $0054E4, $005474, $005405, $005397, $00532A, $0052BF, $005254, $0051EB
    dl  $005183, $00511B, $0050B5, $005050, $004FEC, $004F88, $004F26, $004EC4, $004E64, $004E04
    dl  $004DA6, $004D48, $004CEB, $004C8F, $004C34, $004BDA, $004B80, $004B27, $004AD0, $004A79
    dl  $004A22, $0049CD, $004978, $004924, $0048D1, $00487E, $00482D, $0047DC, $00478B, $00473C
    dl  $0046ED, $00469E, $004651, $004604, $0045B8, $00456C, $004521, $0044D7, $00448D, $004444
    dl  $0043FB, $0043B3, $00436C, $004325, $0042DF, $00429A, $004254, $004210, $0041CC, $004189
    dl  $004146, $004104, $0040C2, $004081, $004040, $004000, $003FC0, $003F80, $003F42, $003F03
    dl  $003EC6, $003E88, $003E4B, $003E0F, $003DD3, $003D98, $003D5D, $003D22, $003CE8, $003CAE
    dl  $003C75, $003C3C, $003C03, $003BCB, $003B94, $003B5C, $003B25, $003AEF, $003AB9, $003A83
    dl  $003A4E, $003A19, $0039E4, $0039B0, $00397C, $003949, $003916, $0038E3, $0038B1, $00387F
    dl  $00384D, $00381C, $0037EB, $0037BA, $003789, $003759, $00372A, $0036FA, $0036CB, $00369D
    dl  $00366E, $003640, $003612, $0035E5, $0035B7, $00358A, $00355E, $003531, $003505, $0034DA
    dl  $0034AE, $003483, $003458, $00342D, $003403, $0033D9, $0033AF, $003385, $00335C, $003333
    dl  $00330A, $0032E1, $0032B9, $003291, $003269, $003241, $00321A, $0031F3, $0031CC, $0031A6
    dl  $00317F, $003159, $003133, $00310D, $0030E8, $0030C3, $00309E, $003079, $003054, $003030
    dl  $00300C, $002FE8, $002FC4, $002FA0, $002F7D, $002F5A, $002F37, $002F14, $002EF2, $002ECF
    dl  $002EAD, $002E8B, $002E69, $002E48, $002E26, $002E05, $002DE4, $002DC3, $002DA3, $002D82
    dl  $002D62, $002D42, $002D22, $002D02, $002CE3, $002CC3, $002CA4, $002C85, $002C66, $002C47
    dl  $002C29, $002C0B, $002BEC, $002BCE, $002BB0, $002B93, $002B75, $002B58, $002B3A, $002B1D
    dl  $002B00, $002AE3, $002AC7, $002AAA, $002A8E, $002A72, $002A55, $002A3A, $002A1E, $002A02
    dl  $0029E7, $0029CB, $0029B0, $002995, $00297A, $00295F, $002944, $00292A, $002910, $0028F5
    dl  $0028DB, $0028C1, $0028A7, $00288D, $002874, $00285A, $002841, $002828, $00280F, $0027F6
    dl  $0027DD, $0027C4, $0027AB, $002793, $00277A, $002762, $00274A, $002732, $00271A, $002702
    dl  $0026EA, $0026D3, $0026BB, $0026A4, $00268C, $002675, $00265E, $002647, $002630, $00261A
    dl  $002603, $0025ED, $0025D6, $0025C0, $0025AA, $002593, $00257D, $002568, $002552, $00253C
    dl  $002526, $002511, $0024FB, $0024E6, $0024D1, $0024BC, $0024A7, $002492, $00247D, $002468
    dl  $002454, $00243F, $00242A, $002416, $002402, $0023EE, $0023D9, $0023C5, $0023B1, $00239E
    dl  $00238A, $002376, $002362, $00234F, $00233C, $002328, $002315, $002302, $0022EF, $0022DC
    dl  $0022C9, $0022B6, $0022A3, $002290, $00227E, $00226B, $002259, $002246, $002234, $002222
    dl  $00220F, $0021FD, $0021EB, $0021D9, $0021C8, $0021B6, $0021A4, $002192, $002181, $00216F
    dl  $00215E, $00214D, $00213B, $00212A, $002119, $002108, $0020F7, $0020E6, $0020D5, $0020C4
    dl  $0020B3, $0020A3, $002092, $002082, $002071, $002061, $002050, $002040, $002030, $002020
    dl  $002010, $002000, $001FF0, $001FE0, $001FD0, $001FC0, $001FB0, $001FA1, $001F91, $001F81
    dl  $001F72, $001F63, $001F53, $001F44, $001F35, $001F25, $001F16, $001F07, $001EF8, $001EE9
    dl  $001EDA, $001ECC, $001EBD, $001EAE, $001E9F, $001E91, $001E82, $001E74, $001E65, $001E57
    dl  $001E48, $001E3A, $001E2C, $001E1E, $001E0F, $001E01, $001DF3, $001DE5, $001DD7, $001DCA
    dl  $001DBC, $001DAE, $001DA0, $001D92, $001D85, $001D77, $001D6A, $001D5C, $001D4F, $001D41
    dl  $001D34, $001D27, $001D19, $001D0C, $001CFF, $001CF2, $001CE5, $001CD8, $001CCB, $001CBE
    dl  $001CB1, $001CA4, $001C97, $001C8B, $001C7E, $001C71, $001C65, $001C58, $001C4C, $001C3F
    dl  $001C33, $001C26, $001C1A, $001C0E, $001C01, $001BF5, $001BE9, $001BDD, $001BD1, $001BC4
    dl  $001BB8, $001BAC, $001BA1, $001B95, $001B89, $001B7D, $001B71, $001B65, $001B5A, $001B4E
    dl  $001B42, $001B37, $001B2B, $001B20, $001B14, $001B09, $001AFD, $001AF2, $001AE7, $001ADB
    dl  $001AD0, $001AC5, $001ABA, $001AAF, $001AA4, $001A98, $001A8D, $001A82, $001A77, $001A6D
    dl  $001A62, $001A57, $001A4C, $001A41, $001A36, $001A2C, $001A21, $001A16, $001A0C, $001A01
    dl  $0019F7, $0019EC, $0019E2, $0019D7, $0019CD, $0019C2, $0019B8, $0019AE, $0019A3, $001999
    dl  $00198F, $001985, $00197B, $001970, $001966, $00195C, $001952, $001948, $00193E, $001934
    dl  $00192A, $001920, $001917, $00190D, $001903, $0018F9, $0018F0, $0018E6, $0018DC, $0018D3
    dl  $0018C9, $0018BF, $0018B6, $0018AC, $0018A3, $001899, $001890, $001886, $00187D, $001874
    dl  $00186A, $001861, $001858, $00184F, $001845, $00183C, $001833, $00182A, $001821, $001818
    dl  $00180F, $001806, $0017FD, $0017F4, $0017EB, $0017E2, $0017D9, $0017D0, $0017C7, $0017BE
    dl  $0017B5, $0017AD, $0017A4, $00179B, $001792, $00178A, $001781, $001779, $001770, $001767
    dl  $00175F, $001756, $00174E, $001745, $00173D, $001734, $00172C, $001724, $00171B, $001713
    dl  $00170B, $001702, $0016FA, $0016F2, $0016EA, $0016E1, $0016D9, $0016D1, $0016C9, $0016C1
    dl  $0016B9, $0016B1, $0016A9, $0016A1, $001699, $001691, $001689, $001681, $001679, $001671
    dl  $001669, $001661, $00165A, $001652, $00164A, $001642, $00163B, $001633, $00162B, $001623
    dl  $00161C, $001614, $00160D, $001605, $0015FD, $0015F6, $0015EE, $0015E7, $0015DF, $0015D8
    dl  $0015D0, $0015C9, $0015C2, $0015BA, $0015B3, $0015AC, $0015A4, $00159D, $001596, $00158E
    dl  $001587, $001580, $001579, $001571, $00156A, $001563, $00155C, $001555, $00154E, $001547
    dl  $001540, $001539, $001532, $00152A, $001524, $00151D, $001516, $00150F, $001508, $001501
    dl  $0014FA, $0014F3, $0014EC, $0014E5, $0014DF, $0014D8, $0014D1, $0014CA, $0014C3, $0014BD
    dl  $0014B6, $0014AF, $0014A9, $0014A2, $00149B, $001495, $00148E, $001488, $001481, $00147A
    dl  $001474, $00146D, $001467, $001460, $00145A, $001453, $00144D, $001446, $001440, $00143A
    dl  $001433, $00142D, $001427, $001420, $00141A, $001414, $00140D, $001407, $001401, $0013FB
    dl  $0013F4, $0013EE, $0013E8, $0013E2, $0013DC, $0013D5, $0013CF, $0013C9, $0013C3, $0013BD
    dl  $0013B7, $0013B1, $0013AB, $0013A5, $00139F, $001399, $001393, $00138D, $001387, $001381
    dl  $00137B, $001375, $00136F, $001369, $001363, $00135D, $001357, $001352, $00134C, $001346
    dl  $001340, $00133A, $001335, $00132F, $001329, $001323, $00131E, $001318, $001312, $00130D
    dl  $001307, $001301, $0012FC, $0012F6, $0012F0, $0012EB, $0012E5, $0012E0, $0012DA, $0012D5
    dl  $0012CF, $0012C9, $0012C4, $0012BE, $0012B9, $0012B4, $0012AE, $0012A9, $0012A3, $00129E
    dl  $001298, $001293, $00128E, $001288, $001283, $00127D, $001278, $001273, $00126E, $001268
    dl  $001263, $00125E, $001258, $001253, $00124E, $001249, $001243, $00123E, $001239, $001234
    dl  $00122F, $00122A, $001224, $00121F, $00121A, $001215, $001210, $00120B, $001206, $001201
    dl  $0011FC, $0011F7, $0011F1, $0011EC, $0011E7, $0011E2, $0011DD, $0011D8, $0011D3, $0011CF
    dl  $0011CA, $0011C5, $0011C0, $0011BB, $0011B6, $0011B1, $0011AC, $0011A7, $0011A2, $00119E
    dl  $001199, $001194, $00118F, $00118A, $001185, $001181, $00117C, $001177, $001172, $00116E
    dl  $001169, $001164, $00115F, $00115B, $001156, $001151, $00114D, $001148, $001143, $00113F
    dl  $00113A, $001135, $001131, $00112C, $001127, $001123, $00111E, $00111A, $001115, $001111
    dl  $00110C, $001107, $001103, $0010FE, $0010FA, $0010F5, $0010F1, $0010EC, $0010E8, $0010E4
    dl  $0010DF, $0010DB, $0010D6, $0010D2, $0010CD, $0010C9, $0010C5, $0010C0, $0010BC, $0010B7
    dl  $0010B3, $0010AF, $0010AA, $0010A6, $0010A2, $00109D, $001099, $001095, $001090, $00108C
    dl  $001088, $001084, $00107F, $00107B, $001077, $001073, $00106E, $00106A, $001066, $001062
    dl  $00105E, $001059, $001055, $001051, $00104D, $001049, $001045, $001041, $00103C, $001038
    dl  $001034, $001030, $00102C, $001028, $001024, $001020, $00101C, $001018

; scales a vertical texture strip using the bresenham line algorithm
    public _draw_strip_clipped
_draw_strip_clipped:
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
; Returns:
;  None
    di                  ;  disables interrupts, these use alternate register set, which this needs

    ld  iy,0            ;  set iy to stack pointer
    add iy,sp

    ; must save state of C++ stuff
    push ix             ;  ix must be preserved

    ld  ix,(iy+3)       ;  destination
    ld  de,(iy+9)       ;  load x coord
    add ix,de           ;  add x coord to dest pointer

; finding offset for source
    ld  de,(iy+12)      ;  y coord (negative)
    ld  hl,0
    and a,a             ;  reset carry
    sbc hl,de           ;  abs of y coord

    ld  de,(iy+15)      ;  target height
    ld  iy,_64_divis_lut_ext
    add iy,de
    add iy,de
    add iy,de
    ld  bc,(iy-3)
    exx
    ld  bc,(iy-3)       ;  increment, 16-bit fixed point
    exx
    call __imulu        ;  64/target_height  *  abs(y_coord)    =  abs(y_coord)/target_height *  64
    push hl
    ld iy,2
    add iy,sp
    ld  c,(iy)        ;  integer part of hl(abs(y_coord)/target_height * 64)
    ld  (iy),0
    ld  b,0
    exx
    pop hl              ;  fractional part of abs(y_coord)/target_height * 64
    exx

    ld  iy,3
    add iy,sp
    ld  hl,(iy+6)       ;  source
; figure out texture coordinate offset
    ld  e,(iy+18)       ;  texCoord, 0-255
    ld  d,64            ;  source size
    mlt de              ;  size scaled by texCoord in d, fixed point arithemetic
    ld  e,64
    mlt de              ;  de is now offset for source texCoord
    add hl,de           ;  add offset

    add hl,bc           ;  skip to corresponding texture on edge of screen
    ld  b,a             ;  64/target_height
    ld  de,0

    exx
    ld  de,320          ;  screen width
    exx
    ld  c,180           ;  target height

;----end of init-----
.loop:
    ld  a,(hl)
    ld  (ix),a
    ld  (ix+1),a
    ld  (ix+2),a
    ld  (ix+3),a

    exx
    add ix,de
    exx

    exx
    add.s hl,bc
    exx
    adc hl,de

    dec c               ;  c is counter
    jp  nz,.loop        ;  jump back to loop while more than 0

    pop ix              ;  ix must be preserved

    ei
    ret                 ;  if c is 0, return

; same algorithm as above, for transparent textures
    public _draw_strip_transparent_clipped
_draw_strip_transparent_clipped:
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
; Returns:
;  None
    di                  ;  disables interrupts, these use alternate register set, which this needs

    ld  iy,0            ;  set iy to stack pointer
    add iy,sp

    ; must save state of C++ stuff
    push ix             ;  ix must be preserved

    ld  ix,(iy+3)       ;  destination
    ld  de,(iy+9)       ;  load x coord
    add ix,de           ;  add x coord to dest pointer

; finding offset for source
    ld  de,(iy+12)      ;  y coord (negative)
    ld  hl,0
    and a,a             ;  reset carry
    sbc hl,de           ;  abs of y coord

    ld  de,(iy+15)      ;  target height
    ld  iy,_64_divis_lut_ext
    add iy,de
    add iy,de
    add iy,de
    ld  bc,(iy-3)
    exx
    ld  bc,(iy-3)       ;  increment, 16-bit fixed point
    exx
    call __imulu        ;  64/target_height  *  abs(y_coord)    =  abs(y_coord)/target_height *  64
    push hl
    ld iy,2
    add iy,sp
    ld  c,(iy)        ;  integer part of hl(abs(y_coord)/target_height * 64)
    ld  (iy),0
    ld  b,0
    exx
    pop hl              ;  fractional part of abs(y_coord)/target_height * 64
    exx

    ld  iy,3
    add iy,sp
    ld  hl,(iy+6)       ;  source
; figure out texture coordinate offset
    ld  e,(iy+18)       ;  texCoord, 0-255
    ld  d,64            ;  source size
    mlt de              ;  size scaled by texCoord in d, fixed point arithemetic
    ld  e,64
    mlt de              ;  de is now offset for source texCoord
    add hl,de           ;  add offset

    add hl,bc           ;  skip to corresponding texture on edge of screen
    ld  b,a             ;  64/target_height
    ld  de,0

    exx
    ld  de,320          ;  screen width
    exx
    ld  c,180           ;  target height

;----end of init-----
.loop:
    ld  a,(hl)
    dec a
    jp  z,.skip
    inc a
    ld  (ix),a
    ld  (ix+1),a
    ld  (ix+2),a
    ld  (ix+3),a
.skip:
    exx
    add ix,de
    exx

    exx
    add.s hl,bc
    exx
    adc hl,de

    dec c               ;  c is counter
    jp  nz,.loop        ;  jump back to loop while more than 0

    pop ix              ;  ix must be preserved

    ei
    ret                 ;  if c is 0, return

    extern __imuls
    extern __imulu
    extern __irems
    extern __idivs

    assume adl=1