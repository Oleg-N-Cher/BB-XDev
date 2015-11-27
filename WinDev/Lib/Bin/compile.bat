@IF EXIST ..\C\%1.c GOTO clib

:olib
..\..\Bin\tcc\tcc -c %1.c -I ".." -I ..\C
@IF errorlevel 1 GOTO noinit
@GOTO exit

:noinit
@COPY /Y %1.c %1.c__
..\..\..\Bin\smartlib %1.c -noinit -nocut
..\..\Bin\tcc\tcc -c %1.c -I ".." -I ..\C
@MOVE /Y %1.c__ %1.c
@GOTO exit

:clib
@IF EXIST %1.h DEL %1.h
@IF EXIST %1.c DEL %1.c
..\..\Bin\tcc\tcc -c ..\C\%1.c -I ".." -I ..\C

:exit
@IF errorlevel 1 PAUSE
