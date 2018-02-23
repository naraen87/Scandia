REM *********************Copy the extarcted folders to cluster enviroment********************************************************

REM set "extranet_intranet_target=M:/BaNCSFS/BancsProduct"
REM set "springbatch_si_target=E:/BancsProduct"

IF EXIST %extractdestination%\Extranet GOTO extranetavailable
IF NOT EXIST %extractdestination%\Extranet GOTO extranetunavailable
:extranetavailable
call %script_location%\10_extranet_copy.bat %extractdestination% %extranet_intranet_target%
echo %_copy_status%
if "%_copy_status%" == "nofiles_failure" goto nofiles
if "%_copy_status%" == "useraction_failure" goto abort
if "%_copy_status%" == "lowmemory_failure" goto lowmemory
if "%_copy_status%" == "diskwrite_failure" goto diskwrite
if "%_copy_status%" == "success" goto success
:diskwrite 
echo Disk write error occurred.
goto revertback
:lowmemory 
echo Insufficient memory to copy files or
echo invalid drive or command-line syntax.
goto revertback 
:abort
echo You pressed CTRL+C to end the copy operation.
goto revertback
:nofiles 
echo No files were found to copy.
goto revertback
:success
echo success
goto exit
:revertback
echo Going to Revert back the old build artifacts and up the serives
REM xcopy "%destination%\TPM_Source\" "D:\Users\narayana.b\Desktop\Scandia\TPM_Source"
REM xcopy "%destination%\DMS_Source\" "D:\Users\narayana.b\Desktop\Scandia\DMS_Source"
REM sc \\%File% start AdobeARMservice
goto logswitch

:extranetunavailable
echo "Extranet folder is unavailable"
goto exit
:exit

IF EXIST %extractdestination%\DMS_Source GOTO intranetavailable
IF NOT EXIST %extractdestination%\DMS_Source GOTO intranetunavailable

:intranetavailable
call %script_location%\11_intranet_copy.bat %extractdestination% %extranet_intranet_target%
echo %_copy_status%
if "%_copy_status%" == "nofiles_failure" goto nofiles
if "%_copy_status%" == "useraction_failure" goto abort
if "%_copy_status%" == "lowmemory_failure" goto lowmemory
if "%_copy_status%" == "diskwrite_failure" goto diskwrite
if "%_copy_status%" == "success" goto success

:diskwrite 
echo Disk write error occurred.
goto revertback
:lowmemory 
echo Insufficient memory to copy files or
echo invalid drive or command-line syntax.
goto revertback 
:abort
echo You pressed CTRL+C to end the copy operation.
goto revertback
:nofiles 
echo No files were found to copy.
goto revertback
:success
echo success
goto exit
:revertback
echo Going to Revert back the old build artifacts and up the serives
REM xcopy "%destination%\TPM_Source\" "D:\Users\narayana.b\Desktop\Scandia\TPM_Source"
REM xcopy "%destination%\DMS_Source\" "D:\Users\narayana.b\Desktop\Scandia\DMS_Source"
REM sc \\%File% start AdobeARMservice
goto logswitch

:intranetunavailable
echo "Extranet folder is unavailable"
goto exit
:exit

IF EXIST %extractdestination%\SI GOTO siavailable
IF NOT EXIST %extractdestination%\SI GOTO siunavailable

:siavailable
call %script_location%\12_si_copy.bat %extractdestination% %springbatch_si_target%
echo %_copy_status%
if "%_copy_status%" == "nofiles_failure" goto nofiles
if "%_copy_status%" == "useraction_failure" goto abort
if "%_copy_status%" == "lowmemory_failure" goto lowmemory
if "%_copy_status%" == "diskwrite_failure" goto diskwrite
if "%_copy_status%" == "success" goto success

:diskwrite 
echo Disk write error occurred.
goto revertback
:lowmemory 
echo Insufficient memory to copy files or
echo invalid drive or command-line syntax.
goto revertback 
:abort
echo You pressed CTRL+C to end the copy operation.
goto revertback
:nofiles 
echo No files were found to copy.
goto revertback
:success
echo success
goto exit
:revertback
echo Going to Revert back the old build artifacts and up the serives
REM xcopy "%destination%\TPM_Source\" "D:\Users\narayana.b\Desktop\Scandia\TPM_Source"
REM xcopy "%destination%\DMS_Source\" "D:\Users\narayana.b\Desktop\Scandia\DMS_Source"
REM sc \\%File% start AdobeARMservice
goto logswitch

:siunavailable
echo "SI folder is unavailable"
goto exit
:exit

IF EXIST %extractdestination%\TPM_Source GOTO springbatchavailable
IF NOT EXIST %extractdestination%\TPM_Source GOTO springbatchunavailable

:springbatchavailable
call %script_location%\13_springbatch_copy.bat %extractdestination% %springbatch_si_target%
echo %_copy_status%
if "%_copy_status%" == "nofiles_failure" goto nofiles
if "%_copy_status%" == "useraction_failure" goto abort
if "%_copy_status%" == "lowmemory_failure" goto lowmemory
if "%_copy_status%" == "diskwrite_failure" goto diskwrite
if "%_copy_status%" == "success" goto success

:diskwrite 
echo Disk write error occurred.
goto revertback
:lowmemory 
echo Insufficient memory to copy files or
echo invalid drive or command-line syntax.
goto revertback 
:abort
echo You pressed CTRL+C to end the copy operation.
goto revertback
:nofiles 
echo No files were found to copy.
goto revertback
:success
echo success
goto exit
:revertback
echo Going to Revert back the old build artifacts and up the serives
REM xcopy "%destination%\TPM_Source\" "D:\Users\narayana.b\Desktop\Scandia\TPM_Source"
REM xcopy "%destination%\DMS_Source\" "D:\Users\narayana.b\Desktop\Scandia\DMS_Source"
REM sc \\%File% start AdobeARMservice
goto logswitch

:springbatchunavailable
echo "SpringBatch folder is unavailable"
goto exit
:exit

:logswitch
echo "Log the output"


:exit

exit /b