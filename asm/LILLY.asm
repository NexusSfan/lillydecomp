; SPDX-License-Identifier: CC0-1.0
; Disassembly of LILLY.bin, with comments.
;
; Legend: *  = CODE not yet run (tentative code)
;         D  = DATA directive (referenced in some way)
;         G  = GFX directive, shown as '#' (stored in player, missile, ball)
;         P  = PGFX directive, shown as '*' (stored in playfield)
;         C  = COL directive, shown as color constants (stored in player color)
;         CP = PCOL directive, shown as color constants (stored in playfield color)
;         CB = BCOL directive, shown as color constants (stored in background color)
;         A  = AUD directive (stored in audio registers)
;         i  = indexed accessed only
;         c  = used by code executed in RAM
;         s  = used by stack
;         !  = page crossed, 1 cycle penalty

    processor 6502


;-----------------------------------------------------------
;      Color constants
;-----------------------------------------------------------

BLACK0           = $00
BLACK1           = $10
YELLOW           = $20
GREEN_YELLOW     = $30
ORANGE           = $40
GREEN            = $50
RED              = $60
CYAN_GREEN       = $70
MAUVE            = $80
CYAN             = $90
VIOLET           = $a0
BLUE_CYAN        = $b0
PURPLE           = $c0
BLUE             = $d0
BLACKE           = $e0
BLACKF           = $f0


;-----------------------------------------------------------
;      TIA and IO constants accessed
;-----------------------------------------------------------

CXP0FB          = $02  ; (R)
CXPPMM          = $07  ; (R)
INPT4           = $0c  ; (R)

VSYNC           = $00  ; (W)
VBLANK          = $01  ; (W)
WSYNC           = $02  ; (W)
NUSIZ0          = $04  ; (W)
NUSIZ1          = $05  ; (W)
COLUP0          = $06  ; (W)
COLUP1          = $07  ; (W)
COLUPF          = $08  ; (W)
COLUBK          = $09  ; (W)
CTRLPF          = $0a  ; (W)
REFP0           = $0b  ; (W)
REFP1           = $0c  ; (W)
PF0             = $0d  ; (W)
PF1             = $0e  ; (W)
PF2             = $0f  ; (W)
RESP0           = $10  ; (W)
RESP1           = $11  ; (W)
;RESM0          = $12  ; (Wi)
;RESBL          = $14  ; (Wi)
AUDC0           = $15  ; (W)
AUDC1           = $16  ; (W)
AUDF0           = $17  ; (W)
AUDF1           = $18  ; (W)
AUDV0           = $19  ; (W)
AUDV1           = $1a  ; (W)
GRP0            = $1b  ; (W)
GRP1            = $1c  ; (W)
ENAM0           = $1d  ; (W)
ENABL           = $1f  ; (W)
HMP0            = $20  ; (W)
HMP1            = $21  ; (W)
HMM0            = $22  ; (W)
HMM1            = $23  ; (W)
;HMBL           = $24  ; (Wi)
VDELP0          = $25  ; (W)
VDELP1          = $26  ; (W)
HMOVE           = $2a  ; (W)
HMCLR           = $2b  ; (W)
CXCLR           = $2c  ; (W)

SWCHA           = $0280
SWCHB           = $0282
INTIM           = $0284
TIM64T          = $0296


;-----------------------------------------------------------
;      RIOT RAM (zero-page) labels
;-----------------------------------------------------------

ram_80          = $80
ram_81          = $81
ram_82          = $82
ram_83          = $83
ram_84          = $84
ram_85          = $85
ram_86          = $86
ram_87          = $87
ram_88          = $88
ram_89          = $89
ram_8A          = $8a
ram_8B          = $8b
ram_8C          = $8c
ram_8D          = $8d
ram_8E          = $8e
ram_8F          = $8f
ram_90          = $90
ram_91          = $91
;                 $92  (i)
ram_93          = $93
;                 $94  (i)
ram_95          = $95
;                 $96  (i)
ram_97          = $97
;                 $98  (i)
ram_99          = $99
;                 $9a  (i)
ram_9B          = $9b
ram_9C          = $9c
ram_9D          = $9d
;                 $9e  (i)
ram_9F          = $9f
;                 $a0  (i)
ram_A1          = $a1
;                 $a2  (i)
ram_A3          = $a3
ram_A4          = $a4
ram_A5          = $a5
;                 $a6  (i)
ram_A7          = $a7
ram_A8          = $a8
ram_A9          = $a9
ram_AA          = $aa
ram_AB          = $ab
;                 $ac  (i)
ram_AD          = $ad
;                 $ae  (i)
ram_AF          = $af
;                 $b0  (i)
ram_B1          = $b1
;                 $b2  (i)
ram_B3          = $b3
;                 $b4  (i)
ram_B5          = $b5
;                 $b6  (i)
ram_B7          = $b7
player_X        = $b8
hawk_X          = $b9
;                 $ba  (i)
hawk_Y          = $bb
;                 $bc  (i)
player_Y        = $bd
ram_BE          = $be
ram_BF          = $bf
ram_C0          = $c0
swimming_X      = $c1
ghost_X          = $c2
ram_C3          = $c3
ram_C4          = $c4
ram_C5          = $c5
ram_C6          = $c6
player_is_dead  = $c7
ram_C8          = $c8
ram_C9          = $c9
ram_CA          = $ca
ram_CB          = $cb
timer_1st_half  = $cc
timer_2nd_half  = $cd
ram_CE          = $ce
;                 $cf  (i)
;                 $d0  (i)
ram_D1          = $d1
ram_D2          = $d2
ram_D3          = $d3
ram_D4          = $d4
ram_D5          = $d5
ram_D6          = $d6
ram_D7          = $d7
aud0_music_ctrl = $d8
aud1_music_ctrl = $d9
ram_DA          = $da
ram_DB          = $db
ram_DC          = $dc
ram_DD          = $dd
ram_DE          = $de
ram_DF          = $df
ram_E0          = $e0
ram_E1          = $e1

ram_E3          = $e3
ram_E4          = $e4
audc_ctrl       = $e5 ; ex. audc_ctrl = fa, then audc0/audc1 = a
ram_E6          = $e6
ram_E7          = $e7
ram_E8          = $e8
ram_E9          = $e9
ram_EA          = $ea
ram_EB          = $eb
;                 $ec  (i)
ram_ED          = $ed
ram_EE          = $ee

;                 $fa  (s)
;                 $fb  (s)
;                 $fc  (s)
;                 $fd  (s)
;                 $fe  (s)
;                 $ff  (s)


;-----------------------------------------------------------
;      User Defined Labels
;-----------------------------------------------------------

; Ignore errors made by these.

Start           = $f1dc
set_player_dead = $f44a
store_ghost_X   = $f604


;***********************************************************
;      Bank 0
;***********************************************************

    SEG     CODE
    ORG     $f000

Lf000
    sta     NUSIZ0                  ;3        
    sta     NUSIZ1                  ;3        
    sta     HMP1                    ;3        
    lda     ram_81                  ;3        
    sta     COLUP1                  ;3        
    lda     ram_82                  ;3        
    sta     COLUP0                  ;3        
    lda     ram_84                  ;3        
    sta     COLUPF                  ;3        
    lda     #$30                    ;2        
    sta     CTRLPF                  ;3        
    nop                             ;2        
    sta     ENABL                   ;3        
    sta     RESP1                   ;3        
    sta     WSYNC                   ;3   =  43
;---------------------------------------
    sta     HMOVE                   ;3        
    ldx     #$06                    ;2   =   5
Lf021
    dex                             ;2        
    bpl     Lf021                   ;2/3      
    sta     HMCLR                   ;3        
    nop                             ;2        
    lda     #$b0                    ;2        
    sta     HMP0                    ;3        
    sta.w   RESP0                   ;4        
    ldy     #$14                    ;2   =  20
Lf030
    lda     (ram_93),y              ;5        
    sta     WSYNC                   ;3   =   8
;---------------------------------------
    sta     HMOVE                   ;3        
    sta     GRP0                    ;3        
    lda     (ram_91),y              ;5        
    sta     GRP1                    ;3        
    lda     #$00                    ;2        
    sta     PF2                     ;3        
    ldx     #$02                    ;2   =  21
Lf042
    dex                             ;2        
    bpl     Lf042                   ;2/3      
    sta     HMCLR                   ;3        
    lda     (ram_95),y              ;5        
    nop                             ;2        
    sta     PF2                     ;3        
    sta     ram_8E                  ;3        
    dey                             ;2        
    bpl     Lf030                   ;2/3      
    lda     #$00                    ;2        
    sta     WSYNC                   ;3   =  29
;---------------------------------------
    sta     HMOVE                   ;3        
    sta     GRP0                    ;3        
    sta     GRP1                    ;3        
    sta     PF2                     ;3        
    lda     ram_85                  ;3        
    sta     COLUPF                  ;3        
    lda     #$e0                    ;2        
    sta     RESP1                   ;3        
    sta     HMP1                    ;3        
    lda     #$b0                    ;2        
    sta     HMP0                    ;3        
    sta     HMP0                    ;3        
    lda     #$17                    ;2        
    sta     NUSIZ0                  ;3        
    lda     #$32                    ;2        
    sta     NUSIZ1                  ;3        
    sta.w   RESP0                   ;4        
    lda     ram_8E                  ;3        
    sta     PF2                     ;3        
    ldy     #$0f                    ;2        
    lda     ram_83                  ;3        
    sta     COLUP1                  ;3        
    lda     ram_86                  ;3        
    sta     COLUP0                  ;3        
    sta     WSYNC                   ;3   =  71
;---------------------------------------
    sta     HMOVE                   ;3        
    lda     (ram_97),y              ;5        
    sta     GRP1                    ;3        
    lda     ram_B7                  ;3        
    sta     GRP0                    ;3        
    lda     #$00                    ;2        
    sta     PF1                     ;3        
    sta     PF2                     ;3        
    lda     #$02                    ;2        
    sta     ENAM0                   ;3        
    sta     HMCLR                   ;3        
    lda     (ram_99),y              ;5        
    sta     PF1                     ;3        
    lda     (ram_9B),y              ;5        
    sta     PF2                     ;3        
    lda     #$10                    ;2        
    sta     HMP0                    ;3        
    lda     #$f0                    ;2        
    sta     HMM0                    ;3        
    sta     HMM1                    ;3        
    dey                             ;2   =  64
Lf0b1
    sta     WSYNC                   ;3   =   3
;---------------------------------------
    sta     HMOVE                   ;3        
    lda     (ram_97),y              ;5        
    sta     GRP1                    ;3        
    lda     #$00                    ;2        
    sta     PF1                     ;3        
    sta     PF2                     ;3        
    lda     ram_87                  ;3        
    sta     COLUPF                  ;3        
    ldx     ram_8A                  ;3        
    ldx     ram_8A                  ;3        
    lda     (ram_99),y              ;5        
    sta     PF1                     ;3        
    lda     (ram_9B),y              ;5        
    dey                             ;2        
    sta     PF2                     ;3        
    bmi     Lf0dc                   ;2/3      
    asl     Lf000,x                 ;7        
    lda     ram_85                  ;3        
    sta     COLUPF                  ;3        
    jmp     Lf0b1                   ;3   =  67
    
Lf0dc
    sta     HMCLR                   ;3        
    ldy     #$07                    ;2        
    lda     #$00                    ;2        
    sta     ENAM0                   ;3        
    sta     GRP1                    ;3        
    lda     ram_8B                  ;3        
    sty     NUSIZ1                  ;3        
    sta     WSYNC                   ;3   =  22
;---------------------------------------
    sta     HMOVE                   ;3        
    stx     COLUBK                  ;3        
    sta     COLUPF                  ;3        
    lda     #$ff                    ;2        
    sta     PF0                     ;3        
    sta     PF1                     ;3        
    lda     Lfd0f,y                 ;4        
    sta     PF2                     ;3        
    lda     ram_B7                  ;3        
    sta     GRP0                    ;3        
    lda     ram_88                  ;3        
    sta     COLUP0                  ;3        
    ldx     Lfd1f,y                 ;4        
    lda     Lfd17,y                 ;4        
    sta     PF0                     ;3        
    stx     PF1                     ;3        
    sta     RESP1                   ;3        
    lda     Lfd27,y                 ;4        
    sta     PF2                     ;3        
    lda     ram_89                  ;3        
    sta     COLUP1                  ;3        
    lda     #$10                    ;2        
    sta     HMP1                    ;3        
    dey                             ;2   =  73
Lf11f
    sta     WSYNC                   ;3   =   3
;---------------------------------------
    sta     HMOVE                   ;3        
    lda     #$34                    ;2        
    sta     CTRLPF                  ;3        
    lda     ram_B7                  ;3        
    sta     GRP1                    ;3        
    lda     #$ff                    ;2        
    sta     PF0                     ;3        
    sta     PF1                     ;3        
    lda     Lfd0f,y                 ;4        
    sta     PF2                     ;3        
    lda     Lfd17,y                 ;4        
    sta     PF0                     ;3        
    lda     Lfd1f,y                 ;4        
    sta     PF1                     ;3        
    lda     Lfd27,y                 ;4        
    sta     PF2                     ;3        
    sta     HMCLR                   ;3        
    dey                             ;2        
    bpl     Lf11f                   ;2/3      
    ldy     #$0f                    ;2   =  59
