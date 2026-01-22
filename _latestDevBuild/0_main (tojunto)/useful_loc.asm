;===> Charset Explorer pre RC2 <===> 'useful_loc.asm' (606 bytes) <===

;MicroHobby charsets menu. Aquí seleccionamos un charset para probarlo.

    ;ORG 60531

;MAIN

    ld a, 1                 ;Abrimos la pantalla inferior.
    call 5633

    ld de, SELBOT_TXT       ;Texto de la pantalla inferior.
    ld bc, EOFSELBOTT-SELBOT_TXT
    call 8252

    ld a, 2                 ;Abrimos la pantalla superior.
    call 5633

    ld de, SELECT_TXT       ;Texto superior ">Select location:".
    ld bc, EOFSEL_TXT-SELECT_TXT
    call 8252

    ld de, USEFUL_UDG       ;Texto UDG.
    ld bc, EOFUSEFUDG-USEFUL_UDG
    call 8252

    call MODE_CHK           ;Comprobamos si estamos en modo 48k (0) o 128k (1).
    jr z, JMP_MODE48A

    ld de, USEFUL_128       ;Texto UDG 128k.
    ld bc, EOFUSEF128-USEFUL_128
    call 8252
    jr JMP_MODEA

JMP_MODE48A:
    ld de, USEFUL_48        ;Texto UDG 48k.
    ld bc, EOFUSEF48-USEFUL_48
    call 8252

JMP_MODEA:
    ld de, USEFUL2_UDG      ;Dirs. de memoria de los UDG.
    ld bc, EOFUSEF2UDG-USEFUL2_UDG
    call 8252

    call MODE_CHK           ;Comprobamos si estamos en modo 48k (0) o 128k (1).
    jr z, JMP_MODE48B

    ld de, USEFUL2_128      ;Dirs. de memoria de los UDG (128k).
    ld bc, EOFUSEF2128-USEFUL2_128
    call 8252
    jr JMP_MODEB

JMP_MODE48B:
    ld de, USEFUL2_48       ;Dirs. de memoria de los UDG (48k).
    ld bc, EOFUSEF248-USEFUL2_48
    call 8252

JMP_MODEB:
    ld de, USEFUL_MENU      ;Todo lo demás.
    ld bc, EOFUSEFUL-USEFUL_MENU
    call 8252

    ld b, 9
    ld hl, 22743

LOOP_SHADE
    ld (hl), 8
    ld de, 32
    add hl, de
    djnz LOOP_SHADE

    ld b, 5
    ld hl, 22697

LOOP_SHADE2
    ld (hl), 78
    ld de, 64
    add hl, de
    djnz LOOP_SHADE2

ret     ;Salimos de la rutina.


;-------------------------------------- SUBRUTINAS ----------------------------------------;


MODE_CHK:
	ld a, (SPCCY_MODE)	;128k mode is on?
	cp 0
ret	;Volvemos a la rutina principal.


;---------------------------------- VARIABLES Y TEXTOS ------------------------------------;


USEFUL_UDG
        db 22, 5, 9, 16, 9, 17, 3, 19, 1, "U-UDG ", 16, 0   ;Magenta (UDG).
EOFUSEFUDG  equ $

USEFUL2_UDG
        db 22, 6, 9, 17, 7, 19, 0, " (", 17, 1, 16, 7, 19, 1, "65368", 19, 0, 17, 7, 16, 9, "-", 16, 1, 19, 1  ;Blanco (dirs. de memoria de los UDG).
EOFUSEF2UDG equ $

USEFUL_MENU
        db 22, 7, 9, 16, 9, 17, 5, 19, 1, "R-ROM Charset "         ;Cyan (Charset de la ROM).
        db 22, 8, 9, 17, 7, 19, 0, " (", 17, 1, 16, 7, 19, 1, "15616", 19, 0, 17, 7, 16, 9, "-", 16, 1, 19, 1, "16376", 19, 0, 16, 0, ")"    ;Blanco (dirs. de memoria del charset de la ROM).

        db 22, 9, 9, 16, 9, 17, 4, 19, 1, "A-MH Charset 1"         ;Verde (MicroHobby charset A).
        db 22, 10, 9, 17, 7, 19, 0, " (", 17, 1, 16, 7, 19, 1, "63064", 19, 0, 17, 7, 16, 9, "-", 16, 1, 19, 1, "63824", 19, 0, 16, 0, ")"   ;Blanco (dirs. de memoria del MH charset A).

        db 22, 11, 9, 16, 9, 17, 4, 19, 1, "B-MH Charset 2"        ;Verde (MicroHobby charset B).
        db 22, 12, 9, 17, 7, 19, 0, " (", 17, 1, 16, 7, 19, 1, "63832", 19, 0, 17, 7, 16, 9, "-", 16, 1, 19, 1, "64592", 19, 0, 16, 0, ")"   ;Blanco (dirs. de memoria del MH charset B).

        db 22, 13, 9, 16, 9, 17, 4, 19, 1, "C-MH Charset 3"        ;Verde (MicroHobby charset C).
        db 22, 14, 9, 17, 7, 19, 0, " (", 17, 1, 16, 7, 19, 1, "64600", 19, 0, 17, 7, 16, 9, "-", 16, 1, 19, 1, "65360", 19, 0, 16, 0, ")"   ;Blanco (dirs. de memoria del MH charset C).

        db 22, 15, 10, 16, 0, 17, 1, 21, 1, 19, 0, 23, 24, " "      ;Azul (sombra de la ventana).
EOFUSEFUL   equ $

USEFUL_128  db "(", 16, 6, "128k", 16, 0, ")  "
EOFUSEF128  equ $

USEFUL_48   db " (", 16, 6, "48k", 16, 0, ")  "
EOFUSEF48   equ $

USEFUL2_128 db "65512", 19, 0, 16, 0, ")"
EOFUSEF2128 equ $

USEFUL2_48  db "65528", 19, 0, 16, 0, ")"
EOFUSEF248  equ $

SELECT_TXT  db 22, 0, 6, 17, 8, 19, 8, 23, 31, " ", 22, 0, 8, 16, 9, ">Select location:"
EOFSEL_TXT  equ $

SELBOT_TXT  db 22, 0, 0, 17, 0, 16, 6, "+", 16, 1, 17, 7, "CShift", 17, 0, 16, 5, ":To 'a'", 23, 27, " "
            db 22, 1, 0, 17, 1, 16, 7, "0", 17, 0, 16, 6, "..", 17, 1, 16, 7, "9", 17, 0, 16, 5, ":Other locations", 23, 26, " "
EOFSELBOTT  equ $


;COLOUR & POSITION CONTROL CODES TABLE:
;
;	16	- INK (0, 1, 2, 3, 4, 5, 6, 7, 8 or 9)
;	17	- PAPER (0, 1, 2, 3, 4, 5, 6, 7, 8 or 9)
;	18	- FLASH (0, 1 or 8)
;	19	- BRIGHT (0, 1 or 8)
;	20	- INVERSE (0, 1 or 8)
;	21	- OVER (0, 1 or 8)
;
;	 6	- Midscreen tabulation (comma).
;	22	- AT command (expects AT and two numbers)
;	23	- TAB command (expects TAB and a number).


;--------------------------------------- LABELS -------------------------------------------;


SPCCY_MODE  equ 62967       ;En esta dir se guarda el modo del Spectrum (0 = 48k, 1 = 128k).
