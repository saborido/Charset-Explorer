;===> Charset Explorer pre RC2 <===> 'checkboard.asm' v2 (221 bytes) <===

;Checkerboard with Attributes:
;Rutina original de @darrylsloan --> https://www.youtube.com/@darrylsloan

; Esto es una modificación de la rutina original para hacer un checkerboard.
;Se logra modificando el brillo de los atributos (en una cuadrícula de 8x8).

; También crea filas con brillo alterno donde aparecerán las direcciones de
;memoria y su valor, y dejamos preparados los bordes de la rejilla, para
;cuando se dibuje el recuadro exterior que aparezca con el color y brillo
;correspondiente (que también lo dibujamos aquí).

	;ORG 60465

;MAIN

    ld a, (EDIT_MODE)
    cp 1
    jr z, CHKBRD_EDIT

    ld c, CHKBRD_OUTCOL
    jr CHKBRD_CONT

CHKBRD_EDIT:
    ld c, CHKBRD_EDITCOL    ;Rojo si Edit mode ON.

CHKBRD_CONT:
    ld hl, 22728    ;Cargamos en HL la dirección 22773 (atributos de pantalla).
    ld de, 10       ;Habrá que sumar 12 para posicionarnos en la siguiente línea.
    ld a, 4         ;Esto es el número de loops (cada loop se imprimen 2 líneas).

    call CHKBRD_UPPBOTT
    add hl, de

CHKBRD_LOOP
    ld b, 4

    ld (hl), c
    inc hl
    ld (hl), 64
    inc hl
    ld (hl), c
    inc hl

    push bc
    ld b, 5
    call CHKBRD_ADDR1
    ld (hl), 68
    inc hl

    ld b, 3
    call CHKBRD_ADDR1
    pop bc

    ld (hl), c
    inc hl

CHKBRD_ROW1
    ld (hl), 64
    inc hl
    ld (hl), 0
    inc hl
    djnz CHKBRD_ROW1
    ld (hl), c

    inc hl
    add hl, de      ;Sumamos DE (24) a HL para posicionarlo al principio de la siguiente linea.

    ld b, 4

    ld (hl), c
    inc hl
    ld (hl), 0
    inc hl
    ld (hl), c
    inc hl

    push bc
    ld b, 5
    call CHKBRD_ADDR0
    ld (hl), 4
    inc hl
    ld b, 3
    call CHKBRD_ADDR0
    pop bc

    ld (hl), c
    inc hl

CHKBRD_ROW2
    ld (hl), 0
    inc hl
    ld (hl), 64
    inc hl
    djnz CHKBRD_ROW2
    ld (hl), c

    inc hl
    add hl, de      ;Nos posicionamos al principio de la siguiente linea.
    dec a
    jr nz, CHKBRD_LOOP

    call CHKBRD_UPPBOTT

;Ahora dibujamos el recuadro exterior de la rejilla y de las direcciones de memoria:
;Esta posición es 60570 (60686-116 bytes, desde el final de la rutina). RANDOMIZE USR 60570

    ld hl, 17608
    call CHKBRD_DRWLINE

    ld hl, 19432
    call CHKBRD_DRWLINE

    ld hl, 17864
    ld b, 3
    call CHKBRD_DR2LP

    ld hl, 16616
    ld b, 8
    call CHKBRD_DR2LP

;-----------------------

    ld a, 7
    ld hl, 18440

CHKBRD_HYPLOOP
    ld b, 8
    push hl
    call CHKBRD_DR2LP
    pop hl
    ld de, 32
    add hl, de
    dec a
    jr nz, CHKBRD_HYPLOOP

    ld hl, 18664
    ld b, 3
    call CHKBRD_DR2LP

ret     ;Salimos de la rutina.


;------------------------------ SUBRUTINAS ------------------------------

CHKBRD_ADDR0:
    ld (hl), 5
    inc hl
    djnz CHKBRD_ADDR0
ret     ;Volvemos a la rutina principal.


CHKBRD_ADDR1:
    ld (hl), 69
    inc hl
    djnz CHKBRD_ADDR1
ret     ;Volvemos a la rutina principal.


CHKBRD_UPPBOTT:
    ld b, 22

UPPBOTT_LOOP
    ld (hl), c
    inc hl
    djnz UPPBOTT_LOOP
ret     ;Volvemos a la rutina principal.


CHKBRD_DRWLINE:
    ld (hl), 15
    inc hl

    ld b, 20

CHKBRD_DRWLP
    ld (hl), 255
    inc hl
    djnz CHKBRD_DRWLP

    ld (hl), 240
    inc hl
ret     ;Volvemos a la rutina principal.


CHKBRD_DRW2:
    ld (hl), 8
    inc hl
    inc hl
    ld (hl), 8
    ld de, 10
    add hl, de
    ld (hl), 8
    dec de
    add hl, de
    ld (hl), 16
ret     ;Volvemos a la rutina principal.


CHKBRD_DR2LP:
    call CHKBRD_DRW2
    ld de, 235
    add hl, de
    djnz CHKBRD_DR2LP
ret     ;Volvemos a la rutina principal.


;------------------------------- LABELS --------------------------------

CHKBRD_OUTCOL   equ 70      ;Amarillo - El color del recuadro exterior de la rejilla (código de atributo).
CHKBRD_EDITCOL  equ 66      ;Rojo - El color del recuadro exterior cuando se está en Edit mode.

EDIT_MODE       equ 62966   ;Aquí se guarda si el modo Edición está activado (0-Off, 1-On).
