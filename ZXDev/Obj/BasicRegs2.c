/* Ofront+ 0.9 -xtspkaem */
#include "SYSTEM.h"
#include "Basic.h"
#include "Debug.h"






/*============================================================================*/


int main(int argc, char **argv)
{
	__INIT(argc, argv);
	__IMPORT(Basic__init);
	__IMPORT(Debug__init);
	__REGMAIN("BasicRegs2", 0);
/* BEGIN */
	Basic_Init();
	Basic_CLS();
	Basic_AT(1, 0);
	Basic_COLOR(6);
	Basic_PRSTR((CHAR*)"AT_ROM_fastcall ", 17);
	Debug_SaveRegsDef();
	Basic_AT(1, 16);
	Debug_CheckRegs();
	Basic_COLOR(6);
	Basic_PRSTR((CHAR*)"ATTR_fastcall ", 15);
	Debug_SaveRegsDef();
	if (Basic_ATTR(1, 15) == 0) {
	}
	Debug_CheckRegs();
	Basic_COLOR(6);
	Basic_PRSTR((CHAR*)"BEEP_EI ", 9);
	Debug_SaveRegsDef();
	Basic_BEEP(10, 1);
	Debug_CheckRegs();
	Basic_COLOR(6);
	Basic_PRSTR((CHAR*)"BORDER ", 8);
	Debug_SaveRegsDef();
	Basic_BORDER(3);
	Debug_CheckRegs();
	Basic_COLOR(6);
	Basic_PRSTR((CHAR*)"CIRCLEW_EI ", 12);
	Debug_SaveRegsDef();
	Basic_CIRCLEW(250, 170, 5);
	Debug_CheckRegs();
	Basic_COLOR(6);
	Basic_PRSTR((CHAR*)"DRAW_fastcall ", 15);
	Basic_PLOT(0, 0);
	Debug_SaveRegsDef();
	Basic_DRAW(3, 3);
	Debug_CheckRegs();
	Basic_COLOR(6);
	Basic_PRSTR((CHAR*)"PLOT_fastcall ", 15);
	Debug_SaveRegsDef();
	Basic_PLOT(255, 175);
	Debug_CheckRegs();
	Basic_COLOR(6);
	Basic_PRSTR((CHAR*)"POINT_fastcall ", 16);
	Debug_SaveRegsDef();
	if (Basic_POINT(0, 0)) {
	}
	Debug_CheckRegs();
	Basic_COLOR(6);
	Basic_PRSTR((CHAR*)"PORTIN ", 8);
	Debug_SaveRegsDef();
	if (Basic_PORTIN(254) == 0) {
	}
	Debug_CheckRegs();
	Basic_COLOR(6);
	Basic_PRSTR((CHAR*)"PORTOUT ", 9);
	Debug_SaveRegsDef();
	Basic_PORTOUT(254, 0);
	Debug_CheckRegs();
	Basic_Quit();
	__FINI;
}
