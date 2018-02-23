REM *********************Delete the Cache and Log Folders************************************************************************
set "servername=10.66.216.141"
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