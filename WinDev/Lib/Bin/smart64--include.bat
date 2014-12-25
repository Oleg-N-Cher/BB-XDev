@REM args:
@REM   LibName ModName [PartName] [-noinit] [-nocut]

@SET RootBin=..\..\..\Bin
@SET Bin=..\..\Bin
@SET tcc=%Bin%\tcc64\tcc.exe

@IF EXIST ..\C\%2.c GOTO clib

:olib
%RootBin%\smartlib %2.c %3 %4 %5
@GOTO compile

:clib
@IF EXIST %2.h DEL %2.h
@IF EXIST %2.c DEL %2.c
%RootBin%\smartlib ..\C\%2.c %3 %4 %5

:compile
@FOR %%i IN (%2_???.c) DO (
  %tcc% -c %%i -I %Bin%\tcc64\include -I "." -I ..\C
  @IF errorlevel 1 PAUSE
)
@FOR %%i IN (%2_???.o) DO %Bin%\ar64 -rc %1 %%i
@%Bin%\clear