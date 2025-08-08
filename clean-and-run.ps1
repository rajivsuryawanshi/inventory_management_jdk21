# PowerShell script to clean up and run the application
Write-Host "Cleaning up existing processes and database files..." -ForegroundColor Green

# Kill any existing Java processes
Write-Host "Killing existing Java processes..." -ForegroundColor Yellow
taskkill /F /IM java.exe 2>$null

# Set Java 21 environment variables
Write-Host "Setting up Java 21 environment..." -ForegroundColor Green
$env:JAVA_HOME = "C:\Program Files\Java\jdk-21"
$env:PATH = "C:\Program Files\Java\jdk-21\bin;" + $env:PATH

Write-Host "JAVA_HOME set to: $env:JAVA_HOME" -ForegroundColor Yellow
Write-Host "Java version:" -ForegroundColor Yellow
java -version

# Clean up old database files
Write-Host "Cleaning up old database files..." -ForegroundColor Yellow
$dataPath = "$env:USERPROFILE\data"
if (Test-Path "$dataPath\h2database.mv.db") {
    Remove-Item "$dataPath\h2database.mv.db" -Force
    Write-Host "Removed old h2database.mv.db" -ForegroundColor Green
}
if (Test-Path "$dataPath\h2database.trace.db") {
    Remove-Item "$dataPath\h2database.trace.db" -Force
    Write-Host "Removed old h2database.trace.db" -ForegroundColor Green
}

Write-Host ""
Write-Host "Starting the application..." -ForegroundColor Green

# Clean and run the application
mvn clean
mvn spring-boot:run
