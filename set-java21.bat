@echo off
echo Setting Java 21 environment variables...

set JAVA_HOME=C:\Program Files\Java\jdk-21
set PATH=C:\Program Files\Java\jdk-21\bin;%PATH%

echo JAVA_HOME set to: %JAVA_HOME%
echo Java version:
java -version

echo.
echo You can now run: mvn spring-boot:run
pause
