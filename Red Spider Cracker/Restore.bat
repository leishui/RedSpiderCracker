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
echo ----------------------------------
echo 2.Attempt to recover backup files
echo ----------------------------------
echo.
cd %dllPath%
if exist "redhooks.dll.bak" (
echo - - - - - - - - - - - - - - - - - - - - - - - -
echo ^<-^>Recover %dllPath%redhooks.dll
echo - - - - - - - - - - - - - - - - - - - - - - - -
echo.
copy redhooks.dll.bak redhooks.dll
IF "%ERRORLEVEL%"=="1" (
echo.
echo - - - - - - - - - - - - - - - - - - -
echo ^<!^>Failed to recover redhooks.dll
echo - - - - - - - - - - - - - - - - - - -
goto :FAIL
)
) else (
echo - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
echo ^<!^>%dllPath%redhooks.dll.bak is not found
echo ^<!^>Failed to recover redhooks.dll!
echo - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
goto :FAIL
)
cd "%exePath%"
if exist REDAgent.exe.bak (
echo - - - - - - - - - - - - - - - - - - - - - - - - -
echo ^<-^>Recover %exePath%REDAgent.exe
echo - - - - - - - - - - - - - - - - - - - - - - - - -
echo.
copy REDAgent.exe.bak REDAgent.exe
IF "%ERRORLEVEL%"=="1" (
echo.
echo - - - - - - - - - - - - - - - - - - -
echo ^<!^>Failed to recover REDAgent.exe
echo - - - - - - - - - - - - - - - - - - -
goto :FAIL
)
) else (
echo - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
echo ^<!^>%exePath%REDAgent.exe.bak is not found
echo ^<!^>Failed to recover REDAgent.exe!
echo - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
goto :FAIL
)
echo ---------------------------------------------
echo 3.Reopen %exePath%REDAgent.exe
echo ---------------------------------------------
echo.
start REDAgent.exe
pause
:FAIL
echo.
echo - - - - - - - - - - - - -
echo ^<!^>Incomplete recovery
echo - - - - - - - - - - - - -
echo.
start /d "%exePath%" REDAgent.exe
pause