;Usamos la instrucción del microprocesador Z80 del ZX Spectrum LDIR, que copia datos de una parte de la memoria a otra.
;Esta instrucción se usa cargando la dirección de memoria Origen (donde se empezará a copiar los datos) en el registro HL,
;cargando la dirección de memoria de Destino en el registro DE, y la longitud de los bytes a copiar se cargan en el
;registro BC, y entonces se llama la instrucción LDIR para que copie los datos. Hay que tener en cuenta que esta
;instrucción modifica varios registros, por si teníamos pensado trabajar con esos registros después de ejecutar una
;instrucción LDIR

	org 50000

;Draw 1 lines:

	;line 1

	ld de, 16823
	ld hl, T_1
	ld bc, 4
	ldir

	;line 2

	ld de, 17079
	ld hl, T_2
	ld bc, 5
	ldir

	;line 3

	ld de, 17335
	ld hl, T_3
	ld bc, 5
	ldir

	;line 4

	ld de, 17591
	ld hl, T_4
	ld bc, 5
	ldir

	;line 5

	ld de, 17847
	ld hl, T_5
	ld bc, 5
	ldir

;Draw 2 lines:

	;line 1

	ld de, 16597
	ld hl, B_1
	ld bc, 8
	ldir

	;line 2

	ld de, 16853
	ld hl, B_2
	ld bc, 8
	ldir

	;line 3

	ld de, 17109
	ld hl, B_3
	ld bc, 8
	ldir

	;line 4

	ld de, 17365
	ld hl, B_4
	ld bc, 8
	ldir

	;line 5

	ld de, 17621
	ld hl, B_5
	ld bc, 8
	ldir

;Draw 3 lines:

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

	ret	;salimos de la rutina


;LDIR origin data:

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
