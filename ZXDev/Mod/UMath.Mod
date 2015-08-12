MODULE UMath; IMPORT SYSTEM, B := Basic;

VAR a, b: SHORTINT;

PROCEDURE -UMultBytes (a, b: SHORTINT):
  SHORTINT
  "( ((CHAR)a) * ((CHAR)b) )";
PROCEDURE -UMultWords (a, b: INTEGER):
  INTEGER
  "(((unsigned int)a)*((unsigned int)b))";
PROCEDURE -UDivBytes (a, b: SHORTINT):
  SHORTINT
  "( ((CHAR)a) / ((CHAR)b) )";
PROCEDURE -UDivWords (a, b: INTEGER):
  INTEGER
  "(((unsigned int)a)/((unsigned int)b))";

BEGIN (*$MAIN*)
  B.Init; B.CLS;
  (* �������� �.�. �������� >
                        SIZE(SHORTINT): *)
  a := SYSTEM.VAL(SHORTINT, 255);
  b := SYSTEM.VAL(SHORTINT, 255);

  (* ��������: 65025 (255*255): *)
  B.PRWORD( UMultBytes(a, b) );
  B.PRLN;

  (* ��������: 1 ( (-1)*(-1) ): *)
  B.PRWORD( a * b );
  B.PRLN;
  a := SYSTEM.VAL(SHORTINT, 255); b := 5;

  (* ��������: 51 (255 DIV 5): *)
  B.PRWORD( UDivBytes(a, b) );
  B.PRLN;

  (* ��������: 0 (-1 DIV 5): *)
  B.PRWORD( a DIV b );
  B.Quit
END UMath.