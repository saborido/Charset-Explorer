;===> Charset Explorer pre RC2 <===> 'useful_loc.asm' (359 bytes) <===

;MicroHobby charsets menu. Aquí seleccionamos un charset para probarlo.

    ORG 50000

MAIN

    ld a, 2                 ;Abrimos la pantalla superior.
    call 5633

    ld de, USEFUL_UDG       ;Texto del charset de la ROM.
    ld bc, 17
    call 8252

    ld de, USEFUL_128       ;Texto del charset de la ROM 128k.
    ld bc, 12
    call 8252

    ld de, USEFUL2_UDG      ;Dirs. de memoria del charset de la ROM.
    ld bc, 19
    call 8252

    ld de, USEFUL2_128      ;Dirs. de memoria del charset de la ROM (128k).
    ld bc, 8
    call 8252

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


;--------------------------------------- LABELS -------------------------------------------;

USEFUL_UDG
        db 22, 5, 9, 19, 1, 16, 9, 17, 3, "U-UDG ", 16, 0   ;Magenta (UDG).

USEFUL2_UDG
        db 22, 6, 9, 17, 7, " (", 16, 1, "65368", 16, 9, "-", 16, 1 ;Blanco (dirs. de memoria de los UDG).

USEFUL_MENU
        db 22, 7, 9, 16, 9, 17, 5, "R-ROM Charset "         ;Cyan (Charset de la ROM).
        db 22, 8, 9, 17, 7, " (", 16, 1, "15616", 16, 9, "-", 16, 1, "16376", 16, 0, ")"    ;Blanco (dirs. de memoria del charset de la ROM).

        db 22, 9, 9, 16, 9, 17, 4, "A-MH Charset 1"         ;Verde (MicroHobby charset A).
        db 22, 10, 9, 17, 7, " (", 16, 1, "63064", 16, 9, "-", 16, 1, "63824", 16, 0, ")"   ;Blanco (dirs. de memoria del MH charset A).

        db 22, 11, 9, 16, 9, 17, 4, "B-MH Charset 2"        ;Verde (MicroHobby charset B).
        db 22, 12, 9, 17, 7, " (", 16, 1, "63832", 16, 9, "-", 16, 1, "64592", 16, 0, ")"   ;Blanco (dirs. de memoria del MH charset B).

        db 22, 13, 9, 16, 9, 17, 4, "C-MH Charset 3"        ;Verde (MicroHobby charset C).
        db 22, 14, 9, 17, 7, " (", 16, 1, "64600", 16, 9, "-", 16, 1, "65360", 16, 0, ")"   ;Blanco (dirs. de memoria del MH charset C).

        db 22, 15, 10, 16, 0, 17, 1, 21, 1, 19, 0, 23, 24, " "      ;Azul (sombra de la ventana).
EOFUSEFUL equ $

USEFUL_128
        db "(", 16, 6, "128k", 16, 0, ")  "

USEFUL_48
        db " (", 16, 6, "48k", 16, 0, ")  "

USEFUL2_128
        db "65512", 16, 0, ")"

USEFUL2_48
        db "65528", 16, 0, ")"
