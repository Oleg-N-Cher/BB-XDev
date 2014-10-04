#include "SYSTEM.h"
#include "GrColors.h"
#include "GrFonts.h"
#include "GrPixel.h"
#include "GrScr.h"
#include "GrTiles.h"
#include "SdlLib.h"

typedef
	struct {
		LONGINT len[1];
		BYTE data[1];
	} *GrConsole_FontPtr;

typedef
	GrTiles_MonoTile8x8 *GrConsole_TilePtr;


static INTEGER GrConsole_curX, GrConsole_curY;
static GrColors_Colors GrConsole_curColors;
static GrConsole_FontPtr GrConsole_curFont;


export void GrConsole_At (INTEGER x, INTEGER y);
export void GrConsole_Clear (INTEGER color);
export void GrConsole_SetColors (GrColors_Colors colors);
export void GrConsole_SetFont (BYTE *font, LONGINT font__len);
export void GrConsole_WriteCh (CHAR ch);
export void GrConsole_WriteInt (INTEGER x);
export void GrConsole_WriteLn (void);
export void GrConsole_WriteStr (CHAR *str, LONGINT str__len);
export void GrConsole_WriteStrLn (CHAR *str, LONGINT str__len);


/*================================== Header ==================================*/

void GrConsole_At (INTEGER x, INTEGER y)
{
	GrConsole_curX = x;
	GrConsole_curY = y;
}

/*--------------------------------- Cut here ---------------------------------*/
void GrConsole_Clear (INTEGER color)
{
	INTEGER x, y, inkTemp;
	GrConsole_curX = 0;
	GrConsole_curY = 0;
	if (GrScr_MustLock && SdlLib_LockSurface(GrScr_Screen) == 0) {
		return;
	}
	inkTemp = GrPixel_ink;
	GrPixel_Ink(color);
	y = GrScr_Screen->h - 1;
	while (y >= 0) {
		x = GrScr_Screen->w - 1;
		while (x >= 0) {
			(*GrPixel_PutPixelNoLock)(x, y);
			x += -1;
		}
		y += -1;
	}
	if (GrScr_MustLock) {
		SdlLib_UnlockSurface(GrScr_Screen);
	}
	GrPixel_Ink(inkTemp);
}

/*--------------------------------- Cut here ---------------------------------*/
void GrConsole_SetColors (GrColors_Colors colors)
{
	GrConsole_curColors = colors;
}

/*--------------------------------- Cut here ---------------------------------*/
void GrConsole_SetFont (BYTE *font, LONGINT font__len)
{
	if (font == GrFonts_ZxSpecRom8x8) {
		GrConsole_curFont = (GrConsole_FontPtr)(font - 256);
	} else {
		GrConsole_curFont = (GrConsole_FontPtr)(font);
	}
}

/*--------------------------------- Cut here ---------------------------------*/
void GrConsole_WriteCh (CHAR ch)
{
	GrConsole_TilePtr tilePtr = NIL;
	tilePtr = (GrConsole_TilePtr)((LONGINT)__ASHL((int)ch, 3) + __VAL(LONGINT, GrConsole_curFont));
	GrTiles_DrawMonoTile8x8(GrConsole_curX, GrConsole_curY, (void*)*tilePtr, 8, GrConsole_curColors);
	GrConsole_curX += 1;
}

/*--------------------------------- Cut here ---------------------------------*/
void GrConsole_WriteLn (void)
{
	GrConsole_curX = 0;
	GrConsole_curY += 1;
}

/*--------------------------------- Cut here ---------------------------------*/
void GrConsole_WriteStr (CHAR *str, LONGINT str__len)
{
	LONGINT n;
	n = 0;
	while (n < str__len && str[__X(n, str__len)] != 0x00) {
		GrConsole_WriteCh(str[__X(n, str__len)]);
		n += 1;
	}
}

/*--------------------------------- Cut here ---------------------------------*/
void GrConsole_WriteStrLn (CHAR *str, LONGINT str__len)
{
	GrConsole_WriteStr(str, str__len);
	GrConsole_WriteLn();
}

/*--------------------------------- Cut here ---------------------------------*/
void GrConsole_WriteInt (INTEGER x)
{
	INTEGER i;
	CHAR buf[10];
	if (x < 0) {
		if (x == (-2147483647-1)) {
			GrConsole_WriteStr((CHAR*)"-2147483648", (LONGINT)12);
			return;
		}
		GrConsole_WriteCh('-');
		x = -x;
	}
	i = 0;
	do {
		buf[__X(i, 10)] = (CHAR)((int)__MOD(x, 10) + 48);
		x = __DIV(x, 10);
		i += 1;
	} while (!(x == 0));
	do {
		i -= 1;
		GrConsole_WriteCh(buf[__X(i, 10)]);
	} while (!(i == 0));
}

/*--------------------------------- Cut here ---------------------------------*/

export void GrConsole__init (void)
{
	__DEFMOD;
	__IMPORT(GrColors__init);
	__IMPORT(GrFonts__init);
	__IMPORT(GrPixel__init);
	__IMPORT(GrScr__init);
	__IMPORT(GrTiles__init);
	__IMPORT(SdlLib__init);
	__REGMOD("GrConsole", 0);
	__REGCMD("WriteLn", GrConsole_WriteLn);
/* BEGIN */
	GrConsole_curX = 0;
	GrConsole_curY = 0;
	GrConsole_curColors.paper = GrColors_Black;
	GrConsole_curColors.ink = GrColors_Gray;
	GrConsole_SetFont((void*)GrFonts_ZxSpecRom8x8, 768);
	__ENDMOD;
}
