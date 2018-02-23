echo off
set "enviroment=cluster"
set "hostname=UKGSWTOWB10"
set "hostname1=UKGSWTOWB05"

if %enviroment%==cluster goto ipofclusterservers
if %enviroment%==non-cluster goto ipofnonclusterservers

:ipofclusterservers
for /f "tokens=1,2 delims=[]" %%A in ('ping %hostname% ^| find "Pinging"') do set servername=%%B
echo IP address is: %servername%

for /f "tokens=1,2 delims=[]" %%A in ('ping %hostname1% ^| find "Pinging"') do set servername=%%B
echo IP address is: %servername%

goto exit

:ipofnonclusterservers
for /f "tokens=1,2 delims=[]" %%A in ('ping %hostname% ^| find "Pinging"') do set servername=%%B
echo IP address is: %servername%

goto exit

:exit

