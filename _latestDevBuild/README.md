## -Charset Explorer pre RC2 (pasando BASIC a ensamblador...) -

Pasando rutinas del programa BASIC a ensamblador, para recuperar espacio tanto en el programa BASIC
como en el compilado resultante, y ganar velocidad de ejecución en partes clave (como el dibujado
de la rejilla).

```
>Zona actual mas alta de la memoria libre (RAMTOP) antes de compilar: 61705
												>Tamaño
		-- RUTINAS ASM --												RAMTOP:		d_chars:
																		-------		--------

R:-|61706-61935: Rutina char2grid.	    -- PROBANDO --	-- 230 bytes.	 61705		  3662
R:-|61936-62311: Rutina bin_text.	    -- PROBANDO --	-- 376 bytes.	 61935		  3432
R:-|62312-62463: Rutina inkey_locations.-- PROBANDO --	-- 152 bytes.	 62311		  3056
R:-|62464-62720: Rutina inkey_main.	    -- PROBANDO --	-- 257 bytes.
R:-|62721-62876: Rutina inkey_edit.	    -- PROBANDO --	-- 156 bytes.
R:-|62877-62960: Rutina inkey_save.	    -- PROBANDO --	--  84 bytes.
```
