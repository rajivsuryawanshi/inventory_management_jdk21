# Inventory Management System - Routes Documentation

## Overview
This document lists all the routes in the inventory management system and their authentication status.

## Prerequisites

### Java 21 Setup
This project requires Java 21. To set up the environment:

**Option 1: Using PowerShell (Recommended)**
```powershell
# Set Java 21 environment variables
$env:JAVA_HOME = "C:\Program Files\Java\jdk-21"
$env:PATH = "C:\Program Files\Java\jdk-21\bin;" + $env:PATH

# Verify Java version
java -version
```

**Option 2: Using the provided script**
```powershell
# Run the PowerShell script
.\set-java21.ps1
```

**Option 3: Using batch file**
```cmd
# Run the batch file
set-java21.bat
```

### Verify Setup
After setting up Java 21, verify with:
```bash
java -version  # Should show Java 21
mvn --version  # Should show Java 21 as runtime
```

## Authentication Status
- ✅ **Authenticated**: Requires user login
- ❌ **Public**: No authentication required
- 🚧 **Placeholder**: Route exists but functionality not implemented

## Web Routes (Controller: WebController)

| Route | Method | Authentication | Status | Description |
|-------|--------|----------------|--------|-------------|
| `/` | GET | ✅ Authenticated | ✅ Implemented | Redirects to dashboard |
| `/dashboard` | GET | ✅ Authenticated | ✅ Implemented | Main dashboard page |
| `/error` | GET | ✅ Authenticated | ✅ Implemented | Error page handler |
| `/productEntry` | GET | ✅ Authenticated | 🚧 Placeholder | Product entry (coming soon) |
| `/purchaseEntry` | GET | ✅ Authenticated | 🚧 Placeholder | Purchase entry (coming soon) |
| `/saleEntry` | GET | ✅ Authenticated | 🚧 Placeholder | Sale entry (coming soon) |
| `/stockDetails` | GET | ✅ Authenticated | 🚧 Placeholder | Stock details (coming soon) |
| `/stockAdjustment` | GET | ✅ Authenticated | 🚧 Placeholder | Stock adjustment (coming soon) |
| `/expenseEntry` | GET | ✅ Authenticated | 🚧 Placeholder | Expense entry (coming soon) |

## Party Management Routes (Controller: PartyController)

| Route | Method | Authentication | Status | Description |
|-------|--------|----------------|--------|-------------|
| `/addParty` | GET | ✅ Authenticated | ✅ Implemented | Show add party form |
| `/addParty` | POST | ✅ Authenticated | ✅ Implemented | Handle party form submission |
| `/parties` | GET | ✅ Authenticated | ✅ Implemented | List all parties |
| `/deleteParty` | POST | ✅ Authenticated | ✅ Implemented | Delete a party |

## User Management API Routes (Controller: UserController)

| Route | Method | Authentication | Status | Description |
|-------|--------|----------------|--------|-------------|
| `/users` | GET | ✅ Authenticated | ✅ Implemented | Get all users (REST API) |
| `/users` | POST | ✅ Authenticated | ✅ Implemented | Create new user (REST API) |
| `/users/{id}` | PUT | ✅ Authenticated | ✅ Implemented | Update user (REST API) |
| `/users/{id}` | DELETE | ✅ Authenticated | ✅ Implemented | Delete user (REST API) |

## Authentication Routes (Spring Security)

| Route | Method | Authentication | Status | Description |
|-------|--------|----------------|--------|-------------|
| `/login` | GET | ❌ Public | ✅ Implemented | Login page |
| `/logout` | POST | ❌ Public | ✅ Implemented | Logout (Spring Security) |

## Static Resources

| Route | Authentication | Status | Description |
|-------|----------------|--------|-------------|
| `/css/**` | ❌ Public | ✅ Implemented | CSS files |
| `/js/**` | ❌ Public | ✅ Implemented | JavaScript files |
| `/webjars/**` | ❌ Public | ✅ Implemented | WebJars (Bootstrap, jQuery) |
| `/h2-console/**` | ❌ Public | ✅ Implemented | H2 Database console |

## Issues Fixed

### 1. Logout Route Issue ✅ FIXED
**Problem**: The dashboard had a POST form to `/logout`, but Spring Security's default logout handler expects a GET request.

**Solution**: 
- Added explicit `.logoutUrl("/logout")` configuration in SecurityConfig
- Removed `/logout` from authenticated routes list (it should be public)
- This allows both GET and POST requests to `/logout`

### 2. CSRF Token Issues ✅ FIXED
**Problem**: All POST forms were missing CSRF tokens, causing 403 Forbidden errors.

**Solution**:
- Added CSRF tokens to all POST forms:
  - Logout forms in all JSP pages
  - Add Party form in `addParty.jsp`
  - Delete Party forms in `partyList.jsp`
- CSRF tokens are automatically provided by Spring Security: `${_csrf.parameterName}` and `${_csrf.token}`

### 3. Missing Route Implementations ✅ FIXED
**Problem**: Dashboard referenced routes that didn't exist, causing 403 Forbidden errors.

**Solution**:
- Added placeholder controller methods for all referenced routes
- Each placeholder returns to dashboard with a "coming soon" message
- Updated dashboard JSP to display these messages

### 4. Error Page Handling ✅ FIXED
**Problem**: No explicit mapping for `/error` causing Whitelabel error pages.

**Solution**:
- Added `/error` route mapping in WebController
- Error page now redirects to dashboard with error message

### 5. Security Configuration Cleanup ✅ FIXED
**Problem**: SecurityConfig had references to unimplemented routes.

**Solution**:
- Removed `/logout` from authenticated routes (should be public)
- Routes are now handled by the general `.anyRequest().authenticated()` rule

### 6. Java 21 Configuration ✅ FIXED
**Problem**: Maven was using Java 17 instead of Java 21.

**Solution**:
- Set JAVA_HOME to point to Java 21: `C:\Program Files\Java\jdk-21`
- Updated PATH to include Java 21 bin directory
- Created helper scripts for easy environment setup

## Current Status
- ✅ All existing routes are properly authenticated
- ✅ Logout functionality works correctly
- ✅ All POST forms include CSRF tokens
- ✅ No more 403 Forbidden errors
- ✅ Error page handling implemented
- ✅ Java 21 properly configured
- 🚧 Placeholder routes show "coming soon" messages instead of errors
- ✅ All static resources are publicly accessible

## CSRF Token Implementation
All POST forms now include the required CSRF token:
```html
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
```

This is required for:
- Logout forms
- Add Party form
- Delete Party forms

## Running the Application

### Prerequisites
1. Java 21 installed at `C:\Program Files\Java\jdk-21`
2. Maven 3.9+ installed
3. Set up Java 21 environment (see Prerequisites section)

### Start the Application
```bash
# Clean and run
mvn clean
mvn spring-boot:run
```

### Access the Application
- **Main Application**: http://localhost:8080
- **H2 Database Console**: http://localhost:8080/h2-console
- **Default Login**: admin/admin

## Next Steps
To implement the placeholder features, create controllers for:
1. Product Entry
2. Purchase Entry  
3. Sale Entry
4. Stock Details
5. Stock Adjustment
6. Expense Entry

## Testing Logout
The logout should now work correctly:
1. Click the "Logout" button on any page
2. You should be redirected to `/login?logout`
3. No more 403 Forbidden errors
4. CSRF tokens are properly included in all forms
