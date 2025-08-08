@echo off
echo Testing Party Functionality...
echo.

echo 1. Testing database connection...
curl -s "http://localhost:8080/swarajtraders/test-db"
echo.
echo.

echo 2. Testing party list (should be empty initially)...
curl -s "http://localhost:8080/swarajtraders/parties"
echo.
echo.

echo 3. Please manually test adding a party:
echo    - Go to: http://localhost:8080/swarajtraders/addParty
echo    - Fill in the form with test data:
echo      * Party Name: Test Company
echo      * GST No: 22AAAAA0000A1Z5
echo      * Phone: 1234567890
echo      * Email: test@example.com
echo      * Billing Address: 123 Test Street
echo      * Shipping Address: 123 Test Street
echo    - Click "Add Party"
echo.
echo 4. After adding, check: http://localhost:8080/swarajtraders/parties
echo.
echo 5. Check H2 Console: http://localhost:8080/swarajtraders/h2-console
echo    - JDBC URL: jdbc:h2:file:~/data/inventory_management_db
echo    - Username: rajiv
echo    - Password: rajiv
echo    - Run: SELECT * FROM party;
echo.

pause
