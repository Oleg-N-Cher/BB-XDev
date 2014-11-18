/*  Ofront 1.2 -xtspkae */
#include "SYSTEM.h"


export void GrTiles_DrawTile8x8 (SHORTCARD x, SHORTCARD y, CARDINAL tile);
export void GrTiles_DrawMonoTile8x8 (SHORTCARD x, SHORTCARD y, CARDINAL tile, SHORTINT colors);


/*================================== Header ==================================*/

void GrTiles_DrawTile8x8 (SHORTCARD x, SHORTCARD y, CARDINAL tile)
{
__asm
#ifdef __SDCC
  PUSH IX
  LD   IX,#0
  ADD  IX,SP
#endif
  LD   E,4(IX) ; x
  LD   D,5(IX) ; y
  LD   L,6(IX)
  LD   H,7(IX) ; Tile address
  LD   A,D     ; ����� ����������� �����
  RRCA         ; ������, ����� ������� �����
  RRCA         ; � �������� A
  RRCA         ; 3 ������� RRCA
  AND  #0xE0 
  ADD  A,E     ; ��������� �������� �� X 
  LD   E,A 
  LD   A,D 
  AND  #0x18 
  OR   #0x40 
  LD   D,A     ; ������� ����� ���������
  LD   B,#7
DRLOOP$:
  LD   A,(HL)          ;����� ���� �� �����
  LD   (DE),A          ;� ������ � �����
  INC  HL              ;���������� fnt adr
  INC  D               ;���������� scr adr
  DJNZ DRLOOP$
  LD   A,(HL)          ;� ��� 8 ���
  LD   (DE),A
; =========scr adr -> attr adr========
; in: DE - screen adress
; out:DE - attr adress
  LD   A,D         ; 4
  RRCA             ; 4
  RRCA             ; 4
  RRCA             ; 4
  AND  #3          ; 7
  OR   #0x58       ; 7
  LD   D,A         ; 4 = 34
  INC  HL
  LD   A,(HL)
  LD   (DE),A
#ifdef __SDCC
  POP  IX
#endif
__endasm;
} //GrTiles_DrawTile8x8

/*--------------------------------- Cut here ---------------------------------*/
void GrTiles_DrawMonoTile8x8 (SHORTCARD x, SHORTCARD y, CARDINAL tile, SHORTINT colors)
{
__asm
#ifdef __SDCC
  PUSH IX
  LD   IX,#0
  ADD  IX,SP
#endif
  LD   E,4(IX) ; x
  LD   D,5(IX) ; y
  LD   L,6(IX)
  LD   H,7(IX) ; Tile address
  LD   A,D     ; ����� ����������� �����
  RRCA         ; ������, ����� ������� �����
  RRCA         ; � �������� A
  RRCA         ; 3 ������� RRCA
  AND  #0xE0
  ADD  A,E     ; ��������� �������� �� X
  LD   E,A
  LD   A,D
  AND  #0x18
  OR   #0x40
  LD   D,A     ; ������� ����� ���������
  LD   B,#7
DRLOOPM$:
  LD   A,(HL)          ;����� ���� �� �����
  LD   (DE),A          ;� ������ � �����
  INC  HL              ;���������� fnt adr
  INC  D               ;���������� scr adr
  DJNZ DRLOOPM$
  LD   A,(HL)          ;� ��� 8 ���
  LD   (DE),A
; =========scr adr -> attr adr========
; in: DE - screen adress
; out:DE - attr adress
  LD   A,D         ; 4
  RRCA             ; 4
  RRCA             ; 4
  RRCA             ; 4
  AND  #3          ; 7
  OR   #0x58       ; 7
  LD   D,A         ; 4 = 34
  LD   A,8(IX)     ; Tile attrib
  LD   (DE),A
#ifdef __SDCC
  POP  IX
#endif
__endasm;
} //GrTiles_DrawMonoTile8x8

