;===> Charset Explorer pre RC2 <===> 'bin_text.asm' v2 (376 bytes) <===

;Rutina que dibuja el marco (bit number, valor del bit, unas flachas, etc) del modo Binario.


    ;ORG 62224

;MAIN

	ld a, 2		;abrimos la pantalla superior
	call 5633

	ld de, STRNG	;escribimos las flechas (^^^^^^^^)
	ld bc, 11
	call 8252

	ld b, 5		;Coloreamos el texto
	ld hl, 22711
TEXCOL
	ld (hl), 5
	inc hl
	djnz TEXCOL

	ld b, 7		;Coloreamos los bit numbers
	ld hl, 22741
ROW_B
	ld (hl), 66
	inc hl
	djnz ROW_B

;	ld hl, 22748	;Coloreamos el bit 0 de amarillo
	ld (hl), 70

	ld b, 8		;Coloreamos las flechas
	ld hl, 23029
ARCOL
	ld (hl), 66
	inc hl
	djnz ARCOL

	ld b, 4		;Coloreamos los decimal values
	ld hl, 23061
ROW_D
	ld (hl), 69
	inc hl
	ld (hl), 5
	inc hl
	djnz ROW_D
	ld de, 24
	add hl, de
	ld (hl), 69

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

T_1	db 202,0,0,64
T_2	db 163,25,94,66,96
T_3	db 202,21,85,103,72
T_4	db 170,21,85,84,64
T_5	db 201,20,209,99,72

;Bit position numbers data:

B_1	db 56,56,56,40,56,56,48,56
B_2	db 8,32,32,40,8,8,16,40
B_3	db 16,56,56,56,24,56,16,40
B_4	db 16,40,8,8,8,32,16,40
B_5	db 215,187,187,235,187,187,187,187

;Decimal values data:

D_2	db 124,68,72
D_3	db 116,84,84,124,124,28,116,72
D_4	db 84,112,124,64,84,16,84,124
D_5	db 92,0,0,0,124,124,92,64
D_6	db 28,116,124
D_7	db 124,16,84,84
D_8	db 84,124,92,112

;Arrows:

STRNG	db 22, 15, 21, "^^^^^^^^"
