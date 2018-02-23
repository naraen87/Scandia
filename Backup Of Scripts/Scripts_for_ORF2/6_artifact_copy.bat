REM *********************Copy the Build Artifacts***************************************************************************

for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"
set "datestamp=%YYYY%%MM%%DD%" & set "timestamp=%HH%%Min%%Sec%"
set "fullstamp=%YYYY%%MM%%DD%_%HH%%Min%%Sec%"
set "destiny=%common_path%\%fullstamp%"
set "pathsource=%artifact_folder%\%artifact_file_name%"
set "pathdestination=\\%servername%\c$\%destiny%"
mkdir %pathdestination%
echo %pathdestination%
REM %psexec% \\%servername% XCOPY "%pathsource%" "%pathdestination%" /E /I /Y
XCOPY "%pathsource%" "%pathdestination%" /I /Y
if %errorlevel%==0 set "copy_status_artifact=success"
if NOT %errorlevel%==0 set "copy_status_artifact=failure"

exit /b
