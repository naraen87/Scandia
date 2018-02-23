REM *********************Down the Services**********************************************************************************
set "servername=10.66.216.141"
sc \\%servername% stop Bancs_SIBulkservice
if %errorlevel%==0 goto startstate1
if NOT %errorlevel%==0 goto stopstate1
:unproper1
echo Wait the service is get stopped

:startstate1
sc \\%servername% query Bancs_SIBulkservice | FIND "STATE" | FIND "STOPPED"
if %errorlevel%==0 goto proper1
if NOT %errorlevel%==0 goto unproper1
:proper1
set "service_down_status=proper"
echo "Service Down Successfully"
goto exit
:stopstate1
sc \\%servername% query Bancs_SIBulkservice | FIND "STATE" | FIND "STOPPED"
if %errorlevel%==0 goto alreadystopped1
if NOT %errorlevel%==0 goto notabletostop1
:alreadystopped1
set "service_down_status=proper"
echo "Service already in stop position"
goto exit
:notabletostop1
set "service_down_status=unproper"
goto :EOF
:exit

sc \\%servername% stop Bancs_SIMessageservice
if %errorlevel%==0 goto startstate2
if NOT %errorlevel%==0 goto stopstate2
:unproper2
echo Wait the service is get stopped
:startstate2
sc \\%servername% query Bancs_SIMessageservice | FIND "STATE" | FIND "STOPPED"
if %errorlevel%==0 goto proper2
if NOT %errorlevel%==0 goto unproper2
:proper2
set "service_down_status=proper"
echo "Service Down Successfully"
goto exit
:stopstate2
sc \\%servername% query Bancs_SIMessageservice | FIND "STATE" | FIND "STOPPED"
if %errorlevel%==0 goto alreadystopped2
if NOT %errorlevel%==0 goto notabletostop2
:alreadystopped2
set "service_down_status=proper"
echo "Service already in stop position"
goto exit
:notabletostop2
set "service_down_status=unproper"
goto :EOF
:exit

sc \\%servername% stop BancsSpringExtranetAdhocProcessor
if %errorlevel%==0 goto startstate3
if NOT %errorlevel%==0 goto stopstate3
:unproper3
echo Wait the service is get stopped
:startstate3
sc \\%servername% query BancsSpringExtranetAdhocProcessor | FIND "STATE" | FIND "STOPPED"
if %errorlevel%==0 goto proper3
if NOT %errorlevel%==0 goto unproper3
:proper3
set "service_down_status=proper"
echo "Service Down Successfully"
goto exit
:stopstate3
sc \\%servername% query BancsSpringExtranetAdhocProcessor | FIND "STATE" | FIND "STOPPED"
if %errorlevel%==0 goto alreadystopped3
if NOT %errorlevel%==0 goto notabletostop3
:alreadystopped3
set "service_down_status=proper"
echo "Service already in stop position"
goto exit
:notabletostop3
set "service_down_status=unproper"
goto :EOF
:exit

sc \\%servername% stop BancsSpringIntranetAdhocProcessor
if %errorlevel%==0 goto startstate4
if NOT %errorlevel%==0 goto stopstate4
:unproper4
echo Wait the service is get stopped
:startstate4
sc \\%servername% query BancsSpringIntranetAdhocProcessor | FIND "STATE" | FIND "STOPPED"
if %errorlevel%==0 goto proper4
if NOT %errorlevel%==0 goto unproper4
:proper4
set "service_down_status=proper"
echo "Service Down Successfully"
goto exit
:stopstate4
sc \\%servername% query BancsSpringIntranetAdhocProcessor | FIND "STATE" | FIND "STOPPED"
if %errorlevel%==0 goto alreadystopped4
if NOT %errorlevel%==0 goto notabletostop4
:alreadystopped4
set "service_down_status=proper"
echo "Service already in stop position"
goto exit
:notabletostop4
set "service_down_status=unproper"
goto :EOF
:exit

