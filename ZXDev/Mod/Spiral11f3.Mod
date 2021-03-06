(* Spiral on the ball, fast version. (Pascal/Fast, UK-NC) for ZXDev/Oberon-2 *)
(* Copyright (C) 1996 AzAtom *)
(* http://azatom.narod.ru, http://zx-pk.ru/forum.php *)
(* ������������� ����������, ��������� ������� ������� *)

MODULE Spiral11f3;
IMPORT G := Graph, B := Basic, GP := GrPixel;

TYPE
  TSinAr = ARRAY 46 OF INT16;

CONST
  cx = 128; cy = 88; (* Coords of screen center *)
  R = 80; (* Radius. Can be changed from 1 to 88 *)
  A = 30; (* Angle. Can be changed from 0 to 90 *)
  V = 20; (* Number of turns. Can be changed from 1 to .. *)

  (*������� ������� ������ ������� �� 0 �� 90 �������� � ����� � 2 �������, ����� �������� �� 360 ��������*)
  SinStart = TSinAr(0, 9, 18, 27, 36, 44, 53, 62, 71, 79, 88, 96, 104, 112, 120, 128, 136, 143, 150, 158, 165, 171, 178, 184, 190, 196, 202, 207, 212, 217, 222, 226, 230, 234, 237, 241, 243, 246, 248, 250, 252, 254, 255, 255, 256, 256);
  
VAR
  KD, MD: INT16;
  (*ox, oy: SHORTINT;*)
  i, q, r1, r2: INT16;
  Sina, Cosa: ARRAY 361 OF INT16;

PROCEDURE PrepareTables;
VAR
  i, x, y: INT16;
BEGIN
  (* ���������� ������� ������� � ���������*)

  (* �������� ������ ������� � ����� � 2 �� ��������� *)
  (* 0-90 �������� *)
  i := 45;
  x := 0;
  y := 0;
  Sina[y] := SinStart[x];
  q := SinStart[x];
  REPEAT
    x := x + 1;
    y := y + 1;
    Sina[y] := (SinStart[x] + q) DIV 2;
    y := y + 1;
    Sina[y] := SinStart[x];
    q := SinStart[x];
    i := i - 1;
  UNTIL i = 0;

  (* 90-180 �������� *)

  i := 90;
  x := 90;
  REPEAT
    x := x - 1;
    y := y + 1;
    Sina[y] := Sina[x];
    i := i - 1;
  UNTIL i = 0;

  (* 180-360 �������� *)
  i := 180;
  x := 0;
  REPEAT
    x := x + 1;
    y := y + 1;
    Sina[y] := -Sina[x];
    i := i - 1;
  UNTIL i = 0;
  
  (* ������� �� ������ *)
  FOR i := 0 TO 360 DO
    Cosa[i] := Sina[(i+90) MOD 360];
  END;
END PrepareTables;

BEGIN (*$MAIN*)
  KD := G.ZX;
  MD := G.ZXMono;
  G.InitGraph(@KD, @MD, "");

  PrepareTables;

  r1 := (R*Sina[A]) DIV 256; (* ������ �� y *)
  r2 := (R*Cosa[A]) DIV 256; (* ������ �� y *)

  (* ������������ ��� ��������� ������� *)

  (*ox:=128+(((R*Cosa[0]) DIV 256)*Sina[0]) DIV 256;
  oy:=88+((((r1*Sina[0]) DIV 256)*Sina[0]) DIV 256)-((r2*Cosa[0]) DIV 256);*)

  i := V * 36;
  REPEAT
    GP.PutPixel(
    (* ����� i ����� �� v*36, ������ ������� ������ v ��� ����� �� 360. *)
    (* ����� i ����� �� v*36, ������ ����� ������ ����� �� 180. *)
    cx + R*Cosa[i*10 MOD 360] DIV 256 * Sina[i*5 DIV V] DIV 256,
    (* ����� i ����� �� v*36, ������ ����� ������ v ��� ����� �� 360. *)
    (* ����� i ����� �� v*36, ������ ����� ������ ����� �� 180. *)
    (* ����� i ����� �� v*36, ������ ������� ������ ����� �� 180. *)
    cy + r1*Sina[i*10 MOD 360] DIV 256 * Sina[i*5 DIV V] DIV 256
       - r2*Cosa[i*5 DIV V] DIV 256
    );
  DEC(i);
  UNTIL i < 0;

  G.CloseGraph
END Spiral11f3.
