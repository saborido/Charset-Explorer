;Rutina original de @darrylsloan
;https://www.youtube.com/@darrylsloan
;Checkerboard with Attributes

;Esto es una modificación de la rutina original para
;hacer el checkerboard modificando el atributo BRIGHT
;en una cuadrícula de 8x8

	ORG 50000
	;ORG 62262

MAIN	ld a, 71
	ld bc,(_PAPER)
	ld b, c		;Aqui va _PAPER
	rl b
	rl b
	rl b
	add a,b
	ld c,a

	ld hl, 22773	;Cargamos en HL la dirección 22773 (pantalla)
	ld de, 24	;Cargamos 24 en DE
	ld a, 4		;Ponemos el acumulador (registro A) a 4

LOOP	ld b, 4
	push af

	ld a,c
	sub 64

ROW1	ld (hl), c
	inc hl
;	push af
;	ld a,c
;	sub 64
	ld (hl), a
;	pop af
	inc hl
	djnz ROW1
	add hl,de	;Sumamos DE (24) a HL para siguiente linea
	ld b, 4

ROW2	ld (hl), a
	inc hl
	ld (hl), c
	inc hl
	djnz ROW2
	pop af
	add hl,de	;Sumamos DE (24) a HL para siguiente linea
	dec a
	jr nz, LOOP

	ret	;salimos de la rutina

_PAPER	equ 62970	;Color del paper guardado en 62970

