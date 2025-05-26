;333 bytes total de la rutina.

;=== Charset Explorer pre RC2 === inkeys.asm v1.
;
;Esta rutina lee la tecla guardada en la variable del
;sistema LAST_K para comprobar si se han pulsado ciertas
;teclas, y devolver un número de línea que al retornar
;al BASIC (desde donde vamos a llamar a esta rutina),
;usaremos con un GO TO USR (dirección_de_la_rutina).

;Uso (con las rutinas principales de abajo):
;
;Cargamos en B el número de teclas a comprobar,
;cargamos en HL la dirección de KEYS_,
;cargamos en DE la dirección de LINES_,
;y saltamos a esta parte de la rutina (MAIN).

	ORG 62628

;--------------------- Subrutina compartida ---------------------;

MAIN	;20 bytes de código compartido.
	ld a, (LAST_K)	;Cargamos en A la última tecla pulsada.
	cp (hl)		;La comparamos con KEY_ (registro HL).
	jr z, END_	;Si coincide, saltamos a JUMP_.

	inc hl		;Incrementamos KEYS_ (HL), que guarda las teclas a comprobar.
	inc de		;Incrementamos LINES_ (DE) dos veces (las líneas son valores
	inc de		;de 16 bits).

	djnz MAIN	;Comprobammos el resto de las teclas.

	ld bc, 0	;El resulado es 0 si no encuentra
	ret			;ninguna tecla y salimos de la rutina.

;Simulando "LD BC, (DE)":
;
;En esta parte de la rutina se carga en BC el valor contenido en
;LINES_ (DE) para que al volver al BASIC pueda trabajar con el.
;
;Muchas gracias al grupo de Ensamblador Z80
;de telegram por la ayuda.

END_
	ex de, hl
	ld c, (hl)
	inc hl
	ld b, (hl)

	ret	;Salimos de la rutina y volvemos al BASIC.

;------------------ FIN de subrutina compartida ------------------;


;---------------------- Rutinas principales ----------------------;

;Estas son las rutinas que se van a llamar
;desde el BASIC, con un GO TO USR xxxxx.

;=== RUTINA SAVE MENU (USR 62648) ===
;INKEY_SAVE	;10 bytes de código (ORG +20)
	ld b, 10	;Número de vueltas del loop.
	ld hl, SAVEK_
	ld de, SAVEL_

	jr MAIN	;Saltamos al principio de la rutina.

;=== RUTINA EDIT MENU (USR 62658) ===
;INKEY_EDIT	;10 bytes de código (ORG +30)
	ld b, 27	;Número de vueltas del loop.
	ld hl, EDITK_
	ld de, EDITL_

	jr MAIN	;Saltamos al principio de la rutina.
	
;=== RUTINA MAIN MENU (USR 62668) ===
;INKEY_MAIN	;10 bytes de código (ORG +40)
	ld b, 36	;Número de vueltas del loop.
	ld hl, MAINK_
	ld de, MAINL_

	jr MAIN	;Saltamos al principio de la rutina.
	
;=== RUTINA LOCATIONS MENU (USR 62678) ===
;INKEY_LOCATIONS ;10 bytes de código (ORG +50)
	ld b, 18	;Número de vueltas del loop.
	ld hl, LOCATK_
	ld de, LOCATA_

	jr MAIN	;Saltamos al principio de la rutina.

;--------------------- FIN de rutinas principales --------------------;


;---------------------- Datos (teclas y líneas) ----------------------;

;30 bytes de datos del SAVE menu:
SAVEK_	db "rwmt12456Q"
SAVEL_	dw 2740, 2740, 2783, 2750, 2570, 2580, 2610, 2650, 2690, 805

;81 bytes de datos del EDIT menu:
EDITK_	db "ao6",8,"dp7",9,"ec","w9",11,"qz","s8",10,"OP","Rb",13,"EQ+G"
EDITL_	dw 125,125,125,125,130,130,130,130,145,145,135,135,135,150,150,140,140,140,319,319,124,318,201,203,810,2235,2240

;108 bytes de datos del MAIN menu:
MAINK_	db "o",8,"p",9,"s",10,"w",11,"KIOPikqWaSldALhrbBR/:",96,"+G.mMQ"
MAINL_	dw 570,570,575,575,580,580,583,583,531,530,540,545,536,533,565,560,555,550,1430,7250,2500,2500,1300,590,14,7450,27,3500,3500,3500,2235,2240,480,410,430,810

;54 bytes de datos de Useful Locations menu:
LOCATK_	db "urRaAbBcC123456789"	;En este caso se devuelve una dirección de memoria en vez de una línea.
LOCATA_	dw 65368,15616,16376,63064,63824,63832,64592,64600,65360,16384,18432,20480,22528,23296,25200,56000,62968,63040

;Labels:

LAST_K	equ 23560	;Variable del Sistema LAST_K.
