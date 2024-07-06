# Charset-Explorer

## A character/sprites editor for ZX Spectrum

------------------------
For create multiple charsets and change it with a RANDOMIZE, [Use this tool](https://github.com/saborido/MHC-Routine-Generator) from other of my projects.

![chars_bar](https://github.com/saborido/Charset-Explorer/assets/11407070/12c12dca-0bbb-4332-8618-93302d39c88e)

![charsxp_test (28-3-2022)](https://github.com/saborido/Charset-Explorer/assets/11407070/09b12b79-d10f-4629-b2e8-7321127c1f85)

![charxp_barra_area-](https://github.com/saborido/Charset-Explorer/assets/11407070/fc049220-3168-40a2-bd0e-10b810a5569a)

![seamless](https://github.com/saborido/Charset-Explorer/assets/11407070/9547aadc-4829-4e62-88df-c5704ae3162b)

![save_load](https://github.com/saborido/Charset-Explorer/assets/11407070/70f1a0ee-0f64-49ab-a809-1872e0744890)

### This repository is in under construction (is my first repository ever, i'm trying to learn how this works...)

![chars_bar](https://github.com/saborido/Charset-Explorer/assets/11407070/12c12dca-0bbb-4332-8618-93302d39c88e)

```
-------------------------------------------------------------------------------------------------------------------------
-- Character Explorer v0.96 Berta 3 (16-Oct-2023) --
-------------------------------------------------------------------------------------------------------------------------

					A not so little introduction:
					----------------------------

Word abbreviations:
------------------

	CShift -> 'Caps Shift' key.
	SShift -> 'Symbol Shift' key.
	Char -> Character.
	CharSet -> Character sets.


User interface (View and Edit Mode).png:
---------------------------------------

 Use this image to become familiar with the interface and its various sections and names.


What is View Mode:
-----------------

 It's the mode in which the program starts, which is used to -as its name indicates- see parts of the memory, although
 basic modifications can be made such as rotating, inverting, mirroring and more.

 In this mode you can displace through the entire Spectrum memory.


What is Edit Mode:
-----------------

 This mode is entered by pressing the 'E' key or the 'Enter' key from Viewer Mode, and allows you to modify the char
 from the grid directly, just like a sprite editor. You'll know you're in Edit Mode because the border of the screen
 will change to Cyan. Needless to say this mode is the sauce of this program, otherwise it would be called Character
 Explorer... wait, oops!

 In this mode you CAN NOT displace through all the memory, since there are parts of it protected so that the system
 does not crash by mistake. Note that if you are in Viewer Mode while in a protected part of memory, you will not be
 able to enter Edit Mode until another non-protected part of memory is selected.

 Protected parts appear with a padlock at the bottom of the Area Bar (the coloured bar that appears at the top). See
 'User interface.png' for further clarification.

 Also the colour of the Area Bar indicates whether that part of the memory is protected or not:

	-Dark Blue: This part belongs to the ROM, and can NOT be modified.
	-Red: This area belongs to basic, the program itself and other things, and can NOT be modified.
	-Magenta: This area belongs to the UDG (User Defined Graphics) and YES it can be modified.
	-Green: This area is not protected and CAN be modified.
	-Cyan: This area belongs to the CharSet of the ROM and, obviously, it can NOT be modified.
	-Yellow: It belongs to the System Variables, printer buffer (in 48k), etc. and YES it can be changed, but I'm
		 still thinking that maybe it's not such a good idea to allow it...
	-White: Belongs to the video memory of the screen, and can NOT be modified.

 In short, only the areas that are GREEN, MAGENTA and YELLOW are allowed to modify.

 These restrictions also apply to the modifications that can be made in the Viewer Mode (invert, rotate, etc.). Or at
 least they should, any bug you know, you will make me a very happy person if you let me know. ;)


				Now to what we are interested in, the list of keys:
				--------------------------------------------------

In View Mode:
------------

		-Grid displacement:

	>O:		-1 Char (-8 bytes). 			>P:		+1 Char (+8 bytes). 
	>CShift + O:	-4 Chars (-32 bytes). 			>CShift + P:	+4 Chars (+32 bytes).
	>Q:		-4 Bytes.				>A:		+4 Bytes.
	>CShift + W:	-1 Byte.				>CShift + S:	+1 Byte.
	>I:		-8 Chars (-64 bytes).			>K:		+8 Chars (+64 bytes).
	>CShift + I:	-1 CharSet (-96 chars, -768 bytes.)	>CShift + K:	+1 CharSet (+96 chars, +768 bytes).

	>W: Move up the yellow selection bar.	>S: Move down the yellow selection bar.

		-Overall:
	>B: Binary mode.
	>H: Change the border colour to black (in case you don't like blue).
	>E, Enter: Enters to Edit Mode with cursor in column 4.
	>R: Refreshes the grid and the position and UDG bars.
	>Cshift + R: Reload the program.
	>L: Enter to the 'Useful Locations' menu.
	>CShift + Q: Exit to Basic (type RUN to return to the program).
	>CShift + H: Change from decimal to hexadecimal and vice versa.
	>CShift + B: MicroHobby CharSets presentation and selection screen.
	>D: Change to memory address (Input).

	>G: Change the grid background colour.
	>CShift + G: Changes the colour of the background dots (inactive pixels) of the grid.
	>SShift + K: Changes the ink colour (active pixels) of the grid.

	>CShift + A: Enters to the Save menu.
	>CShift + L: Enters to the Load menu.

	>M: Memory start address selection mark for copying, moving, deleting or saving (Save/Load).
	>CShift + M: End of memory address selection mark for copying, moving, deleting or saving (Save).
	>SShift + M (the dot), clear the selection/save marks you put.

		-Overall (do not appear in the program):

	>SShift + Z: Deletes the data between the selection/save marks.
	>SShift + X: Moves the data from the selection/save marks to the current address.
	>SShift + V: Copies the data from the selection/save marks to the current address.

	>Numbers from 1 to 8, to enter the Edit Mode with the cursor in the column of the pressed number.


		-Some editing:

	>V: Change the value of the memory address selected in yellow (Input).
	>Cshift + D: Deletes the current char.		>CShift + Z: Deletes the row (byte) selected.
	>F: Flip the char vertically.			>CShift + F: Flip the char horizontally.
	>T: Rotate clockwise.				>CShift + T: Rotate anticlockwise.
	>N: Invertir el char

	>SShift + 6, 7, 8 y 9 (Sinclair Joystick): 'Accommodate' the char (displace around the grid).
	>N, SShift + 0 (Shot on Sinclair Joystick): Inverts the char (a negative, 0 is set to 1 and vice versa).

		-Clipboard:

	>C: Copy the value (byte) from the selection.		>CShift + C: Copies the current char (8 bytes).
	>CShift + V: Pastes the value (byte) or char (8 bytes) at current position.
	>CShift + X: Clears the clipboard.


-Legend of what is shown in the Info about the byte (see 'User interface.png' image):

>The colour of the char that appears in the Byte Info section (to the left of the memory addresses), gives you
 information about the byte value of that memory address. It tells you what char represents, if it's a token, an
 UDG, etc.

	>Dark blue: A dot appears, the byte value is less than 32 and doesn't represent any ASCII char. They are
	 control codes used by the Spectrum (cursors, Enter, Delete, colors, etc).

	>Green: The byte value is between 32 and 143, and tells you what ASCII char it represents.

	>Magenta: The byte value is between 144 to 162 in 128k, and up to 164 in 48k, and represents the UDG. The
	 graphic you have defined doesn't appear, only the letter that it represents.

	>Yellow: The byte value is between 162 in 128k or 164 in 48k up to 255, a 'T' appears, saying that it
	 represents a Spectrum token (a basic command, in a nutshell).

In the Edit Mode:
----------------

			-Displacement through the grid:

	>W, A, S, D: Moves the cursor (Up, Left, Down and Right).
	>O, P: Moves the cursor (Left, Right).
	>Q, E, Z, C: Moves the cursor diagonally (Up Left, Up Right, Down Left and Down Right).

	>CShift + O, P: Save the char in memory and move to previous/next char.

			-Pixel writing:

	>X: Activates writing. It's disabled by pressing again the 'X' key or the space bar.
	>CShift + 0, Delete: Activates eraser. It's disabled by pressing '0', 'CShift + 0' or the space bar.
	>N: Turns On pixel at the cursor position (even with writing/eraser active).
	>M: Turns Off pixel at the cursor position (even with writing/eraser active).
	>Barra Espaciadora: Enables/disables pixel at the cursor position.

			-Modifications:

	>Cshift + D: Deletes current char.
	>CShift + Z: Deletes the row (byte) selected in yellow.
	>F: Flip the char vertically.			>CShift + F: Flip the char horizontally.
	>R: Rotate clockwise.				>CShift + R: Rotate anticlockwise.

	>SShift + 6, 7, 8 y 9 (Sinclair Joystick): 'Accommodate' the char (displace around the grid).
	>I, SShift + 0 (Shot on Sinclair Joystick): Inverts the char (a negative, 0 is set to 1 and vice versa).

			-Overall:

	>B: Binary mode.
	>CShift + S: Activate/deactivate sprite mode.
	>CShift + B: Enable/disable seamless mode, to make it easier to draw seamless tiled backgrounds, for example
	 (thanks to Sergio thEpOpE for the suggestion).
	>CShift + E: It does NOT save the char in memory, restores the original and returns to View Mode.
	>Enter: Save the char in memory and returns to Viewer Mode.
	>CShift + Q: Save the modified char in memory and exit to Basic (type RUN to return to program).

			-Overall (do not appear in the program):

	>L: Reloads the UDG, sprite and position bars.
	>SShift + R: Reload the char and the rest (the grid and the UDG, sprite and position bars).
	>1, 2 & 3: Sprite mode offset (-1, +1 & reset at 0).

In the 'Useful Locations' selection menu ('L' key in View Mode), pointing to various memory parts:
-------------------------------------------------------------------------------------------------

	>U: UDG (65368 in 48k and 128k).		-CShift + U: End of UDG (65512 at 128k, 65528 at 48k).
	>A: ROM CharSet (15616).			-CShift + A: End of ROM CharSet (16376).
	>A: MicroHobby CharSet 1 (63064).		-CShift + A: End of MicroHobby CharSet 1 (63824).
	>B: MicroHobby CharSet 2 (63832).		-CShift + B: End of MicroHobby CharSet 2 (64592).
	>C: MicroHobby CharSet 3 (64600).		-CShift + C: End of MicroHobby CharSet 3 (65360).

	>CShift + Q: Exit to Basic (type RUN to return to program).

			-More Useful Locations keys (don't appear in menu):

	>1: 1st third of the screen (16384).
	>2: 2nd third of the screen (18432).
	>3: 3rd third of the screen (20480).
	>4: Screen colour attributes (22528).
	>5: System variables at 128k, printer buffer at 48k (23296). System variables in 48k begins at 23552.
	>6: Program code start (25200).
	>7: Free User Memory (55400).
	>8: Program routines, data and variables (62968).
	>9: MH charset routine (63040).
	>0: Start of ROM (00000).


In the MicroHobby CharSets screen (keys 'CShift + B' in Viewer Mode):
--------------------------------------------------------------------

	>1: Selects CharSet 1 and change the program font (to test a new CharSet, for example).
	>2: Selects CharSet 2 and the same as above.
	>3: Selects CharSet 3 and...

	>Any other key changes to the default font (ROM) and returns to View Mode.


In the Save and Load menus:
---------------------------

	>1: Save/Load UDG's.
	>2: Save/Load MicroHobby CharSets (all three, 288 chars --2304 bytes without routine, --2329 bytes with routine).
	>R: Select save/load with or without routine.

	>3: Save/Load MicroHobby CharSet (only one charset, 96 chars --768 bytes).
	>M: Select area to save/load CharSet (1, 2 or 3).

	>4: Save/Load from/to selection/save mark(s).
	>5: Save/Load from/to custom address.
	>6: Save complete program / Load from file header.

	>T: Save/Load to Tape, Disk or RAM.

	>Any other key returns to View Mode.

 Be careful when loading, because you can load data on top of the program and make it crash. If saving/loading gives you
 an error or you break, return to the program again with a simple RUN.

 If you need to save or load from a different drive (if you have a divIDE, or Spectrum Next's C drive) you must to do
 manually by exiting to Basic (CShift + Q).

 If you plan to load charsets from the ZX Origins page (https://damieng.com/typography/zx-origins) I recommend that you
 load them into one of the three MicroHobby charsets areas (option 3)


Manually save and load data, character sets, or UDGs:
----------------------------------------------------

 To record or load data manually you have to exit to Basic with the CShift + Q keys (better you write down the memory
 address and the length of the data to be recorded/loaded on a piece of paper).

 To load data, you don't need to do any CLEAR. What's more, if you do, you'll probably mess up the program code and you
 won't be able to return to it without crashing. There's already a CLEAR 25199 in the loader, which is where the program
 begins. From where the program ends (around 55400) to 62967, is free memory that can be used.

 Look carefully where you load things so you don't step the program code. Remember that later in your program/game, you
 can load this data in a memory location that is more comfortable for you without any problem.

 You can use this same program to see which parts are free and thus load data without fear of crushing anything. In View
 Mode, use CShift + I/K to move quickly with 768-byte jumps, and without CShift held for 64-byte jumps.

 Don't load anything between the end of the Basic loader (around 25000) to where the program starts (25200), because the
 Spectrum OS will use that gap to do 'its things'.


Differences between  48k and 128k models:
----------------------------------------

 The program tries to detect the spectrum model, and what mode it is currently in (mode 128 or 48). The program also
 detects if there are any connected disk drives. In the 128k models it's possible to use the RAM disk. If it fails to detect the model, it will treat it as a Spectrum 128k (the Russian clones for example).

 Depending on what it detects, it goes into a mode of four different ones:

	-Mode 0: You are on a 48k model, or a 128k model in 48 mode (USR 0, only the Tape can be used).
	-Mode 1: You're in a 128/+2 in 128 mode, or a clone that doesn't detect (RAM disk can be used).
	-Mode 2: You're in a +2A/B in 128 mode (RAM disk can be used).
	-Mode 3: You are on a +3 or a +2A/B with a disk drive attached (either the RAM disk or the disk drive can be used).

 How do these modes differ? Well, practically only in the layout of the storage device, but certain specific things also
 change, which I explain below:

 In the 'Useful Locations' menu, when pressing the 'CShift + U' key to go to the end of the UDGs, in 128k it goes to UDG S,
 and in 48k mode it goes to UDG U (although you can edit the T and U both in 48k and 128k). In the Area Bar, on 48k the
 printer buffer appears, in 128k it doesn't.


About MicroHobby CharSets:
-------------------------

 This program comes with three character sets. They are the ones that came in MicroHobby magazine number 30, in a section
 called 'Customize your Spectrum', but the third one is changed by a set made by me, and the other two with very slight
 changes in some char. You can use them, modify as you like or create new ones.

 Apart from the three sets, in the magazine came a little assembly routine to change to any of the three sets with a
 RANDOMIZE USR, which changes the CHARS system variable. This routine its included.

 In the program, in Viewer Mode, you can press 'CShift + B' to see all three sets, even select one that will change the
 program's text font to see what it would look like. In this charset selection menu you can see next to each set a text
 that says 'USR xxxxx', where 'xxxxx' is the memory address where you have to do the RANDOMIZE USR to change to that
 charset. I'll put it here as well:

	>RANDOMIZE USR 63044 for first set.

	>RANDOMIZE USR 63049 for second set.

	>RANDOMIZE USR 63054 for third set.

	>RANDOMIZE USR 63039 to return to the ROM character set.

 The charset selection routine begins at memory address 63039, and ends at 63063 (inclusive), and is only 25 bytes long.

 If you use these character sets, I recommend that you call the ROM set routine when exiting the program that uses them, especially in 128k Basic mode, or you will see garbage (or straight blanks) instead of the program listing. At runtime,
 the charsets will look fine, in 48k mode this does not occur. It's all ok, neither the listing of your program has been
 corrupted or anything, it's just the way that the Spectrum works.

 The first charset goes from address 63064 (a complete charset is 768 bytes) to 63831, the second from 63832 to 64599, and
 the third from 64600 to 65367 (right up to where the UDG's begin, which is 65368). Keep this in mind if you only want to
 save the charsets (or just some) without the assembler routine mentioned above.

 For more information on MicroHobby charsets, visit the following link:

 https://openlibra.com/es/book/microhobby-30

 Look for the 'Personaliza tu Spectrum' section (page 14). You even have the source code of the assembler routine, which is
 very simple, and you can modify it to add more charsets, or to be able to place the routine in another memory address if
 necessary. If so, remember that the CHARS system variable points to the memory address of the character set MINUS 256.
 That is, you have to tell the CHARS variable that you have the charset 256 bytes less than the position where the charset
 actually is in memory.


Final Notes and Acknowledgments:
-------------------------------

 On the ZX Origins website (https://damieng.com/typography/zx-origins) you have hundreds of complete charsets at your
 disposal for download. This website is pure gold. Thanks a lot to DamienG for creating it.

 If anyone knows any poke or randomize usr or something to switch to Screen mode from basic 128k (the lower screen),
 please tell me how. It would be nice if it appears in this mode when you exit the program, so that the upper screen is
 not deleted and you can have, for example, the addresses to be recorded in view.

 Thank you very much to vicentecno for his asm routine to find multiples of 32, it has been very useful for the sprite bar.
 Many thanks to Sergio thEpOpE for the seamless background suggestion and for his videos. Many thanks to DamienG for his
 awesome text fonts website. Thanks a lot to AsteroideZX for his great Basic course. And thank you very much especially to
 vicentecno, Paco Vespa, Azimov, and in general to all the people on the Arnau Jess discord for putting up with me (Isaías,
 Jimmy), and especially to the #desarrollo channel of the same server. I don't like to name people because you always leave
 someone out, but anyway, thank you very much to everyone...


							Fin
							---

PS: Okay, so many keys may have gotten a bit out of hand. I am so sorry.

PS2: This is a 'little' help. I'll finish the complete manual when version 1.0 of the program comes out (when? who knows!).
     And if it can be, in pdf and with drawings.

PS3: If anyone finds a bug, or that I've left something out in this help, please let me know. Any suggestions in any area
     of the program (keys, ideas, optimization, etc.) are welcome.

PD4: Too many postscripts, right? ;)


--------------------------------------------------------------------------------------------------------------------
-- CharsExp v0.96 Berta 3 (16-Oct-2023) --				 -- By Saúl Saborido ('sulas' on discord) --
--------------------------------------------------------------------------------------------------------------------
```
