	ORG 50000

MAIN	ld a, 2		;abrimos la pantalla superior
	call 5633

STRNL	ld de, STRNG	;escribimos las flechas (^^^^^^^^)
	ld bc, EOSTRNG-STRNG
	call 8252

	ld hl, 22748	;Coloreamos el bit 0 de amarillo
	ld (hl), 70

	ld b, 8		;Coloreamos las flechas
	ld hl, 23029

ARCOL	ld (hl), 66
	inc hl
	djnz ARCOL


;Text lines:
	
	ld de, 16823	;Text line 1
	ld hl, T_1
	ld bc, 4
	ldir

	ld de, 17079	;Text line 2
	ld hl, T_2
	ld bc, 5
	ldir

	ld de, 17335	;Text line 3
	ld hl, T_3
	ld bc, 5
	ldir

	ld de, 17591	;Text line 4
	ld hl, T_4
	ld bc, 5
	ldir

	ld de, 17847	;Text line 5
	ld hl, T_5
	ld bc, 5
	ldir

;Bit number lines:

	ld de, 16597	;Bit number line 1
	ld hl, B_1
	ld bc, 8
	ldir

	ld de, 16853	;Bit number line 2
	ld hl, B_2
	ld bc, 8
	ldir

	ld de, 17109	;Bit number line 3
	ld hl, B_3
	ld bc, 8
	ldir

	ld de, 17365	;Bit number line 4
	ld hl, B_4
	ld bc, 8
	ldir

	ld de, 17621	;Bit number line 5
	ld hl, B_5
	ld bc, 8
	ldir

;Decimal value lines:

	ld hl, 20501	;Decimal value line 1
	ld (hl), 124

	ld de, 20758	;Decimal value line 2
	ld hl, D_2
	ld bc, 3
	ldir

	ld de, 21013	;Decimal value line 3
	ld hl, D_3
	ld bc, 8
	ldir

	ld de, 21269	;Decimal value line 4
	ld hl, D_4
	ld bc, 8
	ldir

	ld de, 21525	;Decimal value line 5
	ld hl, D_5
	ld bc, 8
	ldir

	ld de, 21782	;Decimal value line 6
	ld hl, D_6
	ld bc, 3
	ldir

	ld de, 22037	;Decimal value line 7
	ld hl, D_7
	ld bc, 4
	ldir

	ld de, 22293	;Decimal value line 8
	ld hl, D_8
	ld bc, 4
	ldir

	ld hl, 20533	;Decimal value line 9
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

;Arrows:

STRNG	defb 22, 15, 21, "^^^^^^^^"
EOSTRNG	equ $

