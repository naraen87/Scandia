 ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

set servername=10.66.216.141

set svcname=BancsSpringIntranetAdhocProcessor
sc \\%servername% start %svcname%
:CheckStateStart
Set STATE=CLOSE
for /f "tokens=1" %%i in ('wmic /node:%servername% service where Name^="%svcname%" get state^| find "Running"')  do (
rem echo Port:%PORT% on %servername% OPEN!
set STATE=OPEN
Goto :EOF

)
echo Waiting for the Service %svcname% on %servername% to Start...
Goto :EOF
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:WaitStart
:: %1 is the Remote Machine Name
:: %2 is null if attempting to start, is Re- if restarting
Set loop=0
:CheckLoopStart
:: Will check state 20 times, adjust as needed.
If %loop%==240 Goto NoStart
:: Wait 5 second for service to (Re-)start (can also use sleep utility)
:: adjust -w as needed units are milliseconds
:: echo Checking Status Again in 5Seconds.
Ping 1.0.0.0 -n 1 -w 5000 >Nul
Call :CheckStateStart
If NOT "%STATE%"=="OPEN" (set /a loop+=1) & Goto CheckLoopStart
Echo Windows Service %svcname% on %servername% is in Running state.
ECHO.
GOTO :EOF
:NoStart
Echo Unable to start service %svcname% on %servername% in 20 minutes
ECHO Please check the state of service manually.
ECHO.
Set ErrFlag=1
Goto :EOF
:EOF
This is the function which checks for the servicename which is RUNNING or not in the machine.

Check whether service is STOPPED or not in remote server

 ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:CheckStateStop
Set STATE=OPEN
for /f "tokens=1" %%i in ('wmic /node:%servername% service where Name^="%svcname%" get state^| find "Stopped"')  do (
rem echo Port:%PORT% on %servername% CLOSE!
set STATE=CLOSE
Goto :EOF
)
echo Waiting for the Service %svcname% on %servername% to Stop...
Goto :EOF
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:WaitStop
:: %1 is the Remote Machine Name
Set loop=0
:CheckLoopStop
:: Will check state 20 times, adjust as needed.
If %loop%==240 Goto NoStop
:: Wait 5 second for service to (Re-)start (can also use sleep utility)
:: adjust -w as needed units are milliseconds
:: echo Checking Status Again in 5Seconds.
Ping 1.0.0.0 -n 1 -w 5000 >Nul
Call :CheckStateStop
If NOT "%STATE%"=="CLOSE" (set /a loop+=1) & Goto CheckLoopStop
Echo Windows Service %svcname% on %servername% is in Stopped state.
ECHO.
GOTO :EOF
:NoStop
Echo Unable to stop %svcname% on %servername% in 20 minutes
ECHO Please check the state of service manually.
ECHO.
Set ErrFlag=1
Goto :EOF