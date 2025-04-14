@echo off
setlocal

:: Environment variables
set TOMCAT_DIR=C:\path\to\apache-tomcat-9.0.67
set APP_NAME=myapp

echo Building application for Tomcat...
echo TOMCAT_DIR: %TOMCAT_DIR%
echo APP_NAME: %APP_NAME%

:: Remove the existing myapp directory
if exist "%TOMCAT_DIR%\webapps\%APP_NAME%" (
    echo Removing existing application directory...
    rmdir /s /q "%TOMCAT_DIR%\webapps\%APP_NAME%"
)

:: Create the necessary directories
echo Creating directories...
mkdir "%TOMCAT_DIR%\webapps\%APP_NAME%\WEB-INF\classes" 2>nul

:: Compile the Java classes
echo Compiling Java classes...
javac -cp "%TOMCAT_DIR%\lib\servlet-api.jar;src\main\webapp\WEB-INF\lib\*" -d "%TOMCAT_DIR%\webapps\%APP_NAME%\WEB-INF\classes" src\main\java\*.java
if %ERRORLEVEL% NEQ 0 (
    echo Error compiling Java classes.
    exit /b 1
)

:: Copy the compiled classes and resources to the myapp directory
echo Copying web application files...
xcopy /s /y "src\main\webapp\*" "%TOMCAT_DIR%\webapps\%APP_NAME%\" >nul

echo Build completed successfully!
endlocal 