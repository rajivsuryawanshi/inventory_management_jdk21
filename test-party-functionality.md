# Party Functionality Test Guide

## Application Status
✅ Application is running successfully on http://localhost:8080/swarajtraders

## Test Steps

### 1. Access the Application
- **Main URL**: http://localhost:8080/swarajtraders
- **Login**: admin/admin
- **H2 Console**: http://localhost:8080/swarajtraders/h2-console

### 2. Test Party Functionality

#### Step 1: Add a Party
1. Go to http://localhost:8080/swarajtraders/addParty
2. Fill in the form with test data:
   - **Party Name**: Test Company
   - **GST No**: 22AAAAA0000A1Z5 (valid GST format)
   - **Phone Number**: 1234567890
   - **Email**: test@example.com
   - **Billing Address**: 123 Test Street, Test City
   - **Shipping Address**: 123 Test Street, Test City
3. Click "Add Party"

#### Step 2: Verify Party List
1. Go to http://localhost:8080/swarajtraders/parties
2. Check if the party appears in the list

#### Step 3: Test H2 Database
1. Go to http://localhost:8080/swarajtraders/h2-console
2. Use these connection details:
   - **JDBC URL**: jdbc:h2:file:~/data/inventory_management_db
   - **Username**: rajiv
   - **Password**: rajiv
3. Run query: `SELECT * FROM party;`

## Expected Results
- ✅ Party should be saved to database
- ✅ Party should appear in the party list
- ✅ Party should be visible in H2 console
- ✅ No validation errors should occur

## Troubleshooting

### If Party is Not Saved:
1. Check application logs for errors
2. Verify database connection in H2 console
3. Check if validation errors are shown

### If Party List is Empty:
1. Check if redirect after adding party works
2. Verify database has data
3. Check for any error messages

## Database Location
- **Database Files**: `C:\Users\TU-PC\data\inventory_management_db.mv.db`
- **Database URL**: `jdbc:h2:file:~/data/inventory_management_db`

## Log Files
Check the application logs for:
- Database connection messages
- SQL queries being executed
- Any error messages during party operations
