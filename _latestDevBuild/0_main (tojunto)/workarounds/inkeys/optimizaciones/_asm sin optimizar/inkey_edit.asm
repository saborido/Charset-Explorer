;Los números de línea a los que se hace referencia son los
;del listado BASIC al que va a reemplazar este código asm,
;que es el código de la RC 1

;éste es el código del menú de Edición

	ORG 62721

MAIN	ld hl, LAST_K	;Cargamos la dirección de LAST_K en HL
	ld a, (hl)	;Cargamos en A la última tecla pulsada

	cp "a"		;línea 96
	jr z, ao_KEY
	cp "o"
	jr z, ao_KEY
	cp "6"
	jr z, ao_KEY
	cp 8
	jr z, ao_KEY

	;lineas 97, 98 y 99 usan expresiones anidadas o usan variables en BASIC

	cp "d"		;línea 101
	jr z, dp_KEY
	cp "p"
	jr z, dp_KEY
	cp "7"
	jr z, dp_KEY
	cp 9
	jr z, dp_KEY

	cp "e"		;línea 102
	jr z, ec_KEY
	cp "c"
	jr z, ec_KEY

	cp "w"		;línea 103
	jr z, w_KEY
	cp "9"
	jr z, w_KEY
	cp 11
	jr z, w_KEY

	cp "q"		;línea 104
	jr z, qz_KEY
	cp "z"
	jr z, qz_KEY

	cp "s"		;línea 105
	jr z, s_KEY
	cp "8"
	jr z, s_KEY
	cp 10
	jr z, s_KEY

	cp "O"		;línea 108
	jr z, OP_MKEY
	cp "P"
	jr z, OP_MKEY

	cp "R"		;línea 109
	jr z, R_MKEY

	cp "b"		;línea 110
	jr z, b_KEY

	cp 13		;línea 112
	jr z, Enter_K

	cp "E"		;línea 113
	jr z, E_MKEY
	
	cp "Q"		;línea 755
	jr z, Q_MKEY

	ld bc, 0	;El resulado es 0 si no encuentra
	ret		;ninguna tecla y sale al BASIC

;KEYS jump labels:

ao_KEY	ld bc, 125	;línea 96
	ret
dp_KEY	ld bc, 130	;línea 101
	ret
ec_KEY	ld bc, 145	;línea 102
	ret
w_KEY	ld bc, 135	;línea 103
	ret
qz_KEY	ld bc, 150	;línea 104
	ret
s_KEY	ld bc, 140	;línea 105
	ret
OP_MKEY	ld bc, 319	;línea 108
	ret
R_MKEY	ld bc, 124	;línea 109
	ret
b_KEY	ld bc, 318	;línea 110
	ret
Enter_K	ld bc, 201	;línea 112
	ret
E_MKEY	ld bc, 203	;línea 113
	ret
Q_MKEY	ld bc, 810	;línea 755
	ret

LAST_K	equ 23560	;Variable del sistema LAST_K

