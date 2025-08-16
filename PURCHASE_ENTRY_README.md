# Purchase Entry System

## Overview
The Purchase Entry system allows users to record purchases from suppliers/parties, automatically update item information, and maintain a complete audit trail of all purchase transactions.

## Features

### 1. Purchase Entry Dashboard (`/purchase-entry`)
- **Party Selection**: Dropdown populated with all parties from the Party entity using AJAX
- **Item Information**: Fields for Item Code, Item Name, Category, and Sub Category
- **Purchase Details**: Quantity, Wholesale Price, Purchase Price, and Discount Percentage
- **Automatic Calculations**: Real-time calculation of subtotal, discount amount, and final total
- **Form Validation**: Client-side and server-side validation of all required fields

### 2. Item Management Integration
- **Automatic Item Creation**: If an item doesn't exist, it's automatically created
- **Price Updates**: Existing items have their wholesale price and purchase price updated
- **Sale Price**: Kept blank as requested (not set during purchase entry)

### 3. Purchase Entry List (`/purchase-entry/list`)
- **Complete Transaction History**: View all purchase entries in a tabular format
- **Search & Filter**: Filter by party, item code, and date range
- **Detailed Information**: Display purchase ID, date, party, item details, pricing, and totals

## Technical Implementation

### Entities
- **PurchaseEntry**: Stores complete purchase transaction details
- **Item**: Updated or created based on purchase entry
- **Party**: Referenced from existing party records

### Services
- **PurchaseEntryService**: Handles business logic for purchase entries and item updates
- **ItemRepository**: Manages item database operations
- **PartyRepository**: Manages party database operations

### Controllers
- **PurchaseEntryController**: Handles HTTP requests for purchase entry operations
- **REST API Endpoints**: 
  - `GET /purchase-entry/api/parties` - Retrieve all parties
  - `POST /purchase-entry/api/purchase-entry` - Save new purchase entry
  - `GET /purchase-entry/api/purchase-entries` - Retrieve all purchase entries

### Data Flow
1. User fills out purchase entry form
2. Party selection loads via AJAX from Party entity
3. Form submission creates PurchaseEntry entity
4. Service layer checks if item exists:
   - If exists: Updates wholesale price and purchase price
   - If not exists: Creates new item with blank sale price
5. Purchase entry is saved to database
6. User receives confirmation and form is reset

## Database Schema

### Purchase Entry Table
```sql
CREATE TABLE purchase_entries (
    purchase_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    party_id BIGINT NOT NULL,
    item_code VARCHAR(20) NOT NULL,
    item_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    sub_category VARCHAR(50) NOT NULL,
    quantity DECIMAL(10,2) NOT NULL,
    wholesale_price DECIMAL(10,2) NOT NULL,
    purchase_price DECIMAL(10,2) NOT NULL,
    discount_percentage DECIMAL(5,2),
    total_amount DECIMAL(10,2),
    purchase_date TIMESTAMP NOT NULL,
    FOREIGN KEY (party_id) REFERENCES parties(party_id)
);
```

## Usage Instructions

### Adding a New Purchase Entry
1. Navigate to `/purchase-entry`
2. Select a party from the dropdown (populated via AJAX)
3. Enter item details (code, name, category, sub-category)
4. Enter purchase details (quantity, wholesale price, purchase price, discount)
5. Review automatic total calculations
6. Click "Save Purchase Entry"

### Viewing Purchase Entries
1. Navigate to `/purchase-entry/list`
2. Use search filters to find specific entries
3. View complete transaction history in tabular format

### Navigation
- **Dashboard**: `/dashboard` - Main navigation hub
- **Purchase Entry**: `/purchase-entry` - Add new purchases
- **Purchase List**: `/purchase-entry/list` - View all purchases
- **Items**: `/items` - Manage product catalog
- **Parties**: `/parties` - Manage suppliers/customers

## Security Features
- Spring Security integration
- Session management
- CSRF protection
- Input validation and sanitization

## Error Handling
- Client-side form validation
- Server-side business logic validation
- User-friendly error messages
- Transaction rollback on errors

## Future Enhancements
- Purchase order management
- Supplier payment tracking
- Purchase return functionality
- Advanced reporting and analytics
- Email notifications
- PDF invoice generation
