;===> Charset Explorer pre RC2 <===> 'checkboard.asm' v2 (86 bytes) <===

;Checkerboard with Attributes:
;Rutina original de @darrylsloan --> https://www.youtube.com/@darrylsloan

; Esto es una modificación de la rutina original para hacer un checkerboard.
;Se logra modificando el brillo de los atributos (en una cuadrícula de 8x8).

; También crea filas con brillo alterno donde aparecerán las direcciones de
;memoria y su valor.

    ;ORG 60266

;MAIN

    ld hl, 22761    ;Cargamos en HL la dirección 22773 (atributos de pantalla).
    ld de, 12       ;Habrá que sumar 12 para posicionarnos en la siguiente línea.
    ld a, 4         ;Esto es el número de loops (cada loop se imprimen 2 líneas).

CHKBRD_LOOP
    ld b, 4

    ld (hl), 64
    inc hl
    inc hl

    push bc
    ld b, 5
    call CHKBRD_ADDR1
    ld (hl), 68
    inc hl

    ld b, 3
    call CHKBRD_ADDR1
    pop bc

    inc hl

CHKBRD_ROW1
    ld (hl), 64
    inc hl
    ld (hl), 0
    inc hl
    djnz CHKBRD_ROW1

    add hl, de      ;Sumamos DE (24) a HL para posicionarlo al principio de la siguiente linea.

    ld b, 4

    ld (hl), 0
    inc hl
    inc hl
    push bc

    ld b, 5
    call CHKBRD_ADDR0

    ld (hl), 4
    inc hl

    ld b, 3
    call CHKBRD_ADDR0

    pop bc
    inc hl

CHKBRD_ROW2
    ld (hl), 0
    inc hl
    ld (hl), 64
    inc hl
    djnz CHKBRD_ROW2

    add hl, de      ;Nos posicionamos al principio de la siguiente linea.
    dec a
    jr nz, CHKBRD_LOOP

ret     ;Salimos de la rutina.
;jr OUTER_RTNE      ;Bueno no, continuamos con 'outer_grid.asm'.


;------------------------------ SUBRUTINAS ------------------------------


CHKBRD_ADDR0:
    ld (hl), 5
    inc hl
    djnz CHKBRD_ADDR0
ret     ;Volvemos a la rutina principal.

;-----------------------

CHKBRD_ADDR1:
    ld (hl), 69
    inc hl
    djnz CHKBRD_ADDR1
ret     ;Volvemos a la rutina principal.

;------------------------------ LABELS ------------------------------

;OUTER_RTNE  equ 60507       ;Dirección de la rutina 'outer_grid.asm'.
