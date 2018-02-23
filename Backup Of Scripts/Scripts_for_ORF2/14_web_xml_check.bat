REM *********************Open the web.xml and check the two fields********************************************************
set "xmlstartlet_location=E:\Jenkins_Software\xmlstarlet-1.6.1-win32\xmlstarlet-1.6.1\xml.exe"
REM set "xmlstartlet_location=\\%servername%\C$\Users\boonar\Downloads\xmlstarlet-1.6.1-win32\xmlstarlet-1.6.1\xml.exe"
set "web_xml_change_path=%xml_file_path%\%xml_file_name%"
if not exist "%web_xml_change_path%" goto :EOF
if not exist "%xmlstartlet_location%" goto :EOF

%xmlstartlet_location% ed -L -N x="http://java.sun.com/xml/ns/javaee" -u "/x:web-app/x:welcome-file-list/x:welcome-file" -v 'LoginSR1.jsp' "%web_xml_change_path%"
echo %errorlevel%
if %errorlevel%==0 goto success
if not %errorlevel%==0  goto abort 
:success
set "xml_change=success"
goto exit
:abort
set "xml_change=failure"
goto :EOF
:exit

%xmlstartlet_location% ed -L -N x="http://java.sun.com/xml/ns/javaee" -u "//x:init-param[x:param-name='AuthMode']/x:param-value" -v "SnRWithBypass1" %web_xml_change_path%

if %errorlevel%==0 goto success
if not %errorlevel%==0  goto abort 
:success
set "xml_change=success"
goto exit
:abort
set "xml_change=failure"
goto :EOF
:exit


exit /b