Lf14c
    lda     Lfd2f,y                 ;4        
    ldx     ram_8C                  ;3        
    sta     WSYNC                   ;3   =  10
;---------------------------------------
    sta     HMOVE                   ;3        
    stx     COLUBK                  ;3        
    ldx     #$00                    ;2        
    stx     GRP0                    ;3        
    stx     GRP1                    ;3        
    sta     PF0                     ;3        
    lda     Lfd3f,y                 ;4        
    sta     PF1                     ;3        
    lda     Lfd4f,y                 ;4        
    sta     PF2                     ;3        
    lda     Lfd5f,y                 ;4        
    sta     PF0                     ;3        
    lda     Lfd6f,y                 ;4        
    sta     PF1                     ;3        
    lda     Lfd7f,y                 ;4        
    sta     PF2                     ;3        
    dey                             ;2        
    bpl     Lf14c                   ;2/3      
    ldy     #$04                    ;2   =  58
Lf17d
    sta     WSYNC                   ;3   =   3
;---------------------------------------
    sta     HMOVE                   ;3        
    lda     ram_8D                  ;3        
    sta     COLUBK                  ;3        
    ldx     #$33                    ;2        
    stx     PF0                     ;3        
    lda     #$cc                    ;2        
    sta     PF1                     ;3        
    stx     PF2                     ;3        
    dey                             ;2        
    bne     Lf17d                   ;2/3      
    sta     WSYNC                   ;3   =  29
;---------------------------------------
    sta     HMOVE                   ;3        
    sty     PF0                     ;3        
    sty     PF1                     ;3        
    sty     PF2                     ;3        
    sty     NUSIZ0                  ;3        
    sty     NUSIZ1                  ;3        
    sta     CXCLR                   ;3        
    lda     #BLACK0|$0              ;2        
    sta     COLUPF                  ;3        
    lda     #$02                    ;2        
    sta     ENABL                   ;3        
    ldx     #$02                    ;2   =  33
Lf1ac
    sta     WSYNC                   ;3   =   3
;---------------------------------------
    sta     HMOVE                   ;3        
    lda     ram_B7,x                ;4        
    jsr     Lfb1b                   ;6        
    sta     ENABL,x                 ;4        
    sta     WSYNC                   ;3   =  20
;---------------------------------------
Lf1b9
    dey                             ;2        
    bpl     Lf1b9                   ;2/3      
    sta     PF2,x                   ;4        
    sta     WSYNC                   ;3   =  11
;---------------------------------------
    sta     HMOVE                   ;3        
    lda     ram_EE                  ;3        
    sta     COLUP1                  ;3        
    lda     ram_BF                  ;3        
    sta     REFP0                   ;3        
    lda     #$31                    ;2        
    sta     CTRLPF                  ;3        
    jsr     Lfb35                   ;6        
    sta     HMCLR                   ;3        
    dex                             ;2        
    beq     Lf200                   ;2/3!     
    bne     Lf1ac                   ;2/3 =  35
    
Lf1d8
    .byte   $00,$0c                         ; $f1d8 (D)
Lf1da
    .byte   $00                             ; $f1da (D)
    .byte   $08                             ; $f1db (*)
    
Start ; Ignore error, the label is correct
    sei                             ;2        
    cld                             ;2        
    lda     #$00                    ;2        
    tax                             ;2   =   8
Lf1e1
    sta     VSYNC,x                 ;4        
    txs                             ;2        
    stx     ram_ED                  ;3        
    inx                             ;2        
    bne     Lf1e1                   ;2/3      
    jsr     Lfa89                   ;6   =  19
Lf1ec
    jsr     Lf88a                   ;6        
    lda     #$01                    ;2        
    ldx     #$04                    ;2        
    jsr     Lfb1b                   ;6        
    jsr     Lfb3a                   ;6        
    lda     #$0f                    ;2        
    sta     ram_BE                  ;3        
    jmp     Lf826                   ;3   =  30
    
Lf200
    sta     WSYNC                   ;3   =   3
;---------------------------------------
    sta     HMOVE                   ;3   =   3
Lf204
    lda     #$00                    ;2        
    cpx     hawk_Y                  ;3        
    bmi     Lf213                   ;2/3      
    ldy     ram_C0                  ;3        
    bmi     Lf213                   ;2/3      
    lda     (ram_9D),y              ;5        
    dey                             ;2        
    sty     ram_C0                  ;3   =  22
Lf213
    sta     ram_8E                  ;3        
    lda     #$00                    ;2        
    cpx     player_Y                  ;3        
    bmi     Lf224                   ;2/3      
    ldy     ram_BE                  ;3        
    bmi     Lf224                   ;2/3      
    lda     (ram_A5),y              ;5        
    dey                             ;2        
    sty     ram_BE                  ;3   =  25
Lf224
    sta     WSYNC                   ;3   =   3
;---------------------------------------
    sta     HMOVE                   ;3        
    sta     GRP0                    ;3        
    lda     Lfd00,y                 ;4        
    sta     COLUP0                  ;3        
    lda     ram_8E                  ;3        
    sta     GRP1                    ;3        
    inx                             ;2        
    cpx     #$28                    ;2        
    bne     Lf204                   ;2/3      
    lda     #$00                    ;2        
    cpx     player_Y                  ;3        
    bmi     Lf247                   ;2/3      
    ldy     ram_BE                  ;3        
    bmi     Lf247                   ;2/3      
    lda     (ram_A5),y              ;5        
    dey                             ;2        
    sty     ram_BE                  ;3   =  47
Lf247
    sta     ram_8F                  ;3        
    inx                             ;2        
    lda     #ORANGE|$a              ;2        
    sta     COLUP1                  ;3        
    lda     Lfd00,y                 ;4        
    sta     COLUP0                  ;3        
    sta     WSYNC                   ;3   =  20
;---------------------------------------
    lda     ram_8F                  ;3        
    sta     GRP0                    ;3        
    ldy     ram_C4                  ;3        
    bmi     Lf28b                   ;2/3      
    lda     #$00                    ;2        
    nop                             ;2   =  15
Lf260
    dey                             ;2        
    bpl     Lf260                   ;2/3      
    sta.w   RESP1                   ;4        
    cpx     player_Y                  ;3        
    bmi     Lf273                   ;2/3      
    ldy     ram_BE                  ;3        
    bmi     Lf273                   ;2/3      
    lda     (ram_A5),y              ;5        
    dey                             ;2        
    sty     ram_BE                  ;3   =  28
Lf273
    jmp     Lf2a5                   ;3   =   3
    
Lf276
    cpx     player_Y                  ;3         *
    nop                             ;2   =   5 *
Lf279
    asl     Lf000                   ;6         *
    asl     Lf000                   ;6         *
    jmp     Lf29d                   ;3   =  15 *
    
Lf282
    cpx     player_Y                  ;3         *
    nop                             ;2   =   5 *
Lf285
    asl     Lf000                   ;6        
    jmp     Lf2f9                   ;3   =   9
    
Lf28b
    lda     #$00                    ;2         *
    cpx     player_Y                  ;3         *
    bmi     Lf276                   ;2/3       *
    ldy     ram_BE                  ;3         *
    bmi     Lf279                   ;2/3       *
    asl     Lf000,x                 ;7         *
    lda     (ram_A5),y              ;5         *
    dey                             ;2         *
    sty     ram_BE                  ;3   =  29 *
Lf29d
    ldy     ram_C4                  ;3         *
    nop                             ;2   =   5 *
Lf2a0
    iny                             ;2         *
    bmi     Lf2a0                   ;2/3       *
    sta     RESP1                   ;3   =   7 *
Lf2a5
    sta     WSYNC                   ;3   =   3
;---------------------------------------
    sta     HMOVE                   ;3        
    sta     GRP0                    ;3        
    ldy     ram_BE                  ;3        
    lda     Lfd00,y                 ;4        
    sta     COLUP0                  ;3        
    inx                             ;2        
    lda     #$00                    ;2        
    sta     ENABL                   ;3        
    cpx     player_Y                  ;3        
    bmi     Lf2c4                   ;2/3      
    ldy     ram_BE                  ;3        
    bmi     Lf2c4                   ;2/3      
    lda     (ram_A5),y              ;5        
    dey                             ;2        
    sty     ram_BE                  ;3   =  43
Lf2c4
    sta     ram_8F                  ;3        
    lda     ram_C6                  ;3        
    sta     NUSIZ1                  ;3        
    sta     HMP1                    ;3        
    lda     #$0b                    ;2        
    sta     ram_8E                  ;3        
    lda     #YELLOW|$4              ;2        
    sta     COLUPF                  ;3   =  22
Lf2d4
    lda     Lfd00,y                 ;4        
    sta     COLUP0                  ;3        
    sta     WSYNC                   ;3   =  10
;---------------------------------------
    sta     HMOVE                   ;3        
    lda     ram_8F                  ;3        
    sta     GRP0                    ;3        
    ldy     ram_8E                  ;3        
    lda     (ram_9F),y              ;5        
    sta     GRP1                    ;3        
    dey                             ;2        
    sty     ram_8E                  ;3        
    lda     #$00                    ;2        
    cpx     player_Y                  ;3        
    bmi     Lf282                   ;2/3      
    ldy     ram_BE                  ;3        
    bmi     Lf285                   ;2/3      
    lda     (ram_A5),y              ;5        
    dey                             ;2        
    sty     ram_BE                  ;3   =  47
Lf2f9
    sta     HMCLR                   ;3        
    sta     ram_8F                  ;3        
    inx                             ;2        
    cpx     #$36                    ;2        
    bne     Lf2d4                   ;2/3!     
    lda     #$f0                    ;2        
    sta     PF0                     ;3        
    lda     #$00                    ;2        
    sta     GRP1                    ;3        
    lda     Lfd00,y                 ;4        
    sta     COLUP0                  ;3   =  29
Lf30f
    sta     HMOVE                   ;3        
    lda     ram_8F                  ;3        
    sta     GRP0                    ;3        
    txa                             ;2        
    sbc     #$36                    ;2        
    lsr                             ;2        
    lsr                             ;2        
    tay                             ;2        
    lda     (ram_A7),y              ;5        
    sta     PF1                     ;3        
    lda     (ram_A9),y              ;5        
    sta     PF2                     ;3        
    lda     #$00                    ;2        
    cpx     player_Y                  ;3        
    bmi     Lf361                   ;2/3      
    ldy     ram_BE                  ;3        
    bmi     Lf364                   ;2/3      
    lda     (ram_A5),y              ;5        
    dey                             ;2        
    sty     ram_BE                  ;3   =  57
Lf332
    inx                             ;2        
    sta     ram_8F                  ;3        
    lda     Lfd00,y                 ;4        
    cpx     #$4a                    ;2        
    sec                             ;2        
    sta     COLUP0                  ;3        
    bne     Lf30f                   ;2/3      
    lda     ram_8F                  ;3        
    sta.w   GRP0                    ;4        
    ldy     ram_C3                  ;3        
    bmi     Lf376                   ;2/3      
    lda     #$00                    ;2        
    nop                             ;2   =  34
Lf34b
    dey                             ;2        
    bpl     Lf34b                   ;2/3      
    sta.w   RESP1                   ;4        
    cpx     player_Y                  ;3        
    bmi     Lf35e                   ;2/3      
    ldy     ram_BE                  ;3        
    bmi     Lf35e                   ;2/3      
    lda     (ram_A5),y              ;5         *
    dey                             ;2         *
    sty     ram_BE                  ;3   =  28 *
Lf35e
    jmp     Lf390                   ;3   =   3
    
Lf361
    cpx     player_Y                  ;3         *
    sec                             ;2   =   5 *
Lf364
    asl     Lf000                   ;6        
    jmp     Lf332                   ;3   =   9
    
Lf36a
    cpx     player_Y                  ;3         *
    nop                             ;2   =   5 *
Lf36d
    asl     Lf000                   ;6         *
    asl     Lf000,x                 ;7         *
    jmp     Lf388                   ;3   =  16 *
    
Lf376
    lda     #$00                    ;2         *
    cpx     player_Y                  ;3         *
    bmi     Lf36a                   ;2/3       *
    ldy     ram_BE                  ;3         *
    bmi     Lf36d                   ;2/3       *
    asl     Lf000,x                 ;7         *
    lda     (ram_A5),y              ;5         *
    dey                             ;2         *
    sty     ram_BE                  ;3   =  29 *
Lf388
    ldy     ram_C3                  ;3         *
    nop                             ;2   =   5 *
Lf38b
    iny                             ;2         *
    bmi     Lf38b                   ;2/3       *
    sta     RESP1                   ;3   =   7 *
Lf390
    sta     WSYNC                   ;3   =   3
;---------------------------------------
    sta     HMOVE                   ;3        
    sta     GRP0                    ;3        
    ldy     ram_BE                  ;3        
    lda     Lfd00,y                 ;4        
    sta     COLUP0                  ;3        
    inx                             ;2        
    lda     #$00                    ;2        
    cpx     player_Y                  ;3        
    bmi     Lf3ad                   ;2/3      
    ldy     ram_BE                  ;3        
    bmi     Lf3ad                   ;2/3      
    lda     (ram_A5),y              ;5         *
    dey                             ;2         *
    sty     ram_BE                  ;3   =  40 *
