REM *********************Delete the Cache and Log Folders************************************************************************
set "Adminlogpathtofolder=\\%servername%\e$\Oracle\Middleware\user_projects\domains\Skandia\servers\AdminServer\logs\"
set "Extranetlogpathtofolder=\\%servername%\e$\Oracle\Middleware\user_projects\domains\Skandia\servers\Extranet-server\logs\"
set "Intranetlogpathtofolder=\\%servername%\e$\Oracle\Middleware\user_projects\domains\Skandia\servers\Intranet-server\logs\"
set "Adminpathtofolder=\\%servername%\e$\Oracle\Middleware\user_projects\domains\Skandia\servers\AdminServer\"
set "Extranetpathtofolder=\\%servername%\e$\Oracle\Middleware\user_projects\domains\Skandia\servers\Extranet-server\"
set "Intranetpathtofolder=\\%servername%\e$\Oracle\Middleware\user_projects\domains\Skandia\servers\Intranet-server\"

if exist "%Adminlogpathtofolder%" goto deleteadminlog
if not exist "%Adminlogpathtofolder%" goto noadminlog

:deleteadminlog
pushd "%Adminlogpathtofolder%" && (rd /s /q "%Adminlogpathtofolder%" 2>nul & popd)
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
pushd "%Extranetlogpathtofolder%" && (rd /s /q "%Extranetlogpathtofolder%" 2>nul & popd)
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
pushd "%Intranetlogpathtofolder%" && (rd /s /q "%Intranetlogpathtofolder%" 2>nul & popd)
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

REM Deleting the Admin Cache Folders
SetLocal EnableDelayedExpansion
pushd "%Adminpathtofolder%"
for /f "delims=" %%i in ('dir /ad /b^|findstr /vlix "stage security logs"') do (
	rd /s /q "%Adminpathtofolder%%%i\"
	popd
	Set "var=%Adminpathtofolder%%%i"
	echo !var!
	if exist !var! (
		popd
		set "cache_delete_status=failure"
		echo "Unable to delete the cache"
		exit 1
	)
set "cache_delete_status=success"
echo !var! Cache folder Deletion Successfully
)
Endlocal
REM Deleting the Extarnet Cache Folders
SetLocal EnableDelayedExpansion
pushd "%Extranetpathtofolder%"
for /f "delims=" %%i in ('dir /ad /b^|findstr /vlix "stage security logs"') do (
	rd /s /q "%Extranetpathtofolder%%%i\"
	popd
	Set "var=%Extranetpathtofolder%%%i"
	echo !var!
	if exist !var! (
		popd
		set "cache_delete_status=failure"
		echo "Unable to delete the cache"
		exit 1
	)
set "cache_delete_status=success"
echo !var! Cache folder Deletion Successfully
)
Endlocal
REM Deleting the Intarnet Cache Folders
SetLocal EnableDelayedExpansion
pushd "%Intranetpathtofolder%"
for /f "delims=" %%i in ('dir /ad /b^|findstr /vlix "stage security logs"') do (
	rd /s /q "%Intranetpathtofolder%%%i\"
	popd
	Set "var=%Intranetpathtofolder%%%i"
	echo !var!
	if exist !var! (
		popd
		set "cache_delete_status=failure"
		echo "Unable to delete the cache"
		exit 1
	)
set "cache_delete_status=success"
echo !var! Cache folder Deletion Successfully
)
Endlocal

exit /b