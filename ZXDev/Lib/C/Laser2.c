/*********************/
/*   LASER BASIC 2   */
/*  by Oleg N. Cher  */
/*   zx.oberon2.ru   */
/*********************/

extern unsigned int Laser2_SPRT_ADR;  // Sprite file start address

// Functions for screen windows processing

void Laser2_ATOF_INSCR (void);
void Laser2_ATON_INSCR (void);
void Laser2_PTBL_INSCR (signed char col, signed char row, unsigned char spn);
void Laser2_PTOR_INSCR (signed char col, signed char row, unsigned char spn);
void Laser2_PTND_INSCR (signed char col, signed char row, unsigned char spn);
void Laser2_PTXR_INSCR (signed char col, signed char row, unsigned char spn);

void Laser2_PTBL_OUTSCR (signed char col, signed char row, unsigned char spn);
void Laser2_PTOR_OUTSCR (signed char col, signed char row, unsigned char spn);
void Laser2_PTND_OUTSCR (signed char col, signed char row, unsigned char spn);
void Laser2_PTXR_OUTSCR (signed char col, signed char row, unsigned char spn);

/* ������� �������� � ������ � ��������� �������:
���� 1 - ����� �������.
���� 2 - ������� ���� ������� ������� (9*HGT*LEN+3).
���� 3 - ������� ���� ������� �������.
���� 4 - ����� �������.
���� 5 - ������ �������.
8*HGT*LEN - ������ � ���������
��������.
HGT*LEN - ��������.
  �����: 9*HGT*LEN+5 ������.
*/
/* This is C realization of Set sprite relocs ===

static typedef struct Sprite {
  BYTE sprN;
  struct Sprite *sprNext;
  BYTE sprLen;
  BYTE sprHgt;
};
*/
/*================================== Header ==================================*/

unsigned int Laser2_SPRT_ADR;  // Sprite file start address

/*--------------------------------- Cut here ---------------------------------*/
void Laser2_ATOF_INSCR (void)
{
__asm
             LD    HL, #Laser2_ATOF0_IN
             XOR   A
             LD    (HL), A     ; "NOP"
             INC   HL
             LD    (HL), A     ; "NOP"
             INC   HL
             LD    (HL), A     ; "NOP"

             LD    HL, #Laser2_ATOF_IN
             LD    (HL), #0x09 ; "ADD HL, BC"
             INC   HL
             LD    (HL), #0x18 ; "JR  XX"
             INC   HL
             LD    (HL), #16   ; "XX"
__endasm;
} //Laser2_ATOF_INSCR

