REM *********************Take the Backup Of Current System******************************************************************
REM @echo off
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"
set "datestamp=%YYYY%%MM%%DD%" & set "timestamp=%HH%%Min%%Sec%"
set "fullstamp=%YYYY%%MM%%DD%_%HH%%Min%%Sec%"
set "backup_location=C:\Users\SVCT-WI-Jenkins\Desktop\backup_location"
set "destination=%backup_location%\%fullstamp%"
mkdir %destination%

SetLocal EnableDelayedExpansion
::This line is just in case n has been defined before the batch file is run
Set n=
Set InputFile=C:\Users\SVCT-WI-Jenkins\Desktop\Scripts_for_ORF2\Input_File_For_Deployment\backupfilenameandlocation.txt
For /F "tokens=*" %%G IN (%InputFile%) DO (
XCOPY %%G %destination% /V /I /Y
if !errorlevel! neq 0 goto backupunsuccess
:backupunsuccess
set "cur_sys_backup_status=failure"
echo "Unable to take the backup"
goto :EOF
:exit
)
:: This line will display the variables just assigned
:: For testing only, delete when not needed

EndLocal