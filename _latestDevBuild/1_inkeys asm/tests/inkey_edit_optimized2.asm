;=== Charset Explorer pre RC2 ===

;Esta rutina lee la tecla guardada en la variable del
;sistema LAST_K para comprobar si se han pulsado ciertas
;teclas, y devolver un número de línea que al retornar
;al BASIC (desde donde vamos a llamar a esta rutina),
;usaremos con un GO TO USR (dirección_de_la_rutina).

;Este es el código del menú de Edición.

	;ORG 62721
	ORG 50000

MAIN
	ld hl, KEY_	;Cargamos en HL donde apunta KEY_.
	ld de, LINE_	;Cargamos en DE donde apunta LINE_ (8 bits).

;Valores de 8 bits (¿esto se puede compratir...?):

	ld b, 25	;Configuramos un loop de 25 vueltas (porque hay 25 valores guardados tanto en KEY_ como en LINE_).

LOOP_
	ld a, (LAST_K)	;Cargamos en A la última tecla pulsada.
	cp (hl)		;La comparamos con KEY_ (registro HL).
	jr z, END_	;Si coincide, saltamos a JUMP_.

	inc hl		;Incrementamos KEY_ (HL), que guarda valores de 1 byte (8 bits).
	inc de		;Incremento de 8 bits.

	ld a, 5
	cp b
	jr c, INC_DE	;Evitamos un INC en caso 8 bits.

	djnz LOOP_	;Hacemos un loop para comprobar todas las teclas (son 4).

	ld bc, 0	;El resulado es 0 si no encuentra
	ret		;ninguna tecla y salimos de la rutina.

;-------------------- Subrutinas --------------------;

;Simulando "LD BC, (DE)":
;
;En esta pate de la rutina se carga en BC el valor contenido en LINE_ ó LINEW_.
;para que al volver al BASIC pueda usar el valor de LINE_ ó LINEW_.
;
;Muchas gracias al grupo de Ensamblador Z80
;de telegram por la ayuda.

END_	ld de, LINE_
	ex de, hl	;Esto conmuta los registros DE y HL.
	ld c, (hl)
	;ld a, 5
	;cp b
	ld b, 0
	jr c, INC_DE	;Evitamos C en caso 8 bits.

	ld b, (hl)

	ret	;Salimos de la rutina y volvemos al BASIC.

INC_DE
	inc de		;Incrementamos en caso de 16 bits.
	ret

;Labels y datos:

KEY_	db "ao6", 8, "dp7", 9, "ec", "w9", 11, "qz", "s8", 10, "R", 13, "EbOPQ"
LINE_	db 125,125,125,125, 130,130,130,130, 145,145, 135,135,135, 150,150, 140,140,140, 124, 201, 203
	dw 318, 319, 319, 810

LAST_K	equ 23560	;Variable del sistema LAST_K

