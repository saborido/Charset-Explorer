;===> Charset Explorer pre RC2 <===> 'checkboard.asm' v1 (49 bytes) <===

;Checkerboard with Attributes:
;Rutina original de @darrylsloan -> https://www.youtube.com/@darrylsloan

;Esto es una modificación de la rutina original para hacer el checkerboard modificando
;el atributo BRIGHT en una cuadrícula de 8x8. El color del PAPER de la rejilla se
;guarda en el contenido del label PAPCOL_ del script 'char2grid.asm'.

	;ORG 50000

;MAIN

    ld a, 71
    ld bc, (COL_PAPER)

    rl c                ;Multiplicamos el PAPER por 8 (para calcular el atributo)
    rl c
    rl c
    add a, c
    ld c, a

    ld hl, 22773        ;Cargamos en HL la dirección 22773 (pantalla)
    ld de, 24
    ld a, 4

LOOP_CHKBD
    ld b, 4
    push af

    ld a, c
    sub 64              ;Le quitamos el brillo restando 64 a los atributos.

LOOP_ROW1
    ld (hl), c
    inc hl
    ld (hl), a
    inc hl
    djnz LOOP_ROW1
    add hl, de          ;Sumamos DE (24) a HL para posicionarnos en la siguiente linea.
    ld b, 4

LOOP_ROW2
    ld (hl), a
    inc hl
    ld (hl), c
    inc hl
    djnz LOOP_ROW2
    pop af
    add hl, de          ;Sumamos DE (24) a HL para siguiente linea.
    dec a
    jr nz, LOOP_CHKBD

ret     ;Salimos de la rutina

;Labels:

COL_PAPER   equ 62970   ;Color del PAPER guardado en 62970

