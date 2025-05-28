;===> Charset Explorer pre RC2 <===> 'char2grid.asm' v3 (444 bytes en total. 363 bytes sin INCLUDEs) <===

; Rutina para dibujar un car�cter alojado en una posici�n de memoria en un grid de 8x8 chars
;y listar las direcciones de memoria y los valores que contienen (tanto en decimal como en
;hexadecimal), juntoo a una evaluaci�n del tipo de dato que contiene cada una de las direccioones
;de memoria del char.

	;ORG 61292

;MAIN

    ld a, 2		        ;Abrimos la pantalla superior.
    call 5633

;----------------- EMPEZAMOS CON LA LISTA DE DIRECCIONES DE MEMORIA DEL CHAR Y SUS VALORES -----------------;

    ld hl, (CHADDR_)
    ld (ADDR_BUFF), hl  ;Guardamos HL en (ADDR_BUFF) para recuperarlo despu�s.

LOOPADR
    call POS_ADDR       ;Nos posicionamos en la pantalla.

    ;ld bc, (CHADDR_)    ;Para imprimir n�meros de 0 a 65535 (inclusives).
    ;call 11563          ; stack number in bc.
    ;call 11747          ; display top of calc. stack.

    call HEX_CHK
    jr nz, JMP_HEX

    call Int2String_16  ;Esto coje el n�mero de HL y lo pasa a un string de 5 chars (STR_BUFF).

    ld de, STR_BUFF  	;Leemos el string creado por Int2String_16.
    ld bc, 5
    call 8252           ;Imprimimos el string (una direcci�n de memoria)

    ld de, BLANK
    ld bc, 5
    call 8252
    ;ld a, 22
    ;rst 16
    ld a, (POS_STR)
    rst 16
    ld a, 17
    rst 16

    ld hl, (ADDR_BUFF)  ;Cargamos (ADDR_BUFF) en HL.

    ld b, 0             ;Imprimimos el valor que contiene la dir. de memoria del string anterior.
    ld c, (hl)
    call 6683           ;Con esto imprimimos un n�mero hasta 9999 (LD BC, number).

    jr JUMP2

JMP_HEX:
    ld a, "$"
    rst 16

    call Hex2String_16  ;Esto coje el n�mero de HL y lo pasa a un string de 5 chars (STR_BUFF).

    ld de, STR_BUFF  	;Leemos el string creado por Int2String_16.
    ld bc, 4
    call 8252           ;Imprimimos el string (una direcci�n de memoria)

    ld a, ","
    rst 16
    ld a, "$"
    rst 16

    ld hl, (ADDR_BUFF)  ;Cargamos (ADDR_BUFF) en HL.
    ld a, (hl)
    ld l, a

    call Hex2String_8
    ld de, STR_BUFF  	;Leemos el string creado por Int2String_16.
    ld bc, 2
    call 8252           ;Imprimimos el string (una direcci�n de memoria)
    ld hl, (ADDR_BUFF)  ;Cargamos (ADDR_BUFF) en HL.

JUMP2:
    inc hl              ;Incrementamos la direcci�n de memoria a la que apunta ADDR_BUFF.
    ld (ADDR_BUFF), hl  ;Guardamos HL en (ADDR_BUFF).

    call Y_INC          ;Incrementamos el eje Y.

    cp 15               ;Hacemos un bucle hasta completar las 8 filas que componen el char.
    jr nz, LOOPADR

    call RESET_POS      ;Reseteamos la posici�n de las filas (eje Y).


;------------------------------------- AQU� YA SEGUIMOS CON LA REJILLA -------------------------------------;

;Creamos y cubrimos la rejilla con pixeles vac�os para borrar lo que ya hubiese, y luego
;dibujamos los p�xeles sobre ella.

;Configuramos los colores del dotted grid:

    ld a, 17            ;Paper command.
    rst 16
    ld a, (PAPCOL_)     ;Color del fondo.
    rst 16

    ld a, 16            ;Dot ink color.
    rst 16
    ld a, (DOTCOL_)     ;Dot color + 1.
    dec a               ;Restamos 1 para obtener el color correcto.
    rst 16

    ld a, 19            ;Ponemos el bright en 8.
    rst 16
    ld a, 8
    rst 16

;Comprobamos si el modo Binario est� activado:

	call BIN_CHK        ;Bin mode is on? If not, avoid Bin mode.
	jr z, BINOFF

;ZEROed grid (si el modo BIN esta ON):

	ld hl, GRBIN+1
	ld (hl), 7

LOOPB
	ld de, GRBIN        ;Llenamos el byte con ceros.
	ld bc, 11
	call 8252

	ld hl, GRBIN+1

	ld a, (hl)
	inc a
	ld (hl), a
	cp 15

	jr nz, LOOPB        ;Hacemos loop si la fila no ha llegado a 15.
	ld hl, GRBIN+1

jr JUMP ;Saltamos el BIN OFF.

;DOTted grid (si el modo BIN esta OFF):

BINOFF:
	ld hl, GRID+1
	ld (hl), 7

LOOPA
	ld de, GRID     ;Llenamos el byte con DOTS.
	ld bc, 11
	call 8252

	ld hl, GRID+1
	ld a, (hl)
	inc a
	ld (hl), a
	cp 15

	jr nz, LOOPA    ;Hacemos loop si la fila no ha llegado a 15.
	ld hl, GRID+1

