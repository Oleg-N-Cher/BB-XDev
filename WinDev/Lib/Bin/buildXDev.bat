@ECHO OFF
SET Lib=..\XDev.a
IF EXIST %Lib% DEL %Lib%

CALL ..\Bin\cc.bat %Lib% SYSTEM
CALL ..\Bin\cc.bat %Lib% Strings
CALL ..\Bin\cc.bat %Lib% CmdLine
CALL ..\Bin\cc.bat %Lib% ConsoleStdIO
CALL ..\Bin\cc.bat %Lib% ConsoleWinAPI
CALL ..\Bin\cc.bat %Lib% Files
CALL ..\Bin\cc.bat %Lib% Delphi
CALL ..\Bin\smart.bat %Lib% Math
