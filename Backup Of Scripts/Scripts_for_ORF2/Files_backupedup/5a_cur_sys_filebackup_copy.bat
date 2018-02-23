@Echo Off
SetLocal EnableDelayedExpansion
::This line is just in case n has been defined before the batch file is run
Set n=
Set InputFile=C:\Users\SVCT-WI-Jenkins\Desktop\Scripts_for_ORF2\Input_File_For_Deployment\test.log
For /F "tokens=*" %%I IN (%InputFile%) DO (
Set /a n+=1
Set var!n!=%%I
echo "%var!n!%"
)
:: This line will display the variables just assigned
:: For testing only, delete when not needed

EndLocal