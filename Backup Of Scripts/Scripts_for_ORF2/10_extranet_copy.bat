REM *********************Copy the extarcted extranet folder to non-cluster enviroment ************************************************************************
XCOPY "%extractdestination%\Extranet" "%extranet_intranet_target%" /E /V /I /Y
REM COPY "%extractdestination%\Extranet" "%extranet_intranet_target%\Extranet" /V /Y
if %errorlevel%==0 (set "_copy_status=success")
if %errorlevel%==1 (set "_copy_status=nofiles_failure")
if %errorlevel%==2 (set "_copy_status=useraction_failure")
if %errorlevel%==4 (set "_copy_status=lowmemory_failure")
if %errorlevel%==5 (set "_copy_status=diskwrite_failure")

exit /b

