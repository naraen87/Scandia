echo off
set "servername=10.66.216.141"
set "Adminlogpathtofolder=\\%servername%\e$\Oracle\Middleware\user_projects\domains\Skandia\servers\AdminServer\logs\"
set "Adminpathtofolder=\\%servername%\e$\Oracle\Middleware\user_projects\domains\Skandia\servers\AdminServer\"

SetLocal EnableDelayedExpansion
pushd "%Adminpathtofolder%"
for /f "delims=" %%i in ('dir /ad /b^|findstr /vlix "stage security logs"') do (
	rd /s /q "%Adminpathtofolder%%%i\"
	popd
	Set "var=%Adminpathtofolder%%%i"
	echo !var!
	if exist !var! (
		popd
		exit 1
	)
)
Endlocal
echo %cache_delete_status%
