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
  set "m_drive_location=%var11%"
  set "s_drive_location=%var12%"
  set "backup_filename_list=%var13%"
  set "db_deployment_state=%var14%"
  set "DB_batchfile_location1=%var15%"
  set "DB_batchfilename1=%var16%"
  set "DB_batchfile_location2=%var17%"
  set "DB_batchfilename2=%var18%"
)

set "script_location=C:\Users\SVCT-WI-Jenkins\Desktop\Scripts_for_ORF2"
set "extranet_intranet_target=%m_drive_location%\BancsProduct"
set "springbatch_si_target=%s_drive_location%\BancsProduct"
set common_path=Users\Public
set extractor_file_location="C:\Program Files\7-Zip\7z.exe"
set "psexec=E:\Jenkins_Software\PSTools\PsExec.exe"
set "jenkins_workspace=C:\Program Files (x86)\Jenkins\workspace\Bancs HotFix Deployment Automation"
if exist "%jenkins_workspace%\test.log" goto del
if not exist "%jenkins_workspace%\test.log" goto exit
:del
del "%jenkins_workspace%\test.log"
goto exit
:exit
xcopy "%script_location%\Input_File_For_Deployment\test.log" "%jenkins_workspace%" /V
if exist "%jenkins_workspace%\task_status.log" goto del
if not exist "%jenkins_workspace%\task_status.log" goto exit
:del
del "C:\Program Files (x86)\Jenkins\workspace\Bancs HotFix Deployment Automation\test.log"
goto exit
:exit
call %script_location%\1_cluster_check.bat %cluster_check%
if "%enviroment%" == "Not_defined_well" goto InputWrong
if not "%enviroment%" == "Not_defined_well" goto Inputsuccess
:Inputsuccess
echo The provide enviroment is %enviroment% >"%jenkins_workspace%\task_status.log"
goto exit
:InputWrong
echo Please provide the enviroment correctly. >"%jenkins_workspace%\task_status.log"
exit 1
:exit

call %script_location%\2_server_connectivity.bat %servername% %servername1%
if "%server_status%" == "unavailable" goto NoServer
if "%server_status%" == "available" goto Server
:Server
echo We are able to reach the provided server >>"%jenkins_workspace%\task_status.log"
goto exit
:NoServer
echo We are not able to reach the provided server >>"%jenkins_workspace%\task_status.log"
exit 1
:exit

call %script_location%\3_drive_connectivity.bat %artifact_folder%
if "%drive_status%" == "abletoaccess" goto Driveabletoaccess
if "%drive_status%" == "unabletoaccess" goto Driveunabletoaccess 
:Driveabletoaccess
echo We are able to access the %artifact_folder% >>"%jenkins_workspace%\task_status.log"
goto exit
:Driveunabletoaccess
echo We are not able to access the %artifact_folder% >>"%jenkins_workspace%\task_status.log"
exit 1
:exit

call %script_location%\4_service_down.bat %servername%
echo %service_down_status%
if "%service_down_status%" == "unproper" goto unproper
if "%service_down_status%" == "proper" goto proper
:proper
echo Services are down properly >>"%jenkins_workspace%\task_status.log"
goto exit
:unproper
echo Not able to down the services properly >>"%jenkins_workspace%\task_status.log"
goto :EOF
:exit

call %script_location%\5_cur_sys_filebackup.bat

call %script_location%\5_cur_sys_filebackup.bat %backup_filename_list%
echo %destination%
echo %cur_sys_backup_status%
if "%cur_sys_backup_status%" == "failure" goto backup_failure
if "%cur_sys_backup_status%" == "success" goto backup_success
:backup_success
echo Current Backup from \\%servername%\c$\narayana is Success >>"%jenkins_workspace%\task_status.log"
goto exit
:backup_failure
echo Current Backup from \\%servername%\c$\narayana is Failure >>"%jenkins_workspace%\task_status.log"
goto :EOF
:exit

call %script_location%\6_artifact_copy.bat %servername% %artifact_folder% %artifact_file_name% %common_path%
echo %pathdestination%
echo %copy_status_artifact%
if "%copy_status_artifact%" == "failure" goto artifact_copy_failure
if "%copy_status_artifact%" == "success" goto artifact_copy_success
:artifact_copy_success
echo Artifact copy from %pathsource% is Success >>"%jenkins_workspace%\task_status.log"
goto exit
:artifact_copy_failure
echo Artifact copy from %pathsource% is Failure >>"%jenkins_workspace%\task_status.log"
goto :EOF
:exit

call %script_location%\7_extract_build.bat %extractor_file_location% %pathdestination% %artifact_file_name%

if "%extract_operation%" == "success" goto success
if "%extract_operation%" == "warning" goto warning
if "%extract_operation%" == "fatal_error" goto fatal_error
if "%extract_operation%" == "command_line_error" goto command_line_error
if "%extract_operation%" == "lowmemory" goto lowmemory
if "%extract_operation%" == "useraction" goto useraction

