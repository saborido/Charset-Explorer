## -Charset Explorer pre RC2 (pasando BASIC a ensamblador...)-

Pasando rutinas del programa BASIC a ensamblador, para recuperar espacio tanto en el programa BASIC
como en el compilado resultante, y ganar velocidad de ejecución en partes clave (como el dibujado
de la rejilla).

```
>Zona actual mas alta de la memoria libre (RAMTOP) antes de compilar: 60685

------------------------ DATOS ESTÁTICOS (RUTINAS ASM) ---------------------	RAMTOP:		 bloque:
    -USR: ENDS:									-------		 ------
    ----- -----									 61319		  2275 bytes.
R:-|60251-60265: Rutina '_UGDchange.asm'    -- PROBANDO --	--  15 bytes.
   \
(R:-|-USR 60251: Entrada de rutina "Change UDG system Variable".)
(R:-|-USR 60259: Entrada de rutina "Reset UDG system Variable".)

R:-|60266-60351: Rutina 'checkboard.asm'    -- PROBANDO --	--  86 bytes.
R:-|60352-60530: Rutina 'outer_grid.asm'    -- PROBANDO --	-- 179 bytes.

R:-|60531-61136: Rutina 'useful_loc.asm'    -- PROBANDO --	-- 606 bytes.
R:-|61137-61735: Rutina 'char2grid.asm'	    -- PROBANDO --	-- 599 bytes.
R:-|61736-62223: Rutina 'MHcharsets.asm'    -- PROBANDO --	-- 488 bytes.
R:-|62224-62599: Rutina 'bin_text.asm'	    -- PROBANDO --	-- 376 bytes.
   |62600-62960: Rutina 'inkeys.asm'	    -- PROBANDO --	-- 361 bytes.
   \
(R:-|-USR 62600: Entrada de rutina inkey_save.)
(R:-|-USR 62610: Entrada de rutina inkey_edit.)
(R:-|-USR 62620: Entrada de rutina inkey_main.)
(R:-|-USR 62630: Entrada de rutina inkey_locations.)
(R:-|-USR 62640: Entrada de rutina inkey_MHcharsets.)

```
