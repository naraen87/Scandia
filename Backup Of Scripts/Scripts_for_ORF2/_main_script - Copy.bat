REM @echo off
if not exist "C:\Users\SVCT-WI-Jenkins\Desktop\Scripts_for_ORF2\Input_File_For_Deployment\test.log" goto :EOF
if exist "C:\Users\SVCT-WI-Jenkins\Desktop\Scripts_for_ORF2\Input_File_For_Deployment\newtest.log" goto del
if not exist "C:\Users\SVCT-WI-Jenkins\Desktop\Scripts_for_ORF2\Input_File_For_Deployment\newtest.log" goto exit
:del
del "C:\Users\SVCT-WI-Jenkins\Desktop\Scripts_for_ORF2\Input_File_For_Deployment\newtest.log"
goto exit
:exit
setlocal EnableExtensions EnableDelayedExpansion
set "InputFile=C:\Users\SVCT-WI-Jenkins\Desktop\Scripts_for_ORF2\Input_File_For_Deployment\test.log"
set "OutputFile=C:\Users\SVCT-WI-Jenkins\Desktop\Scripts_for_ORF2\Input_File_For_Deployment\newtest.log"
FOR /F "tokens=2 delims==" %%G IN (%InputFile%) do echo %%G>>%OutputFile%
endlocal

REM @Echo Off
SetLocal EnableDelayedExpansion
::This line is just in case n has been defined before the batch file is run
Set n=
Set InputFile=C:\Users\SVCT-WI-Jenkins\Desktop\Scripts_for_ORF2\Input_File_For_Deployment\newtest.log
For /F "tokens=*" %%I IN (%InputFile%) DO (
Set /a n+=1
Set var!n!=%%I
REM echo "%var!n!%"
)
:: This line will display the variables just assigned
:: For testing only, delete when not needed

EndLocal & (
  set "cluster_check=%var1%"
  set "servername=%var2%"
  set "servername1=%var3%"
  set "artifact_folder=%var4%"
  set "artifact_file_name=%var5%"
  set "version_number=%var6%"
  set "property_file_name=%var7%"
  set "property_file_path=%var8%"
  set "xml_file_path=%var9%"
  set "xml_file_name=%var10%"
  set "common_path=%var11%"
  set "extractor_file_location=%var12%"
  set "backup_location=%var13%"
  set "m_drive_location=%var14%"
  set "s_drive_location=%var15%"
)

set "psexec=E:\Jenkins_Software\PSTools\PsExec.exe"
set "script_location=C:\Users\SVCT-WI-Jenkins\Desktop\Scripts_for_ORF2"
call %script_location%\1_cluster_check.bat %cluster_check%

call %script_location%\2_server_connectivity.bat %servername% %servername1%
if "%server_status%" == "unavailable" goto NoServer
if "%server_status%" == "available" goto Server
:Server
echo %servername% is availabe.
goto exit
:NoServer
echo %servername% is not availabe yet.
goto :EOF
:exit

call %script_location%\3_drive_connectivity.bat %artifact_folder%
echo %drive_status%
if "%drive_status%" == "abletoaccess" goto Driveabletoaccess
if "%drive_status%" == "unabletoaccess" goto Driveunabletoaccess 
:Driveabletoaccess
echo %artifact_folder% is availabe.
goto exit
:Driveunabletoaccess
echo %artifact_folder% is not availabe yet.
goto :EOF
:exit

call %script_location%\4_service_down.bat %servername%
echo %service_down_status%
if "%service_down_status%" == "unproper" goto unproper
if "%service_down_status%" == "proper" goto proper
:proper
echo Services are down properly.
goto exit
:unproper
echo Not able to down the services properly.
goto :EOF
:exit

set "extranet_intranet_target=%m_drive_location%\BancsProduct"
set "springbatch_si_target=%s_drive_location%\BancsProduct"

call %script_location%\5_cur_sys_filebackup %servername% %psexec% %backup_location% %extranet_intranet_target% %springbatch_si_target%
echo %destination%
echo %cur_sys_backup_status%
if "%cur_sys_backup_status%" == "failure" goto backup_failure
if "%cur_sys_backup_status%" == "success" goto backup_success
:backup_success
echo Current Backup from \\%servername%\c$\narayana is Success.
goto exit
:backup_failure
echo Current Backup from \\%servername%\c$\narayana is Failure.
goto :EOF
:exit


