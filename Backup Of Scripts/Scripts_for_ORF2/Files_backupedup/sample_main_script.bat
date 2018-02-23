call C:\Users\SVCT-WI-Jenkins\Desktop\sample_delete_cache.bat
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