Lf3ad
    sta     ram_8F                  ;3        
    inx                             ;2        
    lda     ram_C5                  ;3        
    sta     NUSIZ1                  ;3        
    sta     HMP1                    ;3        
    lda     #GREEN_YELLOW|$a        ;2        
    sta     COLUP1                  ;3        
    lda     #$00                    ;2        
    sta     ram_8E                  ;3   =  24
Lf3be
    lda     Lfd00,y                 ;4        
    sta     COLUP0                  ;3        
    sta     WSYNC                   ;3   =  10
;---------------------------------------
    sta     HMOVE                   ;3        
    lda     ram_8F                  ;3        
    sta     GRP0                    ;3        
    ldy     ram_8E                  ;3        
    lda     (ram_A3),y              ;5        
    sta     GRP1                    ;3        
    iny                             ;2        
    sty     ram_8E                  ;3        
    lda     #$00                    ;2        
    cpx     player_Y                  ;3        
    bmi     Lf3e3                   ;2/3      
    ldy     ram_BE                  ;3        
    bmi     Lf3e3                   ;2/3      
    lda     (ram_A5),y              ;5         *
    dey                             ;2         *
    sty     ram_BE                  ;3   =  47 *
Lf3e3
    sta     ram_8F                  ;3        
    sta     HMCLR                   ;3        
    inx                             ;2        
    cpx     #$55                    ;2        
    bne     Lf3be                   ;2/3      
    ldx     #$03                    ;2        
    ldy     #VIOLET|$3              ;2        
    jsr     Lfa1f                   ;6        
    jsr     Lfb44                   ;6        
    ldx     #$06                    ;2        
    ldy     #VIOLET|$3              ;2        
    jsr     Lfa1f                   ;6        
    lda     #$e3                    ;2        
    sta     ram_AF                  ;3        
    sta     ram_B1                  ;3        
    jsr     Lfb44                   ;6        
    lda     #$3a                    ;2        
    sta     TIM64T                  ;4        
    lda     ram_D1                  ;3        
    beq     Lf450                   ;2/3      
    bit     player_is_dead                  ;3         *
    bmi     Lf450                   ;2/3       *
    lda     ram_E8                  ;3         *
    and     #$07                    ;2         *
    bne     Lf42e                   ;2/3       *
    sed                             ;2         *
    sec                             ;2         *
    lda     timer_2nd_half                  ;3         *
    sbc     #$01                    ;Subtract 1 from timer.
    sta     timer_2nd_half                  ;3         *
    lda     timer_1st_half                  ;3         *
    sbc     #$00                    ;2         *
    sta     timer_1st_half                  ;3         *
    cld                             ;2         *
    bne     Lf42e                   ;2/3       *
    lda     timer_2nd_half                  ;3         *
    beq     Lf446                   ;2/3 = 104 *
Lf42e
    bit     CXPPMM                  ;3         *
    bmi     Lf43a                   ;2/3       *
    lda     player_Y                  ;3         *
    cmp     #$48                    ;2         *
    bcc     Lf450                   ;2/3       *
    bcs     set_player_dead                   ;2/3 =  14 *
Lf43a
    lda     player_Y                  ;3         *
    cmp     #$36                    ;2         *
    bcc     Lf446                   ;2/3       *
    lda     ram_A3                  ;3         *
    cmp     #$40                    ;2         *
    bne     Lf450                   ;2/3 =  14 *
Lf446
    lda     #$0f                    ;2         *
    sta     ram_D2                  ;3   =   5 *
set_player_dead
    lda     #$80                    ;2         *
    ora     player_is_dead          ; If you replace this with `and`, player will not die.
    sta     player_is_dead                  ;3   =   8 *
Lf450
    bit     player_is_dead                  ;3        
    bvc     Lf457                   ;2/3      
    jmp     Lf4ed                   ;3   =   8 *
    
Lf457
    lda     player_Y                  ;3        
    cmp     #$80                    ;2        
    bcc     Lf493                   ;2/3 =   7
Lf45d
    lda     #$28                    ;2         *
    sta     player_Y                  ;3         *
    lda     #$08                    ;2         *
    sta     player_X                  ;3         *
    lda     #$7f                    ;2         *
    and     player_is_dead                  ;3         *
    sta     player_is_dead                  ;3         *
    lda     ram_D1                  ;3         *
    beq     Lf487                   ;2/3       *
    bit     SWCHB                   ;4         *
    bpl     Lf47f                   ;2/3       *
    lda     ram_D1                  ;3         *
    sec                             ;2         *
    sed                             ;2         *
    sbc     #$01                    ;2         *
    sta     ram_D1                  ;3         *
    cld                             ;2         *
    beq     Lf487                   ;2/3 =  45 *
Lf47f
    lda     #$10                    ;2         *
    sta     timer_1st_half                  ;3         *
    lda     #$00                    ;2         *
    sta     timer_2nd_half                  ;3   =  10 *
Lf487
    lda     ram_D4                  ;3         *
    lsr                             ;2         *
    bcc     Lf490                   ;2/3       *
    lda     #$50                    ;2         *
    sta     ghost_X                  ;3   =  12 *
Lf490
    jmp     Lf4b5                   ;3   =   3 *
    
Lf493
    bit     CXP0FB                  ;3        
    bpl     Lf49d                   ;2/3      
    lda     player_Y                  ;3        
    cmp     #$29                    ;2        
    bcc     Lf4ab                   ;2/3 =  12
Lf49d
    bit     player_is_dead                  ;3        
    bmi     Lf4e2                   ;2/3      
    bit     CXPPMM                  ;3        
    bpl     Lf4e2                   ;2/3      
    lda     player_Y                  ;3         *
    cmp     #$36                    ;2         *
    bcc     Lf4e2                   ;2/3 =  17 *
Lf4ab
    bit     player_is_dead                  ;3        
    bpl     Lf4b5                   ;2/3      
    lda     ram_D2                  ;3         *
    bne     Lf4ea                   ;2/3       *
    beq     Lf45d                   ;2/3 =  12 *
Lf4b5
    lda     ram_D1                  ;3        
    beq     Lf4ea                   ;2/3      
    bit     INPT4                   ;3         *
    bmi     Lf4d6                   ;2/3       *
    lda     #$20                    ;2         *
    bit     player_is_dead                  ;3         *
    bne     Lf4ea                   ;2/3       *
    lda     #$60                    ;2         *
    ora     player_is_dead                  ;3         *
    sta     player_is_dead                  ;3         *
    lda     player_Y                  ;3         *
    sec                             ;2         *
    sbc     #$04                    ;2         *
    sta     player_Y                  ;3         *
    lda     #$08                    ;2         *
    sta     ram_D2                  ;3         *
    bne     Lf4ea                   ;2/3 =  42 *
Lf4d6
    lda     #$df                    ;2         *
    and     player_is_dead                  ;3         *
    sta     player_is_dead                  ;3         *
    lda     #$00                    ;2         *
    sta     ram_C8                  ;3         *
    beq     Lf4ea                   ;2/3 =  15 *
Lf4e2
    lda     ram_E8                  ;3        
    and     #$01                    ;2        
    bne     Lf4ea                   ;2/3      
    inc     player_Y                  ;5   =  12
Lf4ea
    jmp     Lf51d                   ;3   =   3
    
Lf4ed
    lda     ram_C8                  ;3         *
    cmp     #$1c                    ;2         *
    bcs     Lf517                   ;2/3!      *
    bit     CXP0FB                  ;3         *
    bmi     Lf517                   ;2/3!      *
    cmp     #$0c                    ;2         *
    bcc     Lf507                   ;2/3!      *
    lda     #$01                    ;2         *
    and     ram_E8                  ;3         *
    bne     Lf51d                   ;2/3       *
    dec     player_Y                  ;5         *
    inc     ram_C8                  ;5         *
    bne     Lf51d                   ;2/3 =  35 *
Lf507
    sec                             ;2         *
    lda     player_Y                  ;3         *
    sbc     #$04                    ;2         *
    sta     player_Y                  ;3         *
    clc                             ;2         *
    lda     ram_C8                  ;3         *
    adc     #$04                    ;2         *
    sta     ram_C8                  ;3         *
    bne     Lf51d                   ;2/3 =  22 *
Lf517
    lda     #$bf                    ;2         *
    and     player_is_dead                  ;3         *
    sta     player_is_dead                  ;3   =   8 *
Lf51d
    lda     ram_D1                  ;3        
    beq     Lf590                   ;2/3      
    lda     player_X                  ;3         *
    bit     CXP0FB                  ;3         *
    bpl     Lf52f                   ;2/3       *
    lda     player_Y                  ;3         *
    cmp     #$29                    ;2         *
    bcs     Lf590                   ;2/3       *
    lda     player_X                  ;3   =  23 *
Lf52f
    bit     SWCHA                   ;4         *
    bpl     Lf546                   ;2/3       *
    bvs     Lf590                   ;2/3       *
    cmp     #$09                    ;2         *
    bcc     Lf542                   ;2/3       *
    lda     #$03                    ;2         *
    and     ram_E8                  ;3         *
    bne     Lf542                   ;2/3       *
    dec     player_X                  ;5   =  24 *
Lf542
    lda     #$08                    ;2         *
    bne     Lf58e                   ;2/3 =   4 *
Lf546 ; DECOMP: Check if level is completed?
    bit     player_is_dead                  ;3         *
    bmi     Lf590                   ;2/3       *
    cmp     #$9f                    ;2         *
    bcs     Lf558                   ;2/3       *
    lda     #$03                    ;2         *
    and     ram_E8                  ;3         *
    bne     Lf58c                   ;2/3       *
    inc     player_X                  ;5         *
    bne     Lf590                   ;2/3 =  23 *
Lf558
    lda     #$08                    ;2         *
    sta     player_X                  ;3         *
    ldx     #$02                    ;2         *
    clc                             ;2         *
    sed                             ;2   =  11 *
Lf560
    lda     ram_CE,x                ;4         *
    adc     ram_CB,x                ;4         *
    sta     ram_CE,x                ;4         *
    dex                             ;2         *
    bpl     Lf560                   ;2/3       *
    cld                             ;2         *
    inx                             ;2         *
    stx     timer_2nd_half                  ;3         *
    lda     #$10                    ;2         *
    sta     timer_1st_half                  ;3         *
    lda     ram_D1                  ;3         *
    sed                             ;2         *
    clc                             ;2         *
    adc     #$01                    ;2         *
    sta     ram_D1                  ;3         *
    lda     ram_D3                  ;3         *
    clc                             ;2         *
    adc     #$01                    ;2         *
    sta     ram_D3                  ;3         *
    cld                             ;2         *
    inc     ram_D5                  ;5         *
    lda     ram_D5                  ;3         *
    and     #$03                    ;2         *
    sta     ram_D4                  ;3         *
    jsr     Lf8d6                   ;6   =  71 *
Lf58c
    lda     #$00                    ;2   =   2 *
Lf58e
    sta     ram_BF                  ;3   =   3 *
Lf590
    lda     ram_E8                  ;3        
    lsr                             ;2        
    lsr                             ;2        
    lsr                             ;2        
    lsr                             ;2        
    and     #$01                    ;2        
    tax                             ;2        
    ldy     Lf8ae,x                 ;4        
    sty     ram_A1                  ;3        
    lda     ram_D4                  ;3        
    lsr                             ;2        
    bcs     Lf5a9                   ;2/3      
    bit     ram_E9                  ;3        
    bmi     Lf5a9                   ;2/3      
    ldy     #$60                    ;2   =  36
Lf5a9
    sty     ram_9D                  ;3        
    lda     #$20                    ;2        
    and     ram_E9                  ;3        
    beq     Lf5b5                   ;2/3      
    lda     #$10                    ;2         *
    bne     Lf5b7                   ;2/3 =  14 *
Lf5b5
    lda     #$28                    ;2   =   2
Lf5b7
    clc                             ;2        
    adc     Lf1d8,x                 ;4        
    sta     ram_9F                  ;3        
    ldy     #$00                    ;2        
    lda     ram_D4                  ;3        
    lsr                             ;2        
    bcc     Lf5cd                   ;2/3      
    and     #$01                    ;2         *
    tay                             ;2         *
    lda     Lf8b0,y                 ;4         *
    tay                             ;2         *
    bne     Lf5d7                   ;2/3 =  30 *
Lf5cd
    lda     #$10                    ;2        
    and     ram_E9                  ;3        
    bne     Lf5d7                   ;2/3      
    lda     #$60                    ;2        
    sta     ram_9F                  ;3   =  12
Lf5d7
    sty     ram_C6                  ;3        
    lda     ram_E8                  ;3        
    rol                             ;2        
    rol                             ;2        
    and     #$01                    ;2        
    tax                             ;2        
    bit     ram_E9                  ;3        
    bvs     Lf5e8                   ;2/3      
    lda     #$40                    ;2        
    bne     Lf5ea                   ;2/3 =  23
Lf5e8
    lda     #$50                    ;2   =   2 *
Lf5ea
    clc                             ;2        
    adc     Lf1da,x                 ;4        
    sta     ram_A3                  ;3        
    lda     ram_D4                  ;3        
    lsr                             ;2        
    bcc     Lf609                   ;2/3!     
    lda     ram_E8                  ;3         *
    and     #$03                    ;2         *
    bne     Lf606                   ;2/3!      *
    lda     ghost_X                  ;3         *
    sec                             ;2         *
    sbc     #$01                    ;2         *
    bcs     store_ghost_X                   ;2/3       *
    lda     #$9f                    ;2   =  34 *
