## -Charset Explorer pre RC2 (pasando BASIC a ensamblador...)-

Pasando rutinas del programa BASIC a ensamblador, para recuperar espacio tanto en el programa BASIC
como en el compilado resultante, y ganar velocidad de ejecución en partes clave (como el dibujado
de la rejilla).

```
>Zona actual mas alta de la memoria libre (RAMTOP) antes de compilar: 62021

	-- DATOS ESTÁTICOS (RUTINAS ASM) --                    Tamaño:      RAMTOP:      d_chars:
                                                           -------      -------      --------

R:-|62022-62251: Rutina char2grid.	    -- PROBANDO --	-- 230 bytes.	 62021		 939 bytes.
R:-|62252-62627: Rutina bin_text.	    -- PROBANDO --	-- 376 bytes.

R:-|62628-62960: Rutinas inkeys.asm	    -- PROBANDO --	-- 333 bytes.
   |
    \>USR 62628: Rutina inley_save
    |>USR 62638: Rutina inkey_edit
    |>USR 62648: Rutina inkey_main
    |>USR 62658: Rutina inkey_locations
```
