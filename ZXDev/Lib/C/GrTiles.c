void GrTiles_DrawTile8x8 (unsigned char x, unsigned char y, unsigned int tile);
void GrTiles_DrawMonoTile8x8 (
  unsigned char x, unsigned char y, unsigned int tile, unsigned char colors);
/*================================== Header ==================================*/

void GrTiles_DrawTile8x8 (unsigned char x, unsigned char y, unsigned int tile) {
__asm
  POP  BC
  POP  DE      ; D = y; E = x
  POP  HL      ; tile address
  PUSH HL
  PUSH DE
  PUSH BC
  LD   A,D     ; ����� ����������� �����
  RRCA         ;  ������, ����� ������� �����
  RRCA         ;  � �������� A
  RRCA         ; 3 ������� RRCA
  AND  #0xE0 
  ADD  A,E     ; ��������� �������� �� x
  LD   E,A 
  LD   A,D 
  AND  #0x18 
  OR   #0x40 
  LD   D,A     ; ������� ����� ���������
  LD   B,#7
DRLOOP$:
  LD   A,(HL)  ; ���� ���� �� �����
  LD   (DE),A  ;   � ������ � �����
  INC  HL      ; ���������� fnt adr
  INC  D       ; ���������� scr adr
  DJNZ DRLOOP$
  LD   A,(HL)  ; � ��� 8 ���
  LD   (DE),A
; =========scr adr -> attr adr========
; in: DE - screen adress
; out:DE - attr adress
  LD   A,D     ; 4
  RRCA         ; 4
  RRCA         ; 4
  RRCA         ; 4
  AND  #3      ; 7
  OR   #0x58   ; 7
  LD   D,A     ; 4 = 34t
  INC  HL
  LD   A,(HL)
  LD   (DE),A
__endasm;
} //GrTiles_DrawTile8x8

/*--------------------------------- Cut here ---------------------------------*/
void GrTiles_DrawMonoTile8x8 (
    unsigned char x, unsigned char y, unsigned int tile, unsigned char colors) {
__asm
  LD   HL, #2
  ADD  HL, SP
  LD   E, (HL) // E = x
  INC  HL
  LD   D, (HL) // D = y
  INC  HL
; ====================================
  LD   A,D     ; ����� ����������� �����
  RRCA         ;  ������, ����� ������� �����
  RRCA         ;  � �������� A
  RRCA         ; 3 ������� RRCA
  AND  #0xE0
  ADD  A,E     ; ��������� �������� �� x
  LD   E,A
  LD   A,D
  AND  #0x18
  OR   #0x40
  LD   D,A     ; ������� ����� ���������
; ====================================
  LD   A, (HL)
  INC  HL
  LD   B, (HL) // BA = tile address
  INC  HL
  LD   C, (HL) // C = colors
  LD   L, A
  LD   H, B    ; HL = tile address
; ====================================
  LD   B,#7
DRLOOPM$:
  LD   A,(HL)  ; ���� ���� �� �����
  LD   (DE),A  ;  � ������ � �����
  INC  HL      ; ���������� fnt adr
  INC  D       ; ���������� scr adr
  DJNZ DRLOOPM$
  LD   A,(HL)  ; � ��� 8 ���
  LD   (DE),A
; =========scr adr -> attr adr========
; in: DE - screen adress
; out:DE - attr adress
  LD   A,D     ; 4
  RRCA         ; 4
  RRCA         ; 4
  RRCA         ; 4
  AND  #3      ; 7
  OR   #0x58   ; 7
  LD   D,A     ; 4 = 34t
  LD   A,C     ; tile attrib
  LD   (DE),A
__endasm;
} //GrTiles_DrawMonoTile8x8

