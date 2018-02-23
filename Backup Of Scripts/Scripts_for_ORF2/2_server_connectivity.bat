REM *********************Check the connectivity b/w servers*****************************************************************
if %enviroment%==cluster goto checkclusterservers
if %enviroment%==non-cluster goto checknonclusterservers
:checknonclusterservers
%SystemRoot%\system32\ping.exe -n 1 %servername% >nul
if %errorlevel%==0  goto serveravailable
if not %errorlevel%==0  goto serverunavailable 
:serveravailable
set "server_status=available"
goto exit
:serverunavailable
set "server_status=unavailable"
goto :EOF

:checkclusterservers
%SystemRoot%\system32\ping.exe -n 1 %servername% >nul
if %errorlevel%==0  goto serveravailable
if not %errorlevel%==0  goto serverunavailable 
:serveravailable
set "server_status=available"
goto exit
:serverunavailable
set "server_status=unavailable"
goto :EOF
%SystemRoot%\system32\ping.exe -n 1 %servername1% >nul
if %errorlevel%==0  goto serveravailable
if not %errorlevel%==0  goto serverunavailable 
:serveravailable
set "server_status=available"
goto exit
:serverunavailable
set "server_status=unavailable"
goto :EOF
:exit

exit /b