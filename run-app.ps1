# PowerShell script to set up Java 21 and run the application
Write-Host "Setting up Java 21 environment..." -ForegroundColor Green

# Set Java 21 environment variables
$env:JAVA_HOME = "C:\Program Files\Java\jdk-21"
$env:PATH = "C:\Program Files\Java\jdk-21\bin;" + $env:PATH

Write-Host "JAVA_HOME set to: $env:JAVA_HOME" -ForegroundColor Yellow
Write-Host "Java version:" -ForegroundColor Yellow
java -version

Write-Host ""
Write-Host "Cleaning and running the application..." -ForegroundColor Green

# Clean and run the application
mvn clean
mvn spring-boot:run
