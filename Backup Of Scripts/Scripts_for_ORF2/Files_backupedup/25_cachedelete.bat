REM @echo off
set "servername=10.66.216.141"
set "Adminlogpathtofolder=\\%servername%\e$\Oracle\Middleware\user_projects\domains\Skandia\servers\AdminServer\logs\"
set "Adminpathtofolder=\\%servername%\e$\Oracle\Middleware\user_projects\domains\Skandia\servers\AdminServer\"

SetLocal EnableDelayedExpansion
pushd "%Adminpathtofolder%"
for /f "delims=" %%i in ('dir /ad /b^|findstr /vlix "stage security"') do (
	echo rd /s /q "%Adminpathtofolder%%%i\"
	popd
	Set "var=%Adminpathtofolder%!!i"
	echo "var"
	REM if exists !varn! (
			REM SET "cache_delete_status=failure"
			
	REM )
set "cache_delete_status=success"
REM dir /b /a "%Adminpathtofolder%%%i" | >nul findstr "^" && (set fileorfoldersexists=1) || (set fileorfoldersexists=0)
REM ECHO %fileorfoldersexists%
REM IF NOT %fileorfoldersexists% ==1 (SET "cache_delete_status=failure") && goto :EOF || (SET "cache_delete_status=sucess")
)
echo %cache_delete_status%
endlocal