/* Ofront+ 1.0 -m3 -21 */
#include "SYSTEM.h"
#include "Basic.h"
#include "GrPixel.h"
#include "Math.h"


static SHORTINT Spiral11_i, Spiral11_x, Spiral11_y;
static REAL Spiral11_yr1, Spiral11_yr2;
static REAL Spiral11_Sina[361], Spiral11_Cosa[361];


static void Spiral11_PrepareTables (void);


/*============================================================================*/

static void Spiral11_PrepareTables (void)
{
	BYTE i, q, _for__3, _for__2;
	Spiral11_Sina[0] = Math_Sin((REAL)0);
	Spiral11_Cosa[0] = Math_Cos((REAL)0);
	GrPixel_PutPixel(37, 0);
	GrPixel_PutPixel(37, 1);
	GrPixel_PutPixel(37, 2);
	GrPixel_PutPixel(0, 0);
	i = 1;
	_for__3 = 36;
	do {
		Spiral11_yr1 = (i * 3.141599893569946) / (SHORTREAL)(SHORTREAL)18;
		Spiral11_Sina[__X(i * 10, 361, "Spiral11", -810)] = Math_Sin(Spiral11_yr1);
		Spiral11_Cosa[__X(i * 10, 361, "Spiral11", -839)] = Math_Cos(Spiral11_yr1);
		Spiral11_yr1 = (Spiral11_Sina[__X(i * 10, 361, "Spiral11", -888)] - Spiral11_Sina[__X((i - 1) * 10, 361, "Spiral11", -888)]) / (REAL)(REAL)10;
		Spiral11_yr2 = (Spiral11_Cosa[__X(i * 10, 361, "Spiral11", -937)] - Spiral11_Cosa[__X((i - 1) * 10, 361, "Spiral11", -937)]) / (REAL)(REAL)10;
		q = 1;
		_for__2 = 9;
		do {
			Spiral11_Sina[__X((i - 1) * 10 + q, 361, "Spiral11", -1012)] = Spiral11_Sina[__X((i - 1) * 10, 361, "Spiral11", -1012)] + Spiral11_yr1 * q;
			Spiral11_Cosa[__X((i - 1) * 10 + q, 361, "Spiral11", -1064)] = Spiral11_Cosa[__X((i - 1) * 10, 361, "Spiral11", -1064)] + Spiral11_yr2 * q;
			q += 1;
		} while (--_for__2);
		GrPixel_PutPixel(i, 0);
		i += 1;
	} while (--_for__3);
}


int main(int argc, char **argv)
{
	__INIT(argc, argv);
	__IMPORT(Basic__init);
	__IMPORT(GrPixel__init);
	__IMPORT(Math__init);
	__REGMAIN("Spiral11", 0);
/* BEGIN */
	Basic_Init();
	Basic_CLS();
	Spiral11_PrepareTables();
	Basic_CLS();
	Spiral11_yr1 = (REAL)80 * Spiral11_Sina[30];
	Spiral11_yr2 = (REAL)80 * Spiral11_Cosa[30];
	Spiral11_i = 720;
	do {
		GrPixel_PutPixel(128 + (SHORTINT)__ENTIER(((REAL)80 * Spiral11_Cosa[__X((INTEGER)__MOD(Spiral11_i * 10, 360), 361, "Spiral11", -1860)]) * Spiral11_Sina[__X(__DIV(Spiral11_i * 5, 20), 361, "Spiral11", -1860)]), 88 + (SHORTINT)__ENTIER((Spiral11_yr1 * Spiral11_Sina[__X((INTEGER)__MOD(Spiral11_i * 10, 360), 361, "Spiral11", -1860)]) * Spiral11_Sina[__X(__DIV(Spiral11_i * 5, 20), 361, "Spiral11", -1860)] - Spiral11_yr2 * Spiral11_Cosa[__X(__DIV(Spiral11_i * 5, 20), 361, "Spiral11", -1860)]));
		Spiral11_i -= 1;
	} while (!(Spiral11_i < 0));
	Basic_PAUSE(0);
	Basic_Quit();
	__FINI;
}
