# PowerShell Commands Reference

## ❌ Wrong Commands (Don't Use)
```powershell
# This will give syntax errors in PowerShell
cd /d/Study/Rajiv/Cursor/inventory_management_jdk21 && mvn spring-boot:run
```

## ✅ Correct Commands (Use These)

### Option 1: Manual Commands
```powershell
# Set Java 21 environment
$env:JAVA_HOME = "C:\Program Files\Java\jdk-21"
$env:PATH = "C:\Program Files\Java\jdk-21\bin;" + $env:PATH

# Verify Java version
java -version

# Clean and run (use semicolon, not &&)
mvn clean; mvn spring-boot:run
```

### Option 2: Use the Scripts
```powershell
# Run the PowerShell script
.\run-app.ps1

# OR run the batch file
.\run-app.bat
```

### Option 3: One-liner
```powershell
# Set environment and run in one command
$env:JAVA_HOME = "C:\Program Files\Java\jdk-21"; $env:PATH = "C:\Program Files\Java\jdk-21\bin;" + $env:PATH; mvn clean; mvn spring-boot:run
```

## Key Differences Between PowerShell and CMD/Bash

| Feature | CMD/Bash | PowerShell |
|---------|----------|------------|
| Command separator | `&&` | `;` |
| Environment variable | `%VAR%` | `$env:VAR` |
| Path separator | `;` | `;` |
| String concatenation | `%PATH%;newpath` | `$env:PATH + ";newpath"` |

## Application Status
- ✅ Java 21 configured correctly
- ✅ Application running on http://localhost:8080
- ✅ H2 Database console available at http://localhost:8080/h2-console
- ✅ All CSRF token fixes applied
- ✅ Logout functionality working

## Quick Start
1. Open PowerShell in the project directory
2. Run: `.\run-app.ps1`
3. Access: http://localhost:8080
4. Login with: admin/admin
