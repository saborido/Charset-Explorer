;119 bytes total de la rutina.

;=== Charset Explorer pre RC2 ===

	ORG 62691

;Uso:

;Cargamos en B el número de vueltas del loop,
;cargamos en HL la dirección de KEYS_,
;cargamos en DE la dirección de LINES_,
;y saltamos a la rutina que apunta INKEY_.

;11 bytes de código:

MAIN
	ld b, 36	;Número de vueltas del loop.
	ld hl, KEYS_
	ld de, LINES_

	jp INKEY_	;Saltamos a inkey_shared.

;108 bytes de datos:
KEYS_	db "o",8,"p",9,"s",10,"w",11,"KIOPikqWaSldALhrbBR/:",96,"+G.mMQ"
LINES_	dw 570,570,575,575,580,580,583,583,531,530,540,545,536,533,565,560,555,550,1430,7250,2500,2500,1300,590,14,7450,27,3500,3500,3500,2235,2240,480,410,430,810

INKEY_	equ 62956	;Dirección de inkey_shared.

