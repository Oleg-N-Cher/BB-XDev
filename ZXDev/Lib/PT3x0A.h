/*

3Bit #01 - ����� ������� � �������� PT3.x Player �� RSM.
http://zxpress.ru/article.php?id=9508

*/

#ifndef PT3x0A__h
#define PT3x0A__h


import void PT3x0A_Install (unsigned int module);
import void PT3x0A_Play (void);
import void PT3x0A_Stop (void);
#define PT3x0A__init()

import void __PT3x0A_TabAdr__ (void);
#define PT3x0A_TabAdr()	((int)&__PT3x0A_TabAdr__)

#endif
