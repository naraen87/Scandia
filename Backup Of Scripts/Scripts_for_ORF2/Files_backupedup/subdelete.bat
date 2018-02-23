set "cahefolderpath=%1%"
SetLocal EnableDelayedExpansion
cd /d %cahefolderpath%
for /f "delims=" %%i in ('dir /ad /b^|findstr /vlix "stage security logs"') do (
	echo rd /s /q "!cahefolderpath!%%i"
	if exists !cahefolderpath!%%i (
		echo "folder exists"
	)
	echo folder deletion success
)
EndLocal
exit /b