sc \\%servername% stop BancsSpringNAP
if %errorlevel%==0 goto startstate5
if NOT %errorlevel%==0 goto stopstate5
:unproper5
echo Wait the service is get stopped
:startstate5
sc \\%servername% query BancsSpringNAP | FIND "STATE" | FIND "STOPPED"
if %errorlevel%==0 goto proper5
if NOT %errorlevel%==0 goto unproper5
:proper5
set "service_down_status=proper"
echo "Service Down Successfully"
goto exit
:stopstate5
sc \\%servername% query BancsSpringNAP | FIND "STATE" | FIND "STOPPED"
if %errorlevel%==0 goto alreadystopped5
if NOT %errorlevel%==0 goto notabletostop5
:alreadystopped5
set "service_down_status=proper"
echo "Service already in stop position"
goto exit
:notabletostop5
set "service_down_status=unproper"
goto :EOF
:exit

sc \\%servername% stop BancsSpringScheduler
if %errorlevel%==0 goto startstate6
if NOT %errorlevel%==0 goto stopstate6
:unproper6
echo Wait the service is get stopped
:startstate6
sc \\%servername% query BancsSpringScheduler | FIND "STATE" | FIND "STOPPED"
if %errorlevel%==0 goto proper6
if NOT %errorlevel%==0 goto unproper6
:proper6
set "service_down_status=proper"
echo "Service Down Successfully"
goto exit
:stopstate6
sc \\%servername% query BancsSpringScheduler | FIND "STATE" | FIND "STOPPED"
if %errorlevel%==0 goto alreadystopped6
if NOT %errorlevel%==0 goto notabletostop6
:alreadystopped6
set "service_down_status=proper"
echo "Service already in stop position"
goto exit
:notabletostop6
set "service_down_status=unproper"
goto :EOF
:exit

sc \\%servername% stop Bancs_IntranetService
if %errorlevel%==0 goto startstate7
if NOT %errorlevel%==0 goto stopstate7
:unproper7
echo Wait the service is get stopped
:startstate7
sc \\%servername% query Bancs_IntranetService | FIND "STATE" | FIND "STOPPED"
if %errorlevel%==0 goto proper7
if NOT %errorlevel%==0 goto unproper7
:proper7
set "service_down_status=proper"
echo "Service Down Successfully"
goto exit
:stopstate7
sc \\%servername% query Bancs_IntranetService | FIND "STATE" | FIND "STOPPED"
if %errorlevel%==0 goto alreadystopped7
if NOT %errorlevel%==0 goto notabletostop7
:alreadystopped7
set "service_down_status=proper"
echo "Service already in stop position"
goto exit
:notabletostop7
set "service_down_status=unproper"
goto :EOF
:exit

sc \\%servername% stop Bancs_ExtranetService
if %errorlevel%==0 goto startstate8
if NOT %errorlevel%==0 goto stopstate8
:unproper8
echo Wait the service is get stopped
:startstate8
sc \\%servername% query Bancs_ExtranetService | FIND "STATE" | FIND "STOPPED"
if %errorlevel%==0 goto proper8
if NOT %errorlevel%==0 goto unproper8
:proper8
set "service_down_status=proper"
echo "Service Down Successfully"
goto exit
:stopstate8
sc \\%servername% query Bancs_ExtranetService | FIND "STATE" | FIND "STOPPED"
if %errorlevel%==0 goto alreadystopped8
if NOT %errorlevel%==0 goto notabletostop8
:alreadystopped8
set "service_down_status=proper"
echo "Service already in stop position"
goto exit
:notabletostop8
set "service_down_status=unproper"
goto :EOF
:exit

sc \\%servername% stop Bancs_AdminService
if %errorlevel%==0 goto startstate9
if NOT %errorlevel%==0 goto stopstate9
:unproper9
echo Wait the service is get stopped
:startstate9
sc \\%servername% query Bancs_AdminService | FIND "STATE" | FIND "STOPPED"
if %errorlevel%==0 goto proper9
if NOT %errorlevel%==0 goto unproper9
:proper9
set "service_down_status=proper"
echo "Service Down Successfully"
goto exit
:stopstate9
sc \\%servername% query Bancs_AdminService | FIND "STATE" | FIND "STOPPED"
if %errorlevel%==0 goto alreadystopped9
if NOT %errorlevel%==0 goto notabletostop9
:alreadystopped9
set "service_down_status=proper"
echo "Service already in stop position"
goto exit
:notabletostop9
set "service_down_status=unproper"
goto :EOF
:exit

exit /b