<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Swaraj Traders - Dashboard</title>

    <!-- Custom Modern UI Stylesheet -->
    <link rel="stylesheet" href="/swarajtraders/css/modern-ui.css">

    <!-- Font Awesome for Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

</head>
<body>
    <!-- Modern Navigation Bar -->
    <nav class="navbar">
        <a href="/swarajtraders/dashboard" class="nav-link">
            <i class="fas fa-home"></i> Dashboard
        </a>
        <h3><i class="fas fa-user-circle"></i> Welcome, ${name}</h3>
        <!-- Logout Button: Using Spring Security logout with CSRF token -->
        <form action="/swarajtraders/logout" method="post" style="display: inline;">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <button type="submit" class="btn btn-outline-danger">
                <i class="fas fa-sign-out-alt"></i> Logout
            </button>
        </form>
    </nav>

    <div class="container">
        <h1><i class="fas fa-chart-line"></i> Swaraj Traders Dashboard</h1>
        
        <!-- Display message if present -->
        <c:if test="${not empty message}">
            <div class="alert alert-info alert-dismissible" role="alert">
                <i class="fas fa-info-circle"></i> ${message}
                <button type="button" class="btn-close" onclick="this.parentElement.remove()"></button>
            </div>
        </c:if>

        <!-- Modern Dashboard Grid -->
        <div class="dashboard-grid">
            <!-- Party Management Card -->
            <a href="/swarajtraders/parties" class="dashboard-card">
                <div class="icon">
                    <i class="fas fa-users"></i>
                </div>
                <h4>Party Management</h4>
                <p>Manage customer and supplier information, GST details, and contact information</p>
            </a>

            <!-- Item Management Card -->
            <a href="/swarajtraders/addItem" class="dashboard-card">
                <div class="icon">
                    <i class="fas fa-box"></i>
                </div>
                <h4>Add New Item</h4>
                <p>Create new products with categories, pricing, and inventory details</p>
            </a>

            <!-- View Items Card -->
            <a href="/swarajtraders/items" class="dashboard-card">
                <div class="icon">
                    <i class="fas fa-list"></i>
                </div>
                <h4>Inventory List</h4>
                <p>View and manage all items in your inventory with detailed information</p>
            </a>

            <!-- Purchase Entry Card -->
            <a href="/swarajtraders/purchaseEntry" class="dashboard-card">
                <div class="icon">
                    <i class="fas fa-shopping-cart"></i>
                </div>
                <h4>Purchase Entry</h4>
                <p>Record new purchases, update stock levels, and track supplier transactions</p>
            </a>

            <!-- Sale Entry Card -->
            <a href="/swarajtraders/saleEntry" class="dashboard-card">
                <div class="icon">
                    <i class="fas fa-cash-register"></i>
                </div>
                <h4>Sales & Billing</h4>
                <p>Create invoices, process sales, and manage customer transactions</p>
            </a>

            <!-- Stock Details Card -->
            <a href="/swarajtraders/stockDetails" class="dashboard-card">
                <div class="icon">
                    <i class="fas fa-warehouse"></i>
                </div>
                <h4>Stock Details</h4>
                <p>Monitor current stock levels, track inventory movements, and generate reports</p>
            </a>

            <!-- Stock Adjustment Card -->
            <a href="/swarajtraders/stockAdjustment" class="dashboard-card">
                <div class="icon">
                    <i class="fas fa-balance-scale"></i>
                </div>
                <h4>Stock Adjustment</h4>
                <p>Adjust stock quantities, handle returns, and correct inventory discrepancies</p>
            </a>

            <!-- Expense Entry Card -->
            <a href="/swarajtraders/expenseEntry" class="dashboard-card">
                <div class="icon">
                    <i class="fas fa-receipt"></i>
                </div>
                <h4>Expense Tracking</h4>
                <p>Record business expenses, track costs, and manage financial records</p>
            </a>
        </div>

        <!-- Quick Stats Section -->
        <div class="card" style="margin-top: 3rem;">
            <h3><i class="fas fa-chart-bar"></i> Quick Overview</h3>
            <div class="dashboard-grid" style="grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 1.5rem;">
                <div class="dashboard-card" style="text-align: center; padding: 1.5rem;">
                    <div class="icon text-primary">
                        <i class="fas fa-boxes fa-2x"></i>
                    </div>
                    <h5>Total Items</h5>
                    <p class="text-muted">Manage your product catalog</p>
                </div>
                <div class="dashboard-card" style="text-align: center; padding: 1.5rem;">
                    <div class="icon text-success">
                        <i class="fas fa-users fa-2x"></i>
                    </div>
                    <h5>Parties</h5>
                    <p class="text-muted">Customers & Suppliers</p>
                </div>
                <div class="dashboard-card" style="text-align: center; padding: 1.5rem;">
                    <div class="icon text-info">
                        <i class="fas fa-chart-line fa-2x"></i>
                    </div>
                    <h5>Sales</h5>
                    <p class="text-muted">Track your revenue</p>
                </div>
                <div class="dashboard-card" style="text-align: center; padding: 1.5rem;">
                    <div class="icon text-warning">
                        <i class="fas fa-shopping-cart fa-2x"></i>
                    </div>
                    <h5>Purchases</h5>
                    <p class="text-muted">Monitor expenses</p>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Session Timeout Handler -->
    <script src="/swarajtraders/js/session-timeout.js"></script>

    <!-- Enhanced Dashboard Interactions -->
    <script>
        // Add smooth hover effects and interactions
        document.addEventListener('DOMContentLoaded', function() {
            // Add click tracking for analytics
            const dashboardCards = document.querySelectorAll('.dashboard-card');
            dashboardCards.forEach(card => {
                card.addEventListener('click', function() {
                    // Add a subtle click effect
                    this.style.transform = 'scale(0.95)';
                    setTimeout(() => {
                        this.style.transform = '';
                    }, 150);
                });
            });

            // Add loading state for better UX
            const links = document.querySelectorAll('a[href]');
            links.forEach(link => {
                link.addEventListener('click', function() {
                    if (this.classList.contains('dashboard-card')) {
                        this.classList.add('loading');
                    }
                });
            });
        });
    </script>
</body>
</html>
