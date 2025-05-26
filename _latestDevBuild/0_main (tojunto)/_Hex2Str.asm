;-------------------------------------------------------------
; Hex2String_8 y Hex2String_16:
; Convierte el valor numerico de L o de HL en una cadena de
; texto con su representacion en hexadecimal (acabada en 0).
; Rutina adaptada de http://baze.au.com/misc/z80bits.html .
;
; IN:   L = Numero a convertir para la version de 8 bits
;       HL = Numero a convertir para la version de 16 bits
; OUT:  [conv2string] = Cadena con la conversion a HEX.
;-------------------------------------------------------------
;Modificada para ser usado en "char2grid.asm" de Charset Explorer (39 bytes).

Hex2String_16:
    ld de, STR_BUFF           ; Cadena destino
    ld a, h
    call B2AHex_Num1          ; Convertir Hex1 de H
    ld a, h
    call B2AHex_Num2          ; Convertir Hex2 de H
    jr Hex2String_8b          ; Realizar conversion de L

Hex2String_8:                 ; Entrada para la rutina de 8 bits
    ld de, STR_BUFF

Hex2String_8b:
    ld a, l
    call B2AHex_Num1          ; Convertir Hex1 de L
    ld a, l
    call B2AHex_Num2          ; Convertir Hex2 de L
ret         ;Volvemos a "char2grid.asm".

;--------------------------- SUBRUTINAS ---------------------------;

B2AHex_Num1:
    rra
    rra
    rra                       ; Desplazamos 4 veces >>
    rra                       ; para poder usar el siguiente bloque

B2AHex_Num2:
    or $f0                    ; Enmascaramos 11110000
    daa                       ; Ajuste BCD
    add a, $a0
    adc a, $40
    ld (de), a                ; Guardamos dato
    inc de
ret         ;Salimos de esta subrutina.
