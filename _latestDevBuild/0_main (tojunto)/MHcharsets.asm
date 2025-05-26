;===> Charset Explorer pre RC2 <===> 'MHcharsets.asm' (488 bytes) <===

;MicroHobby charsets menu. Aquí seleccionamos un charset para probarlo.

    ;ORG 61764

;MAIN

;Puesta a punto:

    ld hl, 32           ;Paper 4 (verde), Ink 0 (negro), sin Brillo, sin Flash.
    ld (ATTR_P), hl     ;Con la variable del sistema ATTR_P podemos cambiar el paper, ink, brillo y flash.
    call CLS_            ;Hacemos un CLS y esto abre la pantalla superior.

    ld a, 4             ;Borde 4 (verde).
    call BORDER_

;Logos y demás:

    ld hl, 22528        ;Nos posicionamos en la pantalla.
    ld a, 80
    call MH_PAINT       ;Pintamos 5 celdas.

    ld hl, 22560
    ld a, 87
    call MH_PAINT

    ld hl, 22555
    ld a, 120
    call MH_PAINT

    ld hl, 22587
    ld a, 122
    call MH_PAINT

    ld de, 16384        ;Nos posicionamos en la pantalla.
    call MHLOGO         ;Dibujamos las letras cyberneticas.

    ld de, 16411        ;Nos volvemos a posicionar en la pantalla.
    call MHLOGO         ;Volvemos a dibujar las letras de MH.

    ld de, T_CHAR       ;Texto "CHARACTER SETS".
    ld bc, EOT_CHR-T_CHAR
    call 8252

;Barras negras con la información de USR:

    ld a, 3
    ld (SCR_POS), a     ;Actualizamos la posición Y.
    call TXT_CHRSET

    ld de, TEXT_A       ;Texto del charset A.
    ld bc, EOT_A-TEXT_A
    call 8252

    call Y_INC6
    call TXT_CHRSET

    ld de, TEXT_B       ;Texto del charset B.
    ld bc, EOT_B-TEXT_B
    call 8252

    call Y_INC6
    call TXT_CHRSET

    ld de, TEXT_C       ;Texto del charset C.
    ld bc, EOT_C-TEXT_C
    call 8252

    ld de, TEXT_R       ;Texto del charset en ROM.
    ld bc, EOT_R-TEXT_R
    call 8252

    ld a, 1		        ;Abrimos la pantalla inferior.
    call 5633

    ld de, T_SEL        ;Texto del charset en ROM.
    ld bc, EOT_SEL-T_SEL
    call 8252

    ld hl, 22642
    ld b, 4

LOOP_ATTR
    ld (hl), 79
    ld de, 192
    add hl, de
    djnz LOOP_ATTR

;Ahora imprimimos los charsets:

    ld a, 2		        ;Abrimos la pantalla superior.
    call 5633

    ld a, 5
    ld (SCR_POS), a     ;Reseteamos la posición Y.

    call CHR_A          ;Cambiamos al charset A.
    call PRINT_CHARSET
    call CHR_B          ;Cambiamos al charset B.
    call PRINT_CHARSET
    call CHR_C          ;Cambiamos al charset C.
    call PRINT_CHARSET
    call CHR_ROM        ;Cambiamos al charset de la ROM.
ret     ;Salimos de la rutina.


;-------------------------------------- SUBRUTINAS ----------------------------------------;

PRINT_CHARSET:
    ld b, 96            ;Número de caracteres a imprimir.
    call AT_SCR
    ld a, 32            ;Empezamos desde el caracter 32 (espacio).

LOOP_CHR
    ld c, a
    rst 16
    ld a, c
    inc a
    djnz LOOP_CHR
    call Y_INC6
ret     ;Volvemos a la rutina principal.


TXT_CHRSET:
    call AT_SCR         ;Nos posicinamos en Y.
    ld de, TEXT_1       ;Texto "   >CHARACTER SET ".
    ld bc, EOT_1-TEXT_1
    call 8252
ret     ;Volvemos a la rutina principal.


AT_SCR:
    ld a, 22            ;Comando AT (de PRINT AT)
    rst 16
    ld a, (SCR_POS)	    ;eje y
    rst 16
    xor a           	;eje x
    rst 16
ret     ;Volvemos a la rutina principal.


Y_INC6:                  ;Incrementamos la fila 6 unidades (eje y)
    ld a, (SCR_POS)
    add a, 6
    ld (SCR_POS), a
ret     ;Volvemos a la rutina principal.


MH_PAINT:               ;Pintamos los colores del logo de MicroHobby.
    ld b, 5

LOOP_MHCOL
    ld (hl), a
    inc hl
    djnz LOOP_MHCOL
ret     ;Volvemos a la rutina principal.


MHLOGO:                 ;Letras ciberneticas de MicroHobby.
    ld hl, MH_LOGO
    ld b, 4

LOOP_MHLOGO
    push bc

    ld bc, 5
    ldir

    push hl
    ld hl, 27
    add hl, de
    ld d, h
    ld e, l
    pop hl

    ld bc, 5
    ldir

    push hl
    ld hl, 475
    add hl, de
    ld d, h
    ld e, l
    pop hl

    pop bc
    djnz LOOP_MHLOGO
ret     ;Volvemos a la rutina principal.


;---------------------------------- VARIABLES Y TEXTOS ------------------------------------;

SCR_POS db 5            ;Posición 'y' de la pantalla (texto).

T_CHAR  db 22, 1, 9, 19, 1, 17, 6, "CHARACTER SETS", 17, 4
EOT_CHR equ $

TEXT_1  db 17, 0, 16, 7, "   >CHARACTER SET "
EOT_1   equ $

TEXT_A  db "A: USR ", 16, 6, "63044  "
EOT_A   equ $

TEXT_B  db "B: USR ", 16, 6, "63049  "
EOT_B   equ $

TEXT_C  db "C: USR ", 16, 6, "63054  "
EOT_C   equ $

TEXT_R  db 22, 21, 0, 16, 7, "  >CHARSET IN ROM #: USR ", 16, 6, "63039  "
EOT_R   equ $

T_SEL   db 22, 1, 0, 17, 6, 19, 1, "  SELECT CHARSET ", 16, 2, " (AnyKey4ROM)  "
EOT_SEL equ $

MH_LOGO db 126, 60, 126, 124, 126   ;Scan 1 MICRO       ;MH Logo: 40 bytes.
        db 66, 126, 124, 124, 66    ;Scan 1 HOBBY
        db 106, 16, 96, 126, 70     ;Scan 3 MICRO
        db 126, 70, 126, 126, 126   ;Scan 3 HOBBY
        db 106, 24, 96, 98, 66      ;Scan 5 MICRO
        db 98, 66, 98, 98, 24       ;Scan 5 HOBBY
        db 106, 60, 126, 98, 126    ;Scan 7 MICRO
        db 98, 126, 126, 126, 24    ;Scan 7 HOBBY


;--------------------------------------- LABELS -------------------------------------------;

    ;Rutinas de la ROM:

BORDER_  equ 8859
CLS_     equ 3503

    ;Variables del sistema:

ATTR_P  equ 23693       ;Variable del sistema ATTR_P. Cambia atributos de pantalla con
                        ;el formato: FLASH*128 + BRIGHT*64 + (PAPER*8) + INK

    ;Otras mierdas:

CHR_A   equ 63044
CHR_B   equ 63049
CHR_C   equ 63054
CHR_ROM equ 63039
