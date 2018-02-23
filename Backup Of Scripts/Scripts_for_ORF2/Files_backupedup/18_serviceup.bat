REM *********************Down the Services**********************************************************************************
echo %servername%
sc \\%servername% stop MSSQL$SQLEXPRESS
sc \\%servername% query MSSQL$SQLEXPRESS | FIND "STATE" | FIND "STOPPED"
echo %errorlevel%

if %errorlevel%==0 goto proper
if NOT %errorlevel%==0 goto unproper
:proper
set "service_down_status=proper"
echo "Service Stopeed Successfully"
goto exit
:unproper
set "service_down_status=unproper"
echo "Unable to down the services"
goto :EOF

:exit

sc \\%servername% stop bthserv
sc \\%servername% query bthserv | FIND "STATE" | FIND "STOPPED"
echo %errorlevel%

if %errorlevel%==0 goto proper
if NOT %errorlevel%==0 goto unproper
:proper
set "service_down_status=proper"
echo "Service Stopeed Successfully"
goto exit
:unproper
set "service_down_status=unproper"
echo "Unable to down the services"
goto :EOF

:exit

REM sc \\%servername% start Fax
REM sc \\%servername% query Fax | FIND "STATE" | FIND "RUNNING"
REM echo %errorlevel%

REM if %errorlevel%==0 goto proper
REM if NOT %errorlevel%==0 goto unproper
REM :proper
REM set "service_down_status=proper"
REM echo "Service Started Successfully"
REM goto exit
REM :unproper
REM set "service_down_status=unproper"
REM echo "Unable to Start the services"
REM goto :EOF

REM :exit


sc \\%servername% stop AdobeARMservice
sc \\%servername% query AdobeARMservice | FIND "STATE" | FIND "STOPPED"
echo %errorlevel%

if %errorlevel%==0 goto proper
if NOT %errorlevel%==0 goto unproper
:proper
set "service_down_status=proper"
echo "Service Stopeed Successfully"
goto exit
:unproper
set "service_down_status=unproper"
echo "Unable to down the services"
goto :EOF

:exit


exit /b