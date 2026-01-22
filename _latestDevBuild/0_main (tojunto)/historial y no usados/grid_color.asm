;===> Charset Explorer pre RC2 <===> 'grid_color.asm' v1 (46 bytes) (56 bytes con la subrutina OUTGRD_POS) <===

;Aquí coloreamos el PAPER de la rejilla.

    ;ORG 60372

;MAIN

    ld a, 2                 ;Abrimos la pantalla superior.
    call 5633

    ld de, GRIDCOL_INI      ;Color codes INI.
    ld bc, 5
    call 8252
    ld a, (GRIDCOL_PAPER)	;Aqui añadimos el color del paper que falta en GRIDCOL_INI.
    rst 16

    ld c, 7                 ;La posición del eje Y.
    ld d, 21                ;La posición del eje X.

GRIDCOL_LINELOOP
    call OUTGRD_POS         ;Esta subrutina se encuentra en 'outer_grid.asm'. Nos posicionamos en la pantalla.

    ld b, 8                 ;Número de loops para formar una fila.
GRIDCOL_LINELOOP2
    ld a, " "
    rst 16
    djnz GRIDCOL_LINELOOP2

    inc c
    ld a, c
    cp 15
    jr nz, GRIDCOL_LINELOOP ;Repetir bucle hasta que la posición del eje Y sea igual a 14.

ret     ;Salimos de la rutina.

;------------------------------- SUBRUTINAS ------------------------------;

;------------------------- AGUSTINA LA SUBRUTINA -------------------------
;Subrutina para tests unitarios. (8 bytes de subrutina).
;Esta subrutina se encuentra en 'outer_grid.asm'.

; Nos posicionamos en la pantalla.

;OUTGRD_POS:
;    ld a, 22                    ;Comando AT del Basic.
;    rst 16
;    ld a, c                     ;Posición eje Y.
;    rst 16
;    ld a, d                     ;Posición eje X.
;    rst 16
;ret        ;Volvemos a la rutina principal.
;----------------------------------------------


;-------------------------------- DATOS ---------------------------------

GRIDCOL_INI db 21, 1, 19, 8, 16, 8, 17	;OVER 1, BRIGHT 8, INK 8, PAPER (el paper lo cogemos de GRIDCOL_PAPER)
GRIDCOL_END equ $

;COLOUR & POSITION CONTROL CODES TABLE:
;
;	16	- INK (0, 1, 2, 3, 4, 5, 6, 7, 8 or 9)
;	17	- PAPER (0, 1, 2, 3, 4, 5, 6, 7, 8 or 9)
;	18	- FLASH (0, 1 or 8)
;	19	- BRIGHT (0, 1 or 8)
;	20	- INVERSE (0, 1 or 8)
;	21	- OVER (0, 1 or 8)
;
;	 6	- MidScreen tabulation (comma).
;	22	- AT command (expects AT and two numbers)
;	23	- TAB command (expects TAB and a number).

;¿Soy yo el único tio raro que mezcla comentarios en inglés y en castellano en un mismo script?


;-------------------------------- LABELS --------------------------------

GRIDCOL_PAPER   equ 62970   ;Paper color address.

