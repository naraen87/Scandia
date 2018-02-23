REM *********************Take the Backup Of Current System******************************************************************
REM @echo off
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"
set "datestamp=%YYYY%%MM%%DD%" & set "timestamp=%HH%%Min%%Sec%"
set "fullstamp=%YYYY%%MM%%DD%_%HH%%Min%%Sec%"
set "backup_location=C:\Users\SVCT-WI-Jenkins\Desktop\backup_location"
set "destination=%backup_location%\%fullstamp%"
set "destinationintranet=%backup_location%\%fullstamp%\Intranet"
set "destinationextranet=%backup_location%\%fullstamp%\Extranet"
set "destinationspringbatch=%backup_location%\%fullstamp%\Springbatch"
set "destinationsi=%backup_location%\%fullstamp%\SI"
mkdir %destinationintranet%
mkdir %destinationextranet%
mkdir %destinationspringbatch%
mkdir %destinationsi%

SetLocal EnableDelayedExpansion
::This line is just in case n has been defined before the batch file is run
Set n=
Set InputFile=C:\Users\SVCT-WI-Jenkins\Desktop\Scripts_for_ORF2\Input_File_For_Deployment\backupfilenameandlocation.txt
For /F "tokens=*" %%G IN (%InputFile%) DO (
echo.%%G | findstr /C:"Intranet" 1>nul
if !errorlevel! equ 0 (
	COPY "%%G" "%destinationintranet%"
	if !errorlevel! equ 0 (
		echo copy success from %%G to "%destinationintranet%"
		
	) else (
		echo Not able to copy the %%G file
		goto :EOF
	)
) else (
echo goto next copy
)
echo.%%G | findstr /C:"Extranet" 1>nul
if !errorlevel! equ 0 (
	COPY "%%G" "%destinationextranet%"
	if !errorlevel! equ 0 (
		echo copy success from %%G to %destinationextranet%
		
	) else (
		echo Not able to copy the %%G file
		goto :EOF
	)
) else (
echo goto next copy
)
echo.%%G | findstr /C:"Springbatch" 1>nul
if !errorlevel! equ 0 (
	COPY "%%G" "%destinationspringbatch%"
	if !errorlevel! equ 0 (
		echo copy success from %%G to %destinationspringbatch%
		
	) else (
		echo Not able to copy the %%G file
		goto :EOF
	)
) else (
echo goto next copy
)
echo.%%G | findstr /C:"SI" 1>nul
if !errorlevel! equ 0 (
	COPY "%%G" "%destinationsi%"
	if !errorlevel! equ 0 (
		echo copy success from %%G to %destinationsi%
		
	) else (
		echo Not able to copy the %%G file
		goto :EOF
	)
) else (
echo goto next copy
)
:nextloop
echo Next Loop Starts
)
:: This line will display the variables just assigned
:: For testing only, delete when not needed

EndLocal