REM *********************Copy the extarcted folders to non-cluster enviroment************************************************************************
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
echo "Copy status of Extracted extranet folder success"
goto exit
:revertback
echo Going to Revert back the old build artifacts and up the serives
goto logswitch
:logswitch
echo "Extranet Copy Unsuccess"
goto :EOF

:extranetunavailable
echo "Extranet folder is unavailable"
goto exit
:exit

IF EXIST %extractdestination%\Intranet GOTO intranetavailable
IF NOT EXIST %extractdestination%\Intranet GOTO intranetunavailable

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
echo "Copy status of Extracted intranet folder success"
goto exit
:revertback
echo Going to Revert back the old build artifacts and up the serives
goto logswitch
:logswitch
echo "Intranet Copy Unsuccess"
goto :EOF

:intranetunavailable
echo "Intranet folder is unavailable"
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
echo "Copy status of Extracted si folder success"
goto exit
:revertback
echo Going to Revert back the old build artifacts and up the serives
goto logswitch
:logswitch
echo "SI Copy Unsuccess"
goto :EOF

:siunavailable
echo "SI folder is unavailable"
goto exit
:exit

IF EXIST %extractdestination%\SpringBatch GOTO springbatchavailable
IF NOT EXIST %extractdestination%\SpringBatch GOTO springbatchunavailable

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
echo "Copy status of Extracted springbatch folder success"
goto exit
:revertback
echo Going to Revert back the old build artifacts and up the serives
goto logswitch
:logswitch
echo "SpringBatch Copy Unsuccess"
goto :EOF

:springbatchunavailable
echo "SpringBatch folder is unavailable"
goto exit
:exit

exit /b