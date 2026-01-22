;===> Charset Explorer pre RC2 <===> 'checkboard.asm' v2 (34 bytes) <===

;Checkerboard with Attributes:
;Rutina original de @darrylsloan --> https://www.youtube.com/@darrylsloan

;Esto es una modificación de la rutina original para hacer un checkerboard
;modificando el brillo de los atributos (una cuadrícula de 8x8).

	ORG 50000

MAIN
	ld hl, 22773	;Cargamos en HL la dirección 22773 (en medio de los atributos de pantalla)
	ld de, 24	;Cargamos 24 en DE
	ld a, 4		;Ponemos el acumulador (registro A) a 4

LOOP
	ld b, 4
ROW1
	ld (hl), 64
	inc hl
	ld (hl), 0
	inc hl
	djnz ROW1

	add hl, de	;Sumamos DE (24) a HL para posicionarlo al principio de la siguiente linea.

	ld b, 4
ROW2
	ld (hl), 0
	inc hl
	ld (hl), 64
	inc hl
	djnz ROW2

	add hl, de	;Nos posicionamos al principio de la siguiente linea.
	dec a
	jr nz, LOOP

	ret	;salimos de la rutina

