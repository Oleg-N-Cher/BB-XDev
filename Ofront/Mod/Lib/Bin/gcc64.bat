@IF NOT /%XDev%==/ GOTO XDev
@ECHO Please set system variable XDev=X:\Path\To\XDev
@PAUSE
@EXIT

:XDev
@SET PATH=%XDev%\WinDev\Bin\MinGW64\bin;%PATH%
@SET lib=-I..\Lib\Obj64 -I..\Lib\Mod ..\Lib\Ofront64.a %XDev%\WinDev\Bin\MinGW64\lib\libSDL2.dll.a %XDev%\WinDev\Bin\MinGW64\lib\libSDL2_image.dll.a
SET StripExe=-nostartfiles ..\Lib\Mod\crt1.c -Wl,-e_WinMain@16 -D_WINMAIN
@SET CC=gcc.exe %StripExe% -m64 -s -Os -g0 -fno-exceptions -fno-asynchronous-unwind-tables -Wl,--gc-sections

%CC% %1 %2 %3 %4 %5 %6 %7 %8 %9 %lib%
@IF errorlevel 1 PAUSE
