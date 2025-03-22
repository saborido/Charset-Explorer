;65 bytes total de la rutina.

;=== Charset Explorer pre RC2 ===

	ORG 62626

;Uso:

;Cargamos en B el n�mero de vueltas del loop,
;cargamos en HL la direcci�n de KEYS_,
;cargamos en DE la direcci�n de LINES_,
;y saltamos a la rutina que apunta INKEY_.

;11 bytes de c�digo:

MAIN
	ld a, 18	;N�mero de vueltas del loop.
	ld hl, KEYS_
	ld de, ADDRS_

	jp INKEY_	;Saltamos a inkey_shared.

;54 bytes de datos:
KEYS_	db "urRaAbBcC", "123456789"
ADDRS_	dw 65368,15616,16376,63064,63824,63832,64592,64600,65360,16384,18432,20480,22528,23296,25200,56000,62968,63040

INKEY_	equ 62956	;Direcci�n de inkey_shared.

