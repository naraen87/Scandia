REM *********************Check the share folder accessibility***************************************************************
IF EXIST %artifact_folder% goto driveconnectivitysuccess
IF NOT EXIST %artifact_folder% goto driveconnectivityfailure
:driveconnectivitysuccess
set "drive_status=abletoaccess"
goto exit
:driveconnectivityfailure
set "drive_status=unabletoaccess"
goto :EOF
:exit

exit /b