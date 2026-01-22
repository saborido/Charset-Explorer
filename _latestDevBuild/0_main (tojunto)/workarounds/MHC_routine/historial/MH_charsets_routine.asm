;===> Charset Explorer pre RC2 <===> 'MAIN.asm' v3 (2275 bytes en total) <===

;Rutina de MicroHobby de selección de charsets:

    ORG 63039

MAIN

	LD HL, 15360	;CharSet_ROM
	JR (FINAL)
	LD HL, 62808	;CharSet_1
	JR (FINAL)
	LD HL, 63576	;CharSet_2
	JR (FINAL)
	LD HL, 64344	;CharSet_3

FINAL:
	LD (23606), HL
	LD BC, 0
	RET