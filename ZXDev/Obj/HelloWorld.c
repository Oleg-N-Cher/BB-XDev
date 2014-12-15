/*  Ofront 1.2 -xtspkaem */
#include "SYSTEM.h"
#include "Basic.h"


static INTEGER HelloWorld_x;




/*============================================================================*/


export main(int argc, char **argv)
{
	__INIT(argc, argv);
	__IMPORT(Basic__init);
	__REGMAIN("HelloWorld", 0);
/* BEGIN */
	Basic_Init();
	Basic_BORDER(4);
	Basic_PAPER(0);
	Basic_CLS();
	HelloWorld_x = 0;
	while (HelloWorld_x <= 245) {
		Basic_INK(6);
		Basic_PLOT(HelloWorld_x, 127);
		Basic_DRAW(10, 10);
		Basic_INK(3);
		Basic_PLOT(HelloWorld_x, 37);
		Basic_DRAW(10, 10);
		HelloWorld_x += 2;
	}
	Basic_AT(11, 1);
	Basic_PAPER(1);
	Basic_INK(5);
	Basic_BRIGHT(1);
	Basic_FLASH(1);
	Basic_PRSTR((CHAR*)" HELLO WORLD of ZX Spectrum ! ", (LONGINT)31);
	Basic_FLASH(0);
	Basic_PAUSE(0);
	Basic_Quit();
	__FINI;
}
