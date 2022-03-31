@echo off
cd /d "%~dp0\resources"
::Default
set exePath=C:\3000soft\Red Spider\
set dllPath=C:\Windows\SysWOW64\
::For other cases
if not exist "%dllPath%redhooks.dll" (
set dllPath=C:\Windows\System32\
)
if not exist "%exePath%REDAgent.exe" (
set exePath=C:\Program Files\3000soft\Red Spider\
)
::Start
echo ------------------------------
echo 1.Kill processes of RedSpider
echo ------------------------------
echo.
taskkill /im rscheck.exe /f
taskkill /im redagent.exe /f
taskkill /im checkrs.exe /f
taskkill /im epointer.exe /f
echo.
if not exist "%dllPath%redhooks.dll.bak" (
echo - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
echo ^<-^>Backup %dllPath%redhooks.dll as redhooks.dll.bak
echo - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
echo.
rename %dllPath%redhooks.dll redhooks.dll.bak 
)
if not exist "%exePath%REDAgent.exe.bak" (
echo - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
echo ^<-^>Backup %exePath%REDAgent.exe  as REDAgent.exe.bak
echo - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
echo.
rename "%exePath%REDAgent.exe" REDAgent.exe.bak
)
echo -------------------------------------------
echo 2.Replace %dllPath%redhooks.dll
echo -------------------------------------------
echo.
copy redhooks.dll %dllPath%
IF "%ERRORLEVEL%"=="1" (
echo.
echo - - - - - - - - - - - - - - - - - -
echo ^<!^>Failed to replace redhooks.dll
echo - - - - - - - - - - - - - - - - - -
goto :FAIL
)
echo.
echo -----------------------------------------------
echo 3.Replace %exePath%REDAgent.exe
echo -----------------------------------------------
echo.
copy REDAgent.exe "%exePath%"
IF "%ERRORLEVEL%"=="1" (
echo.
echo - - - - - - - - - - - - - - - - - - -
echo ^<!^>Failed to replace REDAgent.exe
echo - - - - - - - - - - - - - - - - - - -
goto :FAIL
)
echo.
echo -------------
echo 4.Completed!
echo -------------
echo.
echo ---------------------------------------------
echo 5.Reopen %exePath%REDAgent.exe
echo ---------------------------------------------
echo.
start /d "%exePath%" REDAgent.exe
pause
exit
:FAIL
echo.
echo - - - - - - - - - - -
echo ^<!^>Failed to crack
echo - - - - - - - - - - -
echo.
start /d "%exePath%" REDAgent.exe
pause