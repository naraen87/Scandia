REM *********************Delete the Cache and Log Folders************************************************************************
set "servername=10.66.216.141"
set "psexec=E:\Jenkins_Software\PSTools\PsExec.exe"
xcopy "\\10.66.224.236\C$\Users\SVCT-WI-Jenkins\Desktop\Scripts_for_ORF2\Files_backupedup\subdelete.bat" "\\10.66.216.141\C$\Users\SVCT-WI-Jenkins\Desktop\Deletescript\" /E /V /I /Y
%psexec% \\%servername% cmd /c C:\Users\SVCT-WI-Jenkins\Desktop\Deletescript\subdelete.bat E:\Oracle\Middleware\user_projects\domains\Skandia\servers\AdminServer\
echo %errorlevel%
if %errorlevel%==0 goto cachesuccess
if not %errorlevel%==0 goto cachefailure
:cachesuccess
set "cache_status=success"
echo Admin cache folder deleted successfully
goto exit
:cachefailure
set "cache_status=failure"
echo Admin cache folder deletion unsuccessful
goto :EOF
:exit
