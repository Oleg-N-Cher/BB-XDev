@SET Mod=TinyHello
@SET Bin=..\Bin
@SET Lib=..\Lib
@SET CodeAddr=45056
@SET DataAddr=63488

%Bin%\sdcc %Mod%.c -mz80 --code-loc %CodeAddr% --data-loc %DataAddr% --no-std-crt0 --opt-code-size --disable-warning 59 --disable-warning 85 -I %Mod% -I %Lib%\C -I %Lib%\Obj -L %Lib% Basic.lib XDev.lib
@IF errorlevel 1 PAUSE

@REM Convert Intel hex format to binary
@REM ==================================
%Bin%\hex2bin %Mod%.ihx
%Bin%\bin2data.exe -rem -org %CodeAddr% %Mod%.bin ..\%Mod%.tap %Mod%
@START ..\%Mod%.tap
