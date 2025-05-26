;Los n�meros de l�nea a los que se hace referencia son los
;del listado BASIC al que va a reemplazar este c�digo asm,
;que es el c�digo de la RC 1

;�ste es el c�digo del men� de Edici�n

	ORG 62721

MAIN	ld hl, LAST_K	;Cargamos la direcci�n de LAST_K en HL
	ld a, (hl)	;Cargamos en A la �ltima tecla pulsada

	cp "a"		;l�nea 96
	jr z, ao_KEY
	cp "o"
	jr z, ao_KEY
	cp "6"
	jr z, ao_KEY
	cp 8
	jr z, ao_KEY

	;lineas 97, 98 y 99 usan expresiones anidadas o usan variables en BASIC

	cp "d"		;l�nea 101
	jr z, dp_KEY
	cp "p"
	jr z, dp_KEY
	cp "7"
	jr z, dp_KEY
	cp 9
	jr z, dp_KEY

	cp "e"		;l�nea 102
	jr z, ec_KEY
	cp "c"
	jr z, ec_KEY

	cp "w"		;l�nea 103
	jr z, w_KEY
	cp "9"
	jr z, w_KEY
	cp 11
	jr z, w_KEY

	cp "q"		;l�nea 104
	jr z, qz_KEY
	cp "z"
	jr z, qz_KEY

	cp "s"		;l�nea 105
	jr z, s_KEY
	cp "8"
	jr z, s_KEY
	cp 10
	jr z, s_KEY

	cp "O"		;l�nea 108
	jr z, OP_MKEY
	cp "P"
	jr z, OP_MKEY

	cp "R"		;l�nea 109
	jr z, R_MKEY

	cp "b"		;l�nea 110
	jr z, b_KEY

	cp 13		;l�nea 112
	jr z, Enter_K

	cp "E"		;l�nea 113
	jr z, E_MKEY
	
	cp "Q"		;l�nea 755
	jr z, Q_MKEY

	ld bc, 0	;El resulado es 0 si no encuentra
	ret		;ninguna tecla y sale al BASIC

;KEYS jump labels:

ao_KEY	ld bc, 125	;l�nea 96
	ret
dp_KEY	ld bc, 130	;l�nea 101
	ret
ec_KEY	ld bc, 145	;l�nea 102
	ret
w_KEY	ld bc, 135	;l�nea 103
	ret
qz_KEY	ld bc, 150	;l�nea 104
	ret
s_KEY	ld bc, 140	;l�nea 105
	ret
OP_MKEY	ld bc, 319	;l�nea 108
	ret
R_MKEY	ld bc, 124	;l�nea 109
	ret
b_KEY	ld bc, 318	;l�nea 110
	ret
Enter_K	ld bc, 201	;l�nea 112
	ret
E_MKEY	ld bc, 203	;l�nea 113
	ret
Q_MKEY	ld bc, 810	;l�nea 755
	ret

LAST_K	equ 23560	;Variable del sistema LAST_K

