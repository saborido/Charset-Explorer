## -Charset Explorer pre RC2 (pasando BASIC a ensamblador...)-

Pasando rutinas del programa BASIC a ensamblador, para recuperar espacio tanto en el programa BASIC
como en el compilado resultante, y ganar velocidad de ejecución en partes clave (como el dibujado
de la rejilla).

```
>Zona actual mas alta de la memoria libre (RAMTOP) antes de compilar: 61319

	---------------- DATOS ESTÁTICOS (RUTINAS ASM) ----------------				>Tamaño del
										RAMTOP:		 bloque:
										-------		 ------
R:-|61320-61763: Rutina 'char2grid.asm'	    -- PROBANDO --	-- 444 bytes.	 61319		  1641 bytes.
R:-|61764-62251: Rutina 'MHcharsets.asm'    -- PROBANDO --	-- 488 bytes.
R:-|62252-62627: Rutina 'bin_text.asm'	    -- PROBANDO --	-- 376 bytes.
   |62628-62960: Rutinas 'inkeys.asm'	    -- PROBANDO --	-- 333 bytes.
   \
 R:-|-USR 62628: Rutina inkey_save.
 R:-|-USR 62638: Rutina inkey_edit.
 R:-|-USR 62648: Rutina inkey_main.
 R:-|-USR 62658: Rutina inkey_locations.
```
