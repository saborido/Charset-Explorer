;=== Charset Explorer pre RC2 ===
;
;Esta rutina lee la tecla guardada en la variable del
;sistema LAST_K para comprobar si se han pulsado ciertas
;teclas, y devolver un número de línea que al retornar
;al BASIC (desde donde vamos a llamar a esta rutina),
;usaremos con un GO TO USR (dirección_de_la_rutina).

;Este es el código del menú de Save/load.

	ORG 62903

MAIN
	ld de, LINE_	;Cargamos en DE donde apunta LINE_.
	ld hl, KEY_	;Cargamos en HL donde apunta KEY_.

	ld b, 10	;Configuramos un loop de 10 vueltas (porque hay 10 valores guardados tanto en KEY_ como en LINE_).
LOOP_
	ld a, (LAST_K)	;Cargamos en A la última tecla pulsada.
	cp (hl)		;La comparamos con KEY_ (registro HL).
	jr z, END_	;Si coincide, saltamos a JUMP_.

	inc hl		;Incrementamos KEY_ (HL), que guarda valores de 1 byte (8 bits).
	inc de		;Incrementamos LINE_ (DE) dos veces, porque guarda valores
	inc de		;de 2 bytes (16 bit), y la instrucción INC incrementa sólo 1 byte.

	djnz LOOP_	;Hacemos un loop para comprobar todas las teclas (son 10).

	ld bc, 0	;El resulado es 0 si no encuentra
	ret		;ninguna tecla y salimos de la rutina.

;Labels y datos:

KEY_	db "rwmt12456Q"	;10 teclas a comprobar con un loop. Abajo sus 10 correspondientes saltos de línea.
LINE_	dw 2740, 2740, 2783, 2750, 2570, 2580, 2610, 2650, 2690, 805	;Números de línea, al que le haremos un GO TO en BASIC.

LAST_K	equ 23560	;Variable del Sistema LAST_K.
END_	equ 62956	;Dirección de inkey_shared.

