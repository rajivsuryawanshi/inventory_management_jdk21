@echo off
echo Cleaning up existing processes and database files...

REM Kill any existing Java processes
echo Killing existing Java processes...
taskkill /F /IM java.exe >nul 2>&1

REM Set Java 21 environment variables
echo Setting up Java 21 environment...
set JAVA_HOME=C:\Program Files\Java\jdk-21
set PATH=C:\Program Files\Java\jdk-21\bin;%PATH%

echo JAVA_HOME set to: %JAVA_HOME%
echo Java version:
java -version

REM Clean up old database files
echo Cleaning up old database files...
if exist "%USERPROFILE%\data\h2database.mv.db" (
    del "%USERPROFILE%\data\h2database.mv.db"
    echo Removed old h2database.mv.db
)
if exist "%USERPROFILE%\data\h2database.trace.db" (
    del "%USERPROFILE%\data\h2database.trace.db"
    echo Removed old h2database.trace.db
)

echo.
echo Starting the application...
mvn clean
mvn spring-boot:run

pause
