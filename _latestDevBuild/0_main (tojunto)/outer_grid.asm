;===> Charset Explorer pre RC2 <===> 'outer_grid.asm' v1 (179 bytes) <===

;Aquí dibujamos el recuadro exterior de la rejilla y de las direcciones de memoria:
;Esta posición es 60570 (60686-116 bytes, desde el final de la rutina). RANDOMIZE USR 60570

    ;ORG 60352

;MAIN

;Primero coloreamos las partes donde se va a dibujar. Sólo usaremos el brillo.
;El color lo fijaremos con un INK n antes de llamar a esta rutina.

    ld a, 2                 ;Abrimos la pantalla superior.
    call 5633

    ld a, 19                ;BRIGHT 1.
    rst 16
    ld a, 1
    rst 16

    ld c, 6                 ;La posición del eje Y.
    ld d, 8                 ;La posición del eje X.

    call OUTGRD_POS         ;Nos posicionamos en la pantalla.
    call OUTGRD_LINE        ;Coloreamos la parte superior.
    inc c                   ;Incrementamos el eje Y.

    ld b, 8
OUTGRD_LP2
    call OUTGRD_PRNTSP

    ld d, 10
    call OUTGRD_PRNTSP
    ld d, 20
    call OUTGRD_PRNTSP
    ld d, 29
    call OUTGRD_PRNTSP

    inc c                   ;Incrementamos la línea (eje Y).
    ld d, 8                 ;Reseteamos la posición del eje X.
    djnz OUTGRD_LP2         ;Hacemos un bucle de 8 vueltas.

    call OUTGRD_POS         ;Nos posicionamos en la pantalla.
    call OUTGRD_LINE        ;Coloreamos la parte inferior.

;Ahora dibujamos la cuadrícula exterior:

    ld hl, 17608            ;Dibujamos la línea de la parte superior.
    call CHKBRD_DRWLINE

    ld hl, 19432
    call CHKBRD_DRWLINE     ;Ahora la línea inferior.

    ld hl, 17864            ;Ahora las líneas verticales. Primero acabamos el tercio superior.
    ld b, 3
    call CHKBRD_DR2LP

    ld hl, 16616
    ld b, 8
    call CHKBRD_DR2LP

    ld a, 7                 ;Y ahora continuamos con el segundo tercio de la pantalla.
    ld hl, 18440

CHKBRD_HYPLOOP              ;Hacemos un bucle mientras podamos.
    ld b, 8
    push hl
    call CHKBRD_DR2LP
    pop hl
    ld de, 32
    add hl, de
    dec a
    jr nz, CHKBRD_HYPLOOP

    ld hl, 18664            ;Y el resto lo acabamos aquí.
    ld b, 3
    call CHKBRD_DR2LP

	ld a, (OUTGRD_BINM)     ;Bin mode is on?
	cp 0
    jr z, OUTGRD_END        ;Si es que no, finalizamos la rutina.

    call BIN_ROUTINE

OUTGRD_END:
ret     ;Salimos de la rutina.


;------------------------------ SUBRUTINAS ------------------------------


CHKBRD_DR2LP:
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

    ld de, 235
    add hl, de
    djnz CHKBRD_DR2LP
ret     ;Volvemos al bucle principal.

;-----------------------

OUTGRD_PRNTSP:
    call OUTGRD_POS
    ld a, " "
    rst 16
ret     ;Volvemos a la rutina principal.

;-----------------------

CHKBRD_DRWLINE:             ;Dibuja una línea horizontal.
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

;-----------------------

OUTGRD_POS:
    ld a, 22        ;Comando AT del Basic.
    rst 16
    ld a, c         ;Posición eje Y.
    rst 16
    ld a, d         ;Posición eje X.
    rst 16
ret     ;Volvemos a la rutina principal.

;-----------------------

OUTGRD_LINE:
    ld b, 22
OUTGRD_LP
    ld a, " "
    rst 16
    djnz OUTGRD_LP
ret     ;Volvemos a la rutina principal.


;-------------------------------- LABELS --------------------------------


OUTGRD_BINM equ 62969   ;Modo Bin Off (0) / On (1) addr.
BIN_ROUTINE equ 62224   ;Dirección de la rutina 'outer_grid.asm'.