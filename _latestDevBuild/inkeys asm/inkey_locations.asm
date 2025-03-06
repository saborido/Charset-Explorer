
;El número de línea BASIC que reemplaza con este asm es 1547
;de la versión RC1 (el menú de Useful Locations)

	ORG 62312

MAIN	ld hl, LAST_K	;Cargamos la dirección de LAST_K en HL
	ld a, (hl)	;Cargamos en A la última tecla pulsada

	cp "u"
	jr z, u_KEY
	cp "r"
	jr z, r_KEY
	cp "R"
	jr z, R_MKEY
	cp "a"
	jr z, a_KEY
	cp "A"
	jr z, A_MKEY
	cp "b"
	jr z, b_KEY
	cp "B"
	jr z, B_MKEY
	cp "c"
	jr z, c_KEY
	cp "C"
	jr z, C_MKEY
	cp "1"
	jr z, one_K
	cp "2"
	jr z, two_K
	cp "3"
	jr z, three_K
	cp "4"
	jr z, four_K
	cp "5"
	jr z, five_K
	cp "6"
	jr z, six_K
	cp "7"
	jr z, seven_K
	cp "8"
	jr z, eight_K
	cp "9"
	jr z, nine_K

	ld bc, 0	;El resulado es 0 si no encuentra
	ret		;ninguna tecla y sale al BASIC

;KEYS jump labels:

u_KEY	ld bc, 65368	;apunta al primer UDG (A)
	ret
r_KEY	ld bc, 15616	;Charset de la ROM
	ret
R_MKEY	ld bc, 16376	;Final del charset de la ROM
	ret
a_KEY	ld bc, 63064	;MicroHobby charset 1
	ret
A_MKEY	ld bc, 63824	;Final del primer charset MH
	ret
b_KEY	ld bc, 63832	;MicroHobby charset 2
	ret
B_MKEY	ld bc, 64592	;Final del segundo charset MH
	ret
c_KEY	ld bc, 64600	;MicroHobby charset 3
	ret
C_MKEY	ld bc, 65360	;Final del tercer charset MH
	ret
one_K	ld bc, 16384	;Primer tercio de la pantalla
	ret
two_K	ld bc, 18432	;Segundo tercio de la pantalla
	ret
three_K	ld bc, 20480	;Tercer tercio de la pantalla
	ret
four_K	ld bc, 22528	;Atributos de color de la pantalla
	ret
five_K	ld bc, 23296	;Variables del sistema, búfer impresora, etc
	ret
six_K	ld bc, 25200	;Comienzo de Charset Explorer
	ret
seven_k	ld bc, 56000	;Principio de la memoria libre
	ret
eight_K	ld bc, 62968	;Rutinas, datos y variables de charxp
	ret
nine_K	ld bc, 63040	;Rutina de MicroHobby charset
	ret

LAST_K	equ 23560	;Variable del sistema LAST_K