store_ghost_X
    sta     ghost_X                  ;3   =   3 *
Lf606
    jmp     Lf62b                   ;3   =   3 *
    
Lf609
    lda     ram_E9                  ;3        
    and     #$0c                    ;2        
    lsr                             ;2        
    lsr                             ;2        
    cmp     #$02                    ;2        
    bcs     Lf617                   ;2/3      
    lda     #$4c                    ;2        
    bne     Lf623                   ;2/3 =  17
Lf617
    beq     Lf627                   ;2/3       *
    bit     ram_EA                  ;3         *
    bvs     Lf621                   ;2/3       *
    lda     #$2c                    ;2         *
    bne     Lf623                   ;2/3 =  11 *
Lf621
    lda     #$6c                    ;2   =   2 *
Lf623
    sta     ghost_X                  ;3        
    bne     Lf62b                   ;2/3 =   5
Lf627
    lda     #$60                    ;2         *
    sta     ram_9F                  ;3   =   5 *
Lf62b
    lda     ram_E8                  ;3        
    and     #$3f                    ;2        
    bne     Lf64a                   ;2/3      
    ldy     ram_CA                  ;3        
    iny                             ;2        
    cpy     #$10                    ;2        
    bne     Lf63a                   ;2/3      
    ldy     #$00                    ;2   =  18 *
Lf63a
    sty     ram_CA                  ;3        
    ldy     ram_C9                  ;3        
    dey                             ;2        
    dey                             ;2        
    dey                             ;2        
    bpl     Lf648                   ;2/3      
    tya                             ;2        
    clc                             ;2        
    adc     #$20                    ;2        
    tay                             ;2   =  22
Lf648
    sty     ram_C9                  ;3   =   3
Lf64a
    lda     ram_E8                  ;3        
    lsr                             ;2        
    bcc     Lf691                   ;2/3      
    and     #$01                    ;2        
    tax                             ;2        
    ldy     ram_C9,x                ;4        
    lda     Lf8b6,y                 ;4        
    sta     ram_8E                  ;3        
    ldy     hawk_X,x                ;4        
    cpy     ram_8E                  ;3        
    bcs     Lf666                   ;2/3      
    cpy     #$88                    ;2        
    bcs     Lf66b                   ;2/3      
    iny                             ;2        
    bne     Lf66b                   ;2/3 =  39
Lf666
    cpy     #$08                    ;2        
    bcc     Lf66b                   ;2/3      
    dey                             ;2   =   6
Lf66b
    sty     hawk_X,x                ;4        
    lda     Lf8b2,x                 ;4        
    sta     ram_8F                  ;3        
    lda     Lf8b4,x                 ;4        
    sta     ram_90                  ;3        
    lda     ram_8E                  ;3        
    and     #$1f                    ;2        
    sta     ram_8E                  ;3        
    ldy     hawk_Y,x                ;4        
    cpy     ram_8E                  ;3        
    bcs     Lf68a                   ;2/3      
    cpy     ram_8F                  ;3        
    bcs     Lf68f                   ;2/3      
    iny                             ;2        
    bne     Lf68f                   ;2/3 =  44
Lf68a
    cpy     ram_90                  ;3        
    bcc     Lf68f                   ;2/3      
    dey                             ;2   =   7
Lf68f
    sty     hawk_Y,x                ;4   =   4
Lf691
    lda     ram_E8                  ;3        
    and     #$07                    ;2        
    bne     Lf6a2                   ;2/3      
    ldy     swimming_X                  ;3        
    cpy     #$9f                    ;2        
    bcc     Lf69f                   ;2/3      
    ldy     #$ff                    ;2   =  16 *
Lf69f
    iny                             ;2        
    sty     swimming_X                  ;3   =   5
Lf6a2
    lda     ram_D5                  ;3        
    ldy     ram_D4                  ;3        
    cpy     #$02                    ;2        
    beq     Lf6be                   ;2/3      
    lsr                             ;2        
    lsr                             ;2        
    and     #$1f                    ;2        
    tax                             ;2        
    lda     Lf9b6,x                 ;4        
    sta     ram_A7                  ;3        
    sta     ram_A9                  ;3        
    lda     #$fd                    ;2        
    sta     ram_A8                  ;3        
    sta     ram_AA                  ;3        
    bne     Lf6ea                   ;2/3 =  38
Lf6be
    lda     #$ff                    ;2         *
    sta     ram_A8                  ;3         *
    sta     ram_AA                  ;3         *
    lda     ram_E8                  ;3         *
    and     #$1f                    ;2         *
    bne     Lf6e0                   ;2/3       *
    lda     ram_E9                  ;3         *
    and     #$01                    ;2         *
    beq     Lf6d5                   ;2/3       *
    ldx     #$00                    ;2         *
    jsr     Lf9d6                   ;6   =  30 *
Lf6d5
    lda     ram_E9                  ;3         *
    and     #$02                    ;2         *
    beq     Lf6e0                   ;2/3       *
    ldx     #$01                    ;2         *
    jsr     Lf9d6                   ;6   =  15 *
Lf6e0
    ldx     #$00                    ;2         *
    jsr     Lf9f1                   ;6         *
    ldx     #$01                    ;2         *
    jsr     Lf9f1                   ;6   =  16 *
Lf6ea
    lda     INTIM                   ;4        
    bne     Lf6ea                   ;2/3      
    ldy     #$82                    ;2        
    sty     WSYNC                   ;3   =  11
;---------------------------------------
    sty     VBLANK                  ;3        
    sty     VSYNC                   ;3        
    sty     WSYNC                   ;3   =   9
;---------------------------------------
    sty     WSYNC                   ;3   =   3
;---------------------------------------
    sty     WSYNC                   ;3   =   3
;---------------------------------------
    sta     VSYNC                   ;3        
    inc     ram_E8                  ;5        
    lda     #$20                    ;2        
    sta     TIM64T                  ;4        
    lsr     SWCHB                   ;6        
    bcs     Lf714                   ;2/3      
    jsr     Lfab7                   ;6         *
    lda     #$05                    ;2         *
    sta     ram_D1                  ;3         *
    sta     ram_ED                  ;3   =  36 *
Lf714
    ldy     #$ea                    ;2        
    bit     player_is_dead                  ;3        
    bmi     Lf72a                   ;2/3      
    bit     CXPPMM                  ;3        
    bmi     Lf722                   ;2/3      
    bit     CXP0FB                  ;3        
    bpl     Lf72a                   ;2/3 =  17
Lf722
    lda     player_X                  ;3        
    and     #$01                    ;2        
    tax                             ;2        
    ldy     Lf81b,x                 ;4   =  11
Lf72a
    sty     ram_A5                  ;3        
    lda     aud0_music_ctrl                  ;3        
    bne     Lf796                   ;2/3      
    ldy     ram_DA                  ;3        
    dey                             ;2        
    bpl     Lf76c                   ;2/3      
    ldy     ram_D6                  ;3        
    dey                             ;2        
    bpl     Lf73c                   ;2/3      
    ldy     #$7f                    ;2   =  24
Lf73c
    sty     ram_D6                  ;3        
    tya                             ;2        
    lsr                             ;2        
    and     #$03                    ;2        
    tax                             ;2        
    lda     Lfb95,x                 ;4        
    sta     audc_ctrl                  ;3        
    tya                             ;2        
    lsr                             ;2        
    lsr                             ;2        
    lsr                             ;2        
    and     #$03                    ;2        
    tax                             ;2        
    lda     Lfb99,x                 ;4        
    sta     ram_E6                  ;3        
    tya                             ;2        
    lsr                             ;2        
    lsr                             ;2        
    lsr                             ;2        
    lsr                             ;2        
    lsr                             ;2        
    and     #$03                    ;2        
    tax                             ;2        
    lda     Lfb99,x                 ;4        
    sta     ram_E7                  ;3        
    ldx     ram_D7                  ;3        
    lda     Lfbc0,x                 ;4        
    sta     ram_E0                  ;3        
    ldy     Lfbbb,x                 ;4   =  74
Lf76c
    sty     ram_DA                  ;3        
    lda     (ram_E0),y              ;5        
    sta     ram_8E                  ;3        
    and     #$f0                    ;2        
    cmp     #$f0                    ;2        
    bne     Lf788                   ;2/3      
    lda     ram_8E                  ;3        
    and     #$0f                    ;2        
    sta     ram_E4                  ;3        
    lda     #$00                    ;2        
    sta     aud1_music_ctrl                  ;3        
    sta     ram_DB                  ;3        
    dey                             ;2        
    jmp     Lf76c                   ;3   =  38
    
Lf788
    lda     ram_8E                  ;3        
    and     #$0f                    ;2        
    tax                             ;2        
    lda     Lfb9d,x                 ;4        
    sta     aud0_music_ctrl                  ;3        
    lda     #$0f                    ;2        
    sta     ram_DE                  ;3   =  19
Lf796
    dec     aud0_music_ctrl                  ;5        
    lda     audc_ctrl                  ;3        
    sta     AUDC0                   ;3        
    ldy     ram_DA                  ;3        
    lda     (ram_E0),y              ;5        
    ldx     #$00                    ;2        
    jsr     Lfafd                   ;6        
    lda     aud1_music_ctrl                  ;3        
    bne     Lf7c7                   ;2/3      
    ldy     ram_DB                  ;3        
    dey                             ;2        
    bpl     Lf7b6                   ;2/3      
    lda     ram_D6                  ;3        
    and     #$01                    ;2        
    tax                             ;2        
    ldy     Lfbc5,x                 ;4   =  50
Lf7b6
    sty     ram_DB                  ;3        
    jsr     Lfade                   ;6        
    and     #$0f                    ;2        
    tax                             ;2        
    lda     Lfb9d,x                 ;4        
    sta     aud1_music_ctrl                  ;3        
    lda     #$0a                    ;2        
    sta     ram_DF                  ;3   =  25
Lf7c7
    dec     aud1_music_ctrl                  ;5        
    lda     ram_D2                  ;3        
    bne     Lf7db                   ;2/3      
    lda     audc_ctrl                  ;3        
    sta     AUDC1                   ;3        
    ldy     ram_DB                  ;3        
    jsr     Lfade                   ;6        
    ldx     #$01                    ;2        
    jsr     Lfafd                   ;6   =  33
Lf7db
    ldx     ram_D2                  ;3        
    beq     Lf7fc                   ;2/3      
    bit     player_is_dead                  ;3         *
    bpl     Lf7e9                   ;2/3       *
    ldx     #$03                    ;2         *
    ldy     #$1f                    ;2         *
    bne     Lf7f4                   ;2/3 =  16 *
Lf7e9
    ldy     Lf81d,x                 ;4         *
    ldx     #$04                    ;2         *
    lda     ram_E8                  ;3         *
    and     #$03                    ;2         *
    bne     Lf810                   ;2/3!=  13 *
Lf7f4
    dec     ram_D2                  ;5         *
    bne     Lf810                   ;2/3!      *
    lda     #$00                    ;2         *
    beq     Lf812                   ;2/3!=  11 *
Lf7fc
    lda     player_Y                  ;3        
    sec                             ;2        
    sbc     #$4c                    ;2        
    bcc     Lf818                   ;2/3      
    ldx     ram_E8                  ;3         *
    ldy     Lf8b6,x                 ;4         *
    lsr                             ;2         *
    lsr                             ;2         *
    eor     #$0f                    ;2         *
    ldx     #$0c                    ;2         *
    bne     Lf812                   ;2/3 =  26 *
Lf810
    lda     #$0f                    ;2   =   2 *
Lf812
    sta     AUDV1                   ;3         *
    stx     AUDC1                   ;3         *
    sty     AUDF1                   ;3   =   9 *
Lf818
    jmp     Lf1ec                   ;3   =   3
    
Lf81b
    .byte   $c3                             ; $f81b (D)
    .byte   $d3                             ; $f81c (*)
Lf81d
    .byte   $11,$11,$11,$0e,$0e,$13,$17,$1d ; $f81d (*)
    .byte   $1d                             ; $f825 (*)
    
Lf826
    sta     ram_BE                  ;3        
    lda     #$07                    ;2        
    sta     ram_C0                  ;3        
    lda     #$6d                    ;2        
    ldx     #$02                    ;2        
    jsr     Lfb1b                   ;6        
    jsr     Lfb3a                   ;6        
    jsr     Lf87c                   ;6   =  30
Lf839
    lda     INTIM                   ;4        
    bne     Lf839                   ;2/3      
    ldx     #$00                    ;2        
    ldy     ram_80                  ;3        
    jsr     Lfa1f                   ;6        
    lda     #$05                    ;2        
    sta     TIM64T                  ;4        
    jsr     Lf87c                   ;6        
    bit     ram_ED                  ;3        
    bpl     Lf85e                   ;2/3      
    ldx     #$0c                    ;2        
    lda     #$50                    ;2   =  38
Lf855
    sta     ram_A9,x                ;4        
    clc                             ;2        
    adc     #$08                    ;2        
    dex                             ;2        
    dex                             ;2        
    bne     Lf855                   ;2/3 =  14
Lf85e
    lda     INTIM                   ;4        
    bne     Lf85e                   ;2/3      
    sta     WSYNC                   ;3   =   9
;---------------------------------------
    sta     HMOVE                   ;3        
    sta     VBLANK                  ;3        
    sta     WSYNC                   ;3   =   9
