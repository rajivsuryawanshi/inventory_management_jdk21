@echo off
echo Setting up Java 21 environment...

set JAVA_HOME=C:\Program Files\Java\jdk-21
set PATH=C:\Program Files\Java\jdk-21\bin;%PATH%

echo JAVA_HOME set to: %JAVA_HOME%
echo Java version:
java -version

echo.
echo Cleaning and running the application...
mvn clean
mvn spring-boot:run

pause
