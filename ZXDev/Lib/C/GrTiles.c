void GrTiles_DrawTile8x8 (unsigned char x, unsigned char y, unsigned int tile) __z88dk_callee;
void GrTiles_DrawMonoTile8x8 (
  unsigned char x, unsigned char y, unsigned int tile, unsigned char colors) __z88dk_callee;
void GrTiles_GetTile8x8 (unsigned char x, unsigned char y, unsigned int tile) __z88dk_callee;
void GrTiles_GetMonoTile8x8 (unsigned char x, unsigned char y, unsigned int tile) __z88dk_callee;
/*================================== Header ==================================*/

void GrTiles_DrawTile8x8 (unsigned char x, unsigned char y, unsigned int tile) __naked __z88dk_callee {
__asm
  POP  HL
  POP  DE      ; D = y; E = x
  EX   (SP),HL ; tile address
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
GTLOOP$:
  LD   A,(HL)  ; ���� ���� �� �����
  LD   (DE),A  ;   � ������ � �����
  INC  HL      ; ���������� fnt adr
  INC  D       ; ���������� scr adr
  DJNZ GTLOOP$
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
  RET
__endasm;
} //GrTiles_DrawTile8x8

/*--------------------------------- Cut here ---------------------------------*/
void GrTiles_GetMonoTile8x8 (unsigned char x, unsigned char y, unsigned int tile) __naked __z88dk_callee {
__asm
  POP  HL
  POP  DE      ; D = y; E = x
  EX   (SP),HL ; tile address
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
GTLOOPM$:
  LD   A,(DE)  ; ���� ���� �� �����
  LD   (HL),A  ;   � ������ � �����
  INC  HL      ; ���������� fnt adr
  INC  D       ; ���������� scr adr
  DJNZ GTLOOPM$
  LD   A,(DE)  ; � ��� 8 ���
  LD   (HL),A
  RET
__endasm;
} //GrTiles_GetMonoTile8x8
/*--------------------------------- Cut here ---------------------------------*/

void GrTiles_GetTile8x8 (unsigned char x, unsigned char y, unsigned int tile) __naked __z88dk_callee {
__asm
  CALL _GrTiles_GetMonoTile8x8
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
  LD   A,(DE)
  LD   (HL),A
  RET
__endasm;
} //GrTiles_GetTile8x8

/*--------------------------------- Cut here ---------------------------------*/
void GrTiles_DrawMonoTile8x8 (
    unsigned char x, unsigned char y, unsigned int tile, unsigned char colors) __naked __z88dk_callee {
__asm
  POP  BC
  POP  DE      ; D = y; E = x
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
  POP  HL      ; HL = tile address
  DEC  SP
  POP  AF      ; A = colors
  PUSH BC
  LD   C,A     ; C = colors
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
  RET
__endasm;
} //GrTiles_DrawMonoTile8x8

