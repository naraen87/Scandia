REM *********************Start the services********************************************************
set "portqry_path=E:\Jenkins_Software\PortQry.exe"
sc \\%servername% start Bancs_AdminService
if %errorlevel%==0 goto startstate1
if NOT %errorlevel%==0 goto stopstate1
:unproper1
sc \\%servername% query Bancs_AdminService | FIND "STATE" | FIND "STOPPED"
if %errorlevel%==0 goto serviceissue1
if NOT %errorlevel%==0 goto servicenoissue1
:serviceissue1
echo "Service has some application level Issue. Kindly Check."
set "service_down_status=unproper"
goto :EOF
:servicenoissue1
echo Wait the service is getting starting
:startstate1
ping -n 30 127.0.0.1>nul
%portqry_path% -n %servername% -e 8001 -q
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
sc \\%servername% query Bancs_ExtranetService | FIND "STATE" | FIND "STOPPED"
if %errorlevel%==0 goto serviceissue2
if NOT %errorlevel%==0 goto servicenoissue2
:serviceissue2
echo "Service has some application level Issue. Kindly Check."
set "service_down_status=unproper"
goto :EOF
:servicenoissue2
echo Wait the service is getting starting
:startstate2
ping -n 30 127.0.0.1>nul
%portqry_path% -n %servername% -e 8005 -q
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
sc \\%servername% query Bancs_IntranetService | FIND "STATE" | FIND "STOPPED"
if %errorlevel%==0 goto serviceissue3
if NOT %errorlevel%==0 goto servicenoissue3
:serviceissue3
echo "Service has some application level Issue. Kindly Check."
set "service_down_status=unproper"
goto :EOF
:servicenoissue3
echo Wait the service is getting starting
:startstate3
ping -n 30 127.0.0.1>nul
%portqry_path% -n %servername% -e 8003 -q
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

sc \\%servername% start BancsSpringExtranetAdhocProcessor
if %errorlevel%==0 goto startstate4
if NOT %errorlevel%==0 goto stopstate4
:unproper4
sc \\%servername% query BancsSpringExtranetAdhocProcessor | FIND "STATE" | FIND "STOPPED"
if %errorlevel%==0 goto serviceissue4
if NOT %errorlevel%==0 goto servicenoissue4
:serviceissue4
echo "Service has some application level Issue. Kindly Check."
set "service_down_status=unproper"
goto :EOF
:servicenoissue4
echo Wait the service is getting starting
:startstate4
ping -n 30 127.0.0.1>nul
sc \\%servername% query BancsSpringExtranetAdhocProcessor | FIND "STATE" | FIND "RUNNING"
if %errorlevel%==0 goto proper4
if NOT %errorlevel%==0 goto unproper4
:proper4
set "service_up_status=proper"
echo "Service RUNNING Successfully"
goto exit
:stopstate4
set "service_down_status=proper"
echo "Service already in start position"
:exit

sc \\%servername% start BancsSpringIntranetAdhocProcessor
if %errorlevel%==0 goto startstate5
if NOT %errorlevel%==0 goto stopstate5
:unproper5
sc \\%servername% query BancsSpringIntranetAdhocProcessor | FIND "STATE" | FIND "STOPPED"
if %errorlevel%==0 goto serviceissue5
if NOT %errorlevel%==0 goto servicenoissue5
:serviceissue5
echo "Service has some application level Issue. Kindly Check."
set "service_down_status=unproper"
goto :EOF
:servicenoissue5
echo Wait the service is getting starting
:startstate5
ping -n 300 127.0.0.1>nul
sc \\%servername% query BancsSpringIntranetAdhocProcessor | FIND "STATE" | FIND "RUNNING"
if %errorlevel%==0 goto proper5
if NOT %errorlevel%==0 goto unproper5
:proper5
set "service_up_status=proper"
echo "Service RUNNING Successfully"
goto exit
:stopstate5
set "service_down_status=proper"
echo "Service already in start position"
:exit

