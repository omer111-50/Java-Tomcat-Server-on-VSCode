@echo off
setlocal

:: Environment variables
set TOMCAT_DIR=C:\path\to\apache-tomcat-9.0.67
set APP_NAME=myapp

:: Remove the existing myapp directory
if exist "%TOMCAT_DIR%\webapps\%APP_NAME%" rmdir /s /q "%TOMCAT_DIR%\webapps\%APP_NAME%"

:: Create the necessary directories
mkdir "%TOMCAT_DIR%\webapps\%APP_NAME%\WEB-INF\classes"

:: Compile the Java classes
javac -cp "%TOMCAT_DIR%\lib\servlet-api.jar;src\main\webapp\WEB-INF\lib\*" -d "%TOMCAT_DIR%\webapps\%APP_NAME%\WEB-INF\classes" src\main\java\*.java

:: Copy the compiled classes and resources to the myapp directory
xcopy /s /y "src\main\webapp\*" "%TOMCAT_DIR%\webapps\%APP_NAME%\"

:: Wait for 1 second
timeout /t 1 /nobreak > nul 