REM *********************Open the property file and check the version********************************************************
set "jrepl_path=E:\Jenkins_Software\JREPL7.9\JREPL.bat"
REM set "jrepl_path=\\%servername%\c$\Users\SVCT-WI-Jenkins\Desktop\JREPL7.9\JREPL.bat"
set "mysys_property_change_path=%property_file_path%\%property_file_name%"
if not exist "%mysys_property_change_path%" goto :EOF
if not exist "%jrepl_path%" goto :EOF

call "%jrepl_path%" "^(Environment=.+)$" "Environment=%version_number%" /I /F "%mysys_property_change_path%" /O -
if %errorlevel%==0 set "property_change=success"
if not %errorlevel%==0 set "property_change=failure"
rd /Q /S "%TEMP%\JREPL" 2>nul
exit /b