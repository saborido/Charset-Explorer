;=== Charset Explorer pre RC2 ===

;Esta rutina compartida se utiliza para
;devolver un n�mero de l�nea al retornar
;al BASIC (desde donde vamos a llamar a esta rutina).
;Usaremos con un GO TO USR (direcci�n_de_la_rutina).

;Este es el c�digo compartido por todas las rutinas inkey$.

	ORG 62956

;Simulando "LD BC, (DE)":

;En esta parte de la rutina se carga en BC el valor contenido en
;LINE_ (DE) para que al volver al BASIC pueda trabajar con el.

;Muchas gracias al grupo de Ensamblador Z80
;de telegram por la ayuda.

MAIN
	ex de, hl
	ld c, (hl)
	inc hl
	ld b, (hl)

	ret	;Salimos de la rutina y volvemos al BASIC.

