## -Charset Explorer pre RC2 (pasando BASIC a ensamblador...)-

Pasando rutinas del programa BASIC a ensamblador, para recuperar espacio tanto en el programa BASIC
como en el compilado resultante, y ganar velocidad de ejecución en partes clave (como el dibujado
de la rejilla).

```
>Zona actual mas alta de la memoria libre (RAMTOP) antes de compilar: 60685

												>Tamaño del
------------------------ DATOS ESTÁTICOS (RUTINAS ASM) ---------------------	RAMTOP:		 bloque:
    -USR: ENDS:									-------		 ------
    ----- -----									 61319		  2275 bytes.
R:-|60686-61291: Rutina 'useful_loc.asm'    -- PROBANDO --	-- 606 bytes.
R:-|61292-61735: Rutina 'char2grid.asm'	    -- PROBANDO --	-- 444 bytes.
R:-|61736-62223: Rutina 'MHcharsets.asm'    -- PROBANDO --	-- 488 bytes.
R:-|62224-62599: Rutina 'bin_text.asm'	    -- PROBANDO --	-- 376 bytes.
   |62600-62960: Rutinas 'inkeys.asm'	    -- PROBANDO --	-- 361 bytes.
   \
(R:-|-USR 62600: Rutina inkey_save.)
(R:-|-USR 62610: Rutina inkey_edit.)
(R:-|-USR 62620: Rutina inkey_main.)
(R:-|-USR 62630: Rutina inkey_locations.)
(R:-|-USR 62640: Rutina inkey_MHcharsets.)

```