;---------------------------------------
    jsr     Lfb44                   ;6        
    ldx     #$18                    ;2   =   8
Lf870
    sta     WSYNC                   ;3   =   3
;---------------------------------------
    sta     HMOVE                   ;3        
    sta     CXCLR                   ;3        
    dex                             ;2        
    bpl     Lf870                   ;2/3      
    jmp     Lf000                   ;3   =  13
    
Lf87c
    sta     WSYNC                   ;3   =   3
;---------------------------------------
    sta     HMOVE                   ;3        
    sta     REFP1                   ;3        
    ldx     #$07                    ;2   =   8
Lf884
    dex                             ;2        
    bpl     Lf884                   ;2/3      
    sta     HMCLR                   ;3        
    rts                             ;6   =  13
    
Lf88a
    ldx     #$01                    ;2   =   2
Lf88c
    lda     ram_C5,x                ;4        
    and     #$07                    ;2        
    sta     ram_8F                  ;3        
    lda     swimming_X,x                ;4        
    jsr     Lfb1b                   ;6        
    ora     ram_8F                  ;3        
    sta     ram_C5,x                ;4        
    dey                             ;2        
    dey                             ;2        
    dey                             ;2        
    tya                             ;2        
    cmp     #$06                    ;2        
    bcc     Lf8a8                   ;2/3      
    sec                             ;2         *
    sbc     #$06                    ;2         *
    eor     #$ff                    ;2   =  44 *
Lf8a8
    sta     ram_C3,x                ;4        
    dex                             ;2        
    bpl     Lf88c                   ;2/3      
    rts                             ;6   =  14
    
Lf8ae
    .byte   $00,$08                         ; $f8ae (D)
Lf8b0
    .byte   $02,$06                         ; $f8b0 (*)
Lf8b2
    .byte   $33,$0f                         ; $f8b2 (D)
Lf8b4
    .byte   $01,$01                         ; $f8b4 (D)
Lf8b6
    .byte   $3c                             ; $f8b6 (*)
    .byte   $2f                             ; $f8b7 (D)
    .byte   $26,$12,$20,$3c,$24,$4f,$36,$4f ; $f8b8 (*)
    .byte   $59,$65,$78,$63,$57,$68,$7c,$8f ; $f8c0 (*)
    .byte   $78,$6a,$5f,$58,$4f,$38,$3f,$26 ; $f8c8 (*)
    .byte   $2f,$49,$28                     ; $f8d0 (*)
    .byte   $1f                             ; $f8d3 (D)
    .byte   $28,$0f                         ; $f8d4 (*)
    
Lf8d6
    lda     ram_E8                  ;3        
    sta     ram_E9                  ;3        
    sta     ram_DC                  ;3        
    eor     #$ff                    ;2        
    sta     ram_EA                  ;3        
    and     #$0f                    ;2        
    ldy     #$00                    ;2        
    jsr     Lf9a6                   ;6        
    lda     ram_EA                  ;3        
    lsr                             ;2        
    lsr                             ;2        
    lsr                             ;2        
    lsr                             ;2        
    ldy     #$01                    ;2        
    jsr     Lf9a6                   ;6        
    lda     ram_D4                  ;3        
    lsr                             ;2        
    bcc     Lf8fb                   ;2/3      
    lda     #$50                    ;2         *
    sta     ghost_X                  ;3   =  55 *
Lf8fb
    lda     ram_DC                  ;3        
    jsr     Lfef8                   ;6        
    sta     ram_88                  ;3        
    sta     ram_89                  ;3        
    sta     ram_8A                  ;3        
    lda     ram_DC                  ;3        
    jsr     Lfef6                   ;6        
    sta     ram_8B                  ;3        
    lda     ram_DC                  ;3        
    jsr     Lfef4                   ;6        
    sta     ram_8C                  ;3        
    lda     ram_DC                  ;3        
    jsr     Lfef2                   ;6        
    sta     ram_8D                  ;3        
    lda     ram_D5                  ;3        
    and     #$01                    ;2        
    tay                             ;2        
    lda     Lfe70,y                 ;4        
    sta     ram_80                  ;3        
    sta     ram_81                  ;3        
    sta     ram_82                  ;3        
    sta     ram_86                  ;3        
    lda     ram_D5                  ;3        
    lsr                             ;2        
    and     #$03                    ;2        
    tax                             ;2        
    lda     Lfe72,x                 ;4        
    sta     ram_84                  ;3        
    sta     ram_85                  ;3        
    sta     ram_87                  ;3        
    lda     ram_D5                  ;3        
    and     #$0f                    ;2        
    cmp     #$0f                    ;2        
    bne     Lf949                   ;2/3      
    lda     #$04                    ;2         *
    jsr     Lf99d                   ;6         *
    beq     Lf956                   ;2/3 = 118 *
Lf949
    and     #$03                    ;2        
    bne     Lf956                   ;2/3      
    lda     ram_DD                  ;3        
    and     #$03                    ;2        
    jsr     Lf99d                   ;6        
    beq     Lf99c                   ;2/3 =  17
Lf956
    lda     ram_D5                  ;3         *
    and     #$03                    ;2         *
    cmp     #$03                    ;2         *
    bne     Lf99c                   ;2/3       *
    lda     #$fe                    ;2         *
    sta     ram_8F                  ;3         *
    lda     ram_DD                  ;3         *
    and     #$1c                    ;2         *
    sta     ram_90                  ;3         *
    lda     ram_DD                  ;3         *
    and     #$03                    ;2         *
    tax                             ;2         *
    lda     Lfe76,x                 ;4         *
    sta     ram_8E                  ;3         *
    ldy     #$09                    ;2   =  38 *
Lf974
    lda     (ram_8E),y              ;5         *
    sta.wy  ram_80,y                ;5         *
    dey                             ;2         *
    bpl     Lf974                   ;2/3       *
    lda     ram_8E                  ;3         *
    clc                             ;2         *
    adc     ram_90                  ;3         *
    adc     #$0a                    ;2         *
    sta     ram_8E                  ;3         *
    ldy     #$03                    ;2   =  29 *
Lf987
    lda     (ram_8E),y              ;5         *
    sta.wy  ram_8A,y                ;5         *
    dey                             ;2         *
    bpl     Lf987                   ;2/3       *
    lda     ram_DD                  ;3         *
    clc                             ;2         *
    adc     #$01                    ;2         *
    cmp     #$14                    ;2         *
    bcc     Lf99a                   ;2/3       *
    lda     #$00                    ;2   =  27 *
Lf99a
    sta     ram_DD                  ;3   =   3 *
Lf99c
    rts                             ;6   =   6
    
Lf99d
    sta     ram_D7                  ;3        
    lda     #$00                    ;2        
    sta     ram_DA                  ;3        
    sta     aud0_music_ctrl                  ;3        
    rts                             ;6   =  17
    
Lf9a6
    tax                             ;2        
    and     #$07                    ;2        
    bne     Lf9ae                   ;2/3      
    inx                             ;2         *
    bne     Lf9b3                   ;2/3 =  10 *
Lf9ae
    cmp     #$07                    ;2        
    bcc     Lf9b3                   ;2/3      
    dex                             ;2   =   6
Lf9b3
    stx     ram_EB,y                ;4        
    rts                             ;6   =  10
    
Lf9b6
    .byte   $55                             ; $f9b6 (D)
    .byte   $13,$b9,$cb,$27,$40,$7f,$38,$28 ; $f9b7 (*)
    .byte   $a4,$a9,$00,$3f,$cb,$06,$36,$ad ; $f9bf (*)
    .byte   $bc,$cb,$41,$b1,$ae,$b1,$35,$2a ; $f9c7 (*)
    .byte   $2c,$2e,$5e,$2d,$2b,$29,$af     ; $f9cf (*)
    
Lf9d6
    lda     ram_EB,x                ;4         *
    cmp     #$08                    ;2         *
    bcs     Lf9e8                   ;2/3       *
    cmp     #$06                    ;2         *
    bne     Lf9e5                   ;2/3       *
    lda     #$0d                    ;2   =  14 *
Lf9e2
    sta     ram_EB,x                ;4         *
    rts                             ;6   =  10 *
    
Lf9e5
    inc     ram_EB,x                ;6         *
    rts                             ;6   =  12 *
    
Lf9e8
    bne     Lf9ee                   ;2/3       *
    lda     #$01                    ;2         *
    bne     Lf9e2                   ;2/3 =   6 *
Lf9ee
    dec     ram_EB,x                ;6         *
    rts                             ;6   =  12 *
    
Lf9f1
    lda     ram_EB,x                ;4         *
    and     #$07                    ;2         *
    tay                             ;2         *
    lda     ram_E9                  ;3         *
    lsr                             ;2         *
    lsr                             ;2         *
    and     Lfa1d,x                 ;4         *
    bne     Lfa09                   ;2/3!      *
    lda     Lfa0f,y                 ;4   =  25 *
Lfa02
    tay                             ;2         *
    txa                             ;2         *
    asl                             ;2         *
    tax                             ;2         *
    sty     ram_A7,x                ;4         *
    rts                             ;6   =  18 *
    
Lfa09
    lda     Lfa16,y                 ;4         *
    jmp     Lfa02                   ;3   =   7 *
    
Lfa0f
    .byte   $7d,$82,$87,$8c,$91,$96,$9b     ; $fa0f (*)
Lfa16
    .byte   $a0,$a5,$aa,$af,$b4,$b9,$be     ; $fa16 (*)
Lfa1d
    .byte   $01,$02                         ; $fa1d (*)
    
Lfa1f
    lda     #$02                    ;2        
    sta     WSYNC                   ;3   =   5
;---------------------------------------
    sty     COLUBK                  ;3        
    sta     ENABL                   ;3        
    lda     #$00                    ;2        
    sta     GRP0                    ;3        
    sta     GRP1                    ;3        
    sta     COLUPF                  ;3        
    sta     PF0                     ;3        
    sta     PF1                     ;3        
    jsr     Lfb38                   ;6        
    sta     RESP0                   ;3        
    sta     RESP1                   ;3        
    sta     PF2                     ;3        
    lda     #$10                    ;2        
    sta     HMP0                    ;3        
    sta     REFP0                   ;3        
    lda     #$20                    ;2        
    sta     HMP1                    ;3        
    lda     #$06                    ;2        
    sta     TIM64T                  ;4        
    lda     ram_CB,x                ;4        
    sta     ram_8E                  ;3        
    lda     timer_1st_half,x                ;4        
    sta     ram_8F                  ;3        
    lda     timer_2nd_half,x                ;4        
    sta     ram_90                  ;3        
    ldx     #$02                    ;2   =  80
Lfa59
    txa                             ;2        
    asl                             ;2        
    asl                             ;2        
    tay                             ;2        
    lda     ram_8E,x                ;4        
    and     #$f0                    ;2        
    lsr                             ;2        
    sta.wy  ram_AB,y                ;5        
    lda     ram_8E,x                ;4        
    and     #$0f                    ;2        
    asl                             ;2        
    asl                             ;2        
    asl                             ;2        
    sta.wy  ram_AD,y                ;5        
    dex                             ;2        
    bpl     Lfa59                   ;2/3      
    inx                             ;2   =  44
Lfa73
    lda     ram_AB,x                ;4        
    cmp     #$00                    ;2        
    bne     Lfa83                   ;2/3      
    lda     #$e3                    ;2        
    sta     ram_AB,x                ;4        
    inx                             ;2        
    inx                             ;2        
    cpx     #$09                    ;2        
    bcc     Lfa73                   ;2/3 =  22
Lfa83
    lda     INTIM                   ;4        
    bne     Lfa83                   ;2/3      
    rts                             ;6   =  12
    
Lfa89
    lda     #$50                    ;2        
    sta     hawk_X                  ;3        
    lda     #$1e                    ;2        
    sta     hawk_Y                  ;3        
    lda     #$3c                    ;2        
    sta     swimming_X                  ;3        
    ldx     #$0c                    ;2        
    lda     #$fd                    ;2        
    ldy     #$fe                    ;2   =  21
Lfa9b
    sta     ram_90,x                ;4        
    sty     ram_9C,x                ;4        
    dex                             ;2        
    dex                             ;2        
    bne     Lfa9b                   ;2/3      
    sty     ram_C5                  ;3        
    ldx     #$12                    ;2        
    lda     #$ff                    ;2   =  21
Lfaa9
    sta     ram_A4,x                ;4        
    dex                             ;2        
    dex                             ;2        
    bne     Lfaa9                   ;2/3      
    lda     #$fc                    ;2        
    sta     ram_E1                  ;3        
    sta     ram_E3                  ;3        
    sta     ram_B7                  ;3   =  21
Lfab7
    lda     #$08                    ;2        
    sta     player_X                  ;3        
    lda     #$24                    ;2        
    sta     player_Y                  ;3        
    lda     #$00                    ;2        
    ldx     #$16                    ;2   =  14
Lfac3
    sta     player_is_dead,x                ;4        
    dex                             ;2        
    bpl     Lfac3                   ;2/3      
    lda     #$10                    ;Default value for timer first half
    sta     timer_1st_half                  ;3        
    jsr     Lf8d6                   ;6        
    ldx     #$0c                    ;2        
    ldy     #$05                    ;2   =  23
