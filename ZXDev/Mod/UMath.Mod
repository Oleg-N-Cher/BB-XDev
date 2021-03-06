MODULE UMath; IMPORT SYSTEM, B := Basic, Platform;

VAR a, b: INT8;

PROCEDURE -UMultBytes (a, b: INT8):
  INT8
  "( ((CHAR)a) * ((CHAR)b) )";
PROCEDURE -UMultWords (a, b: INT16):
  INT16
  "(((unsigned int)a)*((unsigned int)b))";
PROCEDURE -UDivBytes (a, b: INT8):
  INT8
  "( ((CHAR)a) / ((CHAR)b) )";
PROCEDURE -UDivWords (a, b: INT16):
  INT16
  "(((unsigned int)a)/((unsigned int)b))";

BEGIN (*$MAIN*)
  B.Init; B.CLS;
  (* �������� �.�. �������� >
                        SIZE(BYTE): *)
  a := Platform.ToBYTE(255);
  b := Platform.ToBYTE(255);

  (* ��������: 65025 (255*255): *)
  B.PRWORD( UMultBytes(a, b) );
  B.PRLN;

  (* ��������: 1 ( (-1)*(-1) ): *)
  B.PRWORD( a * b );
  B.PRLN;
  a := Platform.ToBYTE(255); b := 5;

  (* ��������: 51 (255 DIV 5): *)
  B.PRWORD( UDivBytes(a, b) );
  B.PRLN;

  (* ��������: 0 (-1 DIV0 5): *)
  B.PRWORD( a DIV0 b );
  B.Quit
END UMath.