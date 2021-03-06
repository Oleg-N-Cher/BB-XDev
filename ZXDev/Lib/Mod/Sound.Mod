(*

(c) Reobne, 2014

*)

MODULE Sound;
IMPORT SYSTEM, Asm;

TYPE
  Fx* = ADRINT;

PROCEDURE Play* (fx: Fx);
BEGIN
  Asm.Code("  DI");(*����� ���������� �� ��������� ���� �� ���������*)
  Asm.Code("  POP DE");
  Asm.Code("  POP HL");
  Asm.Code("  PUSH HL");
  Asm.Code("  PUSH DE");
  Asm.Code("  LD (PlayPos+1),HL");
  Asm.Code("  LD A,#1");
  Asm.Code("  LD (RunStat+1),A");
  Asm.Code("  EI");
END Play;

PROCEDURE RunMe50Hz* ;
BEGIN
  Asm.Code(".globl PlayPos");
  Asm.Code(".globl RunStat");
  (*������������ A,HL,BC
  ����� ����� A AY, ��������� � ����� ����*)
  Asm.Code("RunStat:  LD A,#0");
  Asm.Code("  AND A");
  Asm.Code("  RET Z");
  Asm.Code("  DEC A");
  Asm.Code("  LD (RunStat+1),A");
  Asm.Code("  RET NZ");
  Asm.Code("PlayPos:  LD HL,#0");
  Asm.Code("  LD A,#8");
  Asm.Code("  LD BC,#65533");
  Asm.Code("  OUT (C),A"); (*�������� ���������*)
  Asm.Code("  LD A,(HL)");
  Asm.Code("  AND A");
  Asm.Code("  JR NZ,R50LABEL1");
  Asm.Code("  LD B,#0xBF");
  Asm.Code("  XOR A");
  Asm.Code("  OUT (C),A"); (*�������� ���������*)
  Asm.Code("  RET");
  Asm.Code("R50LABEL1:  LD A,#1");
  Asm.Code("  LD (RunStat+1),A");
  Asm.Code("  LD A,(HL)");
  Asm.Code("  AND #0xF0");
  Asm.Code("  JR NZ,R50LABEL2");
  Asm.Code("  LD A,(HL)");
  Asm.Code("  ADD A,#2");
  Asm.Code("  LD (RunStat+1),A");
  Asm.Code("  INC HL");
  Asm.Code("  LD A,(HL)");
  Asm.Code("  AND #0xF0");
  Asm.Code("R50LABEL2:  RRCA");
  Asm.Code("  RRCA");
  Asm.Code("  RRCA");
  Asm.Code("  RRCA");
  Asm.Code("  LD B,#0xBF");
  Asm.Code("  OUT (C),A");(*���������*)
  Asm.Code("  LD A,#1");
  Asm.Code("  LD B,#0xFF");
  Asm.Code("  OUT (C),A");(*�������� ������� ���� �������*)
  Asm.Code("  LD A,(HL)");
  Asm.Code("  INC HL");
  Asm.Code("  LD (PlayPos+1),HL");
  Asm.Code("  AND #15");
  Asm.Code("  RET Z");
  Asm.Code("  DEC A");
  Asm.Code("  LD B,#0xBF");
  Asm.Code("  OUT (C),A"); (*c� �������*)
  Asm.Code("  XOR A");
  Asm.Code("  LD B,#0xFF");
  Asm.Code("  OUT (C),A");(*�������� ������� ���� �������*)
  Asm.Code("  LD A,(HL)");
  Asm.Code("  INC HL");
  Asm.Code("  LD (PlayPos+1),HL");
  Asm.Code("  LD B,#0xBF");
  Asm.Code("  OUT (C),A"); (* �� �������*)
END RunMe50Hz;

PROCEDURE Quit* ;
BEGIN
  Asm.Code("  DI");
  (* Basic.PORTOUT(0FFFDH,7) *)
  Asm.Code("  LD BC,#0xFFFD");
  Asm.Code("  LD A,#7");
  Asm.Code("  OUT (C),A");
  (* Basic.PORTOUT(0BFFDH,254); *)
  Asm.Code("  LD B,#0xBF");(*�������� ������ ����� �*)
  Asm.Code("  LD A,#254");
  Asm.Code("  OUT (C),A");
  (* Basic.PORTOUT(0FFFDH,8); *)
  Asm.Code("  LD B,#0xFF");
  Asm.Code("  LD A,#8");
  Asm.Code("  OUT (C),A");
  (* Basic.PORTOUT(0BFFDH,0); *)
  Asm.Code("  LD B,#0xBF");(*������� ���������*)
  Asm.Code("  XOR A");
  Asm.Code("  OUT (C),A");
  Asm.Code("  EI");
END Quit;

PROCEDURE -_init* "Sound_Quit()";

END Sound.
