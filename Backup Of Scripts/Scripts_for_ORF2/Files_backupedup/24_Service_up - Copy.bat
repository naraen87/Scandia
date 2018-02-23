REM *********************Start the services********************************************************
set "servername=10.66.216.141"
echo %servername%
sc \\%servername% start Bancs_AdminService
if %errorlevel%==0 goto startstate1
if NOT %errorlevel%==0 goto stopstate1
:unproper1
echo Wait the service is getting starting
:startstate1
sc \\%servername% query Bancs_AdminService | FIND "STATE" | FIND "RUNNING"
if %errorlevel%==0 goto proper1
if NOT %errorlevel%==0 goto unproper1
:proper1
set "service_up_status=proper"
echo "Service RUNNING Successfully"
goto exit
:stopstate1
set "service_down_status=proper"
echo "Service already in start position"
:exit

sc \\%servername% start Bancs_ExtranetService
if %errorlevel%==0 goto startstate2
if NOT %errorlevel%==0 goto stopstate2
:unproper2
echo Wait the service is getting starting
:startstate2
sc \\%servername% query Bancs_ExtranetService | FIND "STATE" | FIND "RUNNING"
if %errorlevel%==0 goto proper2
if NOT %errorlevel%==0 goto unproper2
:proper2
set "service_up_status=proper"
echo "Service RUNNING Successfully"
goto exit
:stopstate2
set "service_down_status=proper"
echo "Service already in start position"
:exit

sc \\%servername% start Bancs_IntranetService
if %errorlevel%==0 goto startstate3
if NOT %errorlevel%==0 goto stopstate3
:unproper3
echo Wait the service is getting starting
:startstate3
sc \\%servername% query Bancs_IntranetService | FIND "STATE" | FIND "RUNNING"
if %errorlevel%==0 goto proper3
if NOT %errorlevel%==0 goto unproper3
:proper3
set "service_up_status=proper"
echo "Service RUNNING Successfully"
goto exit
:stopstate3
set "service_down_status=proper"
echo "Service already in start position"
:exit

REM sc \\%servername% start BancsSpringExtranetAdhocProcessor
REM if %errorlevel%==0 goto startstate4
REM if NOT %errorlevel%==0 goto stopstate4
REM :unproper4
REM echo Wait the service is getting starting
REM :startstate4
REM sc \\%servername% query BancsSpringExtranetAdhocProcessor | FIND "STATE" | FIND "RUNNING"
REM if %errorlevel%==0 goto proper4
REM if NOT %errorlevel%==0 goto unproper4
REM :proper4
REM set "service_up_status=proper"
REM echo "Service RUNNING Successfully"
REM goto exit
REM :stopstate4
REM set "service_down_status=proper"
REM echo "Service already in start position"
REM :exit

REM sc \\%servername% start BancsSpringIntranetAdhocProcessor
REM if %errorlevel%==0 goto startstate5
REM if NOT %errorlevel%==0 goto stopstate5
REM :unproper5
REM echo Wait the service is getting starting
REM :startstate5
REM sc \\%servername% query BancsSpringIntranetAdhocProcessor | FIND "STATE" | FIND "RUNNING"
REM if %errorlevel%==0 goto proper5
REM if NOT %errorlevel%==0 goto unproper5
REM :proper5
REM set "service_up_status=proper"
REM echo "Service RUNNING Successfully"
REM goto exit
REM :stopstate5
REM set "service_down_status=proper"
REM echo "Service already in start position"
REM :exit

REM sc \\%servername% start BancsSpringNAP
REM if %errorlevel%==0 goto startstate6
REM if NOT %errorlevel%==0 goto stopstate6
REM :unproper6
REM echo Wait the service is getting starting
REM :startstate6
REM sc \\%servername% query BancsSpringNAP | FIND "STATE" | FIND "RUNNING"
REM if %errorlevel%==0 goto proper6
REM if NOT %errorlevel%==0 goto unproper6
REM :proper6
REM set "service_up_status=proper"
REM echo "Service RUNNING Successfully"
REM goto exit
REM :stopstate6
REM set "service_down_status=proper"
REM echo "Service already in start position"
REM :exit

REM sc \\%servername% start BancsSpringScheduler
REM if %errorlevel%==0 goto startstate7
REM if NOT %errorlevel%==0 goto stopstate7
REM :unproper7
REM echo Wait the service is getting starting
REM :startstate7
REM sc \\%servername% query BancsSpringScheduler | FIND "STATE" | FIND "RUNNING"
REM if %errorlevel%==0 goto proper7
REM if NOT %errorlevel%==0 goto unproper7
REM :proper7
REM set "service_up_status=proper"
REM echo "Service RUNNING Successfully"
REM goto exit
REM :stopstate7
REM set "service_down_status=proper"
REM echo "Service already in start position"
REM :exit

REM sc \\%servername% start Bancs_SIBulkservice
REM if %errorlevel%==0 goto startstate8
REM if NOT %errorlevel%==0 goto stopstate8
REM :unproper8
REM echo Wait the service is getting starting
REM :startstate8
REM sc \\%servername% query Bancs_SIBulkservice | FIND "STATE" | FIND "RUNNING"
REM if %errorlevel%==0 goto proper8
REM if NOT %errorlevel%==0 goto unproper8
REM :proper8
REM set "service_up_status=proper"
REM echo "Service RUNNING Successfully"
REM goto exit
REM :stopstate8
REM set "service_down_status=proper"
REM echo "Service already in start position"
REM :exit

REM sc \\%servername% start Bancs_SIMessageservice
REM if %errorlevel%==0 goto startstate9
REM if NOT %errorlevel%==0 goto stopstate9
REM :unproper2
REM echo Wait the service is getting starting
REM :startstate9
REM sc \\%servername% query Bancs_SIMessageservice | FIND "STATE" | FIND "RUNNING"
REM if %errorlevel%==0 goto proper9
REM if NOT %errorlevel%==0 goto unproper9
REM :proper9
REM set "service_up_status=proper"
REM echo "Service RUNNING Successfully"
REM goto exit
REM :stopstate9
REM set "service_down_status=proper"
REM echo "Service already in start position"
REM :exit

REM exit /b