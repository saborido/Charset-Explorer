	ORG 50000

MAIN	ld a, 2		;abrimos la pantalla superior
	call 5633
	
	ld hl, GRID+1
	ld (hl), 7

LOOP	ld de, GRID
	ld bc, EOGRID-GRID
	call 8252
	ld hl, GRID+1
	ld a, (hl)
	inc a
	ld (hl), a
	cp 15
	jr nz, LOOP
	ld hl, GRID+1

	ret	;Salimos de la rutina

GRID	defb 22, 7, 21, 19, 8, "........"
EOGRID	equ $
