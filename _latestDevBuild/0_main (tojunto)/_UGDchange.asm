;===> Charset Explorer pre RC2 <===> '_UDGchange.asm' v1 (15 bytes) <===

    ;ORG 60251

;MAIN
_UGDchange:
    ld de, 62864        ;Change UDG system Variable.
    ld (23675), de
ret

;ORG +8 bytes:
_UGDreset:
    ld hl, 65368        ;Reset UDG system Variable to default.
    ld (23675), hl
ret
