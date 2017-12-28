for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"

set "datestamp=%YYYY%%MM%%DD%" & set "timestamp=%HH%%Min%%Sec%"
set "fullstamp=%YYYY%%MM%%DD%_%HH%%Min%%Sec%"
echo datestamp: "%datestamp%"
echo timestamp: "%timestamp%"
echo fullstamp: "%fullstamp%"
pause
set dest=\\10.146.67.146\Users\Public\Backup
set destiny=%dest%\%fullstamp%
set destination=%destiny%\REL_DEV
mkdir %destination%
echo %destination%
xcopy /e/y "D:\Users\narayana.b\Desktop\Scandia\DMS_Source" "%destination%\DMS_Source\"
xcopy /e/y "D:\Users\narayana.b\Desktop\Scandia\TPM_Source" "%destination%\TPM_Source\"