
;los números de línea a los que se hace referencia son los
;del listado BASIC al que va a reemplazar este código asm,
;que es el código de la RC 1

	ORG 62464

MAIN	ld hl, LAST_K	;Cargamos la dirección de LAST_K en HL
	ld a, (hl)	;Cargamos en A la última tecla pulsada

	cp "o"			;línea 610
	jp z, o_KEY
	cp 8
	jp z, o_KEY

	cp "p"			;línea 623
	jp z, p_KEY
	cp 9
	jp z, p_KEY

	cp "s"			;línea 625
	jp z, s_KEY
	cp 10
	jr z, s_KEY

	cp "w"			;línea 627
	jr z, w_KEY
	cp 11
	jr z, w_KEY

	cp "K"			;línea 631
	jr z, K_MKEY

	cp "I"			;línea 633
	jr z, I_MKEY

	cp "O"			;línea 635
	jr z, O_MKEY

	cp "P"			;línea 636
	jr z, P_MKEY

	cp "i"			;línea 639
	jr z, i_KEY

	cp "k"			;línea 650
	jr z, k_KEY

	cp "q"			;línea 653
	jr z, q_KEY

	cp "W"			;línea 655
	jr z, W_MKEY

	cp "a"			;línea 660
	jr z, a_KEY

	cp "S"			;línea 665
	jr z, S_MKEY

	;la linea 670 "H", es un GOSUB y ha sido renumerada a la linea 730

	cp "l"			;línea 675
	jr z, l_KEY

	;linea 690 "v" AND ar, usa variables en BASIC

	cp "d"			;línea 695
	jr z, d_KEY

	;linea 705 "X" AND a<2, usa variables en BASIC

	cp "A"			;línea 707
	jr z, AL_MKEY
	cp "L"
	jr z, AL_MKEY

	;linea 710 "V" AND ar AND a<2, usa variables en BASIC

	cp "h"			;línea 715
	jr z, h_KEY

	cp "r"			;línea 719
	jr z, r_KEY

	cp "b"			;línea 721
	jr z, b_KEY

	cp "B"			;línea 723
	jr z, B_MKEY

	cp "R"			;línea 725
	jr z, R_MKEY

	cp "/"			;línea 726
	jr z, libraK
	cp ":"
	jr z, libraK
	cp 96
	jr z, libraK

	;linea 727, expresiones anidadas, AND ar, usa variables en BASIC

	cp "."			;línea 728
	jr z, dot_K

	cp "m"			;línea 729
	jr z, m_KEY

	cp "M"			;línea 730
	jr z, M_MKEY

	;de la linea 730 a la 753, o usa veriables BASIC o es un GOSUB

	cp "Q"			;línea 755
	jr z, Q_MKEY

	ld bc, 0	;El resulado es 0 si no encuentra
	ret		;ninguna tecla y sale al BASIC

;KEYS jump labels:

o_KEY	ld bc, 570	;línea 610
	ret
p_KEY	ld bc, 575	;línea 623
	ret
s_KEY	ld bc, 580	;línea 625
	ret
w_KEY	ld bc, 583	;línea 627
	ret
K_MKEY	ld bc, 531	;línea 631
	ret
I_MKEY	ld bc, 530	;línea 633
	ret
O_MKEY	ld bc, 540	;línea 635
	ret
P_MKEY	ld bc, 545	;línea 636
	ret
i_KEY	ld bc, 536	;línea 639
	ret
k_KEY	ld bc, 533	;línea 650
	ret
q_KEY	ld bc, 565	;línea 653
	ret
W_MKEY	ld bc, 560	;línea 655
	ret
a_KEY	ld bc, 555	;línea 660
	ret
S_MKEY	ld bc, 550	;línea 665
	ret

;la linea 670 "H", es un GOSUB y ha sido renumerada a la linea 730

l_KEY	ld bc, 1430	;línea 675
	ret

;linea 690 "v" AND ar, usa variables en BASIC

d_KEY	ld bc, 7250	;línea 695
	ret

;linea 705 "X" AND a<2, usa variables en BASIC

AL_MKEY	ld bc, 2500	;línea 707
	ret

;linea 710 "V" AND ar AND a<2, usa variables en BASIC

h_KEY	ld bc, 1300	;línea 715
	ret
r_KEY	ld bc, 590	;línea 719
	ret
b_KEY	ld bc, 14	;línea 721
	ret
B_MKEY	ld bc, 7450	;línea 723
	ret
R_MKEY	ld bc, 27	;línea 725
	ret
libraK	ld bc, 3500	;línea 726
	ret

;linea 727, expresiones anidadas, AND ar, usa variables en BASIC

dot_K	ld bc, 480	;línea 728
	ret
m_KEY	ld bc, 410	;línea 729
	ret
M_MKEY	ld bc, 430	;línea 730
	ret

;de la linea 730 a la 753, o usa veriables BASIC o es un GOSUB

Q_MKEY	ld bc, 810	;línea 755
	ret

LAST_K	equ 23560	;Variable del sistema LAST_K
