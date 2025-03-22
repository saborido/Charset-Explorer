;40 bytes total de la rutina.

;=== Charset Explorer pre RC2 ===

	ORG 62901

;Uso:

;Cargamos en B el número de vueltas del loop,
;cargamos en HL la dirección de KEYS_,
;cargamos en DE la dirección de LINES_,
;y saltamos a la rutina que apunta INKEY_.

;10 bytes de código:

MAIN
	ld b, 10	;Número de vueltas del loop.
	ld hl, KEYS_
	ld de, LINES_

	jr INKEY_	;Saltamos a inkey_shared.

;30 bytes de datos:
KEYS_	db "rwmt12456Q"	;10 teclas a comprobar.
LINES_	dw 2740, 2740, 2783, 2750, 2570, 2580, 2610, 2650, 2690, 805

INKEY_	equ 62956	;Dirección de inkey_shared.