sc \\%servername% start BancsSpringNAP
if %errorlevel%==0 goto startstate6
if NOT %errorlevel%==0 goto stopstate6
:unproper6
sc \\%servername% query BancsSpringNAP | FIND "STATE" | FIND "STOPPED"
if %errorlevel%==0 goto serviceissue6
if NOT %errorlevel%==0 goto servicenoissue6
:serviceissue6
echo "Service has some application level Issue. Kindly Check."
set "service_down_status=unproper"
goto :EOF
:servicenoissue6
echo Wait the service is getting starting
:startstate6
ping -n 30 127.0.0.1>nul
sc \\%servername% query BancsSpringNAP | FIND "STATE" | FIND "RUNNING"
if %errorlevel%==0 goto proper6
if NOT %errorlevel%==0 goto unproper6
:proper6
set "service_up_status=proper"
echo "Service RUNNING Successfully"
goto exit
:stopstate6
set "service_down_status=proper"
echo "Service already in start position"
:exit

sc \\%servername% start BancsSpringScheduler
if %errorlevel%==0 goto startstate7
if NOT %errorlevel%==0 goto stopstate7
:unproper7
sc \\%servername% query BancsSpringScheduler | FIND "STATE" | FIND "STOPPED"
if %errorlevel%==0 goto serviceissue7
if NOT %errorlevel%==0 goto servicenoissue7
:serviceissue7
echo "Service has some application level Issue. Kindly Check."
set "service_down_status=unproper"
goto :EOF
:servicenoissue7
echo Wait the service is getting starting
:startstate7
ping -n 30 127.0.0.1>nul
sc \\%servername% query BancsSpringScheduler | FIND "STATE" | FIND "RUNNING"
if %errorlevel%==0 goto proper7
if NOT %errorlevel%==0 goto unproper7
:proper7
set "service_up_status=proper"
echo "Service RUNNING Successfully"
goto exit
:stopstate7
set "service_down_status=proper"
echo "Service already in start position"
:exit

sc \\%servername% start Bancs_SIBulkservice
if %errorlevel%==0 goto startstate8
if NOT %errorlevel%==0 goto stopstate8
:unproper8
sc \\%servername% query Bancs_SIBulkservice | FIND "STATE" | FIND "STOPPED"
if %errorlevel%==0 goto serviceissue8
if NOT %errorlevel%==0 goto servicenoissue8
:serviceissue8
echo "Service has some application level Issue. Kindly Check."
set "service_down_status=unproper"
goto :EOF
:servicenoissue8
echo Wait the service is getting starting
:startstate8
ping -n 30 127.0.0.1>nul
sc \\%servername% query Bancs_SIBulkservice | FIND "STATE" | FIND "RUNNING"
if %errorlevel%==0 goto proper8
if NOT %errorlevel%==0 goto unproper8
:proper8
set "service_up_status=proper"
echo "Service RUNNING Successfully"
goto exit
:stopstate8
set "service_down_status=proper"
echo "Service already in start position"
:exit

sc \\%servername% start Bancs_SIMessageservice
if %errorlevel%==0 goto startstate9
if NOT %errorlevel%==0 goto stopstate9
:unproper9
sc \\%servername% query Bancs_SIMessageservice | FIND "STATE" | FIND "STOPPED"
if %errorlevel%==0 goto serviceissue9
if NOT %errorlevel%==0 goto servicenoissue9
:serviceissue9
echo "Service has some application level Issue. Kindly Check."
set "service_down_status=unproper"
goto :EOF
:servicenoissue9
echo Wait the service is getting starting
:startstate9
ping -n 30 127.0.0.1>nul
sc \\%servername% query Bancs_SIMessageservice | FIND "STATE" | FIND "RUNNING"
if %errorlevel%==0 goto proper9
if NOT %errorlevel%==0 goto unproper9
:proper9
set "service_up_status=proper"
echo "Service RUNNING Successfully"
goto exit
:stopstate9
set "service_down_status=proper"
echo "Service already in start position"
:exit

exit /b