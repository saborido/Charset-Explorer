;===> Charset Explorer pre RC2 <===> 'inkeys.asm' v3 (361 bytes) <===

;Esta rutina lee la tecla guardada en la variable del
;sistema LAST_K para comprobar si se han pulsado ciertas
;teclas, y devolver un número de línea que al retornar
;al BASIC (desde donde vamos a llamar a esta rutina), que
;usaremos con un GO TO USR (dirección_de_la_rutina).

; Uso:
;Cargamos en B el número de teclas a comprobar,
;cargamos en HL la dirección de KEYS_,
;cargamos en DE la dirección de LINES_,

	;ORG 62600

;MAIN

;----------------- Rutinas principales [40 + 10 bytes] -----------------;


;=== RUTINA INKEY_SAVE          [USR 62600] === 0 bytes (ORG +0).
	ld b, 10
	ld hl, SAVEK_
	ld de, SAVEL_
	jr LOOP_

;=== RUTINA INKEY_EDIT          [USR 62610] === +10 bytes (ORG +10).
	ld b, 27
	ld hl, EDITK_
	ld de, EDITL_
	jr LOOP_

;=== RUTINA INKEY_MAIN          [USR 62620] === +10 bytes (ORG +20).
	ld b, 36
	ld hl, MAINK_
	ld de, MAINL_
	jr LOOP_

;=== RUTINA INKEY_LOCATIONS     [USR 62630] === +10 bytes (ORG +30).
	ld b, 18
	ld hl, LOCATK_
	ld de, LOCATA_
	jr LOOP_

;=== RUTINA INKEY_MHCharsets    [USR 62640] === +10 bytes (ORG +40).
	ld b, 6
	ld hl, HOBBYK_
	ld de, HOBBYU_
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
ret				;Ninguna tecla y salimos de la rutina.

END_:

;Simulando "LD BC, (DE)":
;En esta parte de la rutina se carga en BC el valor contenido en
;LINES_ (DE) para que al volver al BASIC se pueda trabajar con el.

;Muchas gracias al grupo de ensamblador Z80 de Telegram por la ayuda.

;Escribimos en BC el resultado para que lo devuelva en el BASIC.

	ex de, hl
	ld c, (hl)
	inc hl
	ld b, (hl)

	ret	;Salimos de la rutina y volvemos al BASIC.


;------------------- FIN de subrutina compartida -------------------;


;--------------- Datos (teclas y líneas) [273 + 18 bytes] ---------------;


;30 bytes de datos del SAVE menu:
SAVEK_	db "rwmt12456Q" ;10 teclas.
SAVEL_	dw 2740, 2740, 2783, 2750, 2570, 2580, 2610, 2650, 2690, 805
;			 r     w     m     t     1     2     3     4     5    Q

;81 bytes de datos del EDIT menu:
EDITK_	db "ao6",8,"dp7",9,"ecw9",11,"qzs8",10,"OPRb",13,"EQ+G" ;27 teclas
EDITL_	dw 125,125,125,125,130,130,130,130,145,145,135,135,135,150,150,140,140,140,319,319,124,318,201,203,810,2235,2240
;			a   o   6  ,8,  d   p   7  ,9,  e   c   w   9 ,11,  q   z   s   8 ,10,  O   P   R   b ,13,  E   Q    +    G

;108 bytes de datos del MAIN menu:
MAINK_	db "o",8,"p",9,"s",10,"w",11,"KIOPikqWaSldALhrbHR/:",96,"+G.mMQ" ;36 teclas
MAINL_	dw 570,570,575,575,580,580,583,583,531,530,540,545,536,533,565,560,555,550,1430,7250,2500,2500,1300,590,14,7450,27,3500,3500,3500,2235,2240,480,410,430,810
;			o  ,8,  p  ,9,  s ,10,  w ,11,  K   I   O   P   i   k   q   W   a   S    l    d    A    L    h    r b    H  R    /    :  ,96,   +    G   .   m   M   Q

;54 bytes de datos de Useful Locations menu:
LOCATK_	db "urRaAbBcC123456789" ;18 teclas.
LOCATA_	dw 65368,15616,16136,63064,63584,63832,64352,64600,65120,16384,18432,20480,22528,23296,25200,53000,62016,62960 ;En este caso se devuelve una dirección de memoria.
;			 u     r     R     a     A     b     B     c     C     1     2     3     4     5     6     7     8     9

;18 bytes de datos de MicroHobby charsets menu:
HOBBYK_	db "a1b2c3" ;6 teclas.
HOBBYU_	dw 63044,63044,63049,63049,63054,63054 ;En este caso se devuelven direcciones de rutinas.
;			 a     1     b     2     c     3


;<=== Labels ===>


ROM_CHR equ 63039   ;Charset de la ROM.
LAST_K	equ 23560	;Variable del Sistema LAST_K.
