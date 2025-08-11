<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="_csrf" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
    <title>Swaraj Traders - Edit Item</title>

    <!-- Bootstrap CSS -->
    <link href="webjars/bootstrap/5.1.3/css/bootstrap.min.css" rel="stylesheet">
    
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
        <h1><i class="fas fa-edit"></i> Edit Item</h1>
        
        <!-- Error Message -->
        <!-- Display BindingResult errors if there are any -->
        <c:if test="${not empty errors}">
            <div class="alert alert-danger alert-dismissible" role="alert">
                <i class="fas fa-exclamation-triangle"></i>
                <ul style="margin: 0; padding-left: 1rem;">
                    <!-- Iterate over all the errors -->
                    <c:forEach var="error" items="${errors}">
                        <li>${error.defaultMessage}</li>
                    </c:forEach>
                </ul>
                <button type="button" class="btn-close" onclick="this.parentElement.remove()"></button>
            </div>
        </c:if>
        
        <!-- Display general error message -->
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible" role="alert">
                <i class="fas fa-exclamation-triangle"></i> ${error}
                <button type="button" class="btn-close" onclick="this.parentElement.remove()"></button>
            </div>
        </c:if>

        <div class="form-section">
            <!-- Form starts here using regular HTML with proper field names -->
            <form action="/swarajtraders/editItem" method="post" class="needs-validation" novalidate>
                <!-- CSRF Token -->
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                
                <!-- Hidden Item ID for editing -->
                <input type="hidden" name="itemId" value="${item.itemId}"/>
                
                <!-- Item Name -->
                <div class="mb-3">
                    <label for="itemName" class="form-label">
                        <i class="fas fa-box"></i> Item Name
                    </label> 
                    <input type="text" class="form-control ${not empty fieldErrors['itemName'] ? 'is-invalid' : ''}" id="itemName" name="itemName" value="${item.itemName}" required>
                    <c:if test="${not empty fieldErrors['itemName']}">
                        <div class="invalid-feedback d-block">
                            <i class="fas fa-times-circle"></i> ${fieldErrors['itemName']}
                        </div>
                    </c:if>
                    <c:if test="${empty fieldErrors['itemName']}">
                        <div class="invalid-feedback">
                            <i class="fas fa-times-circle"></i> Please enter a valid item name.
                        </div>
                    </c:if>
                </div>

                <!-- Item Code -->
                <div class="mb-3">
                    <label for="itemCode" class="form-label">
                        <i class="fas fa-barcode"></i> Item Code
                    </label> 
                    <input type="text" class="form-control ${not empty fieldErrors['itemCode'] ? 'is-invalid' : ''}" id="itemCode" name="itemCode" value="${item.itemCode}" required>
                    <c:if test="${not empty fieldErrors['itemCode']}">
                        <div class="invalid-feedback d-block">
                            <i class="fas fa-times-circle"></i> ${fieldErrors['itemCode']}
                        </div>
                    </c:if>
                    <c:if test="${empty fieldErrors['itemCode']}">
                        <div class="invalid-feedback">
                            <i class="fas fa-times-circle"></i> Please enter a valid item code (3-20 characters).
                        </div>
                    </c:if>
                </div>

                <!-- Category -->
                <div class="mb-3">
                    <label for="category" class="form-label">
                        <i class="fas fa-tags"></i> Category
                    </label> 
                    <input type="text" class="form-control ${not empty fieldErrors['category'] ? 'is-invalid' : ''}" id="category" name="category" value="${item.category}" required>
                    <c:if test="${not empty fieldErrors['category']}">
                        <div class="invalid-feedback d-block">
                            <i class="fas fa-times-circle"></i> ${fieldErrors['category']}
                        </div>
                    </c:if>
                    <c:if test="${empty fieldErrors['category']}">
                        <div class="invalid-feedback">
                            <i class="fas fa-times-circle"></i> Please enter a category.
                        </div>
                    </c:if>
                </div>

                <!-- Sub Category -->
                <div class="mb-3">
                    <label for="subCategory" class="form-label">
                        <i class="fas fa-tag"></i> Sub Category
                    </label> 
                    <input type="text" class="form-control ${not empty fieldErrors['subCategory'] ? 'is-invalid' : ''}" id="subCategory" name="subCategory" value="${item.subCategory}" required>
                    <c:if test="${not empty fieldErrors['subCategory']}">
                        <div class="invalid-feedback d-block">
                            <i class="fas fa-times-circle"></i> ${fieldErrors['subCategory']}
                        </div>
                    </c:if>
                    <c:if test="${empty fieldErrors['subCategory']}">
                        <div class="invalid-feedback">
                            <i class="fas fa-times-circle"></i> Please enter a sub category.
                        </div>
                    </c:if>
                </div>

                <!-- Wholesale Price -->
                <div class="mb-3">
                    <label for="wholesalePrice" class="form-label">
                        <i class="fas fa-dollar-sign"></i> Wholesale Price
                    </label> 
                    <input type="number" step="0.01" min="0.01" class="form-control ${not empty fieldErrors['wholesalePrice'] ? 'is-invalid' : ''}" id="wholesalePrice" name="wholesalePrice" value="${item.wholesalePrice}" required>
                    <c:if test="${not empty fieldErrors['wholesalePrice']}">
                        <div class="invalid-feedback d-block">
                            <i class="fas fa-times-circle"></i> ${fieldErrors['wholesalePrice']}
                        </div>
                    </c:if>
                    <c:if test="${empty fieldErrors['wholesalePrice']}">
                        <div class="invalid-feedback">
                            <i class="fas fa-times-circle"></i> Please enter a valid wholesale price (greater than 0).
                        </div>
                    </c:if>
                </div>

                <!-- Purchase Price -->
                <div class="mb-3">
                    <label for="purchasePrice" class="form-label">
                        <i class="fas fa-shopping-cart"></i> Purchase Price
                    </label> 
                    <input type="number" step="0.01" min="0.01" class="form-control ${not empty fieldErrors['purchasePrice'] ? 'is-invalid' : ''}" id="purchasePrice" name="purchasePrice" value="${item.purchasePrice}" required>
                    <c:if test="${not empty fieldErrors['purchasePrice']}">
                        <div class="invalid-feedback d-block">
                            <i class="fas fa-times-circle"></i> ${fieldErrors['purchasePrice']}
                        </div>
                    </c:if>
                    <c:if test="${empty fieldErrors['purchasePrice']}">
                        <div class="invalid-feedback">
                            <i class="fas fa-times-circle"></i> Please enter a valid purchase price (greater than 0).
                        </div>
                    </c:if>
                </div>

                <!-- Sale Price -->
                <div class="mb-3">
                    <label for="salePrice" class="form-label">
                        <i class="fas fa-cash-register"></i> Sale Price
                    </label> 
                    <input type="number" step="0.01" min="0.01" class="form-control ${not empty fieldErrors['salePrice'] ? 'is-invalid' : ''}" id="salePrice" name="salePrice" value="${item.salePrice}" required>
                    <c:if test="${not empty fieldErrors['salePrice']}">
                        <div class="invalid-feedback d-block">
                            <i class="fas fa-times-circle"></i> ${fieldErrors['salePrice']}
                        </div>
                    </c:if>
                    <c:if test="${empty fieldErrors['salePrice']}">
                        <div class="invalid-feedback">
                            <i class="fas fa-times-circle"></i> Please enter a valid sale price (greater than 0).
                        </div>
                    </c:if>
                </div>

                <!-- Submit Button -->
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-save"></i> Update Item
                </button>
                
                <!-- Back to Item List Button -->
                <a href="/swarajtraders/items" class="btn btn-outline-danger" style="margin-left: 1rem;">
                    <i class="fas fa-arrow-left"></i> Back to Item List
                </a>
            </form>
        </div>
    </div>
    
    <!-- Bootstrap JS -->
    <script src="webjars/bootstrap/5.1.3/js/bootstrap.bundle.min.js"></script>
    
    <!-- Session Timeout Handler -->
    <script src="/swarajtraders/js/session-timeout.js"></script>
    
    <script>
        // Bootstrap form validation (enable client-side validation)
        (function() {
            'use strict'
            var forms = document.querySelectorAll('.needs-validation')

            Array.prototype.slice.call(forms).forEach(function(form) {
                form.addEventListener('submit', function(event) {
                    if (!form.checkValidity()) {
                        event.preventDefault()
                        event.stopPropagation()
                    }
                    form.classList.add('was-validated')
                }, false)
            })
        })()
        
        // Enhanced form interactions
        document.addEventListener('DOMContentLoaded', function() {
            // Add focus effects to form controls
            const formControls = document.querySelectorAll('.form-control');
            formControls.forEach(control => {
                control.addEventListener('focus', function() {
                    this.parentElement.classList.add('focused');
                });
                
                control.addEventListener('blur', function() {
                    this.parentElement.classList.remove('focused');
                });
            });
            
            // Add smooth transitions for form sections
            const formSection = document.querySelector('.form-section');
            if (formSection) {
                formSection.style.opacity = '0';
                formSection.style.transform = 'translateY(20px)';
                
                setTimeout(() => {
                    formSection.style.transition = 'all 0.6s ease-out';
                    formSection.style.opacity = '1';
                    formSection.style.transform = 'translateY(0)';
                }, 100);
            }
        });
    </script>
</body>
</html>
