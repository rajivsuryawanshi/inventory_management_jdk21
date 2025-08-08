# PowerShell script to set Java 21 environment variables
Write-Host "Setting Java 21 environment variables..." -ForegroundColor Green

$env:JAVA_HOME = "C:\Program Files\Java\jdk-21"
$env:PATH = "C:\Program Files\Java\jdk-21\bin;" + $env:PATH

Write-Host "JAVA_HOME set to: $env:JAVA_HOME" -ForegroundColor Yellow
Write-Host "Java version:" -ForegroundColor Yellow
java -version

Write-Host ""
Write-Host "You can now run: mvn spring-boot:run" -ForegroundColor Green
