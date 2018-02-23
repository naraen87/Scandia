REM @echo off
if "%1"=="" goto _help
if "%2"=="" goto _help
 
REM 0=success, 1=failure
E:\Jenkins_Software\PortQry.exe -n %1 -e %2 -q
 
IF ERRORLEVEL 1 GOTO _closed
:_opened
	REM handler for open port
	echo. SUCCESS: Port is OPENED
	goto _eof
 
:_closed
	REM handler for closed port
	echo. FAILURE: Port is CLOSED
	goto _eof
 
:_help
	echo.
	echo. Test if port is open
	echo.
	echo. Syntax:
	echo.
	echo. 	%0 hostname port
	echo.
 
:_eof