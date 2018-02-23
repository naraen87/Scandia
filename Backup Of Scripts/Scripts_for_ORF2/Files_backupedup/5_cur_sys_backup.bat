REM *********************Take the Backup Of Current System******************************************************************
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"
set "datestamp=%YYYY%%MM%%DD%" & set "timestamp=%HH%%Min%%Sec%"
set "fullstamp=%YYYY%%MM%%DD%_%HH%%Min%%Sec%"
set "destination=%backup_location%\%fullstamp%"
mkdir %destination%

if exist "%springbatch_si_target%\SI" goto sibackup
if not exist "%springbatch_si_target%\SI" goto sinotavailable
:sibackup
%psexec% \\%servername% XCOPY "%springbatch_si_target%\SI" "%destination%\SI" /E /V /I /Y
if %errorlevel%==0 goto sibackupsuccess
if NOT %errorlevel%==0 goto sibackupunsuccess
:sibackupsuccess
set "cur_sys_backup_status=success"
echo "Current SI Backup Successfully"
goto exit
:sibackupunsuccess
set "cur_sys_backup_status=failure"
echo "Unable to take the SI current system backup"
goto :EOF
:sinotavailable
set "cur_sys_backup_status=success"
echo "SI Folder not exists in the current system"
:exit

if exist "%springbatch_si_target%\SpringBatch" goto springbatchbackup
if not exist "%springbatch_si_target%\SpringBatch" goto springbatchnotavailable
:springbatchbackup
%psexec% \\%servername% XCOPY "%springbatch_si_target%\SpringBatch" "%destination%\SpringBatch" /E /V /I /Y
if %errorlevel%==0 goto springbatchbackupsuccess
if NOT %errorlevel%==0 goto springbatchbackupunsuccess
:springbatchbackupsuccess
set "cur_sys_backup_status=success"
echo "Current SpringBatch Backup Successfully"
goto exit
:springbatchbackupunsuccess
set "cur_sys_backup_status=failure"
echo "Unable to take the SpringBatch current system backup"
goto :EOF
:springbatchnotavailable
set "cur_sys_backup_status=success"
echo "SpringBatch Folder not exists in the current system"
:exit

if exist "%extranet_intranet_target%\Extranet" goto extranetbackup
if not exist "%extranet_intranet_target%\Extranet" goto extranetnotavailable
:extranetbackup
%psexec% \\%servername% XCOPY "%extranet_intranet_target%\Extranet" "%destination%\Extranet" /E /V /I /Y
if %errorlevel%==0 goto extranetbackupsuccess
if NOT %errorlevel%==0 goto extranetbatchbackupunsuccess
:extranetbackupsuccess
set "cur_sys_backup_status=success"
echo "Current Extarnet Backup Successfully"
goto exit
:extranetbatchbackupunsuccess
set "cur_sys_backup_status=failure"
echo "Unable to take the Extarnet current system backup"
goto :EOF
:extranetnotavailable
set "cur_sys_backup_status=success"
echo "Extranet Folder not exists in the current system"
:exit

if exist "%extranet_intranet_target%\Intranet" goto intranetbackup
if not exist "%extranet_intranet_target%\Intranet" goto intranetnotavailable
:intranetbackup
%psexec% \\%servername% XCOPY "%extranet_intranet_target%\Intranet" "%destination%\Intranet" /E /V /I /Y
if %errorlevel%==0 goto intranetbackupsuccess
if NOT %errorlevel%==0 goto intranetbatchbackupunsuccess
:intranetbackupsuccess
set "cur_sys_backup_status=success"
echo "Current Intranet Backup Successfully"
goto exit
:intranetbatchbackupunsuccess
set "cur_sys_backup_status=failure"
echo "Unable to take the Intranet current system backup"
goto :EOF
:intranetnotavailable
set "cur_sys_backup_status=success"
echo "Extranet Folder not exists in the current system"
:exit

exit /b