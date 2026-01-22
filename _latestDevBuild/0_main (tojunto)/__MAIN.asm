;===> Charset Explorer pre RC2 <===> '__MAIN.asm' v3 (2710 bytes en total) <===

;Con este script lo juntamos todo y decidimos la posición en la memoria (ORG):

    ORG 60251

MAIN
    ;INCLUDE "modulo32.asm"          ;   9 bytes. (ORG + ¿?).    -USR xxxxx
    ;INCLUDE "MHC_routine.asm"       ;  25 bytes. (ORG + ¿?).    -USR xxxxx

    INCLUDE "_UGDchange.asm"        ;  15 bytes. (ORG + ¿?).    -USR 60251
    INCLUDE "checkboard.asm"        ;  86 bytes. (ORG + ¿?).    -USR 60266
    INCLUDE "outer_grid.asm"        ; 179 bytes. (ORG + ¿?).    -USR 60352
    INCLUDE "useful_loc.asm"        ; 606 bytes. (ORG + ¿?).    -USR 60531
    INCLUDE "char2grid.asm"         ; 599 bytes. (ORG + ¿?).    -USR 61137
    INCLUDE "MHcharsets.asm"        ; 488 bytes. (ORG + ¿?).    -USR 61736
    INCLUDE "bin_text.asm"          ; 376 bytes. (ORG + ¿?).    -USR 62224
    INCLUDE "inkeys.asm"            ; 361 bytes. (ORG + ¿?).    -USR 62600
;                                    ------------
;                            TOTAL:   2710 bytes.
