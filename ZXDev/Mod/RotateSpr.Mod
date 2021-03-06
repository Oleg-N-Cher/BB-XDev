(*$MAIN*) MODULE RotateSpr;

(* "RotateSpr" Demo for Sinclair ZX Spectrum, 48 Kb. *)
(* Copyright (C) 2019 Oleg N. Cher, VEDAsoft. *)

IMPORT L := Laser, B := Basic;

TYPE
  Sprite = ARRAY 83 OF CHAR;

CONST
  SprSizeBytes = ( 5(*hdr*) + 8*4(*data*) + 4(*attrs*) );
  Baraban = Sprite (
    1X, CHR(SprSizeBytes-2), 0X, 2X, 2X, (* SPN, offset, LEN, HGT *)
    0F0X,00FX,000X,000X,0AFX,0F5X,0D7X,0EBX,
    0EBX,0D7X,075X,0AEX,07AX,05EX,07DX,0BEX,
    07DX,0BEX,07AX,05EX,075X,0AEX,0EBX,0D7X,
    0D7X,0EBX,0AFX,0F5X,000X,000X,0FFX,0FFX,
    004X,004X,004X,005X,
    2X, CHR(SprSizeBytes-2), 0X, 2X, 2X, (* SPN, offset, LEN, HGT *)
    000X,000X,000X,000X,000X,000X,000X,000X,
    000X,000X,000X,000X,000X,000X,000X,000X,
    000X,000X,000X,000X,000X,000X,000X,000X,
    000X,000X,000X,000X,000X,000X,000X,000X,
    000X,000X,000X,000X,
    0X
  );

VAR
  spn: INT8;

BEGIN
  B.Init; L.InitSpritesAr(Baraban);
  B.BORDER(B.Green); B.PAPER(B.Black); B.CLS; (* ���������� ������ *)
  spn := 1;
  LOOP (* ������ ���� *)
    L.PTBL(12, 10, spn); (* ������� �� ����� ������ *)
    L.ATOF;
    L.PTBL(16, 10, spn); (* ������� �� ����� �/� ������ *)
    L.ATON;
    L.CLSM(3 - spn); (* ������������ �������� �������� ������ *)
    L.SPNM(3 - spn, spn); (* ������ ������ �� 90 �������� *)
    spn := 3 - spn;
    B.PAUSE(25);
  END;
  (*B.Quit;*)
END RotateSpr.
