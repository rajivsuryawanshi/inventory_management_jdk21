<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Swaraj Traders - Party List</title>

    <!-- Custom Modern UI Stylesheet -->
    <link rel="stylesheet" href="/swarajtraders/css/modern-ui.css">

    <!-- Font Awesome for Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<script>
    function confirmDelete(partyId) {
        // Show the confirmation dialog
        if (confirm("Are you sure you want to delete this party?")) {
            // If confirmed, submit the form
            document.getElementById('deleteForm-' + partyId).submit();
        }
    }
</script>
<body>
    <!-- Modern Navigation Bar -->
    <nav class="navbar">
        <a href="/swarajtraders/dashboard" class="nav-link">
            <i class="fas fa-home"></i> Dashboard
        </a>
        <h3><i class="fas fa-user-circle"></i> Welcome, ${user.getUserName()}</h3>
        <!-- Logout Button: Using Spring Security logout with CSRF token -->
        <form action="/swarajtraders/logout" method="post" style="display: inline;">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <button type="submit" class="btn btn-outline-danger">
                <i class="fas fa-sign-out-alt"></i> Logout
            </button>
        </form>
    </nav>

    <div class="container">
        <h1><i class="fas fa-users"></i> Party Management</h1>
        
        <!-- Display success message -->
        <c:if test="${not empty message}">
            <div class="alert alert-success alert-dismissible" role="alert">
                <i class="fas fa-check-circle"></i> ${message}
                <button type="button" class="btn-close" onclick="this.parentElement.remove()"></button>
            </div>
        </c:if>
        
        <!-- Display error message -->
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible" role="alert">
                <i class="fas fa-exclamation-triangle"></i> ${error}
                <button type="button" class="btn-close" onclick="this.parentElement.remove()"></button>
            </div>
        </c:if>
        
        <!-- Action Buttons -->
        <div style="margin-bottom: 2rem; display: flex; gap: 1rem; flex-wrap: wrap;">
            <a href="/swarajtraders/addParty" class="btn btn-success">
                <i class="fas fa-plus"></i> Add New Party
            </a>
            <a href="/swarajtraders/dashboard" class="btn btn-outline-danger">
                <i class="fas fa-arrow-left"></i> Back to Dashboard
            </a>
        </div>
        
        <!-- Party List Table -->
        <div class="table-responsive" style="max-height: 70vh; overflow-y: auto;">
            <table class="table table-striped">
                <thead style="position: sticky; top: 0; z-index: 10;">
                    <tr>
                        <th style="min-width: 60px;"><i class="fas fa-hashtag"></i> ID</th>
                        <th style="min-width: 150px;"><i class="fas fa-building"></i> Party Name</th>
                        <th style="min-width: 120px;"><i class="fas fa-receipt"></i> GST No</th>
                        <th style="min-width: 120px;"><i class="fas fa-phone"></i> Phone</th>
                        <th style="min-width: 180px;"><i class="fas fa-envelope"></i> Email</th>
                        <th style="min-width: 200px;"><i class="fas fa-map-marker-alt"></i> Billing Address</th>
                        <th style="min-width: 200px;"><i class="fas fa-shipping-fast"></i> Shipping Address</th>
                        <th style="min-width: 100px;"><i class="fas fa-cogs"></i> Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty parties}">
                            <c:forEach items="${parties}" var="party">
                                <tr>
                                    <td><strong>${party.getPartyId()}</strong></td>
                                    <td><strong>${party.getPartyName()}</strong></td>
                                    <td>${party.getGstNo()}</td>
                                    <td>
                                        <i class="fas fa-phone"></i> ${party.getPhoneNumber()}
                                    </td>
                                    <td>
                                        <i class="fas fa-envelope"></i> ${party.getEmail()}
                                    </td>
                                    <td style="word-wrap: break-word; max-width: 200px;">${party.getBillingAddress()}</td>
                                    <td style="word-wrap: break-word; max-width: 200px;">${party.getShippingAddress()}</td>
                                    <td>
                                        <!-- Edit Button -->
                                        <a href="/swarajtraders/editParty?partyId=${party.getPartyId()}" class="btn btn-primary btn-sm" style="margin-right: 0.5rem;">
                                            <i class="fas fa-edit"></i> Edit
                                        </a>
                                        
                                        <!-- Form that submits a POST request to delete the party -->
                                        <form action="/swarajtraders/deleteParty" method="POST"
                                            style="display: inline;" id="deleteForm-${party.getPartyId()}">
                                            <!-- CSRF Token -->
                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                            <input type="hidden" name="partyId"
                                                value="${party.getPartyId()}" />
                                            <button type="button" class="btn btn-danger btn-sm"
                                                onclick="confirmDelete(${party.getPartyId()})">
                                                <i class="fas fa-trash"></i> Delete
                                            </button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="8" style="text-align: center; padding: 3rem;">
                                    <div style="color: var(--text-secondary);">
                                        <i class="fas fa-users fa-3x" style="margin-bottom: 1rem; color: var(--text-muted);"></i>
                                        <h4>No parties found</h4>
                                        <p>Start by adding your first party to the system.</p>
                                        <a href="/swarajtraders/addParty" class="btn btn-success">
                                            <i class="fas fa-plus"></i> Add New Party
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
        
        <!-- Summary Card -->
        <c:if test="${not empty parties}">
            <div class="card" style="margin-top: 2rem;">
                <h3><i class="fas fa-chart-bar"></i> Party Summary</h3>
                <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 1.5rem;">
                    <div style="text-align: center; padding: 1.5rem;">
                        <div style="font-size: 2rem; color: var(--primary-color); margin-bottom: 0.5rem;">
                            <i class="fas fa-users"></i>
                        </div>
                        <h5>Total Parties</h5>
                        <p style="color: var(--text-secondary); margin: 0;">${parties.size()}</p>
                    </div>
                    <div style="text-align: center; padding: 1.5rem;">
                        <div style="font-size: 2rem; color: var(--success-color); margin-bottom: 0.5rem;">
                            <i class="fas fa-check-circle"></i>
                        </div>
                        <h5>Active Parties</h5>
                        <p style="color: var(--text-secondary); margin: 0;">${parties.size()}</p>
                    </div>
                    <div style="text-align: center; padding: 1.5rem;">
                        <div style="font-size: 2rem; color: var(--info-color); margin-bottom: 0.5rem;">
                            <i class="fas fa-receipt"></i>
                        </div>
                        <h5>With GST</h5>
                        <p style="color: var(--text-secondary); margin: 0;">All parties</p>
                    </div>
                </div>
            </div>
        </c:if>
    </div>

    <!-- Session Timeout Handler -->
    <script src="/swarajtraders/js/session-timeout.js"></script>
    
    <!-- Enhanced Table Interactions -->
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Add hover effects to table rows
            const tableRows = document.querySelectorAll('tbody tr');
            tableRows.forEach(row => {
                row.addEventListener('mouseenter', function() {
                    this.style.transform = 'scale(1.01)';
                });
                
                row.addEventListener('mouseleave', function() {
                    this.style.transform = 'scale(1)';
                });
            });
            
            // Add smooth loading animation
            const container = document.querySelector('.container');
            if (container) {
                container.style.opacity = '0';
                container.style.transform = 'translateY(20px)';
                
                setTimeout(() => {
                    container.style.transition = 'all 0.6s ease-out';
                    container.style.opacity = '1';
                    container.style.transform = 'translateY(0)';
                }, 100);
            }
            
            // Enhanced delete confirmation
            window.confirmDelete = function(partyId) {
                const result = confirm("Are you sure you want to delete this party? This action cannot be undone.");
                if (result) {
                    const form = document.getElementById('deleteForm-' + partyId);
                    if (form) {
                        // Add loading state
                        const button = form.querySelector('button');
                        const originalText = button.innerHTML;
                        button.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Deleting...';
                        button.disabled = true;
                        
                        form.submit();
                    }
                }
            };
        });
    </script>
</body>
</html>
