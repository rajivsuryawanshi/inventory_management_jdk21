@echo off
echo Creating log directory...

REM Create log directory (requires admin privileges)
mkdir "C:\data\logs" 2>nul
if %errorlevel% neq 0 (
    echo Failed to create log directory. Please run as administrator.
    echo You can manually create the directory: C:\data\logs
    pause
    exit /b 1
)

echo Log directory created at C:\data\logs
echo You can now run the application and logs will be written to C:\data\logs\inventory-management.log
pause
