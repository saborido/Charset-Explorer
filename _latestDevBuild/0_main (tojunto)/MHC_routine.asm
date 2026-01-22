;===> Charset Explorer pre RC2 <===> 'MHC_routine.asm' v1 (25 bytes) <===

;Rutina de MicroHobby de selección de charsets:

    ;ORG 63039

;MAIN

	LD HL, 15360	;CharSet_ROM    -Entrada: ORG +0
	JR (FINAL_MHC)
	LD HL, 62808	;CharSet_1      -Entrada: ORG +5
	JR (FINAL_MHC)
	LD HL, 63576	;CharSet_2      -Entrada: ORG +10
	JR (FINAL_MHC)
	LD HL, 64344	;CharSet_3      -Entrada: ORG +15

FINAL_MHC:
	LD (23606), HL
	LD BC, 0
RET

    ;END 63030
