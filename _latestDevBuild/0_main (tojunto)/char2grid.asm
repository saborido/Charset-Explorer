;Rutina para dibujar un carácter alojado en una
;posición de memoria en un grid de 8x8 chars.

;Primero cubrimos la rejilla con pixeles vacíos para
;borrar lo que ya hubiese, y luego dibujamos los
;píxeles sobre ella.

	;ORG 62022

;MAIN
	ld a, 2		;Abrimos la pantalla superior
	call 5633

;Configuramos los colores del dotted grid:

	ld a, 17	;Paper command.
	rst 16
	ld a, (PAPCOL_)	;Color del fondo.
	rst 16

	ld a, 16	;Dot ink color.
	rst 16
	ld a, (DOTCOL_) ;Dot color + 1.
	dec a		;Restamos 1 para obtener
	rst 16		;el color correcto.

	ld a, 19	;Ponemos el bright en 8.
	rst 16
	ld a, 8
	rst 16

;Comprobamos si el modo Binario está activado:

	call BIN_CHK	;Bin mode is on? If not,
	jr z, BINOFF	;avoid Bin mode.

;ZEROed grid (si el modo BIN esta ON):

	ld hl, GRBIN+1
	ld (hl), 7

LOOPB
	ld de, GRBIN	;Llenamos el byte con ceros.
	ld bc, EOGRBIN-GRBIN
	call 8252

	ld hl, GRBIN+1

	ld a, (hl)
	inc a
	ld (hl), a
	cp 15

	jr nz, LOOPB	;Hacemos loop si la fila no ha llegado a 15.
	ld hl, GRBIN+1

	jr JUMP	;Saltamos el BIN OFF.

;DOTted grid (si el modo BIN esta OFF):

BINOFF
	ld hl, GRID+1
	ld (hl), 7

LOOPA
	ld de, GRID	;Llenamos el byte con DOTS.
	ld bc, EOGRID-GRID
	call 8252

	ld hl, GRID+1
	ld a, (hl)
	inc a
	ld (hl), a
	cp 15

	jr nz, LOOPA	;Hacemos loop si la fila no ha llegado a 15.
	ld hl, GRID+1

;Configuramos el color de los píxeles ON:

JUMP
	ld a, 16
	rst 16

	ld a, (INKCOL_)	;Pixel ink color + 1.
	dec a		;Restamos 1 para obtener 
	rst 16		;el color correcto.


;;-------------- Char Grid Draw Start ---------------;

	ld hl, (CHADDR_) ;Copiamos el char en el
	ld de, CHR_BUF	;búfer, ya que lo vamos
	ld bc, 8 ;a ir modificando y no funcionaría
	ldir	;con la parte de la ROM.

	call POS_SCR	;Nos posicionamos en la rejilla.

	ld hl, CHR_BUF	;Cargamos en HL el char a dibujar.

LOOPF
	ld b, 8	;Loop de 8 rotaciones (left).

CHR_LD
	bit 7, (hl)	;comprobamos el bit 7 del byte
	jr z, DRW_ZRO	;si el flag Z es 0, se pasa de dibujar nada
	call nz, DRW_BIT ;si es un 1, dibujamos el pixel

JMP_ZRO
	rlc (hl)	;Rotamos hacia la izquierda.
	djnz CHR_LD	;Volvemos a comprobar...

	ld a, 21	  ;Reseteamos la posición de
	ld (POS_STR+2), a ;las columnas (eje x).

	ld a, (POS_STR+1) ;incrementamos la fila (eje y)
	inc a
	ld (POS_STR+1), a

	inc hl	;Incrementamos la fila y comprobamos
	cp 15	;si hemos llegado a la última fila
	jr nz, LOOPF	;de la rejilla.

;Reseteamos variables antes de salir de la rutina:

	ld hl, POS_STR+1 ;Reseteamos la posición
	ld (hl), 7	 ;de las filas (eje Y).

	ret	;Salimos de la rutina.


;;-------------------- Subrutinas --------------------;

DRW_ZRO
	call X_INC	;incrementamos el eje x
	jr JMP_ZRO	;Volvemos a la rutina principal.

DRW_BIT
	call POS_SCR	;Nos posicionamos en la rejilla.

	push bc
	call BIN_CHK	;Comprobamos el modo Binario.
	pop bc		;Si BIN mode es ON, saltamos
	jr nz, JMP_BIN	;a JMP_BIN a imprimir unos.

;Modo normal, imprime pixeles definidos con PIX_CHR:

	ld a, PIX_CHR	;Imprimimos el píxel
	rst 16		;(el modo Bin está OFF).

	jr X_INC	;Saltamos el modo Bin...

;Modo Binario, imprime unos:

JMP_BIN
	ld a, "1"
	rst 16

;Aquí hay que llamar a la rutina X_INC y después hacer
;un RET, pero como la tenemos a continuación...

X_INC
	ld a, (POS_STR+2)	;incrementamos el
	inc a			;eje x.
	ld (POS_STR+2), a

	ret	;Volvemos a la rutina principal.

BIN_CHK
	ld a, (BINMOD_)	;Bin mode is on?
	cp 0

	ret	;Volvemos a la rutina principal.

POS_SCR
	ld a, 22	;Comando AT (de PRINT AT)
	rst 16
	ld a, (POS_STR+1)	;eje y
	rst 16
	ld a, (POS_STR+2)	;eje x
	rst 16

	ret	;Volvemos a la rutina principal.


;;------------------ Datos y labels ------------------;

CHR_BUF
	db %00000000	;Copia del char a dibujar
	db %00000000	;en la rejilla.
	db %00000000
	db %00000000	;La copia es necesaria porque
	db %00000000	;vamos a ir rotando bits, y
	db %00000000	;no funcionaría con la parte
	db %00000000	;de la ROM.
	db %00000000

GRBIN	db 22, 7, 21, "00000000"
EOGRBIN	equ $

GRID	db 22, 7, 21, "........"
EOGRID	equ $

POS_STR	db 22, 7, 21	;Start position (AT 7,21)
EOPOS	equ $

CHADDR_	equ 62973	;Char Address.

PIX_CHR	equ 160		;Pixel char (udg Q).

BINMOD_	equ 62969	;Modo Bin Off(0)/On(1) addr.
PAPCOL_	equ 62970	;Paper color addr.
DOTCOL_	equ 62971	;Dots ink color+1 addr.
INKCOL_	equ 62972	;Pixel ink color+1 addr.
