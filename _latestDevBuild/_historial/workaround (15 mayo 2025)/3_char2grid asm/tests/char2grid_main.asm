;Rutina para dibujar un car�cter alojado en una
;posici�n de memoria en un grid de 8x8 chars.

;Primero cubrimos la rejilla con dots vac�os para
;borrar lo que ya hubiese, y luego dibujamos los
;p�xeles sobre ella.

	ORG 50000

;----------------------------------------------
;----------- Checkerboard start ---------------
;----------------------------------------------

MAIN	ld hl, 22773	;Cargamos en HL la direcci�n 22773 (en medio de los atributos de pantalla)
	ld de, 24	;Cargamos 24 en DE
	ld a, 4		;Ponemos el acumulador (registro A) a 4

LOOPG	ld b, 4
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
	jr nz, LOOPG

;----------------------------------------------
;------------- Checkerboard end ---------------
;----------------------------------------------

	;ORG 62069

;MAIN
	ld a, 2		;Abrimos la pantalla superior
	call 5633

;Configuramos los colores del dotted grid:

	ld a, 17	;Paper color
	rst 16
	ld a, (PAPCOL_)	;color del fondo
	rst 16

	ld a, 16	;Dot ink color
	rst 16
	ld bc, (DOTCOL_) ;Dot color + 1
	ld a, c
	cp 0		;Si el color es 0 saltamos el -1
	jr z, JMPUNO
	dec c		;restamos 1 para obtener el color correcto
JMPUNO	ld a, c		;color de los dots
	rst 16

	ld a, 19	;ponemos el bright en 8
	rst 16
	ld a, 8
	rst 16

;Comprobamos si el modo Binario est� activado:

	call BIN_CHK

	;ld bc, (BINMOD_) ;Bin mode is on?
	;ld a, c
	;cp 0		;Si la respuesta es no,
	jr z, BINOFF	;pasamos del modo binario.

;ZEROed grid (si el modo BIN esta ON):

	ld hl, GRBIN+1
	ld (hl), 7

LOOPB	ld de, GRBIN	;Lo llenamos t� de ceros.
	ld bc, EOGRBIN-GRBIN
	call 8252
	ld hl, GRBIN+1
	ld a, (hl)
	inc a
	ld (hl), a
	cp 15
	jr nz, LOOPB
	ld hl, GRBIN+1

	jr JUMP	;Saltamos el BIN OFF.

;DOTted grid (si el modo BIN esta OFF):

BINOFF	ld hl, GRID+1
	ld (hl), 7

LOOPA	ld de, GRID	;Llenamos el byte con DOTS.
	ld bc, EOGRID-GRID
	call 8252

	ld hl, GRID+1
	ld a, (hl)
	inc a
	ld (hl), a
	cp 15
	jr nz, LOOPA
	ld hl, GRID+1

;Configuramos el color de los p�xeles ON:

JUMP	ld a, 16
	rst 16

	ld bc, (INKCOL_);Pixel ink color + 1
	ld a,c
	cp 0		;si el color es 0 saltamos el -1
	jr z, JMPDOS
	dec c		;restamos 1 para obtener el color correcto

JMPDOS	ld a,c		;color de los pixeles
	rst 16


;-------------- Char Grid Draw Start ---------------;

	ld hl, _CHADDR	;Copiamos el char en el
	ld de, CHR_BUF	;b�fer, ya que lo vamos
	ld bc, 8 ;a ir modificando y no funcionar�a
	ldir	;con la parte de la ROM.

;Nos posicionamos en la rejilla:

	call POS_SCR

	;ld de, POS_STR	;Start position of the grid.
	;ld bc, EOPOS-POS_STR
	;call 8252

	ld hl, CHR_BUF	;Cargamos en HL el char a dibujar.

LOOPF	ld b, 8	;Loop de 8 rotaciones (left).

CHR_LD	bit 7, (hl)	;comprobamos el bit 7 del byte
	jr z, DRW_ZRO	;si el flag Z es 0, se pasa de dibujar nada
	call nz, DRW_BIT ;si es un 1, dibujamos el pixel

JMP_ZRO	rlc (hl)	;Rotamos hacia la izquierda.
	djnz CHR_LD	;Volvemos a comprobar...

	ld a, 21	  ;Reseteamos la posici�n de
	ld (POS_STR+2), a ;las columnas (eje x).

	ld a, (POS_STR+1) ;incrementamos la fila (eje y)
	inc a
	ld (POS_STR+1), a

	inc hl	;Incrementamos la fila y comprobamos
	cp 15	;si hemos llegado a la �ltima fila
	jr nz, LOOPF	;de la rejilla.

;Reseteamos variables antes de salir de la rutina:

	ld hl, POS_STR+1 ;Reseteamos la posici�n
	ld (hl), 7	 ;de las filas (eje Y).

	ret	;Salimos de la rutina.


;-------------------- Subrutinas --------------------;

DRW_ZRO	call X_INC	;incrementamos el eje x
	jr JMP_ZRO	;Volvemos a la rutina principal.

DRW_BIT	call POS_SCR

	;ld a, 22	;Comando AT (de PRINT AT)
	;rst 16
	;ld a, (POS_STR+1)	;eje y
	;rst 16
	;ld a, (POS_STR+2)	;eje x
	;rst 16

	push bc
	call BIN_CHK	;Comprobamos el modo Binario.
	pop bc		;Si BIN mode es ON, saltamos
	jr nz, JMP_BIN	;a JMP_BIN a imprimir unos.

;Modo normal, imprime pixeles definidos con PIX_CHR:

	ld a, PIX_CHR	;Imprimimos el p�xel
	rst 16		;(el modo Bin est� OFF).

	jr X_INC	;Saltamos el modo Bin...

;Modo Binario, imprime unos:

JMP_BIN	ld a, "1"
	rst 16

;Aqu� hay que llamar a la rutina X_INC y despu�s hacer
;un RET, pero como la tenemos a continuaci�n...

X_INC	;push hl
	ld a, (POS_STR+2)	;incrementamos el
	inc a			;eje x.
	ld (POS_STR+2), a
	;pop hl

	ret	;Volvemos a la rutina principal.

BIN_CHK	ld bc, (BINMOD_) ;Bin mode is on?
	ld a, c
	cp 0

	ret	;Volvemos a la rutina principal.

POS_SCR	ld a, 22	;Comando AT (de PRINT AT)
	rst 16
	ld a, (POS_STR+1)	;eje y
	rst 16
	ld a, (POS_STR+2)	;eje x
	rst 16

	ret	;Volvemos a la rutina principal.


;------------------ Datos y labels ------------------;

GRBIN	defb 22, 7, 21, "00000000"
EOGRBIN	equ $

GRID	defb 22, 7, 21, "........"
EOGRID	equ $

BINMOD_	equ 62969	;Modo Bin Off(0)/On(1) addr.
PAPCOL_	equ 62970	;Paper color addr.
DOTCOL_	equ 62971	;Dots ink color+1 addr.
INKCOL_	equ 62972	;Pixel ink color+1 addr.

_CHADDR	equ 65368	;Char Address.

PIX_CHR	equ 143		;Pixel char (udg A).

POS_STR	defb 22, 7, 21	;Start position (AT 7,21)
EOPOS	equ $

CHR_BUF	db %00000000	;Copia del char a dibujar
	db %00000000	;en la rejilla.
	db %00000000
	db %00000000	;La copia es necesaria porque
	db %00000000	;vamos a ir rotando bits, y
	db %00000000	;no funcionar�a con la parte
	db %00000000	;de la ROM.
	db %00000000

