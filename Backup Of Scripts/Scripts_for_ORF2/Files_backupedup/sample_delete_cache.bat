REM *********************Delete the Cache and Log Folders************************************************************************
set "servername=10.47.36.90"
set "psexec=E:\Jenkins_Software\PSTools\PsExec.exe"
set "Adminlogpathtofolder=\\%servername%\C$\narayana\Enviromnet_Setup\WIServerSetup\UAT\EDrive\Oracle\Middleware\user_projects\domains\Skandia\servers\AdminServer\logs\"
set "Extranetlogpathtofolder=\\%servername%\C$\narayana\Enviromnet_Setup\WIServerSetup\UAT\EDrive\Oracle\Middleware\user_projects\domains\Skandia\servers\Extranet-server\logs\"
set "Intranetlogpathtofolder=\\%servername%\C$\narayana\Enviromnet_Setup\WIServerSetup\UAT\EDrive\Oracle\Middleware\user_projects\domains\Skandia\servers\Intranet-server\logs\"
set "Adminpathtofolder=C:\narayana\Enviromnet_Setup\WIServerSetup\UAT\EDrive\Oracle\Middleware\user_projects\domains\Skandia\servers\AdminServer\"
set "Extranetpathtofolder=\\%servername%\C$\narayana\Enviromnet_Setup\WIServerSetup\UAT\EDrive\Oracle\Middleware\user_projects\domains\Skandia\servers\Extranet-server\"
set "Intranetpathtofolder=\\%servername%\C$\narayana\Enviromnet_Setup\WIServerSetup\UAT\EDrive\Oracle\Middleware\user_projects\domains\Skandia\servers\Intranet-server\"

if exist "%Adminlogpathtofolder%" goto deleteadminlog
if not exist "%Adminlogpathtofolder%" goto noadminlog

:deleteadminlog
REM %psexec% \\%servername% pushd "%Adminlogpathtofolder%" && (rd /s /q "%Adminlogpathtofolder%" 2>nul & popd)
REM %psexec% \\%servername% cmd /c "rd /s /q %Adminlogpathtofolder%"
pushd "%Adminlogpathtofolder%" && (rd /s /q "%Adminlogpathtofolder%" 2>nul & popd)

if %errorlevel%==0 goto cachedeletesuccess
if NOT %errorlevel%==0 goto cachedeleteunsuccess
:cachedeletesuccess
set "cache_delete_status=success"
echo "Admin Cache Deletion Successfully"
goto exit
:cachedeleteunsuccess
set "cache_delete_status=failure"
echo "Unable to delete the cache"
goto :EOF

:noadminlog
echo "There is no log folder on the Admin Server"
goto exit
:exit

if exist "%Extranetlogpathtofolder%" goto deleteextranetlog
if not exist "%Extranetlogpathtofolder%" goto noextranetlog

:deleteextranetlog
REM %psexec% \\%servername% pushd "%Extranetlogpathtofolder%" && (rd /s /q "%Extranetlogpathtofolder%" 2>nul & popd)
REM %psexec% \\%servername% cmd /c "rd /s /q %Extranetlogpathtofolder%"
%psexec% \\%servername% cmd /c "pushd "%Extranetlogpathtofolder%" && (rd /s /q "%Extranetlogpathtofolder%" 2>nul & popd)"
if %errorlevel%==0 goto cachedeletesuccess
if NOT %errorlevel%==0 goto cachedeleteunsuccess
:cachedeletesuccess
set "cache_delete_status=success"
echo "Extranet Cache Deletion Successfully"
goto exit
:cachedeleteunsuccess
set "cache_delete_status=failure"
echo "Unable to delete the Extranet cache"
goto :EOF

:noextranetlog
echo "There is no log folder on the Extranet Server"
goto exit
:exit


if exist "%Intranetlogpathtofolder%" goto deleteintranetlog
if not exist "%Intranetlogpathtofolder%" goto nointranetlog

:deleteintranetlog
REM %psexec% \\%servername% pushd "%Intranetlogpathtofolder%" && (rd /s /q "%Intranetlogpathtofolder%" 2>nul & popd)
REM %psexec% \\%servername% cmd /c "rd /s /q %Intranetlogpathtofolder%"
%psexec% \\%servername% cmd /c "pushd "%Intranetlogpathtofolder%" && (rd /s /q "%Intranetlogpathtofolder%" 2>nul & popd)"
if %errorlevel%==0 goto cachedeletesuccess
if NOT %errorlevel%==0 goto cachedeleteunsuccess
:cachedeletesuccess
set "cache_delete_status=success"
echo "Intranet Cache Deletion Successfully"
goto exit
:cachedeleteunsuccess
set "cache_delete_status=failure"
echo "Unable to delete the Intranet cache"
goto :EOF

:nointranetlog
echo "There is no log folder on the Intranet Server"
goto exit
:exit

%psexec% \\%servername% cmd /c "cd /d "%Adminpathtofolder%" &rd /s /q stage &rd /s /q security &rd /s /q logs"

if %errorlevel%==0 goto cachedeletesuccess
if NOT %errorlevel%==0 goto cachedeleteunsuccess
:cachedeletesuccess
set "cache_delete_status=success"
echo "Cache Deletion Successfully"
goto exit
:cachedeleteunsuccess
set "cache_delete_status=failure"
echo "Unable to delete the cache"
goto :EOF

:exit

exit /b