;20 bytes total de la rutina.

;=== Charset Explorer pre RC2 ===

;Esta rutina lee la tecla guardada en la variable del
;sistema LAST_K para comprobar si se han pulsado ciertas
;teclas, y devolver un número de línea que al retornar
;al BASIC (desde donde vamos a llamar a esta rutina),
;usaremos con un GO TO USR (dirección_de_la_rutina).

;Uso:

;Cargamos en B el número de vueltas del loop,
;cargamos en HL la dirección de KEYS_,
;cargamos en DE la dirección de LINES_,
;y llamamos a esta rutina.

	ORG 62941

MAIN
	ld a, (LAST_K)	;Cargamos en A la última tecla pulsada.
	cp (hl)		;La comparamos con KEY_ (registro HL).
	jr z, END_	;Si coincide, saltamos a JUMP_.

	inc hl		;Incrementamos KEYS_ (HL).
	inc de		;Incrementamos LINES_ (DE) dos veces, porque guardamos valores
	inc de		;de 2 bytes (16 bits).

	djnz MAIN	;Comprobamos todas las teclas.

	ld bc, 0	;El resulado es 0 si no encuentra
	ret		;ninguna tecla y salimos de la rutina.

;Simulando "LD BC, (DE)":

;En esta parte de la rutina se carga en BC el valor contenido en
;LINE_ (DE) para que al volver al BASIC pueda trabajar con el.

;Muchas gracias al grupo de Ensamblador Z80
;de telegram por la ayuda.

END_
	ex de, hl
	ld c, (hl)
	inc hl
	ld b, (hl)

	ret	;Salimos de la rutina y volvemos al BASIC.

LAST_K	equ 23560	;Variable del Sistema LAST_K.