Lfad3
    lda     Lfaf7,y                 ;4        
    dey                             ;2        
    sta     ram_8F,x                ;4        
    dex                             ;2        
    dex                             ;2        
    bne     Lfad3                   ;2/3      
    rts                             ;6   =  22
    
Lfade
    ldx     ram_E4                  ;3        
    lda     ram_D6                  ;3        
    and     #$01                    ;2        
    beq     Lfaec                   ;2/3      
    lda     Lfbcb,x                 ;4        
    jmp     Lfaef                   ;3   =  17
    
Lfaec
    lda     Lfbc7,x                 ;4   =   4 *
Lfaef
    clc                             ;2        
    adc     ram_DB                  ;3        
    tay                             ;2        
    lda     Lfbcf,y                 ;4        
    rts                             ;6   =  17
    
Lfaf7
    .byte   $8f,$a4,$c9,$b9,$de,$ee         ; $faf7 (D)
    
Lfafd
    and     #$f0                    ;2        
    lsr                             ;2        
    lsr                             ;2        
    lsr                             ;2        
    lsr                             ;2        
    tay                             ;2        
    lda     Lfbad,y                 ;4        
    sta     AUDF0,x                 ;4        
    ldy     ram_DE,x                ;4        
    lda     ram_E8                  ;3        
    and     ram_E6,x                ;4        
    bne     Lfb18                   ;2/3      
    ldy     ram_DE,x                ;4        
    beq     Lfb16                   ;2/3      
    dey                             ;2   =  41
Lfb16
    sty     ram_DE,x                ;4   =   4
Lfb18
    sty     AUDV0,x                 ;4        
    rts                             ;6   =  10
    
Lfb1b
    clc                             ;2        
    adc     #$2e                    ;2        
    tay                             ;2        
    and     #$0f                    ;2        
    sta     ram_8E                  ;3        
    tya                             ;2        
    lsr                             ;2        
    lsr                             ;2        
    lsr                             ;2        
    lsr                             ;2        
    tay                             ;2        
    clc                             ;2        
    adc     ram_8E                  ;3        
    cmp     #$0f                    ;2        
    bcc     Lfb33                   ;2/3      
    sbc     #$0f                    ;2        
    iny                             ;2   =  36
Lfb33
    eor     #$07                    ;2   =   2
Lfb35
    asl                             ;2        
    asl                             ;2        
    asl                             ;2   =   6
Lfb38
    asl                             ;2        
    rts                             ;6   =   8
    
Lfb3a
    sta     HMP0,x                  ;4        
    sta     WSYNC                   ;3   =   7
;---------------------------------------
Lfb3e
    dey                             ;2        
    bpl     Lfb3e                   ;2/3      
    sta     RESP0,x                 ;4        
    rts                             ;6   =  14
    
Lfb44
    sta     WSYNC                   ;3   =   3
;---------------------------------------
    sta     HMOVE                   ;3        
    lda     #$07                    ;2        
    sta     ram_8E                  ;3        
    sta     VDELP0                  ;3        
    sta     VDELP1                  ;3        
    lda     #$00                    ;2        
    sta     GRP0                    ;3        
    lda     #$03                    ;2        
    sta     NUSIZ0                  ;3        
    sta     NUSIZ1                  ;3        
    lda     #GREEN_YELLOW|$c        ;2        
    sta     COLUP0                  ;3        
    sta     COLUP1                  ;3   =  35
Lfb60
    ldy     ram_8E                  ;3        
    lda     (ram_B5),y              ;5        
    sta     ram_8F                  ;3        
    sta     WSYNC                   ;3   =  14
;---------------------------------------
    lda     (ram_B3),y              ;5        
    tax                             ;2        
    lda     (ram_AB),y              ;5        
    nop                             ;2        
    sta     GRP0                    ;3        
    lda     (ram_AD),y              ;5        
    sta     GRP1                    ;3        
    lda     (ram_AF),y              ;5        
    sta     GRP0                    ;3        
    lda     (ram_B1),y              ;5        
    ldy     ram_8F                  ;3        
    sta     GRP1                    ;3        
    stx     GRP0                    ;3        
    sty     GRP1                    ;3        
    sta     GRP0                    ;3        
    dec     ram_8E                  ;5        
    bpl     Lfb60                   ;2/3      
    sta     WSYNC                   ;3   =  63
;---------------------------------------
    lda     #$00                    ;2        
    sta     VDELP0                  ;3        
    sta     VDELP1                  ;3        
    sta     GRP0                    ;3        
    sta     GRP1                    ;3        
    rts                             ;6   =  20
    
Lfb95
    .byte   $04,$01,$0c                     ; $fb95 (*)
    .byte   $04                             ; $fb98 (D)
Lfb99
    .byte   $07,$01,$03                     ; $fb99 (*)
    .byte   $00                             ; $fb9c (D)
Lfb9d
    .byte   $07                             ; $fb9d (D)
    .byte   $0d,$13,$19,$1f                 ; $fb9e (*)
    .byte   $25                             ; $fba2 (D)
    .byte   $2b,$31,$37,$3d,$43,$49,$4f,$55 ; $fba3 (*)
    .byte   $5b,$61                         ; $fbab (*)
Lfbad
    .byte   $1d                             ; $fbad (D)
    .byte   $1a                             ; $fbae (*)
    .byte   $17                             ; $fbaf (D)
    .byte   $15                             ; $fbb0 (*)
    .byte   $13                             ; $fbb1 (D)
    .byte   $11,$0f                         ; $fbb2 (*)
    .byte   $0e                             ; $fbb4 (D)
    .byte   $0c                             ; $fbb5 (*)
    .byte   $0b                             ; $fbb6 (D)
    .byte   $0a,$09,$08,$07                 ; $fbb7 (*)
Lfbbb
    .byte   $2e                             ; $fbbb (D)
    .byte   $3b,$1e,$32,$36                 ; $fbbc (*)
Lfbc0
    .byte   $00                             ; $fbc0 (D)
    .byte   $2f,$6b,$8a,$bd                 ; $fbc1 (*)
Lfbc5
    .byte   $03                             ; $fbc5 (*)
    .byte   $07                             ; $fbc6 (D)
Lfbc7
    .byte   $00,$04,$08,$0c                 ; $fbc7 (*)
Lfbcb
    .byte   $10                             ; $fbcb (D)
    .byte   $18,$20,$28                     ; $fbcc (*)
Lfbcf
    .byte   $41,$21,$41,$01,$51,$31,$51,$11 ; $fbcf (*)
    .byte   $41,$31,$41,$11,$51,$31,$51,$01 ; $fbd7 (*)
    .byte   $20,$40,$70                     ; $fbdf (*)
    .byte   $90,$70,$40,$20,$00             ; $fbe2 (D)
    .byte   $30,$50,$80,$a0,$80,$50,$30,$10 ; $fbe7 (*)
    .byte   $40,$60,$80,$b0,$80,$60,$40,$10 ; $fbef (*)
    .byte   $30,$50,$70,$a0,$70,$50,$30,$00 ; $fbf7 (*)
    .byte   $00,$07,$17,$03,$23,$41,$35,$47 ; $fbff (*)
    .byte   $51,$71,$53,$73,$43,$21,$05,$f0 ; $fc07 (*)
    .byte   $17,$21,$41,$23,$33,$33,$43,$43 ; $fc0f (*)
    .byte   $17,$21,$41,$23,$33,$33,$43,$43 ; $fc17 (*)
    .byte   $f2,$07,$17,$03,$23,$41,$35,$47 ; $fc1f (*)
    .byte   $51,$71,$53,$73,$43,$21         ; $fc27 (*)
    .byte   $05,$f0                         ; $fc2d (D)
    .byte   $0f,$43,$43,$23,$03,$f0,$17,$13 ; $fc2f (*)
    .byte   $33,$f2,$27,$23,$43,$47,$33,$23 ; $fc37 (*)
    .byte   $23,$23,$23,$23,$f0,$37,$23,$13 ; $fc3f (*)
    .byte   $13,$13,$13,$13,$f2,$27,$23,$23 ; $fc47 (*)
    .byte   $43,$43,$23,$03,$f0,$17,$13,$33 ; $fc4f (*)
    .byte   $f2,$27,$23,$43,$47,$43,$43,$33 ; $fc57 (*)
    .byte   $23,$13,$03,$f0,$17,$13,$33,$f2 ; $fc5f (*)
    .byte   $27,$23,$43,$f0,$07,$13,$23,$f0 ; $fc67 (*)
    .byte   $47,$17,$f2,$47,$33,$23,$f0,$33 ; $fc6f (*)
    .byte   $43,$51,$45,$f2,$47,$33,$23,$f0 ; $fc77 (*)
    .byte   $37,$23,$13,$47,$33,$23,$33,$43 ; $fc7f (*)
    .byte   $51,$45,$f2,$77,$81,$a1,$b1,$b1 ; $fc87 (*)
    .byte   $93,$91,$a1,$f0,$a3,$a1,$a1,$f1 ; $fc8f (*)
    .byte   $97,$80,$72,$b1,$91,$93,$91,$91 ; $fc97 (*)
    .byte   $93,$91,$91,$77,$f0,$81,$a1,$b1 ; $fc9f (*)
    .byte   $c1,$b3,$b1,$b1,$81,$91,$a1,$51 ; $fca7 (*)
    .byte   $51,$55,$f1,$71,$81,$91,$41,$41 ; $fcaf (*)
    .byte   $45,$71,$81,$91,$41,$f0,$0b,$f0 ; $fcb7 (*)
    .byte   $13,$31,$45,$f2,$23,$43,$73,$f0 ; $fcbf (*)
    .byte   $9b,$f0,$7b,$f0,$63,$81,$a5,$f2 ; $fcc7 (*)
    .byte   $83,$87,$f2,$2b,$f0,$43,$51,$45 ; $fccf (*)
    .byte   $f0,$53,$61,$75,$f3,$53,$57,$f3 ; $fcd7 (*)
    .byte   $4b,$f0,$73,$77,$6b,$f2,$83,$87 ; $fcdf (*)
    .byte   $f2,$2b,$f0,$43,$51,$45,$f0,$2b ; $fce7 (*)
    .byte   $f0,$43,$51,$45,$f0,$68,$aa,$68 ; $fcef (*)
    .byte   $a8,$68,$60,$84,$aa,$85,$ab,$48 ; $fcf7 (*)
    .byte   $98                             ; $fcff (*)
    
Lfd00 ; DECOMP: Lilly color pallete.
    .byte   ORANGE|$c                       ; $fd00 (C)
    .byte   VIOLET|$8                       ; $fd01 (C)
    .byte   VIOLET|$8                       ; $fd02 (C)
    .byte   VIOLET|$8                       ; $fd03 (C)
    .byte   VIOLET|$8                       ; $fd04 (C)
    .byte   VIOLET|$8                       ; $fd05 (C)
    .byte   ORANGE|$6                       ; $fd06 (C)
    .byte   VIOLET|$8                       ; $fd07 (C)
    .byte   VIOLET|$8                       ; $fd08 (C)
    .byte   ORANGE|$c                       ; $fd09 (C)
    .byte   ORANGE|$c                       ; $fd0a (C)
    .byte   ORANGE|$c                       ; $fd0b (C)
    .byte   BLACK0|$0                       ; $fd0c (C)
    .byte   BLACK0|$0                       ; $fd0d (C)
    .byte   BLACK0|$0                       ; $fd0e (C)
    
Lfd0f
    .byte   %11111111 ; |********|            $fd0f (P)
    .byte   %11111111 ; |********|            $fd10 (P)
    .byte   %11111111 ; |********|            $fd11 (P)
    .byte   %11111111 ; |********|            $fd12 (P)
    .byte   %00111111 ; |  ******|            $fd13 (P)
    .byte   %00011111 ; |   *****|            $fd14 (P)
    .byte   %00001111 ; |    ****|            $fd15 (P)
    .byte   %00000011 ; |      **|            $fd16 (P)
Lfd17
    .byte   %11110000 ; |****    |            $fd17 (P)
    .byte   %01110000 ; | ***    |            $fd18 (P)
    .byte   %00010000 ; |   *    |            $fd19 (P)
    .byte   %00000000 ; |        |            $fd1a (P)
    .byte   %00000000 ; |        |            $fd1b (P)
    .byte   %00000000 ; |        |            $fd1c (P)
    .byte   %00000000 ; |        |            $fd1d (P)
    .byte   %00000000 ; |        |            $fd1e (P)
Lfd1f
    .byte   %01111111 ; | *******|            $fd1f (P)
    .byte   %00011111 ; |   *****|            $fd20 (P)
    .byte   %00000000 ; |        |            $fd21 (P)
    .byte   %00000000 ; |        |            $fd22 (P)
    .byte   %00000000 ; |        |            $fd23 (P)
    .byte   %00000000 ; |        |            $fd24 (P)
    .byte   %00000000 ; |        |            $fd25 (P)
    .byte   %00000000 ; |        |            $fd26 (P)
Lfd27
    .byte   %00011111 ; |   *****|            $fd27 (P)
    .byte   %00011111 ; |   *****|            $fd28 (P)
    .byte   %00111100 ; |  ****  |            $fd29 (P)
    .byte   %00111000 ; |  ***   |            $fd2a (P)
    .byte   %00111000 ; |  ***   |            $fd2b (P)
    .byte   %00011100 ; |   ***  |            $fd2c (P)
    .byte   %00001110 ; |    *** |            $fd2d (P)
    .byte   %00000111 ; |     ***|            $fd2e (P)