;Configuramos el color de los p�xeles ON:

JUMP:
    ld a, 16
    rst 16

    ld a, (INKCOL_)	;Pixel ink color + 1.
    dec a		;Restamos 1 para obtener el color correcto.
    rst 16

;;-------------- Char Grid Draw Start ---------------;

	ld hl, (CHADDR_) ;Copiamos el char en el
	ld de, CHR_BUFF	;b�fer, ya que lo vamos
	ld bc, 8 ;a ir modificando y no funcionar�a
	ldir	;con la parte de la ROM.

	call POS_SCR	;Nos posicionamos en la rejilla.

	ld hl, CHR_BUFF	;Cargamos en HL el char a dibujar.

LOOPF
    ld b, 8	;Loop de 8 rotaciones (left).

CHR_LD
    bit 7, (hl)	;Comprobamos el bit 7 del byte.
    jr z, DRW_ZRO    ;Si el flag Z es 0, no dibujamos nada.
    call nz, DRW_BIT ;Si es un 1, dibujamos el pixel.

JMP_ZRO:
    rlc (hl)	;Rotamos hacia la izquierda.
    djnz CHR_LD	;Volvemos a comprobar...

    ld a, 21    ;Reseteamos la posici�n de las columnas (eje x).
    ld (POS_STR+1), a

    call Y_INC

    inc hl  ; Incrementamos la fila y comprobamos si hemos llegado
    cp 15   ;a la �ltima fila de la rejilla.
    jr nz, LOOPF

;Reseteamos variables antes de salir de la rutina:

RESET_POS:
	ld a, 7         ;Reseteamos la posici�n de las filas (eje Y).
	ld (POS_STR), a
ret	;Salimos de la rutina.


;----------------------------------------------------- Subrutinas ------------------------------------------------------;

DRW_ZRO:
    call X_INC          ;incrementamos el eje x
jr JMP_ZRO              ;Volvemos a la rutina principal.

DRW_BIT:
    call POS_SCR        ;Nos posicionamos en la rejilla.
    push bc
    call BIN_CHK        ;Comprobamos el modo Binario.
    pop bc              ;Si BIN mode es ON, saltamos

    jr nz, JMP_BIN      ;Salto a JMP_BIN a imprimir unos.

;Modo normal, imprime pixeles definidos con PIX_CHR:

    ld a, PIX_CHR	;Imprimimos el p�xel
    rst 16		;(el modo Bin est� OFF).
jr X_INC	;Saltamos el modo Bin...

;Modo Binario, imprime unos:

JMP_BIN:
    ld a, "1"
    rst 16

    ;Aqu� hay que llamar a la rutina X_INC y despu�s hacer
    ;un RET, pero como la tenemos a continuaci�n...

X_INC:
	ld a, (POS_STR+1)   ;incrementamos el
	inc a               ;eje x.
	ld (POS_STR+1), a
ret ;Volvemos a la rutina principal.

Y_INC:          ;incrementamos la fila (eje y)
    ld a, (POS_STR)
    inc a
    ld (POS_STR), a
ret ;Volvemos a la rutina principal.

BIN_CHK:
	ld a, (BINMOD_)	;Bin mode is on?
	cp 0
ret	;Volvemos a la rutina principal.

HEX_CHK:
	ld a, (HEXMOD_)	;Hex mode is on?
	cp 0
ret	;Volvemos a la rutina principal.

POS_SCR:        ;Posici�n de la rejilla.
    ld a, 22    ;Comando AT (de PRINT AT)
    rst 16

    ld a, (POS_STR)	;eje y
    rst 16

    ld a, (POS_STR+1)	;eje x
    rst 16
ret	;Volvemos a la rutina principal.

POS_ADDR:       ;Posici�n de las direcciones de memoria.
    ld a, 22    ;Comando AT (de PRINT AT)
    rst 16

    ld a, (POS_STR) ;eje y
    rst 16

    ld a, 11        ;eje x
    rst 16
ret	;Volvemos a la rutina principal.

    INCLUDE "_Int2Str.asm"
    INCLUDE "_Hex2Str.asm"

;;---------------------- Datos -----------------------;

CHR_BUFF        ;Copia del char a dibujar en la rejilla (8 bytes). Abarca hasta el final de ADDR_BUFF.
	db 255
STR_BUFF        ;Aprovechamos para guardar el string de texto (5 bytes).
    db 255, 255, 255, 255, 255
ADDR_BUFF       ;Aqu� guardamos la address memory del char (16 bit address, 2 bytes).
	dw 65535

POS_STR	db 7, 21	;Grid & addresses start position (AT 7,21)
BLANK   db ",   ", 22
GRBIN	db 22, 7, 21, "00000000"
GRID	db 22, 7, 21, "........"

;;---------------------- labels ----------------------;

CHADDR_	equ 62973	;Char Address. Contiene la direcci�n de memoria del char a dibujar.
PIX_CHR	equ 160		;Pixel char (UDG 'Q'). El car�cter del p�xel encendido.

HEXMOD_ equ 62968   ;Modo Hex Off (0) / On (1) addr.
BINMOD_	equ 62969	;Modo Bin Off (0) / On (1) addr.

PAPCOL_	equ 62970	;Paper color addr.
DOTCOL_	equ 62971	;Dots ink color+1 addr.
INKCOL_	equ 62972	;Pixel ink color+1 addr.
