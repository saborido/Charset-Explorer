	ORG 50000

;----------------------------------------------
;----------- Checkerboard start ---------------
;----------------------------------------------

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

;----------------------------------------------
;------------- Checkerboard end ---------------
;----------------------------------------------

	ld a, 2		;abrimos la pantalla superior
	call 5633

;Char draw start:

_CHADDR	equ 65368	;Char Address
;_UNOINK	defb 3
;_ZROINK	defb 1

;Start position of grid (7,21):

	ld hl, _CHADDR

LOOPF	ld de, POS_STR
	ld bc, EOPOS-POS_STR
	call 8252

	ld b, 8
CHR_LD	
	bit 7, (hl)
	call z, DRW_BIT

	ld a, (hl)
	cpl
	ld (hl), a

	bit 7, (hl)
	call z, DRW_ZRO

	ld a, (hl)
	cpl
	ld (hl), a

	rlc (hl)
	djnz CHR_LD

	push hl
	ld hl, POS_STR+3
	ld a, (hl)
	inc a
	ld (hl), a
	pop hl

	inc hl
	cp 15
	jr nz, LOOPF

;	ld hl, POS_STR+3
;	ld (hl), 7

	ret	;salimos de la rutina


DRW_BIT	ld a, "."
	rst 16
	ret

DRW_ZRO	ld a, 143
	rst 16
	ret

;Start position:

POS_STR	defb 19, 8, 22, 7, 21
EOPOS	equ $

