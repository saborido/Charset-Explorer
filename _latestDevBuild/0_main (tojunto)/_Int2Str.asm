;-----------------------------------------------------------------
; Int2String_8 e Int2String_16:
; Convierte un valor de 16 bits a una cadena imprimible.
;
; Entrada:   HL = valor numerico a convertir
; Salida:    Cadena en int2dec16_result .
; De:        Milos Bazelides http://baze.au.com/misc/z80bits.html
;-----------------------------------------------------------------
;Modificada para ser usado en "char2grid.asm" de Charset Explorer (42 bytes).

Int2String_16:
    ld de, STR_BUFF             ; Apuntamos a cadena destino
    ld bc, -10000               ; Calcular digito decenas de miles
    call Int2Dec_num1
    ld bc, -1000                ; Calcular digito miles
    call Int2Dec_num1
 
    ld bc, -100                 ; Calcular digito de centenas
    call Int2Dec_num1
    ld c, -10                   ; Calcular digito de decenas
    call Int2Dec_num1
    ld c, b                     ; Calcular unidades
    call Int2Dec_num1
ret         ;Volvemos a "char2grid.asm".

;--------------------------- SUBRUTINA ---------------------------;

Int2Dec_num1:
    ld a,'0'-1                  ; Contador unidades, empieza '0'-1
 
Int2Dec_num2
    inc a                       ; Incrementamos el digito ('0', ... '9')
    add hl, bc                  ; Restamos "unidades" hasta sobrepasarlo
    jr c, Int2Dec_num2          ; Repetir n veces

    sbc hl, bc                  ; Deshacemos el último paso
    ld (de), a                  ; Almacenamos el valor
    inc de
ret         ;Salimos de esta subrutina.