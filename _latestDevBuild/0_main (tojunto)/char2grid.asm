;===> Charset Explorer pre RC2 <===> 'char2grid.asm' v3 (599 bytes en total (con INCLUDEs -menos uno- y sin AGUSTINA la subrutina) <===

; Rutina para dibujar un carácter alojado en una posición de memoria en un grid de 8x8 chars
;y listar las direcciones de memoria y los valores que contienen (tanto en decimal como en
;hexadecimal), junto a una evaluación del tipo de dato que contiene cada una de las direccioones
;de memoria del char.

    ;ORG 61137

;MAIN

    ld a, 2                     ;Abrimos la pantalla superior.
    call 5633

    call INKBRIGHT              ;Empezamos con INK 8 y BRIGHT 8.

    ;call _UGDreset              ;Reseteamos la variable del sistema UDG. Para tests unitarios descomantar el include casi al
                                ;final del script. La rutina a la que aquí se llama está en el archivo "_UGDchange.asm".

;------------------------- EMPEZAMOS CON LA DIRECCIÓN DE MEMORIA DEL CHAR Y SU VALOR -------------------------;

    ld hl, (CHADDR_)
    ld (ADDR_BUFF), hl          ;Guardamos (CHADDR_) en (ADDR_BUFF) para recuperarlo después.

LOOPADR                    ;Loop principal de la impresión de las direcciones de memoria y sus valores.
    call POS_ADDR               ;Nos posicionamos en la pantalla.

    ld a, (HEXMOD_)             ;Comprobamos si el modo hexadecimal está activado.
    cp 0
    jr nz, JMP_HEX              ;Si es que sí, saltamos a imprimir en hexadecimal (JMP_HEX).

;Esta parte es para imprimir en decimal:
    call Int2String_16          ;Esto coje el número de HL (16 bit) y lo pasa a un string de 5 chars (STR_BUFF).

    ld a, 16
    rst 16
    ld a, 5
    rst 16

    ld de, STR_BUFF             ;Leemos el string creado por Int2String_16.
    ld bc, 5
    call 8252                   ;Imprimimos el string (una dirección de memoria)

    ld a, 16
    rst 16
    ld a, 8
    rst 16

    ld de, BLANK_VAL            ;Imprimimos espacios en el sitio del 'Val'
    ld bc, 9                    ;para tapar valores anteriores más largos.
    call 8252

    ld a, (POS_STR)             ;Nos posicionamos en la pantalla.
    rst 16
    ld a, 17
    rst 16

    ld hl, (ADDR_BUFF)
    ld b, 0                     ;Imprimimos el valor que contiene la dir. de memoria del string anterior.
    ld c, (hl)
    call 6683                   ;Con esto imprimimos un número hasta 9999 (LD BC, number).

    jr JUMP2                    ;Nos saltamos el modo hexadecimal.

;Esta parte es para imprimir en hexadecimal:
JMP_HEX:
    call HEX_SIGN               ;Imprimimos el signo $ en azul.
    call Hex2String_16          ;Esto coje el número en decimal de HL (16 bit) y lo pasa a un string de 4 chars en hexadecimal (STR_BUFF+3).

    ld de, STR_BUFF             ;Leemos el string creado por Hex2String_16.
    ld bc, 4
    call 8252                   ;Imprimimos el string (una dirección de memoria)

    ld a, ","
    rst 16
    call HEX_SIGN

    ld hl, (ADDR_BUFF)          ;Aquí cargamos el value en L para pasarlo a hexadecimal.
    ld a, (hl)
    ld l, a

    call Hex2String_8           ;Esto coje el número en decimal de L (8 bit) y lo pasa a un string de 2 chars en hexadecimal (STR_BUFF+1).

    ld de, STR_BUFF             ;Leemos el string creado por Hex2String_8.
    ld bc, 2
    call 8252                   ;Imprimimos el string (una dirección de memoria)

JUMP2:
;--------------------------------- Aquí imprimimos el Control Code / Char / TokenS ---------------------------------;

    ld a, (POS_STR)
    ld c, a
    ld d, 9
    call OUTGRD_POS             ;Esta subrutina se encuentra en 'outer_grid.asm'. Nos posicionamos en la pantalla.

    ld hl, (ADDR_BUFF)          ;Aquí cargamos el value en A para compararlo.

;Tokens (0-31): Control Codes ("." blue).
    ld a, (hl)
    cp 32
    jr nc, C2G_TOKEN

    ld a, 16
    rst 16
    ld a, 1
    rst 16
    ld a, "."
    rst 16
    jr C2G_TOKEN_END

;Tokens A (32-127): Characters (CHR$ green).
C2G_TOKEN:
    ld a, (hl)
    cp 128
    jr nc, C2G_TOKEN_B

    ld a, 16
    rst 16
    ld a, 4
    rst 16
    ld a, (hl)
    rst 16
    jr C2G_TOKEN_END

;Tokens B (128-143):  Characters - Graphic Blocks (CHR$ red).
C2G_TOKEN_B:
    ld a, (hl)
    cp 144
    jr nc, C2G_TOKEN_C

    ld a, 16
    rst 16
    ld a, 2
    rst 16
    ld a, (hl)
    rst 16
    jr C2G_TOKEN_END

;Tokens C: UDG's.
C2G_TOKEN_C:
    ld a, (C2G_SPMD)        ;Comprobar modo 48k o 128k.
    cp 0
    jr z, C2G_TOKEN_C_48

;Tokens C (144-162): UDG's (from 128k, UDG_CHAR magenta).
    ld a, (hl)
    cp 163
    jr nc, C2G_TOKEN_D

    ld a, 16
    rst 16
    ld a, 3
    rst 16
    ld a, (hl)
    rst 16
    jr C2G_TOKEN_END

;Tokens C (144-164): UDG's (from 48k, UDG_CHAR magenta).
C2G_TOKEN_C_48:
    ld a, (hl)
    cp 165
    jr nc, C2G_TOKEN_D

    ld a, 16
    rst 16
    ld a, 3
    rst 16
    ld a, (hl)
    rst 16
    jr C2G_TOKEN_END

;Tokens D (163 or 165-255): TOKENS ("T" yellow).
C2G_TOKEN_D:
    ld a, 16
    rst 16
    ld a, 6
    rst 16
    ld a, "T"
    rst 16

C2G_TOKEN_END:
    call INKBRIGHT                ;Reiniciamos INK 8 y BRIGHT 8.

;------------- Ahora incrementamos el eje Y y hacemos un bucle.

    inc hl                      ;Incrementamos la dirección de memoria a la que apunta ADDR_BUFF.
    ld (ADDR_BUFF), hl          ;Guardamos HL en (ADDR_BUFF).

    call Y_INC                  ;Incrementamos el eje Y.

    cp 15                        ;15 es el eje Y de la última fila de la rejilla.
    jp nz, LOOPADR                ;Hacemos un bucle a la etiqueta LOOPADR hasta completar las 8 filas que componen el char.

    call RESET_POS              ;Reseteamos la posición de las filas (eje Y).


;---------------------------------- DESDE AQUÍ SE PODRÍA SEPARAR EL SCRIPT (valorar) ---------------------------------;


;------------------------------------- AQUÍ YA SEGUIMOS CON LA REJILLA -------------------------------------;

;Creamos y cubrimos la rejilla con pixeles vacíos para borrar lo que ya hubiese, y luego
;dibujamos los píxeles sobre ella.

    call _UGDchange             ;Cambiamos la variable del sistema UDG (para usar la Q como cuadrado de píxel encendido, sin realmente usar el UDG Q)
                                ;Para tests unitarios descomantar el include casi al final del script. La rutina a la que aquí se llama está en
                                ;el archivo "_UGDchange.asm".

;Configuramos los colores del dotted grid:
    call INKBRIGHT              ;Ponemos el bright en 8.

    ld a, 17                    ;PAPER command.
    rst 16
    ld a, (PAPCOL_)             ;Color del fondo.
    rst 16

    ld a, 16                    ;INK command.
    rst 16                        ;Dot ink color.
    ld a, (DOTCOL_)             ;Dot color + 1.
    dec a                       ;Restamos 1 para obtener el color correcto.
    rst 16

;Comprobamos si el modo Binario está activado:
    call BIN_CHK                ;Bin mode is on? If not, avoid Bin mode.
    jr z, BINOFF

;ZEROed grid (si el modo BIN esta ON):
    ld hl, GRBIN+1
    ld (hl), 7

LOOPB
    ld de, GRBIN                ;Llenamos el byte con ceros.
    ld bc, 11
    call 8252

    ld hl, GRBIN+1

    ld a, (hl)
    inc a
    ld (hl), a
    cp 15

    jr nz, LOOPB                ;Hacemos loop si la fila no ha llegado a 15.
    ld hl, GRBIN+1

jr JUMP ;Saltamos el BIN OFF.

;DOTted grid (si el modo BIN esta OFF):
BINOFF:
    ld hl, GRID+1
    ld (hl), 7

LOOPA
    ld de, GRID                 ;Llenamos el byte con DOTS.
    ld bc, 11
    call 8252

    ld hl, GRID+1
    ld a, (hl)
    inc a
    ld (hl), a
    cp 15

    jr nz, LOOPA                ;Hacemos loop si la fila no ha llegado a 15.
    ld hl, GRID+1

;Configuramos el color de los píxeles ON:

JUMP:
    ld a, 16
    rst 16

    ld a, (INKCOL_)             ;Pixel ink color + 1.
    dec a                       ;Restamos 1 para obtener el color correcto.
    rst 16

;-------------- Char Grid Draw Start ---------------;

    ld hl, (CHADDR_)            ;Copiamos el char en el búfer, ya que lo vamos a ir
    ld de, CHR_BUFF             ;modificando y no funcionaría con la parte de la ROM.
    ld bc, 8
    ldir

    call POS_SCR                ;Nos posicionamos en la rejilla.

    ld hl, CHR_BUFF             ;Cargamos en HL el char a dibujar.

LOOPF                    ;Vamos a ir rotando el byte del char para comprobar el bit 7 cada vez.
    ld b, 8                     ;Loop de 8 rotaciones (left).

CHR_LD
    bit 7, (hl)                 ;Comprobamos el bit 7 del byte.
    jr z, DRW_ZRO               ;Si el flag Z es 0, no dibujamos nada.
    call nz, DRW_BIT            ;Si es un 1, dibujamos el pixel.

JMP_ZRO:
    rlc (hl)                    ;Rotamos hacia la izquierda.
    djnz CHR_LD                 ;Volvemos a comprobar...

    ld a, 21                    ;Reseteamos la posición de las columnas (eje x).
    ld (POS_STR+1), a

    call Y_INC                  ;Incrementamos la fila...
    inc hl                      ;Incrementamos HL (el búfer CHR_BUFF del char a dibujar).
    cp 15                       ;Comprobamos si hemos llegado a la última fila de la rejilla para salir del bucle (cuando el eje Y = 15).
    jr nz, LOOPF

    call RESET_POS              ;Reseteamos la posición de las filas (eje Y).

;Reseteamos variables antes de salir de la rutina:

RESET_POS:
    ld a, 7                     ;Reseteamos la posición de las filas (eje Y).
    ld (POS_STR), a

    call _UGDreset              ;Reseteamos la variable del sistema UDG. Para tests unitarios descomantar el include casi al
                                ;final del script. La rutina a la que aquí se llama está en el archivo "_UGDchange.asm".

ret         ;Salimos de la rutina.


;----------------------------------------------- Subrutinas -------------------------------------------------;

;------------------------- AGUSTINA LA SUBRUTINA -------------------------
;Subrutina para tests unitarios. (8 bytes de subrutina).
;Esta subrutina se encuentra en 'outer_grid.asm'.

; Nos posicionamos en la pantalla.

;OUTGRD_POS:
;    ld a, 22                    ;Comando AT del Basic.
;    rst 16
;    ld a, c                     ;Posición eje Y.
;    rst 16
;    ld a, d                     ;Posición eje X.
;    rst 16
;ret        ;Volvemos a la rutina principal.
;---------------------------------------------------------------------

HEX_SIGN:       ;Hex sign ($).
    ld de, CHR2GRD_HEX
    ld bc, 5
    call 8252
ret            ;Volvemos a la rutina principal.

;---------------------------------------------------------------------

INKBRIGHT:
    ld de, CHR2GRD_INI  ;Empezamos con INK 8 y BRIGHT 8.
    ld bc, 4
    call 8252
ret            ;Volvemos a la rutina principal.

;---------------------------------------------------------------------

DRW_ZRO:
    call X_INC                  ;incrementamos el eje x
jr JMP_ZRO                      ;Volvemos a la rutina principal.

DRW_BIT:
    call POS_SCR                ;Nos posicionamos en la rejilla.
    push bc
    call BIN_CHK                ;Comprobamos el modo Binario.
    pop bc                      ;Si BIN mode es ON, saltamos

    jr nz, JMP_BIN              ;Salto a JMP_BIN a imprimir unos.

;Modo normal, imprime pixeles definidos con PIX_CHR:

    ld a, PIX_CHR               ;Imprimimos el píxel
    rst 16                      ;(el modo Bin está OFF).
jr X_INC                    ;Saltamos el modo Bin...

;Modo Binario, imprime unos:

JMP_BIN:
    ld a, "1"
    rst 16

    ;Aquí hay que llamar a la subrutina X_INC y después hacer
    ;un RET, pero como la tenemos a continuación...

;---------------------------------------------------------------------

X_INC:                      ;incrementamos el eje x.
    ld a, (POS_STR+1)
    inc a
    ld (POS_STR+1), a
ret         ;Volvemos a la rutina principal.

;---------------------------------------------------------------------

Y_INC:                      ;Incrementamos la fila (eje y)
    ld a, (POS_STR)
    inc a
    ld (POS_STR), a
ret         ;Volvemos a la rutina principal.

;---------------------------------------------------------------------

BIN_CHK:
    ld a, (BINMOD_)             ;Bin mode is on?
    cp 0
ret         ;Volvemos a la rutina principal.

;---------------------------------------------------------------------

POS_SCR:                    ;Posición de la rejilla.
    ld a, 22                    ;Comando AT (de PRINT AT)
    rst 16

    ld a, (POS_STR)             ;eje y
    rst 16

    ld a, (POS_STR+1)           ;eje x
    rst 16
ret         ;Volvemos a la rutina principal.

;---------------------------------------------------------------------

POS_ADDR:                   ;Posición de las direcciones de memoria.
    ld a, 22                    ;Comando AT (de PRINT AT)
    rst 16

    ld a, (POS_STR)             ;eje y
    rst 16

    ld a, 11                    ;eje x
    rst 16
ret         ;Volvemos a la rutina principal.

;--------------------------------------------------- INCLUDES ---------------------------------------------------;

    INCLUDE "_Int2Str.asm"
    INCLUDE "_Hex2Str.asm"

    ;INCLUDE "_UGDchange.asm"        ;Usarlo sólo para tests unitarios. El include 'weno' está en "__MAIN.asm"

;---------------------------------------------------- DATOS -----------------------------------------------------;

CHR_BUFF                ;Copia del char a dibujar en la rejilla (8 bytes). Abarca hasta el final de ADDR_BUFF.
    db 255
STR_BUFF                ;Aprovechamos para guardar el string de texto (5 bytes).
    db 255, 255, 255, 255, 255
ADDR_BUFF               ;Aquí guardamos la address memory del char (16 bit address, 2 bytes).
    dw 65535

POS_STR     db 7, 21    ;Grid & addresses start position (AT 7,21)
BLANK_VAL   db ",", 16, 5, "   ", 16, 8, 22
GRBIN       db 22, 7, 21, "00000000"
GRID        db 22, 7, 21, "........"
CHR2GRD_INI db 16, 8, 19, 8
CHR2GRD_HEX db 16, 1, "$", 16, 8

;---------------------------------------------------- LABELS ----------------------------------------------------;

PIX_CHR     equ 160         ;Pixel char (UDG 'Q'). El UDG del píxel encendido.

CHADDR_     equ 62973       ;Char Address. Contiene la dirección de memoria del char a dibujar.

C2G_SPMD    equ 62967       ;En esta dir se guarda el modo del Spectrum (0 = 48k, 1 = 128k).
HEXMOD_     equ 62968       ;Modo Hex Off (0) / On (1) addr.
BINMOD_     equ 62969       ;Modo Bin Off (0) / On (1) addr.

PAPCOL_     equ 62970       ;Paper color addr.
DOTCOL_     equ 62971       ;Dots ink color+1 addr.
INKCOL_     equ 62972       ;Pixel ink color+1 addr.
