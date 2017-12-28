@echo off
set /p MyServer=<D:\Users\narayana.b\Desktop\Scandia\servername.txt
echo %MyServer%
REM *********************Check the connectivity b/w servers*****************************************************************
%SystemRoot%\system32\ping.exe -n 1 %MyServer% >nul
if errorlevel 1 goto NoServer

echo %MyServer% is availabe.
rem Insert commands here, for example 1 or more net use to connect network drives.
goto exit
:NoServer
echo %MyServer% is not availabe yet.
pause
goto :EOF
:exit
REM *********************Check the share folder accessibility***************************************************************

REM *********************Down the Services**********************************************************************************

REM sc \\%File% stop AdobeARMservice

REM *********************Take the Backup Of Current System******************************************************************
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"

set "datestamp=%YYYY%%MM%%DD%" & set "timestamp=%HH%%Min%%Sec%"
set "fullstamp=%YYYY%%MM%%DD%_%HH%%Min%%Sec%"
echo datestamp: "%datestamp%"
echo timestamp: "%timestamp%"
echo fullstamp: "%fullstamp%"
pause
set dest=\\10.146.67.146\Users\Public\Backup
set destiny=%dest%\%fullstamp%
set destination=%destiny%\REL_DEV
mkdir %destination%
echo %destination%
xcopy /e/y "D:\Users\narayana.b\Desktop\Scandia\DMS_Source" "%destination%\DMS_Source\"
xcopy /e/y "D:\Users\narayana.b\Desktop\Scandia\TPM_Source" "%destination%\TPM_Source\"

REM *********************Copy the Build Artifacts***************************************************************************
xcopy /Y "\\10.146.67.146\Users\REL2_DEV.7z" "D:\Users\narayana.b\Desktop\Desktop\"

REM *********************Check the copy status and revert back if we face any issue*****************************************
echo %errorlevel%
if "%errorlevel%" == "5" goto diskwrite 
if "%errorlevel%" == "4" goto lowmemory 
if "%errorlevel%" == "2" goto useraction 
if "%errorlevel%" == "1" goto nofiles 
if "%errorlevel%" == "0" goto success 
:diskwrite 
echo Disk write error occurred. >C:\narayana\log.txt
goto revertback
:lowmemory 
echo Insufficient memory to copy files or >C:\narayana\log.txt
echo invalid drive or command-line syntax. >>C:\narayana\log.txt
goto revertback 
:abort
echo You pressed CTRL+C to end the copy operation. >C:\narayana\log.txt
goto revertback 
:nofiles 
echo No files were found to copy. >C:\narayana\log.txt
goto revertback
:success
echo success >C:\narayana\log.txt
goto exit
:revertback
echo Going to Revert back the old build artifacts and up the serives
copy %destination% //destination
REM sc \\%File% start AdobeARMservice
goto :EOF
:exit
REM *********************Extract the Build Artifacts************************************************************************
7z e recording_20130731180507.zip -o "C:\users\User1\documents\folder1\test"
REM *********************Check the extract status and revert back if we face any issue**************************************
echo %errorlevel%
if "%errorlevel%" == "255" goto useraction 
if "%errorlevel%" == "8" goto lowmemory 
if "%errorlevel%" == "7" goto command_line_error 
if "%errorlevel%" == "2" goto fatal_error 
if "%errorlevel%" == "1" goto warning 
if "%errorlevel%" == "0" goto success
:useraction 
echo User stopped the process. >C:\narayana\log.txt
goto revertback
:lowmemory 
echo Not enough memory for operation. >C:\narayana\log.txt
goto revertback 
:command_line_error 
echo Command line error. >C:\narayana\log.txt
goto revertback 
:fatal_error 
echo Fatal error. >C:\narayana\log.txt
goto revertback
:warning 
echo Warning (Non fatal error(s)). >C:\narayana\log.txt
echo For example, one or more files were locked by some other application, so they were not compressed. >C:\narayana\log.txt
goto revertback
:success
echo success >C:\narayana\log.txt
goto exit
:revertback
echo Going to Revert back the old build artifacts and up the serives
copy %destination% //destination
REM sc \\%File% start AdobeARMservice
goto :EOF
:exit

REM *********************Copy the extarcted folders to target server********************************************************

xcopy /e/y //source //destination

REM *********************Check the copy status and revert back if we face any issue*****************************************
echo %errorlevel%
if "%errorlevel%" == "5" goto diskwrite 
if "%errorlevel%" == "4" goto lowmemory 
if "%errorlevel%" == "2" goto useraction 
if "%errorlevel%" == "1" goto nofiles 
if "%errorlevel%" == "0" goto success 
:diskwrite 
echo Disk write error occurred. >C:\narayana\log.txt
goto revertback
:lowmemory 
echo Insufficient memory to copy files or >C:\narayana\log.txt
echo invalid drive or command-line syntax. >>C:\narayana\log.txt
goto revertback 
:abort 
echo You pressed CTRL+C to end the copy operation. >C:\narayana\log.txt
goto revertback 
:nofiles 
echo No files were found to copy. >C:\narayana\log.txt
goto revertback
:success
echo success >C:\narayana\log.txt
goto exit
:revertback
echo Going to Revert back the old build artifacts and up the serives
copy %destination% //destination
REM sc \\%File% start AdobeARMservice
goto :EOF
:exit