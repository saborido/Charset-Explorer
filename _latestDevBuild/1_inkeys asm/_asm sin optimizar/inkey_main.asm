
;los n�meros de l�nea a los que se hace referencia son los
;del listado BASIC al que va a reemplazar este c�digo asm,
;que es el c�digo de la RC 1

	ORG 62464

MAIN	ld hl, LAST_K	;Cargamos la direcci�n de LAST_K en HL
	ld a, (hl)	;Cargamos en A la �ltima tecla pulsada

	cp "o"			;l�nea 610
	jp z, o_KEY
	cp 8
	jp z, o_KEY

	cp "p"			;l�nea 623
	jp z, p_KEY
	cp 9
	jp z, p_KEY

	cp "s"			;l�nea 625
	jp z, s_KEY
	cp 10
	jr z, s_KEY

	cp "w"			;l�nea 627
	jr z, w_KEY
	cp 11
	jr z, w_KEY

	cp "K"			;l�nea 631
	jr z, K_MKEY

	cp "I"			;l�nea 633
	jr z, I_MKEY

	cp "O"			;l�nea 635
	jr z, O_MKEY

	cp "P"			;l�nea 636
	jr z, P_MKEY

	cp "i"			;l�nea 639
	jr z, i_KEY

	cp "k"			;l�nea 650
	jr z, k_KEY

	cp "q"			;l�nea 653
	jr z, q_KEY

	cp "W"			;l�nea 655
	jr z, W_MKEY

	cp "a"			;l�nea 660
	jr z, a_KEY

	cp "S"			;l�nea 665
	jr z, S_MKEY

	;la linea 670 "H", es un GOSUB y ha sido renumerada a la linea 730

	cp "l"			;l�nea 675
	jr z, l_KEY

	;linea 690 "v" AND ar, usa variables en BASIC

	cp "d"			;l�nea 695
	jr z, d_KEY

	;linea 705 "X" AND a<2, usa variables en BASIC

	cp "A"			;l�nea 707
	jr z, AL_MKEY
	cp "L"
	jr z, AL_MKEY

	;linea 710 "V" AND ar AND a<2, usa variables en BASIC

	cp "h"			;l�nea 715
	jr z, h_KEY

	cp "r"			;l�nea 719
	jr z, r_KEY

	cp "b"			;l�nea 721
	jr z, b_KEY

	cp "B"			;l�nea 723
	jr z, B_MKEY

	cp "R"			;l�nea 725
	jr z, R_MKEY

	cp "/"			;l�nea 726
	jr z, libraK
	cp ":"
	jr z, libraK
	cp 96
	jr z, libraK

	;linea 727, expresiones anidadas, AND ar, usa variables en BASIC

	cp "."			;l�nea 728
	jr z, dot_K

	cp "m"			;l�nea 729
	jr z, m_KEY

	cp "M"			;l�nea 730
	jr z, M_MKEY

	;de la linea 730 a la 753, o usa veriables BASIC o es un GOSUB

	cp "Q"			;l�nea 755
	jr z, Q_MKEY

	ld bc, 0	;El resulado es 0 si no encuentra
	ret		;ninguna tecla y sale al BASIC

;KEYS jump labels:

o_KEY	ld bc, 570	;l�nea 610
	ret
p_KEY	ld bc, 575	;l�nea 623
	ret
s_KEY	ld bc, 580	;l�nea 625
	ret
w_KEY	ld bc, 583	;l�nea 627
	ret
K_MKEY	ld bc, 531	;l�nea 631
	ret
I_MKEY	ld bc, 530	;l�nea 633
	ret
O_MKEY	ld bc, 540	;l�nea 635
	ret
P_MKEY	ld bc, 545	;l�nea 636
	ret
i_KEY	ld bc, 536	;l�nea 639
	ret
k_KEY	ld bc, 533	;l�nea 650
	ret
q_KEY	ld bc, 565	;l�nea 653
	ret
W_MKEY	ld bc, 560	;l�nea 655
	ret
a_KEY	ld bc, 555	;l�nea 660
	ret
S_MKEY	ld bc, 550	;l�nea 665
	ret

;la linea 670 "H", es un GOSUB y ha sido renumerada a la linea 730

l_KEY	ld bc, 1430	;l�nea 675
	ret

;linea 690 "v" AND ar, usa variables en BASIC

d_KEY	ld bc, 7250	;l�nea 695
	ret

;linea 705 "X" AND a<2, usa variables en BASIC

AL_MKEY	ld bc, 2500	;l�nea 707
	ret

;linea 710 "V" AND ar AND a<2, usa variables en BASIC

h_KEY	ld bc, 1300	;l�nea 715
	ret
r_KEY	ld bc, 590	;l�nea 719
	ret
b_KEY	ld bc, 14	;l�nea 721
	ret
B_MKEY	ld bc, 7450	;l�nea 723
	ret
R_MKEY	ld bc, 27	;l�nea 725
	ret
libraK	ld bc, 3500	;l�nea 726
	ret

;linea 727, expresiones anidadas, AND ar, usa variables en BASIC

dot_K	ld bc, 480	;l�nea 728
	ret
m_KEY	ld bc, 410	;l�nea 729
	ret
M_MKEY	ld bc, 430	;l�nea 730
	ret

;de la linea 730 a la 753, o usa veriables BASIC o es un GOSUB

Q_MKEY	ld bc, 810	;l�nea 755
	ret

LAST_K	equ 23560	;Variable del sistema LAST_K