/*--------------------------------- Cut here ---------------------------------*/
void Laser2_ATON_INSCR (void)
{
__asm
             LD    HL, #Laser2_ATOF0_IN
             LD    (HL), #0x22 ; "LD (Laser2_ATOF_IN+1), HL"
             INC   HL
             LD    (HL), #<Laser2_ATOF_IN+1
             INC   HL
             LD    (HL), #>Laser2_ATOF_IN+1
             
             LD    A, #0x11    ; "LD DE, NN"
             LD    (#Laser2_ATOF_IN), A
__endasm;
} //Laser2_ATON_INSCR

/*--------------------------------- Cut here ---------------------------------*/

void Laser2_PTBL_INSCR (signed char col, signed char row, unsigned char spn) __naked {
__asm
             POP   HL
             POP   BC        ; C = col; B = row
             POP   DE        ; E = spn
             PUSH  DE
             PUSH  BC
             PUSH  HL
             XOR   A         ; NOP
             JP    _Laser2_PUT_SPRITE_INSCR
__endasm;
} //Laser2_PTBL_INSCR

/*--------------------------------- Cut here ---------------------------------*/
void Laser2_PTOR_INSCR (signed char col, signed char row, unsigned char spn) __naked {
__asm
             POP   HL
             POP   BC        ; C = col; B = row
             POP   DE        ; E = spn
             PUSH  DE
             PUSH  BC
             PUSH  HL
             LD    A, #0xB6  ; OR (HL)
             JP    _Laser2_PUT_SPRITE_INSCR
__endasm;
} //Laser2_PTOR_INSCR

/*--------------------------------- Cut here ---------------------------------*/
void Laser2_PTXR_INSCR (signed char col, signed char row, unsigned char spn) __naked {
__asm
             POP   HL
             POP   BC        ; C = col; B = row
             POP   DE        ; E = spn
             PUSH  DE
             PUSH  BC
             PUSH  HL
             LD    A, #0xAE  ; XOR (HL)
             JP    _Laser2_PUT_SPRITE_INSCR
__endasm;
} //Laser2_PTXR_INSCR

/*--------------------------------- Cut here ---------------------------------*/
void Laser2_PTND_INSCR (signed char col, signed char row, unsigned char spn) __naked {
__asm
             POP   HL
             POP   BC        ; C = col; B = row
             POP   DE        ; E = spn
             PUSH  DE
             PUSH  BC
             PUSH  HL
             LD    A, #0xA6  ; AND (HL)
             JP    _Laser2_PUT_SPRITE_INSCR
__endasm;
} //Laser2_PTND_INSCR

/*--------------------------------- Cut here ---------------------------------*/

/* ������� �������� � ������ � ��������� �������:
���� 1 - ����� �������.
���� 2 - ������� ���� ������� ������� (9*HGT*LEN+3).
���� 3 - ������� ���� ������� �������
���� 4 - ����� �������.
���� 5 - ������ �������.
8*HGT*LEN - ������ � ���������
��������.
HGT*LEN - ��������.
  �����: 9*HGT*LEN+5 ������.
*/

void Laser2_PUT_SPRITE_OUTSCR (void) __naked {
//  A: mode; C: col; D: row; E: spn
__asm
             LD    (SPRT_MODE$), A ; Set draw mode
             LD    (SPRT_XY$+1), HL
             LD    HL, (_Laser2_SPRT_ADR)
FIND_BY_N$:  LD    A, (HL)         ; N of a sprite
             OR    A
             RET   Z
             INC   HL
             CP    E               ; spn
             JR    Z, SPRT_FOUND$
             LD    C, (HL)
             INC   HL
             LD    B, (HL)
             ADD   HL, BC          ; + offset to next sprite
             JR    FIND_BY_N$
SPRT_FOUND$: INC   HL
             INC   HL
SPRT_XY$:    LD    DE, #0
             LD    A, #32          ; 32
             SUB   D               ; - col
             CP    (HL)            ; < len
             JR    NC, SAVE_LEN$
             LD    A, (HL)         ; IF 32-col < len THEN len := 32-col
SAVE_LEN$:   LD    (SPRT_LINE8$+1), A
             LD    B, A            ; |len|
             SUB   (HL)
             NEG
             //LD    (SAVE_REST$+1)  ; rest := len - |len|
             INC   HL
             LD    A, #24          ; 24
             SUB   E               ; - row
             CP    (HL)            ; < hgt
             JR    NC, SAVE_HGT$
             LD    A, (HL)         ; IF 32-row < hgh THEN hgt := 32-row
SAVE_HGT$:   LD    (SPRT_HGT_8$+1), A
Laser2_ATON$:
             LD    C, A            ; |hgt|

;��������� ������� ������ ��������� �� ���������
; (c) �.��������, �.�����, 1996.
; http://zxpress.ru/book_articles.php?id=633
;������ ������� (E = X; D = Y; 12B; 61T):
             LD    A, D            ;  4
             ADD   A, A            ;  4
             ADD   A, A            ;  4
             ADD   A, A            ;  4
             LD    L, A            ;  4
             LD    H, #0x16        ;  7
             ADD   HL, HL          ; 11
             ADD   HL, HL          ; 11
             LD    A, L            ;  4
             OR    E               ;  4
             LD    L, A            ;  4
/*
;������ ������� (H = X; L = Y; 10B; 74T):
             LD    A, H            ;  4
             ADD   HL, HL          ; 11
             ADD   HL, HL          ; 11
             ADD   HL, HL          ; 11
             LD    H, #0x16        ;  7
             ADD   HL, HL          ; 11
             ADD   HL, HL          ; 11
             ADD   A, L            ;  4
             LD    L, A            ;  4
*/
;�� ������ ����� �������� � HL - ����� ����� ���������.

OUT_ATR_HLINE$:
             PUSH  BC
             PUSH  HL
OUT_ATR_LINE$:
             LD    A, (DE)
             LD    (HL), A
             INC   DE
             INC   L
             DJNZ  OUT_ATR_LINE$
SAVE_REST$:                        ; Correction of the attributes adress
             LD    HL, #0          ; 10
             ADD   HL, DE          ; 11
             LD    E, L            ;  4
             LD    D, H            ;  4  =>  29
             POP   HL
             LD    BC, #32
             ADD   HL, BC
             POP   BC
             DEC   C
             JR    NZ, OUT_ATR_HLINE$


SPRT_HGT_8$: LD    B, #0           ; Height of sprite
SPRT_HLINE$: PUSH  BC              ; Begin of loop on charlines
             LD    C, #8           ; Height of a character field (charline)
             PUSH  HL
SPRT_LINE8$: LD    B, #0           ; Draw 8 lines (one charline)
             PUSH  HL              ; Draw W bytes (one line)
SPRT_LINE$:  LD    A, (DE)

SPRT_MODE$:  NOP                   ; NOP | AND (HL) | OR (HL) | XOR (HL)
             LD    (HL), A
             INC   HL
             INC   DE
             DJNZ  SPRT_LINE$
             POP   HL
             INC   H               ; Next screen line
             DEC   C
             JR    NZ, SPRT_LINE8$
             POP   HL
             LD    A, #0x20        ; Next charline
             ADD   L
             LD    L, A            ; If carry then jump to next third of screen
             JR    NC, CONTIN_1_3$
             LD    A, #0x08        ; Next third of screen
             ADD   A, H
             LD    H, A            ; HL = HL + 0x0800
CONTIN_1_3$: POP   BC
             DJNZ  SPRT_HLINE$     ; End of loop on charlines (the same third)
             RET

/* http://zxpress.ru/book_articles.php?id=639

  (�) ������� ������
                �. ��������������, 1996

   �������� �� ���������.

1. ��� ��������� ������� �� ����� ������ ������������ ������������, ��������
��� �����:

    �----�  �-�
    �--� �--� �
       �------�

   ������ �������: ��������� - 1 ���� - ���������� ��������� � �������;
������ ������� - 1 ���� Y ����������, 2 ���� X ���������� (����������
������������� �� ������ �������� ���� �������). ����� 8 ���� ������
����������.
   ������� ���������: HL - ����� ������ �������; DE - ���������� X,Y
���������� ������ �������� ���� �������; A - ����� ������ ������� ( �
������������ ���� SP_PUT � � ���������� ����������� SP_OR, SP_XOR, SP_AND).
���� ����� ������� ��� ���� ������ ������� �� ������� ������, �� �� ������
�� ����������.

SP_PUT    EQU  #00
SP_OR     EQU  #B6
SP_XOR    EQU  #AE
SP_AND    EQU  #A6
PTBL      LD   (SPRT_MODE),A
          LD   A,(HL)
          INC  HL
PTBL_1    PUSH AF
          PUSH DE
          LD   A,(HL)
          ADD  A,E
          CP   #18
          JR   NC,PTBL_4
          LD   E,A
          INC  HL
          LD   A,(HL)
          ADD  A,D
          CP   32
          JR   NC,PTBL_5
          LD   D,A
          INC  HL
          PUSH HL
          LD   A,E
          AND  #18
          ADD  A,#40
          LD   H,A
          LD   A,E
          AND  7
          RRCA
          RRCA
          RRCA
          ADD  A,D
          LD   L,A
          POP  DE
          LD   B,8
PTLB_2    LD   A,(DE)
MODE      NOP
          LD   (HL),A
          INC  H
          INC  DE
          DJNZ PTBL_2
          EX   DE,HL
PTBL_3    POP  DE
          POP  AF
          DEC  A
          JR   NZ,PTBL_1
          RET
PTBL_4    INC  HL
PTBL_5    LD   DE,9
          ADD  HL,DE
          JR   PTBL_3

   ����� ����� - ���� � ���������� � ����� ����� "�����" <��� �������� ���� ��
����������>. */

__endasm;
} //Laser2_PUT_SPRITE

/*--------------------------------- Cut here ---------------------------------*/
void Laser2_PUT_SPRITE_INSCR (void) __naked {
//  A: mode; C: col; D: row; E: spn
__asm
.globl Laser2_ATOF0_IN
.globl Laser2_ATOF_IN

                 LD    (SPRT_MODE_IN$), A ; Set draw mode

;��������� ������� ������ ��������� �� ���������
; (c) �.��������, �.�����, 1996.
; http://zxpress.ru/book_articles.php?id=633
;������ ������� (C = X; B = Y; 12B; 61T):
                 LD    A, B            ;  4
                 ADD   A, A            ;  4
                 ADD   A, A            ;  4
                 ADD   A, A            ;  4
                 LD    L, A            ;  4
                 LD    H, #0x16        ;  7
                 ADD   HL, HL          ; 11
                 ADD   HL, HL          ; 11
                 LD    A, L            ;  4
                 OR    C               ;  4
                 LD    L, A            ;  4
/*
;������ ������� (H = X; L = Y; 10B; 74T):
                 LD    A, H            ;  4
                 ADD   HL, HL          ; 11
                 ADD   HL, HL          ; 11
                 ADD   HL, HL          ; 11
                 LD    H, #0x16        ;  7
                 ADD   HL, HL          ; 11
                 ADD   HL, HL          ; 11
                 ADD   A, L            ;  4
                 LD    L, A            ;  4
*/
;�� ������ ����� �������� � HL - ����� ����� ���������.
Laser2_ATOF0_IN:
                 LD    (Laser2_ATOF_IN+1), HL
                 
;������ ��������� ������ �� ������ ���������
; (c) �.��������, �.�����, 1996.
; http://zxpress.ru/book_articles.php?id=633
;����: HL = ����� ���������
                 LD    A, H            ; 4
                 ADD   A, A            ; 4
                 ADD   A, A            ; 4
                 ADD   A, A            ; 4
                 AND   #0x7F           ; 7
                 LD    H, A            ; 4 = 27T
;�����: HL = �������� �����
                 LD    (SCR_ADR_IN$+1), HL
                 
                 LD    HL, (_Laser2_SPRT_ADR)
FIND_BY_N_IN$:   LD    A, (HL)         ; N of a sprite
                 OR    A
                 RET   Z
                 INC   HL
                 CP    E               ; spn
                 JR    Z, SPRT_FOUND_IN$
                 LD    C, (HL)
                 INC   HL
                 LD    B, (HL)
                 ADD   HL, BC          ; + offset to next sprite
                 JR    FIND_BY_N_IN$
SPRT_FOUND_IN$:  INC   HL
                 INC   HL
                 LD    A, (HL)         ; len
                 LD    (SPRT_HGT_A_IN$+1), A
                 LD    (SPRT_HGT_S_IN$+1), A
                 INC   HL
                 LD    B, (HL)         ; height of sprite
                 INC   HL
SPRT_HLINE_IN$:  PUSH  BC              ; Begin of loop on charlines
SPRT_HGT_A_IN$:  LD    BC, #0
Laser2_ATOF_IN:  LD    DE, #0          ; ATOF$: ADD HL, BC : JR XX [SCR_ADR_IN$]
                 LDIR                         ; 2
                 LD    E, L                   ; 1
                 LD    D, H                   ; 1
                 LD    HL, (Laser2_ATOF_IN+1) ; 3
                 LD    BC, #0x20              ; 3
                 ADD   HL, BC                 ; 1
                 LD    (Laser2_ATOF_IN+1), HL ; 3
                 LD    L, E                   ; 1
                 LD    H, D                   ; 1 => 16
                 
SCR_ADR_IN$:     LD    DE, #0
SPRT_HGT_S_IN$:  LD    BC, #0x0800     ; Height in a character fields (charlines)
                 //PUSH  DE              ; Draw W lines (one line)
SPRT_CHAR_IN$:   LD    A, (HL)
SPRT_MODE_IN$:   NOP                   ; NOP | AND (HL) | OR (HL) | XOR (HL)
                 LD    (DE), A
                 INC   HL
                 INC   D
                 DJNZ  SPRT_CHAR_IN$
                 LD    B, #8           ; Draw 8 bytes (one charline)
                 LD    A, D
                 SUB   A, B
                 LD    D, A
                 INC   E               ; Next screen line
                 DEC   C
                 JR    NZ, SPRT_CHAR_IN$
                 //POP   DE
                 LD    A, #0x20        ; Next charline
                 ADD   E
                 LD    D, A            ; If carry then jump to next third of screen
                 JR    NC, CONTIN_1_3_IN$
                 LD    A, #0x08        ; Next third of screen
                 ADD   A, D
                 LD    D, A            ; DE = DE + 0x0800
CONTIN_1_3_IN$:  LD    (SCR_ADR_IN$+1), DE
                 POP   BC
                 DJNZ  SPRT_HLINE_IN$  ; End of loop on charlines (the same third)
                 RET
__endasm;
} //Laser2_PUT_SPRITE_INSCR