Lfd2f
    .byte   %00000000 ; |        |            $fd2f (P)
    .byte   %00000000 ; |        |            $fd30 (P)
    .byte   %00000000 ; |        |            $fd31 (P)
    .byte   %00000000 ; |        |            $fd32 (P)
    .byte   %00000000 ; |        |            $fd33 (P)
    .byte   %00000000 ; |        |            $fd34 (P)
    .byte   %00010000 ; |   *    |            $fd35 (P)
    .byte   %00110000 ; |  **    |            $fd36 (P)
    .byte   %01110000 ; | ***    |            $fd37 (P)
    .byte   %11110000 ; |****    |            $fd38 (P)
    .byte   %11110000 ; |****    |            $fd39 (P)
    .byte   %11110000 ; |****    |            $fd3a (P)
    .byte   %11110000 ; |****    |            $fd3b (P)
    .byte   %11110000 ; |****    |            $fd3c (P)
    .byte   %11110000 ; |****    |            $fd3d (P)
    .byte   %11110000 ; |****    |            $fd3e (P)
Lfd3f
    .byte   %00111111 ; |  ******|            $fd3f (P)
    .byte   %00011111 ; |   *****|            $fd40 (P)
    .byte   %00001111 ; |    ****|            $fd41 (P)
    .byte   %00000111 ; |     ***|            $fd42 (P)
    .byte   %00000011 ; |      **|            $fd43 (P)
    .byte   %00000001 ; |       *|            $fd44 (P)
    .byte   %00000000 ; |        |            $fd45 (P)
    .byte   %00000000 ; |        |            $fd46 (P)
    .byte   %10000000 ; |*       |            $fd47 (P)
    .byte   %11000000 ; |**      |            $fd48 (P)
    .byte   %11000000 ; |**      |            $fd49 (P)
    .byte   %11100000 ; |***     |            $fd4a (P)
    .byte   %11110000 ; |****    |            $fd4b (P)
    .byte   %11111000 ; |*****   |            $fd4c (P)
    .byte   %11111100 ; |******  |            $fd4d (P)
    .byte   %11111111 ; |********|            $fd4e (P)
Lfd4f
    .byte   %11111111 ; |********|            $fd4f (P)
    .byte   %11111111 ; |********|            $fd50 (P)
    .byte   %11111111 ; |********|            $fd51 (P)
    .byte   %11111111 ; |********|            $fd52 (P)
    .byte   %11111111 ; |********|            $fd53 (P)
    .byte   %11111111 ; |********|            $fd54 (P)
    .byte   %11111111 ; |********|            $fd55 (P)
    .byte   %11111110 ; |******* |            $fd56 (P)
    .byte   %11111000 ; |*****   |            $fd57 (P)
    .byte   %11110000 ; |****    |            $fd58 (P)
    .byte   %11000000 ; |**      |            $fd59 (P)
    .byte   %00000000 ; |        |            $fd5a (P)
    .byte   %00000000 ; |        |            $fd5b (P)
    .byte   %00000000 ; |        |            $fd5c (P)
    .byte   %10000001 ; |*      *|            $fd5d (P)
    .byte   %11100001 ; |***    *|            $fd5e (P)
Lfd5f
    .byte   %11110000 ; |****    |            $fd5f (P)
    .byte   %11110000 ; |****    |            $fd60 (P)
    .byte   %11110000 ; |****    |            $fd61 (P)
    .byte   %11110000 ; |****    |            $fd62 (P)
    .byte   %11110000 ; |****    |            $fd63 (P)
    .byte   %11110000 ; |****    |            $fd64 (P)
    .byte   %11110000 ; |****    |            $fd65 (P)
    .byte   %11110000 ; |****    |            $fd66 (P)
    .byte   %11110000 ; |****    |            $fd67 (P)
    .byte   %11110000 ; |****    |            $fd68 (P)
    .byte   %11110000 ; |****    |            $fd69 (P)
    .byte   %11110000 ; |****    |            $fd6a (P)
    .byte   %11100000 ; |***     |            $fd6b (P)
    .byte   %11000000 ; |**      |            $fd6c (P)
    .byte   %10110000 ; |* **    |            $fd6d (P)
    .byte   %11110000 ; |****    |            $fd6e (P)
Lfd6f
    .byte   %11111111 ; |********|            $fd6f (P)
    .byte   %11111111 ; |********|            $fd70 (P)
    .byte   %11111111 ; |********|            $fd71 (P)
    .byte   %11111111 ; |********|            $fd72 (P)
    .byte   %11111110 ; |******* |            $fd73 (P)
    .byte   %11111100 ; |******  |            $fd74 (P)
    .byte   %11111100 ; |******  |            $fd75 (P)
    .byte   %11111110 ; |******* |            $fd76 (P)
    .byte   %11111110 ; |******* |            $fd77 (P)
    .byte   %11111111 ; |********|            $fd78 (P)
    .byte   %11111111 ; |********|            $fd79 (P)
    .byte   %11111111 ; |********|            $fd7a (P)
    .byte   %11111111 ; |********|            $fd7b (P)
    .byte   %11111111 ; |********|            $fd7c (P)
    .byte   %11111111 ; |********|            $fd7d (P)
    .byte   %11111111 ; |********|            $fd7e (P)
Lfd7f ; DECOMP: Probably background control?
    .byte   %00000111 ; |     ***|            $fd7f (P)
    .byte   %00000011 ; |      **|            $fd80 (P)
    .byte   %00000001 ; |       *|            $fd81 (P)
    .byte   %00000000 ; |        |            $fd82 (P)
    .byte   %00000000 ; |        |            $fd83 (P)
    .byte   %00000000 ; |        |            $fd84 (P)
    .byte   %00000000 ; |        |            $fd85 (P)
    .byte   %00000000 ; |        |            $fd86 (P)
    .byte   %00000000 ; |        |            $fd87 (P)
    .byte   %00000000 ; |        |            $fd88 (P)
    .byte   %00000000 ; |        |            $fd89 (P)
    .byte   %00000001 ; |       *|            $fd8a (P)
    .byte   %00000011 ; |      **|            $fd8b (P)
    .byte   %00000111 ; |     ***|            $fd8c (P)
    .byte   %00001111 ; |    ****|            $fd8d (P)
    .byte   %00001111 ; |    ****|            $fd8e (P)
    .byte   %11111111 ; |########|            $fd8f (G)
    .byte   %01111111 ; | #######|            $fd90 (G)
    .byte   %00111111 ; |  ######|            $fd91 (G)
    .byte   %00011111 ; |   #####|            $fd92 (G)
    .byte   %00111111 ; |  ######|            $fd93 (G)
    .byte   %11111111 ; |########|            $fd94 (G)
    .byte   %01111111 ; | #######|            $fd95 (G)
    .byte   %00111111 ; |  ######|            $fd96 (G)
    .byte   %00011111 ; |   #####|            $fd97 (G)
    .byte   %00001111 ; |    ####|            $fd98 (G)
    .byte   %00011111 ; |   #####|            $fd99 (G)
    .byte   %01111111 ; | #######|            $fd9a (G)
    .byte   %00111111 ; |  ######|            $fd9b (G)
    .byte   %00111111 ; |  ######|            $fd9c (G)
    .byte   %00011111 ; |   #####|            $fd9d (G)
    .byte   %00011111 ; |   #####|            $fd9e (G)
    .byte   %00001111 ; |    ####|            $fd9f (G)
    .byte   %00001110 ; |    ### |            $fda0 (G)
    .byte   %00000100 ; |     #  |            $fda1 (G)
    .byte   %00000100 ; |     #  |            $fda2 (G)
    .byte   %00000100 ; |     #  |            $fda3 (G)
    .byte   %00011100 ; |   ###  |            $fda4 (G)
    .byte   %01111000 ; | ####   |            $fda5 (G)
    .byte   %01110000 ; | ###    |            $fda6 (G)
    .byte   %00110111 ; |  ## ###|            $fda7 (G)
    .byte   %00111110 ; |  ##### |            $fda8 (G)
    .byte   %00111100 ; |  ####  |            $fda9 (G)
    .byte   %01111000 ; | ####   |            $fdaa (G)
    .byte   %01110000 ; | ###    |            $fdab (G)
    .byte   %00100000 ; |  #     |            $fdac (G)
    .byte   %00111110 ; |  ##### |            $fdad (G)
    .byte   %01111000 ; | ####   |            $fdae (G)
    .byte   %11110000 ; |####    |            $fdaf (G)
    .byte   %11100000 ; |###     |            $fdb0 (G)
    .byte   %01111100 ; | #####  |            $fdb1 (G)
    .byte   %01111000 ; | ####   |            $fdb2 (G)
    .byte   %11110000 ; |####    |            $fdb3 (G)
    .byte   %11100000 ; |###     |            $fdb4 (G)
    .byte   %11000000 ; |##      |            $fdb5 (G)
    .byte   %10000000 ; |#       |            $fdb6 (G)
    .byte   %10000000 ; |#       |            $fdb7 (G)
    .byte   %10000000 ; |#       |            $fdb8 (G)
    .byte   %00111100 ; |  ####  |            $fdb9 (G)
    .byte   %11111110 ; |####### |            $fdba (G)
    .byte   %01111111 ; | #######|            $fdbb (G)
    .byte   %00111110 ; |  ##### |            $fdbc (G)
    .byte   %00111100 ; |  ####  |            $fdbd (G)
    .byte   %00011111 ; |   #####|            $fdbe (G)
    .byte   %01111110 ; | ###### |            $fdbf (G)
    .byte   %00111100 ; |  ####  |            $fdc0 (G)
    .byte   %00011111 ; |   #####|            $fdc1 (G)
    .byte   %01011110 ; | # #### |            $fdc2 (G)
    .byte   %00111100 ; |  ####  |            $fdc3 (G)
    .byte   %00111000 ; |  ###   |            $fdc4 (G)
    .byte   %00011110 ; |   #### |            $fdc5 (G)
    .byte   %00011100 ; |   ###  |            $fdc6 (G)
    .byte   %00001000 ; |    #   |            $fdc7 (G)
    .byte   %00001000 ; |    #   |            $fdc8 (G)
    .byte   %01111000 ; | ****   |            $fdc9 (P)
    .byte   %01111000 ; | ****   |            $fdca (P)
    .byte   %00111000 ; |  ***   |            $fdcb (P)
    .byte   %00111000 ; |  ***   |            $fdcc (P)
    .byte   %00110000 ; |  **    |            $fdcd (P)
    .byte   %00010000 ; |   *    |            $fdce (P)
    .byte   %00010000 ; |   *    |            $fdcf (P)
    .byte   %00010000 ; |   *    |            $fdd0 (P)
    .byte   %00000000 ; |        |            $fdd1 (P)
    .byte   %00000000 ; |        |            $fdd2 (P)
    .byte   %00000000 ; |        |            $fdd3 (P)
    .byte   %00000000 ; |        |            $fdd4 (P)
    .byte   %00000000 ; |        |            $fdd5 (P)
    .byte   %00000000 ; |        |            $fdd6 (P)
    .byte   %00000000 ; |        |            $fdd7 (P)
    .byte   %00000000 ; |        |            $fdd8 (P)
    .byte   %00000000 ; |        |            $fdd9 (P)
    .byte   %00000000 ; |        |            $fdda (P)
    .byte   %00000000 ; |        |            $fddb (P)
    .byte   %00000000 ; |        |            $fddc (P)
    .byte   %00000000 ; |        |            $fddd (P)
    .byte   %11111101 ; |****** *|            $fdde (P)
    .byte   %11111101 ; |****** *|            $fddf (P)
    .byte   %11111101 ; |****** *|            $fde0 (P)
    .byte   %11111100 ; |******  |            $fde1 (P)
    .byte   %01111100 ; | *****  |            $fde2 (P)
    .byte   %01111100 ; | *****  |            $fde3 (P)
    .byte   %01111000 ; | ****   |            $fde4 (P)
    .byte   %01111000 ; | ****   |            $fde5 (P)
    .byte   %00111000 ; |  ***   |            $fde6 (P)
    .byte   %00111000 ; |  ***   |            $fde7 (P)
    .byte   %00110000 ; |  **    |            $fde8 (P)
    .byte   %00110000 ; |  **    |            $fde9 (P)
    .byte   %00110000 ; |  **    |            $fdea (P)
    .byte   %00000000 ; |        |            $fdeb (P)
    .byte   %00000000 ; |        |            $fdec (P)
    .byte   %00000000 ; |        |            $fded (P)
    .byte   %11111111 ; |********|            $fdee (P)
    .byte   %11111111 ; |********|            $fdef (P)
    .byte   %11111111 ; |********|            $fdf0 (P)
    .byte   %11111111 ; |********|            $fdf1 (P)
    .byte   %11111111 ; |********|            $fdf2 (P)
    .byte   %11111111 ; |********|            $fdf3 (P)
    .byte   %11111111 ; |********|            $fdf4 (P)
    .byte   %11111110 ; |******* |            $fdf5 (P)
    .byte   %11111110 ; |******* |            $fdf6 (P)
    .byte   %11111110 ; |******* |            $fdf7 (P)
    .byte   %11111110 ; |******* |            $fdf8 (P)
    .byte   %11111110 ; |******* |            $fdf9 (P)
    .byte   %11111100 ; |******  |            $fdfa (P)
    .byte   %11111100 ; |******  |            $fdfb (P)
    .byte   %01111100 ; | *****  |            $fdfc (P)
    .byte   %01111100 ; | *****  |            $fdfd (P)
    
    .byte   $ac                             ; $fdfe (*)
    
    .byte   MAUVE|$8                        ; $fdff (C)
    
    .byte   %00010000 ; |   #    |            $fe00 (G)
    .byte   %00010000 ; |   #    |            $fe01 (G)
    .byte   %10101010 ; |# # # # |            $fe02 (G)
    .byte   %01000100 ; | #   #  |            $fe03 (G)
    .byte   %00000000 ; |        |            $fe04 (G)
    .byte   %00000000 ; |        |            $fe05 (G)
    .byte   %00000000 ; |        |            $fe06 (G)
    .byte   %00000000 ; |        |            $fe07 (G)
    .byte   %00000000 ; |        |            $fe08 (G)
    .byte   %10000010 ; |#     # |            $fe09 (G)
    .byte   %01010100 ; | # # #  |            $fe0a (G)
    .byte   %00111000 ; |  ###   |            $fe0b (G)
    
    .byte   $00,$00,$00,$00,$07,$e6,$7e,$7e ; $fe0c (*)
    .byte   $7f,$1d,$7f,$4e,$5f,$55,$5f,$4e ; $fe14 (*)
    .byte   $e0,$67,$7e,$7e,$fe,$b8,$fe,$72 ; $fe1c (*)
    .byte   $f2,$aa,$fa,$72,$ff,$7e,$3c,$1e ; $fe24 (*)
    .byte   $1e,$1b,$1b,$1f,$15,$1f,$0e,$00 ; $fe2c (*)
    .byte   $7f,$3e,$3c,$78,$78,$d8,$d8,$f8 ; $fe34 (*)
    .byte   $a8,$78,$70,$00                 ; $fe3c (*)
    
    .byte   %00000011 ; |      ##|            $fe40 (G)
    .byte   %00001101 ; |    ## #|            $fe41 (G)
    .byte   %00110100 ; |  ## #  |            $fe42 (G)
    .byte   %11010000 ; |## #    |            $fe43 (G)
    .byte   %11000000 ; |##      |            $fe44 (G)
    .byte   %10000000 ; |#       |            $fe45 (G)
    .byte   %11010101 ; |## # # #|            $fe46 (G)
    .byte   %11111111 ; |########|            $fe47 (G)
    .byte   %00000000 ; |        |            $fe48 (G)
    
    .byte   $00,$00,$00,$0f,$f5,$d5,$ff,$00 ; $fe49 (*)
    .byte   $01,$39,$7d,$fd,$ff,$fe,$43,$00 ; $fe51 (*)
    .byte   $00,$38,$7d,$fd,$ff,$fe,$86     ; $fe59 (*)
    
    .byte   %00000000 ; |        |            $fe60 (G)
    .byte   %00000000 ; |        |            $fe61 (G)
    .byte   %00000000 ; |        |            $fe62 (G)
    .byte   %00000000 ; |        |            $fe63 (G)
    .byte   %00000000 ; |        |            $fe64 (G)
    .byte   %00000000 ; |        |            $fe65 (G)
    .byte   %00000000 ; |        |            $fe66 (G)
    .byte   %00000000 ; |        |            $fe67 (G)
    .byte   %00000000 ; |        |            $fe68 (G)
    .byte   %00000000 ; |        |            $fe69 (G)
    .byte   %00000000 ; |        |            $fe6a (G)
    .byte   %00000000 ; |        |            $fe6b (G)
    
