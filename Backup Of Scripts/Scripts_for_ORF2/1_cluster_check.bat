REM *********************Check CLusster or Non_clustter********************************************************
if "%cluster_check%"=="cluster" goto cluster
if %cluster_check%==non-cluster goto non-cluster
if not %cluster_check%==cluster if not %cluster_check%==non-cluster goto not-defined
:non-cluster
set "enviroment=non-cluster"
goto exit

:cluster
set "enviroment=cluster"
goto exit

:not-defined
set "enviroment=Not_defined_well"
goto :EOF
:exit
exit /b