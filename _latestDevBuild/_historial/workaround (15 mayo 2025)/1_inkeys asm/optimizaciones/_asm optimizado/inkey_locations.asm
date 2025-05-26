;=== Charset Explorer pre RC2 ===

;Esta rutina lee la tecla guardada en la variable del
;sistema LAST_K para comprobar si se han pulsado ciertas
;teclas, y devolver un número de línea que al retornar
;al BASIC (desde donde vamos a llamar a esta rutina),
;usaremos con un GO TO USR (dirección_de_la_rutina).

;Este es el código del menú de Useful Locations.

	ORG 62600
MAIN
	ld de, ADDR_	;Cargamos en DE donde apunta LINE_.
	ld hl, KEY_	;Cargamos en HL donde apunta KEY_.

	ld b, 18	;Configuramos un loop de 18 vueltas (porque hay 25 valores guardados tanto en KEY_ como en LINE_).
LOOP_
	ld a, (LAST_K)	;Cargamos en A la última tecla pulsada.
	cp (hl)		;La comparamos con KEY_ (registro HL).
	jp z, END_	;Si coincide, saltamos a JUMP_.

	inc hl		;Incrementamos KEY_ (HL).
	inc de		;Incrementamos LINE_ (DE) dos veces, porque guardamos valores
	inc de		;de 2 bytes (16 bits).

	djnz LOOP_	;Comprobamos todas las teclas.

	ld bc, 0	;El resulado es 0 si no encuentra
	ret		;ninguna tecla y salimos de la rutina.

;Labels y datos:

KEY_	db  "u",  "r",  "R",  "a",  "A",  "b",  "B",  "c",  "C",  "1",  "2",  "3",  "4",  "5",  "6",  "7",  "8",  "9"
ADDR_	dw 65368,15616,16376,63064,63824,63832,64592,64600,65360,16384,18432,20480,22528,23296,25200,56000,62968,63040

LAST_K	equ 23560	;Variable del sistema LAST_K
END_	equ 62956	;Dirección de inkey_shared.