Lfe6c
    .byte   $0f                             ; $fe6c (D)
    .byte   $57,$27,$b7                     ; $fe6d (*)
Lfe70
    .byte   $00                             ; $fe70 (D)
    .byte   $ba                             ; $fe71 (*)
Lfe72
    .byte   $0f                             ; $fe72 (D)
    .byte   $35,$57,$27                     ; $fe73 (*)
Lfe76
    .byte   $7a,$98,$b6,$d4,$ba,$57,$5c,$5c ; $fe76 (*)
    .byte   $3c,$3a,$47,$87,$87,$87,$57,$07 ; $fe7e (*)
    .byte   $57,$dc,$57,$07,$b7,$b7,$07,$57 ; $fe86 (*)
    .byte   $07,$dc,$07,$57,$b7,$b7,$57,$b7 ; $fe8e (*)
    .byte   $57,$b7,$4a,$34,$4c,$4c,$57,$57 ; $fe96 (*)
    .byte   $37,$87,$47,$87,$57,$07,$57,$dc ; $fe9e (*)
    .byte   $57,$07,$b7,$b7,$57,$dc,$57,$dc ; $fea6 (*)
    .byte   $2e,$57,$2e,$57,$b7,$57,$b7,$57 ; $feae (*)
    .byte   $2a,$27,$2c,$2c,$27,$27,$27,$23 ; $feb6 (*)
    .byte   $53,$23,$2e,$37,$2e,$c7,$2e,$37 ; $febe (*)
    .byte   $c7,$c7,$37,$2e,$37,$c7,$37,$2e ; $fec6 (*)
    .byte   $c7,$c7,$2e,$c7,$2e,$c7,$ca,$b4 ; $fece (*)
    .byte   $0f,$b5,$0f,$82,$0e,$27,$47,$27 ; $fed6 (*)
    .byte   $82,$0e,$b7,$dc,$82,$0e,$b7,$0f ; $fede (*)
    .byte   $82,$0e,$b7,$b7,$82,$0f,$b7,$0f ; $fee6 (*)
    .byte   $0f,$b7,$0f,$b7                 ; $feee (*)
    
Lfef2
    lsr                             ;2        
    lsr                             ;2   =   4
Lfef4
    lsr                             ;2        
    lsr                             ;2   =   4
Lfef6
    lsr                             ;2        
    lsr                             ;2   =   4
Lfef8
    and     #$03                    ;2        
    tax                             ;2        
    lda     Lfe6c,x                 ;4        
    rts                             ;6   =  14
    
    .byte   $a0                             ; $feff (*)
    
    .byte   %00111100 ; |  ****  |            $ff00 (P)
    .byte   %01100110 ; | **  ** |            $ff01 (P)
    .byte   %01100110 ; | **  ** |            $ff02 (P)
    .byte   %01100110 ; | **  ** |            $ff03 (P)
    .byte   %01100110 ; | **  ** |            $ff04 (P)
    
    .byte   $66,$66,$3c,$3c,$18             ; $ff05 (D)
    
    .byte   %00011000 ; |   ##   |            $ff0a (G)
    
    .byte   $18                             ; $ff0b (D)
    
    .byte   %00011000 ; |   ##   |            $ff0c (G)
    .byte   %00011000 ; |   ##   |            $ff0d (G)
    .byte   %00111000 ; |  ###   |            $ff0e (G)
    .byte   %00011000 ; |   ##   |            $ff0f (G)
    
    .byte   $7e,$60,$60,$3c,$06,$06,$46,$3c ; $ff10 (*)
    .byte   $3c,$46,$06,$0c,$0c,$06,$46,$3c ; $ff18 (*)
    .byte   $0c,$0c,$0c,$7e,$4c,$2c,$1c,$0c ; $ff20 (*)
    .byte   $7c,$46,$06,$06,$7c,$60,$60,$7e ; $ff28 (*)
    .byte   $3c,$66,$66,$66,$7c,$60,$62,$3c ; $ff30 (*)
    .byte   $18,$18,$18,$18,$0c,$06,$42,$7e ; $ff38 (*)
    .byte   $3c,$66,$66,$3c,$3c,$66,$66,$3c ; $ff40 (*)
    .byte   $3c,$46,$06,$3e,$66,$66,$66,$3c ; $ff48 (*)
    .byte   $dc,$44,$dc,$44,$dc,$01,$01,$00 ; $ff50 (D)
    
    .byte   %00101001 ; |  # #  #|            $ff58 (G)
    .byte   %10101001 ; |# # #  #|            $ff59 (G)
    .byte   %10101001 ; |# # #  #|            $ff5a (G)
    .byte   %10101001 ; |# # #  #|            $ff5b (G)
    .byte   %00010001 ; |   #   #|            $ff5c (G)
    .byte   %00000000 ; |        |            $ff5d (G)
    .byte   %00000000 ; |        |            $ff5e (G)
    .byte   %00000000 ; |        |            $ff5f (G)
    .byte   %01101001 ; | ## #  #|            $ff60 (G)
    .byte   %00101010 ; |  # # # |            $ff61 (G)
    .byte   %01101010 ; | ## # # |            $ff62 (G)
    .byte   %01001010 ; | #  # # |            $ff63 (G)
    .byte   %01101001 ; | ## #  #|            $ff64 (G)
    .byte   %00000000 ; |        |            $ff65 (G)
    .byte   %00001000 ; |    #   |            $ff66 (G)
    .byte   %00000000 ; |        |            $ff67 (G)
    .byte   %10001001 ; |#   #  #|            $ff68 (G)
    .byte   %00010101 ; |   # # #|            $ff69 (G)
    .byte   %10010101 ; |#  # # #|            $ff6a (G)
    .byte   %10010101 ; |#  # # #|            $ff6b (G)
    .byte   %10010101 ; |#  # # #|            $ff6c (G)
    .byte   %00000000 ; |        |            $ff6d (G)
    .byte   %00000001 ; |       #|            $ff6e (G)
    .byte   %00000000 ; |        |            $ff6f (G)
    .byte   %10101011 ; |# # # ##|            $ff70 (G)
    .byte   %10101010 ; |# # # # |            $ff71 (G)
    .byte   %10101011 ; |# # # ##|            $ff72 (G)
    .byte   %10101010 ; |# # # # |            $ff73 (G)
    .byte   %01010011 ; | # #  ##|            $ff74 (G)
    .byte   %00000000 ; |        |            $ff75 (G)
    .byte   %00000000 ; |        |            $ff76 (G)
    .byte   %00000000 ; |        |            $ff77 (G)
    .byte   %10100100 ; |# #  #  |            $ff78 (G)
    .byte   %10101010 ; |# # # # |            $ff79 (G)
    .byte   %10101010 ; |# # # # |            $ff7a (G)
    .byte   %10101010 ; |# # # # |            $ff7b (G)
    .byte   %11100100 ; |###  #  |            $ff7c (G)
    .byte   %10000000 ; |#       |            $ff7d (G)
    .byte   %10000000 ; |#       |            $ff7e (G)
    .byte   %10000000 ; |#       |            $ff7f (G)
    
    .byte   $80,$80,$c0,$c0,$c0,$80,$80,$e0 ; $ff80 (*)
    .byte   $e0,$e0,$80,$80,$f0,$f0,$e0,$80 ; $ff88 (*)
    .byte   $80,$f8,$f8,$e0,$80,$80,$fc,$f8 ; $ff90 (*)
    .byte   $e0,$80,$80,$ff,$f8,$e0,$80,$80 ; $ff98 (*)
    .byte   $01,$01,$01,$01,$01,$03,$03,$03 ; $ffa0 (*)
    .byte   $01,$01,$07,$07,$07,$01,$01,$0f ; $ffa8 (*)
    .byte   $0f,$07,$01,$01,$1f,$1f,$07,$01 ; $ffb0 (*)
    .byte   $01,$3f,$1f,$07,$01,$01,$ff,$1f ; $ffb8 (*)
    .byte   $07,$01,$01                     ; $ffc0 (*)
    .byte   $67,$c6,$7e,$7f,$ff,$7e,$3c,$18 ; $ffc3 (D)
    .byte   $7e,$38,$1c,$1e,$1c,$bc         ; $ffcb (D)
    
    .byte   %01011100 ; | # ###  |            $ffd1 (G)
    
    .byte   $88                             ; $ffd2 (D)
    .byte   $3c,$38,$7e,$7f,$ff,$7e,$3c,$18 ; $ffd3 (*)
    .byte   $7e,$38,$1c,$1e,$1c,$bc,$5c,$88 ; $ffdb (*)
    
    .byte   %00000000 ; |        |            $ffe3 (G)
    .byte   %00000000 ; |        |            $ffe4 (G)
    .byte   %00000000 ; |        |            $ffe5 (G)
    .byte   %00000000 ; |        |            $ffe6 (G)
    .byte   %00000000 ; |        |            $ffe7 (G)
    .byte   %00000000 ; |        |            $ffe8 (G)
    .byte   %00000000 ; |        |            $ffe9 (G)
    .byte   %00000000 ; |        |            $ffea (G)
    
    .byte   $e7,$7e,$7e,$ff,$3c,$3c,$18,$7e ; $ffeb (D)
    .byte   $38,$1c                         ; $fff3 (D)
    
    .byte   %00011110 ; |   #### |            $fff5 (G)
    .byte   %00011100 ; |   ###  |            $fff6 (G)
    .byte   %10111100 ; |# ####  |            $fff7 (G)
    .byte   %01011100 ; | # ###  |            $fff8 (G)
    .byte   %10001000 ; |#   #   |            $fff9 (G)
    
    .byte   $a0,$a0                         ; $fffa (*)
    .byte   $dc,$f1                         ; $fffc (D)
    .byte   $e0                             ; $fffe (*)
    .byte   $f7                             ; $ffff (*)
