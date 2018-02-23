REM *********************Delete the Cache and Log Folders************************************************************************
set "Adminlogpathtofolder=\\%servername%\e$\Oracle\Middleware\user_projects\domains\Skandia\servers\AdminServer\logs\"
set "Extranetlogpathtofolder=\\%servername%\e$\Oracle\Middleware\user_projects\domains\Skandia\servers\Extranet-server\logs\"
set "Intranetlogpathtofolder=\\%servername%\e$\Oracle\Middleware\user_projects\domains\Skandia\servers\Intranet-server\logs\"
set "Adminpathtofolder=\\%servername%\e$\Oracle\Middleware\user_projects\domains\Skandia\servers\AdminServer\"
set "Extranetpathtofolder=\\%servername%\e$\Oracle\Middleware\user_projects\domains\Skandia\servers\Extranet-server\"
set "Intranetpathtofolder=\\%servername%\e$\Oracle\Middleware\user_projects\domains\Skandia\servers\Intranet-server\"
set "Intranetpathtofolder=\\%servername%\e$\Oracle\Middleware\user_projects\domains\Skandia\servers\Intranet-server\"

if exist "%Adminlogpathtofolder%" goto deleteadminlog
if not exist "%Adminlogpathtofolder%" goto noadminlog

:deleteadminlog
"pushd "%Adminlogpathtofolder%" && (rd /s /q "%Adminlogpathtofolder%" 2>nul & popd)"
dir /b /a "%Adminlogpathtofolder%\*" | >nul findstr "^" && (set fileorfoldersexists=1) || (set fileorfoldersexists=0)
if %fileorfoldersexists%==0 goto cachedeletesuccess
if NOT %fileorfoldersexists%==0 goto cachedeleteunsuccess
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
"pushd "%Extranetlogpathtofolder%" && (rd /s /q "%Extranetlogpathtofolder%" 2>nul & popd)"
dir /b /a "%Extranetlogpathtofolder%\*" | >nul findstr "^" && (set fileorfoldersexists=1) || (set fileorfoldersexists=0)
if %fileorfoldersexists%==0 goto cachedeletesuccess
if NOT %fileorfoldersexists%==0 goto cachedeleteunsuccess
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
"pushd "%Intranetlogpathtofolder%" && (rd /s /q "%Intranetlogpathtofolder%" 2>nul & popd)"
dir /b /a "%Intranetlogpathtofolder%\*" | >nul findstr "^" && (set fileorfoldersexists=1) || (set fileorfoldersexists=0)
if %fileorfoldersexists%==0 goto cachedeletesuccess
if NOT %fileorfoldersexists%==0 goto cachedeleteunsuccess
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

REM %psexec% \\%servername% pushd "%Adminpathtofolder%"
REM for /f "delims=" %%i in ('dir /ad /b^|findstr /vlix "stage security logs"') do rd /s /q "%%i"
REM popd
REM if %errorlevel%==0 goto cachedeletesuccess
REM if NOT %errorlevel%==0 goto cachedeleteunsuccess
REM :cachedeletesuccess
REM set "cache_delete_status=success"
REM echo "Cache Deletion Successfully"
REM goto exit
REM :cachedeleteunsuccess
REM set "cache_delete_status=failure"
REM echo "Unable to delete the cache"
REM goto :EOF

REM :exit

REM %psexec% \\%servername% pushd "%Extranetpathtofolder%"
REM for /f "delims=" %%i in ('dir /ad /b^|findstr /vlix "stage security logs"') do rd /s /q "%%i"
REM popd
REM if %errorlevel%==0 goto cachedeletesuccess
REM if NOT %errorlevel%==0 goto cachedeleteunsuccess
REM :cachedeletesuccess
REM set "cache_delete_status=success"
REM echo "Cache Deletion Successfully"
REM goto exit
REM :cachedeleteunsuccess
REM set "cache_delete_status=failure"
REM echo "Unable to delete the cache"
REM goto :EOF

REM :exit

REM %psexec% \\%servername% pushd "%Intranetpathtofolder%"
REM for /f "delims=" %%i in ('dir /ad /b^|findstr /vlix "stage security logs"') do rd /s /q "%%i"
REM popd
REM if %errorlevel%==0 goto cachedeletesuccess
REM if NOT %errorlevel%==0 goto cachedeleteunsuccess
REM :cachedeletesuccess
REM set "cache_delete_status=success"
REM echo "Cache Deletion Successfully"
REM goto exit
REM :cachedeleteunsuccess
REM set "cache_delete_status=failure"
REM echo "Unable to delete the cache"
REM goto :EOF

REM :exit

exit /b