call %script_location%\6_artifact_copy.bat %servername% %artifact_folder% %artifact_file_name% %common_path% %psexec%
echo %pathdestination%
echo %copy_status_artifact%
if "%copy_status_artifact%" == "failure" goto artifact_copy_failure
if "%copy_status_artifact%" == "success" goto artifact_copy_success
:artifact_copy_success
echo Artifact copy from %pathsource% is Success.
goto exit
:artifact_copy_failure
echo Artifact copy from %pathsource% is Failure.
goto :EOF
:exit

call %script_location%\7_extract_build.bat %servername% %extractor_file_location% %pathdestination% %artifact_file_name% %psexec%

if "%extract_operation%" == "success" goto success
if "%extract_operation%" == "warning" goto warning
if "%extract_operation%" == "fatal_error" goto fatal_error
if "%extract_operation%" == "command_line_error" goto command_line_error
if "%extract_operation%" == "lowmemory" goto lowmemory
if "%extract_operation%" == "useraction" goto useraction

:useraction 
echo User stopped the process.
goto revertback
:lowmemory 
echo Not enough memory for operation.
goto revertback 
:command_line_error 
echo Command line error.
goto revertback 
:fatal_error 
echo Fatal error.
goto revertback
:warning 
echo Warning (Non fatal error(s)).
echo For example, one or more files were locked by some other application, so they were not compressed.
goto revertback
:success
echo success
goto exit
:revertback
echo "Extraction Fails"
goto :EOF
:exit

set "extractdestination=%pathdestination%\BancsProduct"

echo %enviroment%
if %enviroment%==cluster goto cluster_copy
if %enviroment%==non-cluster goto non_cluster_copy
REM ==========================================================================
REM if not %enviroment% ==cluster if not %enviroment%==non-cluster goto :EOF

REM set "pathdestination=D:\Users\narayana.b\Desktop\extract_test"
REM ===========================================================================
:cluster_copy
call %script_location%\8_target_foldercopy_cluster.bat %servername% %servername1% %extractdestination% %extranet_intranet_target% %springbatch_si_target% %script_location%

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
goto :EOF
:exit


:non_cluster_copy
call %script_location%\9_target_foldercopy_non_cluster.bat %servername% %extractdestination% %extranet_intranet_target% %springbatch_si_target% %script_location%
echo "copy_status"=%_copy_status%
if %_copy_status%==success goto success
if %_copy_status%==useraction_failure  goto abort
if %_copy_status%==nofiles_failure goto nofiles
if %_copy_status%==lowmemory_failure goto lowmemory
if %_copy_status%==diskwrite_failure goto diskwrite
 
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
goto :EOF
:exit

call %script_location%\14_web_xml_check.bat %xml_file_path% %xml_file_name%
echo %xml_change%
if %xml_change%==success goto xml_file_change_success
if %xml_change%==failure  goto xml_file_change_failure

:xml_file_change_success
echo File change success
goto exit
:xml_file_change_failure
goto :EOF
:exit

call %script_location%\15_version_check.bat %property_file_path% %property_file_name% %version_number%

if %property_change%==success goto property_file_change_success
if %property_change%==failure  goto property_file_change_failure

:property_file_change_success
echo File change success
goto exit
:property_file_change_failure
goto :EOF

:exit

call %script_location%\25_delete_cache %servername%
echo %cache_delete_status%
if "%cache_delete_status%" == "unproper" goto unproper
if "%cache_delete_status%" == "proper" goto proper
:proper
echo Cache Deletion done properly.
goto exit
:unproper
echo Not able to delete the cache.
goto :EOF
:exit

call %script_location%\24_Service_up.bat %servername%
echo %service_up_status%
if "%service_up_status%" == "unproper" goto unproper
if "%service_up_status%" == "proper" goto proper
:proper
echo Services are running up properly.
goto exit
:unproper
echo Not able to start the services properly.
goto :EOF
:exit