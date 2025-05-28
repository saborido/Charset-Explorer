;===> Charset Explorer pre RC2 <===> 'MAIN.asm' v3 (2275 bytes en total) <===

;Con este script lo juntamos todo y decidimos la posición en la memoria (ORG):

    ORG 60686

MAIN

    INCLUDE "useful_loc.asm"        ; 606 bytes. (ORG + 0).     -USR 60686
    INCLUDE "char2grid.asm"         ; 444 bytes. (ORG + 606).   -USR 61292
    INCLUDE "MHcharsets.asm"        ; 488 bytes. (ORG + 1050).  -USR 61736
    INCLUDE "bin_text.asm"          ; 376 bytes. (ORG + 1538).  -USR 62224
    INCLUDE "inkeys.asm"            ; 361 bytes. (ORG + 1914).  -USR 62600
;                                   ------------
;                           TOTAL:   2275 bytes.
