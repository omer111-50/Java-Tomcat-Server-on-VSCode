@echo off
setlocal

:: Get the TOMCAT_DIR from build.bat
for /f "tokens=2 delims==" %%a in ('findstr "TOMCAT_DIR=" scripts\windows\build.bat') do set TOMCAT_DIR=%%a
:: Get the APP_NAME from build.bat
for /f "tokens=2 delims==" %%a in ('findstr "APP_NAME=" scripts\windows\build.bat') do set APP_NAME=%%a

:: Function to check if Tomcat is running
:is_tomcat_running
tasklist /FI "IMAGENAME eq java.exe" | find "java.exe" > nul
if %ERRORLEVEL% EQU 0 (
    exit /b 0
) else (
    exit /b 1
)

:: Function to start Tomcat and build
:start_tomcat
echo Starting Tomcat server...
call "%TOMCAT_DIR%\bin\startup.bat"

:: Wait for Tomcat to start (give it 5 seconds)
echo Waiting for Tomcat to start...
timeout /t 5 /nobreak > nul

:: Run the build script
echo Running build script...
call scripts\windows\build.bat

echo Tomcat is now running and application is built!
echo You can access your application at: http://localhost:8080/%APP_NAME%
exit /b 0

:: Function to stop Tomcat
:stop_tomcat
echo Stopping Tomcat server...
call "%TOMCAT_DIR%\bin\shutdown.bat"

:: Wait for Tomcat to stop (give it 5 seconds)
timeout /t 5 /nobreak > nul

:: Double check if Tomcat is still running
call :is_tomcat_running
if %ERRORLEVEL% EQU 0 (
    echo Tomcat is still running. Forcing shutdown...
    taskkill /F /IM java.exe
)

echo Tomcat has been stopped.
exit /b 0

:: Main script logic
call :is_tomcat_running
if %ERRORLEVEL% EQU 0 (
    echo Tomcat is currently running.
    set /p answer=Do you want to stop Tomcat? (y/n): 
    if /i "%answer%"=="y" (
        call :stop_tomcat
    ) else (
        echo Tomcat will continue running.
    )
) else (
    echo Tomcat is not running.
    set /p answer=Do you want to start Tomcat and build the application? (y/n): 
    if /i "%answer%"=="y" (
        call :start_tomcat
    ) else (
        echo Tomcat will remain stopped.
    )
) 