;===> Charset Explorer pre RC2 <===> 'MAIN.asm' v3 (1641 bytes en total) <===

;Con este script lo juntamos todo y decidimos la posición en la memoria (ORG):

    ORG 61320

MAIN

    INCLUDE "char2grid.asm"         ; 444 bytes. (ORG + 0).
    INCLUDE "MHcharsets.asm"        ; 488 bytes. (ORG + 444).
    INCLUDE "bin_text.asm"          ; 376 bytes. (ORG + 932).
    INCLUDE "inkeys.asm"            ; 333 bytes. (ORG + 1308).
    ;INCLUDE "useful_loc.asm"        ; 359 bytes. (ORG + 1608)
;                                   ------------
;                           TOTAL:   1641 bytes.
