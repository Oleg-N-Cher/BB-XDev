@SET Mod=IM2
@SET Bin=..\..\Bin
@SET Lib=..\..\Lib
@SET CodeAddr=26000
@SET DataAddr=60000

@IF EXIST %Mod%.c @MOVE /Y %Mod%.c IM2
@CD IM2
%Bin%\sdcc %Mod%.c -mz80 --code-loc %CodeAddr% --data-loc %DataAddr% --no-std-crt0 --opt-code-size --funsigned-char --disable-warning 126 -I "." -I %Lib% -L %Lib%/z80 Basic.lib XDev.lib
@IF errorlevel 1 PAUSE

@REM Convert Intel hex format to binary
@REM ==================================
%Bin%\hex2bin %Mod%.ihx
%Bin%\bin2data.exe -rem -org %CodeAddr% %Mod%.bin ..\..\%Mod%.tap %Mod%
@CD ..
@START ..\%Mod%.tap
