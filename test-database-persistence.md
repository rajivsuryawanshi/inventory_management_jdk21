# H2 Database Persistence Test Guide

## Overview
H2 database persistence has been enabled so that data persists between server restarts. The database will no longer be recreated on each startup, and your data will be preserved.

## Configuration Changes Made

### 1. **Database Schema Management**
- **Before**: `spring.jpa.hibernate.ddl-auto=create-drop` (drops and recreates schema on every startup)
- **After**: `spring.jpa.hibernate.ddl-auto=update` (preserves existing schema and data)

### 2. **Database URL Enhancement**
- **Added**: `AUTO_SERVER=TRUE` for better file handling and multi-process support
- **URL**: `jdbc:h2:file:~/data/inventory_management_db;DB_CLOSE_ON_EXIT=FALSE;DB_CLOSE_DELAY=-1;AUTO_SERVER=TRUE`

### 3. **Data Initialization Logic**
- **Before**: Created admin user and sample items if they didn't exist (on every restart)
- **After**: Only creates initial data for fresh installations (when database is completely empty)

## How to Test Database Persistence

### Test 1: Basic Data Persistence
1. **Start the application**
   ```bash
   ./mvnw spring-boot:run
   ```

2. **Login and add data**
   - Login with `admin/admin`
   - Navigate to Party Management or Item Management
   - Add some new parties or items
   - Verify they appear in the list

3. **Stop the application**
   ```bash
   # Stop the application (Ctrl+C)
   ```

4. **Restart the application**
   ```bash
   ./mvnw spring-boot:run
   ```

5. **Verify data persistence**
   - Login with `admin/admin`
   - Navigate to the same sections
   - **Expected Result**: Your previously added data should still be there
   - **Before Fix**: Data would be lost and only sample data would appear

### Test 2: Fresh Installation vs Existing Data
1. **First time startup (fresh installation)**
   - Delete existing database files (if any)
   - Start the application
   - Check console logs: Should see "Default user created: admin/admin" and "Sample items created for fresh installation"

2. **Subsequent startups (existing data)**
   - Stop and restart the application
   - Check console logs: Should see "Database already contains data - skipping initial data creation"
   - Verify admin user and sample items still exist

### Test 3: Database File Location
1. **Check database files**
   - Database files are stored in: `src/main/resources/inventory_management_db.mv.db`
   - Trace file: `src/main/resources/inventory_management_db.trace.db`

2. **Monitor file size**
   - Start with fresh database
   - Add data through the application
   - Check that database file size increases
   - Restart application and verify file size remains the same

### Test 4: H2 Console Access
1. **Access H2 Console**
   - Start the application
   - Open browser: `http://localhost:8080/swarajtraders/h2-console`
   - Connection details:
     - JDBC URL: `jdbc:h2:file:~/data/inventory_management_db`
     - Username: `rajiv`
     - Password: `rajiv`

2. **Verify data in console**
   - Connect to the database
   - Browse tables: `USER`, `ITEM`, `PARTY`
   - Verify your data is present
   - Restart application and check again

## Expected Behavior

### ✅ Data Persistence
- Data persists between server restarts
- Database file grows as you add more data
- No data loss when stopping/starting the application

### ✅ Smart Initialization
- Initial data (admin user, sample items) only created on fresh installation
- No recreation of sample data on subsequent restarts
- Console messages indicate whether it's a fresh installation or existing data

### ✅ Schema Updates
- Database schema is preserved
- New columns/tables can be added without losing data
- Existing data remains intact during schema updates

### ✅ File-based Storage
- Database stored in file system
- Can be backed up by copying the `.mv.db` file
- Supports multiple application instances (with AUTO_SERVER=TRUE)

## Troubleshooting

### If data still doesn't persist:
1. **Check application.properties**
   - Verify `spring.jpa.hibernate.ddl-auto=update`
   - Verify `spring.jpa.properties.hibernate.hbm2ddl.auto=update`
   - Verify `AUTO_SERVER=TRUE` in database URL

2. **Check database files**
   - Ensure `inventory_management_db.mv.db` exists in `src/main/resources/`
   - Check file permissions
   - Verify file size increases when adding data

3. **Check application logs**
   - Look for "Database already contains data - skipping initial data creation"
   - Check for any database-related errors

### If you want to start fresh:
1. **Stop the application**
2. **Delete database files**
   ```bash
   rm src/main/resources/inventory_management_db.*
   ```
3. **Restart the application**
   - It will create fresh database with initial data

### If H2 console doesn't work:
1. **Verify H2 console is enabled**
   - Check `spring.h2.console.enabled=true` in application.properties
2. **Check URL path**
   - Use: `http://localhost:8080/swarajtraders/h2-console`
3. **Verify connection details**
   - JDBC URL: `jdbc:h2:file:~/data/inventory_management_db`
   - Username: `rajiv`
   - Password: `rajiv`

## Database File Management

### Backup Database
```bash
# Copy the database file to backup location
cp src/main/resources/inventory_management_db.mv.db backup/
```

### Restore Database
```bash
# Stop application
# Copy backup file back
cp backup/inventory_management_db.mv.db src/main/resources/
# Start application
```

### Reset Database
```bash
# Stop application
# Delete database files
rm src/main/resources/inventory_management_db.*
# Start application (will create fresh database)
```

## Performance Considerations

### ✅ Benefits
- Data persistence across restarts
- No need to recreate data
- Faster startup times after first run
- Better for production use

### ⚠️ Considerations
- Database file size will grow over time
- Regular backups recommended
- Monitor disk space usage

## Files Modified

### Configuration:
- `application.properties` (updated database settings)

### Java Code:
- `DataInitializer.java` (updated initialization logic)

The H2 database persistence is now enabled and ready for testing! 🎉
