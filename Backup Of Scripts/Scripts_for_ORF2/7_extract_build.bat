REM *********************Extract the Build Artifacts************************************************************************
%extractor_file_location% x "%pathdestination%\%artifact_file_name%" -o"%pathdestination%"
if %errorlevel%==0 set "extract_operation=success"
if %errorlevel%==1 set "extract_operation=warning"
if %errorlevel%==2 set "extract_operation=fatal_error"
if %errorlevel%==7 set "extract_operation=command_line_error"
if %errorlevel%==8 set "extract_operation=lowmemory"
if %errorlevel%==255 set "extract_operation=useraction"

exit /b