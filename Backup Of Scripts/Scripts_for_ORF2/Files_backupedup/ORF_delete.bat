REM *********************Delete the Cache and Log Folders************************************************************************
set "servername=10.66.216.141"
set "psexec=E:\Jenkins_Software\PSTools\PsExec.exe"
set "Adminlogpathtofolder=\\vfs-or2-wi\bancs\BaNCSFS\ORF2Test\New folder\"

if exist "%Adminlogpathtofolder%" goto deleteadminlog
if not exist "%Adminlogpathtofolder%" goto noadminlog

:deleteadminlog
REM %psexec% \\%servername% pushd "%Adminlogpathtofolder%" && (rd /s /q "%Adminlogpathtofolder%" 2>nul & popd)
REM %psexec% \\%servername% cmd /c "rd /s /q %Adminlogpathtofolder%"
REM pushd "%Adminlogpathtofolder%" && (rd /s /q "%Adminlogpathtofolder%" 2>nul & popd)
pushd "%Adminlogpathtofolder%"
rd /s /q "%Adminlogpathtofolder%"
echo %errorlevel%
popd
if %errorlevel%==0 goto cachedeletesuccess
if NOT %errorlevel%==0 goto cachedeleteunsuccess
:cachedeletesuccess
set "cache_delete_status=success"
echo "Admin Cache Deletion Successfully"
goto exit
:cachedeleteunsuccess
set "cache_delete_status=failure"
echo "Unable to delete the cache"
goto :EOF

:noadminlog
echo "There is no log folder on the Admin Server"
goto exit
:exit