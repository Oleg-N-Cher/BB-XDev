/* Ofront+ 1.0 -sC -48 */
#include "SYSTEM.h"
#include "Ignore.h"
#include "Strings.h"
#include "WinAPI.h"


static LONGINT ConsoleWinAPI_hConOutput;


export void ConsoleWinAPI_SetColors (SHORTINT colors);
export void ConsoleWinAPI_WriteCh (CHAR ch);
export void ConsoleWinAPI_WriteInt (INTEGER n);
export void ConsoleWinAPI_WriteStr (CHAR *str, INTEGER str__len);


/*============================================================================*/

void ConsoleWinAPI_SetColors (SHORTINT colors)
{
	Ignore_Int(WinAPI_SetConsoleTextAttribute(ConsoleWinAPI_hConOutput, colors));
}

/*----------------------------------------------------------------------------*/
void ConsoleWinAPI_WriteCh (CHAR ch)
{
	INTEGER maxLen;
	Ignore_Int(WinAPI_WriteFile(ConsoleWinAPI_hConOutput, (SYSTEM_ADRINT)&ch, 1, &maxLen, NIL, NIL));
}

/*----------------------------------------------------------------------------*/
void ConsoleWinAPI_WriteInt (INTEGER n)
{
}

/*----------------------------------------------------------------------------*/
void ConsoleWinAPI_WriteStr (CHAR *str, INTEGER str__len)
{
	INTEGER maxLen;
	Ignore_Int(WinAPI_WriteFile(ConsoleWinAPI_hConOutput, (SYSTEM_ADRINT)str, Strings_Length((void*)str, str__len), &maxLen, NIL, NIL));
}

/*----------------------------------------------------------------------------*/

export void *ConsoleWinAPI__init(void)
{
	__DEFMOD;
	__IMPORT(Ignore__init);
	__IMPORT(Strings__init);
	__IMPORT(WinAPI__init);
	__REGMOD("ConsoleWinAPI", 0);
/* BEGIN */
	ConsoleWinAPI_hConOutput = WinAPI_GetStdHandle(-11);
	__ENDMOD;
}
