@echo off
setlocal EnableDelayedExpansion

:: Get the TOMCAT_DIR from build.bat
for /f "tokens=2 delims==" %%a in ('findstr "TOMCAT_DIR=" "%~dp0build.bat"') do set TOMCAT_DIR=%%a
:: Get the APP_NAME from build.bat
for /f "tokens=2 delims==" %%a in ('findstr "APP_NAME=" "%~dp0build.bat"') do set APP_NAME=%%a

echo TOMCAT_DIR: %TOMCAT_DIR%
echo APP_NAME: %APP_NAME%

:: Check if Tomcat is running
echo Checking if Tomcat is running...
tasklist /FI "IMAGENAME eq java.exe" | find "java.exe" > nul
if %ERRORLEVEL% EQU 0 (
    echo Tomcat is currently running.
    set /p answer=Do you want to stop Tomcat? (y/n): 
    if /i "%answer%"=="y" (
        echo Stopping Tomcat server...
        call "%TOMCAT_DIR%\bin\shutdown.bat"
        
        :: Wait for Tomcat to stop (give it 5 seconds)
        echo Waiting for Tomcat to stop...
        timeout /t 5 /nobreak > nul
        
        :: Double check if Tomcat is still running
        tasklist /FI "IMAGENAME eq java.exe" | find "java.exe" > nul
        if %ERRORLEVEL% EQU 0 (
            echo Tomcat is still running. Forcing shutdown...
            taskkill /F /IM java.exe
        )
        
        echo Tomcat has been stopped.
    ) else (
        echo Tomcat will continue running.
    )
) else (
    echo Tomcat is not running.
    set /p answer=Do you want to start Tomcat and build the application? (y/n): 
    if /i "%answer%"=="y" (
        echo Starting Tomcat server...
        call "%TOMCAT_DIR%\bin\startup.bat"
        
        :: Wait for Tomcat to start (give it 5 seconds)
        echo Waiting for Tomcat to start...
        timeout /t 5 /nobreak > nul
        
        :: Run the build script
        echo Running build script...
        call "%~dp0build.bat"
        
        echo Tomcat is now running and application is built!
        echo You can access your application at: http://localhost:8080/%APP_NAME%
    ) else (
        echo Tomcat will remain stopped.
    )
)

endlocal 