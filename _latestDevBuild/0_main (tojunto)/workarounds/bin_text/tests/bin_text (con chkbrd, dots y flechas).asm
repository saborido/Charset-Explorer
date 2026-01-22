	ORG 50000

MAIN	call 3503	;3545	;rutina CLS de la ROM
	ld hl, 22773	;Cargamos en HL la dirección 22773 (en medio de los atributos de pantalla)
	ld de, 24	;Cargamos 24 en DE
	ld a, 4		;Ponemos el acumulador (registro A) a 4
LOOP2	ld b, 4
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
	jr nz, LOOP2

	ld hl, GRID+1
	ld (hl), 7

	ld a, 2
	call 5633
LOOP	ld de, GRID
	ld bc, EOGRID-GRID
	call 8252
	ld hl, GRID+1
	ld a, (hl)
	inc a
	ld (hl), a
	cp 15
	jr nz, LOOP

;Escribimos las flechas (^^^^^^^^):

	ld de, ARSTR
	ld bc, EOARSTR-ARSTR
	call 8252

;Coloreamos las flechas:

	ld b, 8
	ld hl, 23029
ARCOL	ld (hl), 66
	inc hl
	djnz ARCOL

;Coloreamos el texto:

	ld b, 5
	ld hl, 22711

ROW_T	ld (hl), 5
	inc hl
	djnz ROW_T

;Coloreamos los bit numbers:

	ld b, 7
	ld hl, 22741

ROW_B	ld (hl), 66
	inc hl
	djnz ROW_B

	ld (hl), 70

;Coloreamos los decimal values:

	ld b, 4
	ld hl, 23061

ROW_D	ld (hl), 69
	inc hl
	ld (hl), 5
	inc hl
	djnz ROW_D

	ld de, 24
	add hl, de
	ld (hl), 69

	;Text line 1

	ld de, 16823
	ld hl, T_1
	ld bc, 4
	ldir

	;Text line 2

	ld de, 17079
	ld hl, T_2
	ld bc, 5
	ldir

	;Text line 3

	ld de, 17335
	ld hl, T_3
	ld bc, 5
	ldir

	;Text line 4

	ld de, 17591
	ld hl, T_4
	ld bc, 5
	ldir

	;Text line 5

	ld de, 17847
	ld hl, T_5
	ld bc, 5
	ldir

;Bit number lines:

	;Bit number line 1

	ld de, 16597
	ld hl, B_1
	ld bc, 8
	ldir

	;Bit number line 2

	ld de, 16853
	ld hl, B_2
	ld bc, 8
	ldir

	;Bit number line 3

	ld de, 17109
	ld hl, B_3
	ld bc, 8
	ldir

	;Bit number line 4

	ld de, 17365
	ld hl, B_4
	ld bc, 8
	ldir

	;Bit number line 5

	ld de, 17621
	ld hl, B_5
	ld bc, 8
	ldir

;Decimal value lines:

	;Decimal value line 1

	ld hl, 20501
	ld (hl), 124

	;Decimal value line 2

	ld de, 20758
	ld hl, D_2
	ld bc, 3
	ldir

	;Decimal value line 3

	ld de, 21013
	ld hl, D_3
	ld bc, 8
	ldir

	;Decimal value line 4

	ld de, 21269
	ld hl, D_4
	ld bc, 8
	ldir

	;Decimal value line 5

	ld de, 21525
	ld hl, D_5
	ld bc, 8
	ldir

	;Decimal value line 6

	ld de, 21782
	ld hl, D_6
	ld bc, 3
	ldir

	;Decimal value line 7

	ld de, 22037
	ld hl, D_7
	ld bc, 4
	ldir

	;Decimal value line 8

	ld de, 22293
	ld hl, D_8
	ld bc, 4
	ldir

	;Decimal value line 9

	ld hl, 20533
	ld (hl), 124

	ret	;salimos de la rutina


;'Bit number:' text data:

T_1	defb 202,0,0,64
T_2	defb 163,25,94,66,96
T_3	defb 202,21,85,103,72
T_4	defb 170,21,85,84,64
T_5	defb 201,20,209,99,72

;Bit position numbers data:

B_1	defb 56,56,56,40,56,56,48,56
B_2	defb 8,32,32,40,8,8,16,40
B_3	defb 16,56,56,56,24,56,16,40
B_4	defb 16,40,8,8,8,32,16,40
B_5	defb 215,187,187,235,187,187,187,187

;Decimal values data:

D_2	defb 124,68,72
D_3	defb 116,84,84,124,124,28,116,72
D_4	defb 84,112,124,64,84,16,84,124
D_5	defb 92,0,0,0,124,124,92,64
D_6	defb 28,116,124
D_7	defb 124,16,84,84
D_8	defb 84,124,92,112

;Dots (empty grid):

GRID	defb 22, 7, 21, 19, 8, "........"
EOGRID	equ $

;Arrows:

ARSTR	defb 22, 15, 21, "^^^^^^^^"
EOARSTR	equ $

