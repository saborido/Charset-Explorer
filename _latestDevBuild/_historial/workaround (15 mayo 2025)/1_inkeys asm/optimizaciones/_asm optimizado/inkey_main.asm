;=== Charset Explorer pre RC2 ===

;Esta rutina lee la tecla guardada en la variable del
;sistema LAST_K para comprobar si se han pulsado ciertas
;teclas, y devolver un n�mero de l�nea que al retornar
;al BASIC (desde donde vamos a llamar a esta rutina),
;usaremos con un GO TO USR (direcci�n_de_la_rutina).

;Este es el c�digo del Main men�.

	ORG 62678

MAIN
	ld de, LINE_	;Cargamos en DE donde apunta LINE_.
	ld hl, KEY_	;Cargamos en HL donde apunta KEY_.

	ld b, 36	;Configuramos un loop de 36 vueltas (porque hay 36 valores guardados tanto en KEY_ como en LINE_).
LOOP_
	ld a, (LAST_K)	;Cargamos en A la �ltima tecla pulsada.
	cp (hl)		;La comparamos con KEY_ (registro HL).
	jp z, END_	;Si coincide, saltamos a JUMP_.

	inc hl		;Incrementamos KEY_ (HL).
	inc de		;Incrementamos LINE_ (DE) dos veces, porque guardamos valores
	inc de		;de 2 bytes (16 bits).

	djnz LOOP_	;Comprobamos todas las teclas.

	ld bc, 0	;El resulado es 0 si no encuentra
	ret		;ninguna tecla y salimos de la rutina.

;Labels y datos:

KEY_	db  "o",8, "p",9,  "s",10, "w",11, "K","I","O","P","i","k","q","W","a","S", "l", "d", "A", "L", "h","r","b","B","R","/", ":", 96,  "+", "G",".","m","M","Q"
LINE_	dw 570,570,575,575,580,580,583,583,531,530,540,545,536,533,565,560,555,550,1430,7250,2500,2500,1300,590,14,7450,27,3500,3500,3500,2235,2240,480,410,430,810

LAST_K	equ 23560	;Variable del sistema LAST_K
END_	equ 62956	;Direcci�n de inkey_shared.

