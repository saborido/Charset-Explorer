;Los n�meros de l�nea a los que se hace referencia son los
;del listado BASIC al que va a reemplazar este c�digo asm,
;que es el c�digo de la RC 1

;�ste es el c�digo del men� de Save/load

	ORG 62877

MAIN	ld hl, LAST_K	;Cargamos la direcci�n de LAST_K en HL
	ld a, (hl)	;Cargamos en A la �ltima tecla pulsada

	cp "r"		;l�nea 2515
	jr z, rw_KEY
	cp "w"
	jr z, rw_KEY

	cp "m"		;l�nea 2520
	jr z, m_KEY

	cp "t"		;l�nea 2527
	jr z, t_KEY

	cp "1"		;l�nea 2530
	jr z, one_K

	cp "2"		;l�nea 2535
	jr z, two_K

	;linea 2540 "3", usa expresiones anidadas y usa variables en BASIC

	cp "4"		;l�nea 2545
	jr z, four_K

	cp "5"		;l�nea 2550
	jr z, five_K

	cp "6"		;l�nea 2555
	jr z, six_K
	
	cp "Q"		;l�nea 2560
	jr z, Q_MKEY

	ld bc, 0	;El resulado es 0 si no encuentra
	ret		;ninguna tecla y sale al BASIC

;KEYS jump labels:

rw_KEY	ld bc, 2740	;l�nea 2515
	ret
m_KEY	ld bc, 2783	;l�nea 2520
	ret
t_KEY	ld bc, 2750	;l�nea 2527
	ret
one_K	ld bc, 2570	;l�nea 2530
	ret
two_K	ld bc, 2580	;l�nea 2535
	ret

;linea 2540 "3", usa expresiones anidadas y usa variables en BASIC

four_K	ld bc, 2610	;l�nea 2545
	ret
five_K	ld bc, 2650	;l�nea 2550
	ret
six_K	ld bc, 2690	;l�nea 2555
	ret
Q_MKEY	ld bc, 805	;l�nea 2560
	ret

LAST_K	equ 23560	;Variable del sistema LAST_K


