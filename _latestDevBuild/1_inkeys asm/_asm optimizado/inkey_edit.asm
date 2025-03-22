;=== Charset Explorer pre RC2 ===

;Esta rutina lee la tecla guardada en la variable del
;sistema LAST_K para comprobar si se han pulsado ciertas
;teclas, y devolver un número de línea que al retornar
;al BASIC (desde donde vamos a llamar a esta rutina),
;usaremos con un GO TO USR (dirección_de_la_rutina).

;Este es el código del menú de Edición.

	ORG 62804

MAIN
	ld de, LINE_	;Cargamos en DE donde apunta LINE_.
	ld hl, KEY_	;Cargamos en HL donde apunta KEY_.

	ld b, 27	;Configuramos un loop de 27 vueltas (porque hay 27 valores guardados tanto en KEY_ como en LINE_).
LOOP_
	ld a, (LAST_K)	;Cargamos en A la última tecla pulsada.
	cp (hl)		;La comparamos con KEY_ (registro HL).
	jp z, END_	;Si coincide, saltamos a JUMP_.

	inc hl		;Incrementamos KEY_ (HL), que guarda valores de 1 byte (8 bits).
	inc de		;Incrementamos LINE_ (DE) dos veces, porque guarda valores
	inc de		;de 2 bytes (16 bit), y la instrucción INC incrementa sólo 1 byte.

	djnz LOOP_	;Hacemos un loop para comprobar todas las teclas.

	ld bc, 0	;El resulado es 0 si no encuentra
	ret		;ninguna tecla y salimos de la rutina.

;Labels y datos:

KEY_	db    "ao6",8, 		    "dp7",9,	  "ec", 	"w9",11,    "qz",    "s8",10, 	  "OP",    "Rb",   13,   "EQ+G"
LINE_	dw 125,125,125,125, 130,130,130,130, 145,145, 135,135,135, 150,150, 140,140,140, 319,319, 124,318, 201, 203,810,2235,2240

LAST_K	equ 23560	;Variable del sistema LAST_K
END_	equ 62956	;Dirección de inkey_shared.

