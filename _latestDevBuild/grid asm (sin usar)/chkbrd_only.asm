;Rutina original de @darrylsloan
;https://www.youtube.com/@darrylsloan
;Checkerboard with Attributes

;Esto es una modificación de la rutina original para
;hacer el checkerboard modificando el atributo BRIGHT
;en una cuadrícula de 8x8

	ORG 50000

MAIN	call 3503	;3545	;rutina CLS de la ROM
	ld hl, 22773	;Cargamos en HL la dirección 22773 (en medio de los atributos de pantalla)
	ld de, 24	;Cargamos 24 en DE
	ld a, 4		;Ponemos el acumulador (registro A) a 4
LOOP	ld b, 4
ROW1	ld (hl), 127
	inc hl
	ld (hl), 63
	inc hl
	djnz ROW1
	add hl,de	;Sumamos DE (24) a HL para posicionarlo al principio de la siguiente linea
	ld b, 4
ROW2	ld (hl), 63
	inc hl
	ld (hl), 127
	inc hl
	djnz ROW2
	add hl,de	;Sumamos DE (24) a HL para posicionarlo al principio de la siguiente linea
	dec a
	jr nz, LOOP

	ret	;salimos de la rutina

