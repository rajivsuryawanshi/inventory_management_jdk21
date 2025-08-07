# Inventory Management System - Routes Documentation

## 🔍 **Current Routes Analysis**

### **Web Pages (Require Authentication)**
| Route | Method | Controller | Description | Status |
|-------|--------|------------|-------------|---------|
| `/` | GET | WebController | Home page (redirects to dashboard) | ✅ Implemented |
| `/dashboard` | GET | WebController | Main dashboard | ✅ Implemented |
| `/addParty` | GET | PartyController | Show add party form | ✅ Implemented |
| `/addParty` | POST | PartyController | Handle party form submission | ✅ Implemented |
| `/parties` | GET | PartyController | List all parties | ✅ Implemented |
| `/deleteParty` | POST | PartyController | Delete a party | ✅ Implemented |

### **REST API Endpoints (Require Authentication)**
| Route | Method | Controller | Description | Status |
|-------|--------|------------|-------------|---------|
| `/users` | GET | UserController | Get all users | ✅ Implemented |
| `/users` | POST | UserController | Create new user | ✅ Implemented |
| `/users/{id}` | PUT | UserController | Update user | ✅ Implemented |
| `/users/{id}` | DELETE | UserController | Delete user | ✅ Implemented |

### **Public Resources (No Authentication Required)**
| Route | Description | Status |
|-------|-------------|---------|
| `/h2-console/**` | H2 Database Console | ✅ Implemented |
| `/css/**` | Static CSS files | ✅ Implemented |
| `/js/**` | Static JavaScript files | ✅ Implemented |
| `/webjars/**` | WebJars resources (Bootstrap, jQuery) | ✅ Implemented |

### **Future Routes (Referenced in Dashboard but Not Yet Implemented)**
| Route | Description | Status |
|-------|-------------|---------|
| `/productEntry` | Product/Item Entry | 🔄 Planned |
| `/purchaseEntry` | Purchase Entry | 🔄 Planned |
| `/saleEntry` | Sale/Bill Entry | 🔄 Planned |
| `/stockDetails` | Stock Details | 🔄 Planned |
| `/stockAdjustment` | Stock Adjustment | 🔄 Planned |
| `/expenseEntry` | Expense Entry | 🔄 Planned |

## 🔧 **How to Add New Routes**

### **Step 1: Create Controller**
Create a new controller class in the appropriate package:

```java
@Controller  // For web pages
// OR
@RestController  // For REST APIs
public class YourController {
    
    @GetMapping("/your-route")
    public String yourMethod() {
        return "viewName";  // For @Controller
        // OR return data;  // For @RestController
    }
}
```

### **Step 2: Update Security Configuration**
Add your new route to `SecurityConfig.java`:

```java
.authorizeHttpRequests(authz -> authz
    // For public routes (no authentication)
    .requestMatchers("/your-public-route").permitAll()
    
    // For authenticated routes
    .requestMatchers("/your-protected-route").authenticated()
    
    // For role-based access
    .requestMatchers("/admin-route").hasRole("ADMIN")
    
    // For API routes
    .requestMatchers("/api/**").authenticated()
)
```

### **Step 3: Create View (if needed)**
For web pages, create JSP files in:
```
src/main/resources/META-INF/resources/WEB-INF/jsp/yourView.jsp
```

### **Step 4: Update Dashboard (if needed)**
Add navigation links in:
```
src/main/resources/META-INF/resources/WEB-INF/jsp/dashboard.jsp
```

## 📁 **File Structure for Routes**

### **Controllers Location:**
- **Web Controllers**: `src/main/java/com/swarajtraders/inventory_management/`
- **Party Controllers**: `src/main/java/com/swarajtraders/inventory_management/party/controller/`
- **User Controllers**: `src/main/java/com/swarajtraders/inventory_management/user/controller/`

### **Views Location:**
- **JSP Files**: `src/main/resources/META-INF/resources/WEB-INF/jsp/`

### **Security Configuration:**
- **SecurityConfig**: `src/main/java/com/swarajtraders/inventory_management/SecurityConfig.java`

## 🔐 **Security Patterns**

### **Public Routes:**
```java
.requestMatchers("/public-route").permitAll()
```

### **Authenticated Routes:**
```java
.requestMatchers("/protected-route").authenticated()
```

### **Role-Based Routes:**
```java
.requestMatchers("/admin-route").hasRole("ADMIN")
.requestMatchers("/user-route").hasRole("USER")
```

### **API Routes:**
```java
.requestMatchers("/api/**").authenticated()
```

## 🚀 **Quick Start for New Routes**

1. **Create Controller** → Add `@GetMapping` or `@PostMapping`
2. **Update SecurityConfig** → Add route to appropriate security group
3. **Create View** → Add JSP file (if web page)
4. **Test Route** → Access via browser or API client
5. **Update Dashboard** → Add navigation link (if needed)

## 📝 **Notes**

- All routes are currently configured to require authentication except for static resources and H2 console
- The application uses Spring Security with form-based login
- Default login credentials: `admin` / `admin`
- CSRF protection is enabled for all forms except H2 console
- Session management is handled by Spring Security

## 🔍 **Troubleshooting**

### **403 Forbidden Error:**
- Check if route is added to SecurityConfig
- Verify authentication status
- Check if route requires specific roles

### **404 Not Found Error:**
- Verify controller is properly annotated
- Check if view file exists (for web pages)
- Ensure route mapping is correct

### **500 Internal Server Error:**
- Check controller method implementation
- Verify dependencies are properly injected
- Check database connectivity (if applicable)
