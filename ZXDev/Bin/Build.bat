@ECHO OFF
SET ZXDev=%XDev%\ZXDev
IF "%XDev%"=="" SET ZXDev=..

IF "%MainMod%"=="" SET MainMod=%1
IF "%MainMod%"=="%1" GOTO Build

:Compile

IF EXIST %1.sym MOVE /Y %1.sym %1.osm
SET SaveOptions=%Options%
SET SaveInclude=%Include%
CALL %ZXDev%\Bin\compile.bat %1
SET Options=%SaveOptions%
SET Include=%SaveInclude%
IF EXIST %1.osm MOVE /Y %1.osm %1.sym

:Build

IF "%CodeAdr%"=="" SET CodeAdr=45056
IF "%DataAdr%"=="" SET DataAdr=63488
SET Options=%Options% -mz80 --no-xinit-opt --opt-code-size --reserve-regs-iy --code-loc %CodeAdr% --data-loc %DataAdr% --disable-warning 59 --disable-warning 85 --disable-warning 126
SET Include=%Include% -I%ZXDev%\Lib\C -I%ZXDev%\Lib\Obj
SET Libraries=%Libraries% -L%ZXDev%\Lib XDev.lib Graph.lib Basic.lib Laser.lib MegaBasic.lib Best40.lib trdos.lib libspr.lib Supercode.lib NewSupercode.lib MiraMod2.lib Pt3xPlayer.lib Wham.lib ZX7.lib CalcZX.lib Laser2.lib Mem128.lib Out6x8.lib Cursor.lib StcPlayer.lib Pt3Player.lib KMouse.lib
IF "%Target%"=="" SET Target=TAP
IF "%Clean%"=="" SET Clean=TRUE
IF "%Start%"=="" SET Start=TRUE
IF "%Pause%"=="" SET Pause=FALSE

SET SDCC=%ZXDev%\Bin\sdcc.exe %Options% %Modules% %Libraries%

IF EXIST %MainMod% GOTO Config

%SDCC% %MainMod%.c -I. -I..\Lib -I%ZXDev%\Lib %Include%
GOTO Link

:Config

%SDCC% %MainMod%.c -I%MainMod% %Include%

:Link

IF errorlevel 1 PAUSE

%ZXDev%\Bin\hex2bin.exe %MainMod%.ihx
IF "%StripBin%"=="TRUE" %ZXDev%\Bin\stripbin.exe %MainMod%.bin
IF "%Target%"=="REM" %ZXDev%\Bin\bin2data.exe -rem -org %CodeAdr% %MainMod%.bin ..\%MainMod%.tap %MainMod%
IF "%Target%"=="TAP" %ZXDev%\Bin\bin2tap.exe -c 24499 -a %CodeAdr% -r %CodeAdr% -b -o ..\%MainMod%.tap %MainMod%.bin

IF NOT "%Clean%"=="TRUE" GOTO Done
DEL *.asm *.bin *.ihx *.lk *.lst *.map *.noi %MainMod%.Oh %MainMod%.sym %MainMod%.rel
IF "%Modules%"=="" DEL %MainMod%.c

:Done

IF "%Pause%"=="TRUE" PAUSE
IF "%Start%"=="TRUE" START ..\%MainMod%.tap
