;===> Charset Explorer pre RC2 <===> 'modulo32.asm' v1 (9 bytes) <===

;Rutina de módulo de 32, gracias a vicentecno. Le pasamos un número de hasta 16 bit
;y nos devuelve el múltiplo de 32 anterior al número proporcionado:

    ;ORG 62975
    ;ORG 60677
    
;MAIN

    ld bc,(62984)
    ld a,c
    and 224	;%11100000
    ld c,a
ret

    ;END 60677
