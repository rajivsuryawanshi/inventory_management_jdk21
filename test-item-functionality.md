# Testing Item Functionality

This document outlines how to test the newly created Item management system.

## Prerequisites
- Java 21 installed
- Maven installed
- Application running

## Test Steps

### 1. Start the Application
```bash
./mvnw spring-boot:run
```

### 2. Access the Application
- Open browser and go to: http://localhost:8080/swarajtraders/dashboard
- Login with: admin/admin

### 3. Test Item Creation
- Click on "Product / Item Entry" from the dashboard
- Fill in the form with test data:
  - Item Name: Test Product
  - Item Code: TP001
  - Category: Test Category
  - Sub Category: Test Sub Category
  - Wholesale Price: 100.00
  - Purchase Price: 120.00
  - Sale Price: 150.00
- Click "Add Item"
- Should redirect to item list showing the new item

### 4. Test Item Listing
- Click on "View All Items" from the dashboard
- Should display all items in a table format
- Should show the sample items created by DataInitializer
- Should show the newly created test item

### 5. Test Item Deletion
- In the item list, click "Delete" button on any item
- Confirm deletion when prompted
- Item should be removed from the list

### 6. Test Validation
- Try to submit the form with empty required fields
- Should show validation error messages
- Try to submit with invalid price values (negative or zero)
- Should show appropriate error messages

### 7. Test Database Connectivity
- Access: http://localhost:8080/swarajtraders/test-item-db
- Should show "Database connection successful. Item count: X"

## Expected Results
- Items can be created, listed, and deleted successfully
- Validation works properly for all fields
- Database operations are successful
- UI displays items correctly with proper formatting
- Navigation between pages works smoothly

## Troubleshooting
- If items don't appear, check the database connection
- If validation fails, ensure all required fields are filled
- If deletion fails, check if the item exists in the database
- Check application logs for any error messages
