@REM args:
@REM   LibName ModName

@SET RootBin=..\..\..\Bin
@SET Bin=..\..\Bin
@SET tcc=%Bin%\tcc\tcc.exe

@IF EXIST ..\%2.c GOTO clib

:olib
%tcc% -c %2.c -I ".." -I "."
@GOTO done

:clib
@IF EXIST %2.h DEL %2.h
@IF EXIST %2.c DEL %2.c
%tcc% -c ..\%2.c -I ".." -I "."

:done
@IF errorlevel 1 PAUSE

@%Bin%\ar -rc %1 %2.o
@DEL %2.o