:useraction 
echo User stopped the process >>"%jenkins_workspace%\task_status.log"
goto revertback
:lowmemory 
echo Not enough memory for operation >>"%jenkins_workspace%\task_status.log"
goto revertback 
:command_line_error 
echo Command line error >>"%jenkins_workspace%\task_status.log"
goto revertback 
:fatal_error 
echo Fatal error >>"%jenkins_workspace%\task_status.log"
goto revertback
:warning 
echo Warning (Non fatal error(s)) >>"%jenkins_workspace%\task_status.log"
echo For example, one or more files were locked by some other application, so they were not compressed >>"%jenkins_workspace%\task_status.log"
goto revertback
:success
echo Extraction Success >>"%jenkins_workspace%\task_status.log"
goto exit
:revertback
echo "Extraction Fails" >>"%jenkins_workspace%\task_status.log"
goto :EOF
:exit

set "extractdestination=%pathdestination%\BancsProduct"
echo %extractdestination%
if %enviroment%==cluster goto cluster_copy
if %enviroment%==non-cluster goto non_cluster_copy
:cluster_copy
call %script_location%\8_target_foldercopy_cluster.bat %servername% %servername1% %extractdestination% %extranet_intranet_target% %springbatch_si_target% %script_location%

if "%_copy_status%" == "nofiles_failure" goto nofiles
if "%_copy_status%" == "useraction_failure" goto abort
if "%_copy_status%" == "lowmemory_failure" goto lowmemory
if "%_copy_status%" == "diskwrite_failure" goto diskwrite
if "%_copy_status%" == "success" goto success
:diskwrite 
echo Disk write error occurred >>"%jenkins_workspace%\task_status.log"
goto revertback
:lowmemory 
echo Insufficient memory to copy files or >>"%jenkins_workspace%\task_status.log"
echo invalid drive or command-line syntax >>"%jenkins_workspace%\task_status.log"
goto revertback
:abort
echo You pressed CTRL+C to end the copy operation >>"%jenkins_workspace%\task_status.log"
goto revertback
:nofiles 
echo No files were found to copy >>"%jenkins_workspace%\task_status.log"
goto revertback
:success
echo success
goto exit
:revertback
echo Code Binaries Copy from extarcted path to cluster Fails >>"%jenkins_workspace%\task_status.log"
goto :EOF
:exit

:non_cluster_copy
call %script_location%\9_target_foldercopy_non_cluster.bat %extractdestination% %extranet_intranet_target% %springbatch_si_target% %script_location%
echo "copy_status"=%_copy_status%
if %_copy_status%==success goto success
if %_copy_status%==useraction_failure  goto abort
if %_copy_status%==nofiles_failure goto nofiles
if %_copy_status%==lowmemory_failure goto lowmemory
if %_copy_status%==diskwrite_failure goto diskwrite
 
:diskwrite 
echo Disk write error occurred >>"%jenkins_workspace%\task_status.log"
goto revertback
:lowmemory 
echo Insufficient memory to copy files or >>"%jenkins_workspace%\task_status.log"
echo invalid drive or command-line syntax >>"%jenkins_workspace%\task_status.log"
goto revertback 
:abort
echo You pressed CTRL+C to end the copy operation >>"%jenkins_workspace%\task_status.log"
goto revertback
:nofiles 
echo No files were found to copy >>"%jenkins_workspace%\task_status.log"
goto revertback
:success
echo success >>"%jenkins_workspace%\task_status.log"
goto exit
:revertback
echo Code Binaries Copy from extarcted path to non-cluster Fails >>"%jenkins_workspace%\task_status.log"
goto :EOF
:exit

call %script_location%\14_web_xml_check.bat %xml_file_path% %xml_file_name%
echo %xml_change%
if %xml_change%==success goto xml_file_change_success
if %xml_change%==failure  goto xml_file_change_failure

:xml_file_change_success
echo XML File change success >>"%jenkins_workspace%\task_status.log"
goto exit
:xml_file_change_failure
echo XML File change failure >>"%jenkins_workspace%\task_status.log"
goto :EOF
:exit

call %script_location%\15_version_check.bat %property_file_path% %property_file_name% %version_number%

if %property_change%==success goto property_file_change_success
if %property_change%==failure  goto property_file_change_failure

:property_file_change_success
echo Version Update Success >>"%jenkins_workspace%\task_status.log"
goto exit
:property_file_change_failure
echo Version Update Failure >>"%jenkins_workspace%\task_status.log"
goto :EOF
:exit
REM echo off
call %script_location%\25_delete_cache.bat %servername%
echo %cache_delete_status%
if "%cache_delete_status%" == "unproper" goto unproper
if "%cache_delete_status%" == "proper" goto proper
:proper
echo Cache Deletion done properly >>"%jenkins_workspace%\task_status.log"
goto exit
:unproper
echo Not able to delete the cache >>"%jenkins_workspace%\task_status.log"
goto :EOF
:exit

call %script_location%\24_Service_up.bat %servername%
echo %service_up_status%
if "%service_up_status%" == "unproper" goto unproper
if "%service_up_status%" == "proper" goto proper
:proper
echo Services are running up properly >>"%jenkins_workspace%\task_status.log"
goto exit
:unproper
echo Not able to start the services properly >>"%jenkins_workspace%\task_status.log"
goto :EOF
:exit

