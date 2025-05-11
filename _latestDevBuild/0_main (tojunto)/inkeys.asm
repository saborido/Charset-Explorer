;===> Charset Explorer pre RC2 <===> inkeys.asm v2 (333 bytes) <===

;Esta rutina lee la tecla guardada en la variable del
;sistema LAST_K para comprobar si se han pulsado ciertas
;teclas, y devolver un número de línea que al retornar
;al BASIC (desde donde vamos a llamar a esta rutina), que
;usaremos con un GO TO USR (dirección_de_la_rutina).

; Uso:

;Cargamos en B el número de teclas a comprobar,
;cargamos en HL la dirección de KEYS_,
;cargamos en DE la dirección de LINES_,

	;ORG 62628

;----------------- Rutinas principales [40 bytes] -----------------;

;MAIN

;=== RUTINA INKEY_SAVE [USR 62628] === 0 bytes (ORG +0).
	ld b, 10        ;Cargamos el número de elementos en la tabla.
	ld hl, SAVEK_
	ld de, SAVEL_
	jr LOOP_

;=== RUTINA INKEY_EDIT [USR 62638] === +10 bytes (ORG +10).
	ld b, 27
	ld hl, EDITK_
	ld de, EDITL_
	jr LOOP_

;=== RUTINA INKEY_MAIN [USR 62648] === +10 bytes (ORG +20).
	ld b, 36
	ld hl, MAINK_
	ld de, MAINL_
	jr LOOP_

;=== RUTINA INKEY_LOCATIONS [USR 62658] === +10 bytes (ORG +30).
	ld b, 18
	ld hl, LOCATK_
	ld de, LOCATA_
	jr LOOP_

;------------------- FIN de rutinas principales -------------------;

;---------------- Subrutina compartida [20 bytes] -----------------;

LOOP_
	ld a, (LAST_K)	;Cargamos en A la última tecla pulsada.
	cp (hl)		;La comparamos con KEY_ (HL).
	jr z, END_	;Si coincide, saltamos a END_.

	inc hl		;Incrementamos KEYS_ (HL), que guarda las teclas a comprobar.
	inc de		;Incrementamos LINES_ (DE) dos veces (las líneas son valores
	inc de		;de 16 bits).

	djnz LOOP_	;Comprobammos el resto de las teclas.

	ld bc, 0	;El resulado es 0 si no encuentra
	ret	;ninguna tecla y salimos de la rutina.

;Simulando "LD BC, (DE)":

;En esta parte de la rutina se carga en BC el valor contenido en
;LINES_ (DE) para que al volver al BASIC se pueda trabajar con el.

;Muchas gracias al grupo de Ensamblador Z80
;de telegram por la ayuda.

END_
	ex de, hl	;Escribimos en BC el resultado
	ld c, (hl)	;para que lo devuelva en el BASIC.
	inc hl
	ld b, (hl)

	ret	;Salimos de la rutina y volvemos al BASIC.

;------------------- FIN de subrutina compartida -------------------;

;--------------- Datos (teclas y líneas) [273 bytes] ---------------;

;30 bytes de datos del SAVE menu:
SAVEK_	db "rwmt12456Q" ;10 teclas.
SAVEL_	dw 2740, 2740, 2783, 2750, 2570, 2580, 2610, 2650, 2690, 805

;81 bytes de datos del EDIT menu:
EDITK_	db "ao6",8,"dp7",9,"ecw9",11,"qzs8",10,"OPRb",13,"EQ+G" ;27 teclas
EDITL_	dw 125,125,125,125,130,130,130,130,145,145,135,135,135,150,150,140,140,140,319,319,124,318,201,203,810,2235,2240

;108 bytes de datos del MAIN menu:
MAINK_	db "o",8,"p",9,"s",10,"w",11,"KIOPikqWaSldALhrbHR/:",96,"+G.mMQ" ;36 teclas
MAINL_	dw 570,570,575,575,580,580,583,583,531,530,540,545,536,533,565,560,555,550,1430,7250,2500,2500,1300,590,14,7450,27,3500,3500,3500,2235,2240,480,410,430,810

;54 bytes de datos de Useful Locations menu:
LOCATK_	db "urRaAbBcC123456789" ;18 teclas.
LOCATA_	dw 65368,15616,16136,63064,63584,63832,64352,64600,65120,16384,18432,20480,22528,23296,25200,53000,62016,62960 ;En este caso se devuelve una dirección de memoria.

;<=== Labels ===>

LAST_K	equ 23560	;Variable del Sistema LAST_K.
