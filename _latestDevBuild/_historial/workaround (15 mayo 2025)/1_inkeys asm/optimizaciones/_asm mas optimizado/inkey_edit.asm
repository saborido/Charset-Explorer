;91 bytes total de la rutina.

;=== Charset Explorer pre RC2 ===

	ORG 62810

;Uso:

;Cargamos en B el número de vueltas del loop,
;cargamos en HL la dirección de KEYS_,
;cargamos en DE la dirección de LINES_,
;y saltamos a la rutina que apunta INKEY_.

;10 bytes de código:

MAIN
	ld b, 27	;Número de vueltas del loop.
	ld hl, KEYS_
	ld de, LINES_

	jr INKEY_	;Saltamos a inkey_shared.

;81 bytes de datos:
KEYS_	db "ao6",8,"dp7",9,"ec","w9",11,"qz","s8",10,"OP","Rb",13,"EQ+G"
LINES_	dw 125,125,125,125,130,130,130,130,145,145,135,135,135,150,150,140,140,140,319,319,124,318,201,203,810,2235,2240

INKEY_	equ 62956	;Dirección de inkey_shared.

