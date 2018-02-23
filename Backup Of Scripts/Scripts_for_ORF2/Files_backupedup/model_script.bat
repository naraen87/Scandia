
set "psexec=E:\Jenkins_Software\PSTools\PsExec.exe"
set "script_location=C:\Users\SVCT-WI-Jenkins\Desktop\Scripts_for_ORF2"

%psexec% \\%servername% cmd /c call %script_location%\5_cur_sys_backup.bat
echo %destination%
echo %cur_sys_backup_status%
if "%cur_sys_backup_status%" == "failure" goto backup_failure
if "%cur_sys_backup_status%" == "success" goto backup_success
:backup_success
echo Current Backup from \\%servername%\c$\narayana is Success.
goto exit
:backup_failure
echo Current Backup from \\%servername%\c$\narayana is Failure.
goto :EOF
:exit