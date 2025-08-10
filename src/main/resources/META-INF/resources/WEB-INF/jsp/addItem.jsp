<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="_csrf" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
    <title>Add Item</title>
    <link href="webjars/bootstrap/5.1.3/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom Stylesheet -->
    <link rel="stylesheet" href="/swarajtraders/css/styles.css">
    </head>
<body>

    <!-- Navigation Bar with Home and Logout buttons -->
    <nav class="navbar">
        <a href="/swarajtraders/dashboard">Home</a>
        <h3 class="text-center">Hello, ${name}</h3>
        <!-- Logout Button: Using Spring Security logout with CSRF token -->
        <form action="/swarajtraders/logout" method="post" style="display: inline;">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <button type="submit" class="btn btn-outline-danger">Logout</button>
        </form>
    </nav>

    <!-- Error Message -->
    <!-- Display BindingResult errors if there are any -->
    <c:if test="${not empty errors}">
        <div class="alert alert-danger">
            <ul>
                <!-- Iterate over all the errors -->
                <c:forEach var="error" items="${errors}">
                    <li>${error.defaultMessage}</li>
                </c:forEach>
            </ul>
        </div>
    </c:if>
    
    <!-- Display general error message -->
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            ${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <div class="container mt-5">
        <div class="form-section">
            <h3>Add Item</h3>

            <!-- Form starts here using regular HTML with proper field names -->
            <form action="/swarajtraders/addItem" method="post" class="needs-validation" novalidate>
                <!-- CSRF Token -->
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                
                <!-- Item Name -->
                <div class="mb-3">
                    <label for="itemName" class="form-label">Item Name</label> 
                    <input type="text" class="form-control ${not empty fieldErrors['itemName'] ? 'is-invalid' : ''}" id="itemName" name="itemName" value="${item.itemName}" required>
                    <c:if test="${not empty fieldErrors['itemName']}">
                        <div class="invalid-feedback d-block">${fieldErrors['itemName']}</div>
                    </c:if>
                    <c:if test="${empty fieldErrors['itemName']}">
                        <div class="invalid-feedback">Please enter a valid item name.</div>
                    </c:if>
                </div>

                <!-- Item Code -->
                <div class="mb-3">
                    <label for="itemCode" class="form-label">Item Code</label> 
                    <input type="text" class="form-control ${not empty fieldErrors['itemCode'] ? 'is-invalid' : ''}" id="itemCode" name="itemCode" value="${item.itemCode}" required>
                    <c:if test="${not empty fieldErrors['itemCode']}">
                        <div class="invalid-feedback d-block">${fieldErrors['itemCode']}</div>
                    </c:if>
                    <c:if test="${empty fieldErrors['itemCode']}">
                        <div class="invalid-feedback">Please enter a valid item code (3-20 characters).</div>
                    </c:if>
                </div>

                <!-- Category -->
                <div class="mb-3">
                    <label for="category" class="form-label">Category</label> 
                    <input type="text" class="form-control ${not empty fieldErrors['category'] ? 'is-invalid' : ''}" id="category" name="category" value="${item.category}" required>
                    <c:if test="${not empty fieldErrors['category']}">
                        <div class="invalid-feedback d-block">${fieldErrors['category']}</div>
                    </c:if>
                    <c:if test="${empty fieldErrors['category']}">
                        <div class="invalid-feedback">Please enter a category.</div>
                    </c:if>
                </div>

                <!-- Sub Category -->
                <div class="mb-3">
                    <label for="subCategory" class="form-label">Sub Category</label> 
                    <input type="text" class="form-control ${not empty fieldErrors['subCategory'] ? 'is-invalid' : ''}" id="subCategory" name="subCategory" value="${item.subCategory}" required>
                    <c:if test="${not empty fieldErrors['subCategory']}">
                        <div class="invalid-feedback d-block">${fieldErrors['subCategory']}</div>
                    </c:if>
                    <c:if test="${empty fieldErrors['subCategory']}">
                        <div class="invalid-feedback">Please enter a sub category.</div>
                    </c:if>
                </div>

                <!-- Wholesale Price -->
                <div class="mb-3">
                    <label for="wholesalePrice" class="form-label">Wholesale Price</label> 
                    <input type="number" step="0.01" min="0.01" class="form-control ${not empty fieldErrors['wholesalePrice'] ? 'is-invalid' : ''}" id="wholesalePrice" name="wholesalePrice" value="${item.wholesalePrice}" required>
                    <c:if test="${not empty fieldErrors['wholesalePrice']}">
                        <div class="invalid-feedback d-block">${fieldErrors['wholesalePrice']}</div>
                    </c:if>
                    <c:if test="${empty fieldErrors['wholesalePrice']}">
                        <div class="invalid-feedback">Please enter a valid wholesale price (greater than 0).</div>
                    </c:if>
                </div>

                <!-- Purchase Price -->
                <div class="mb-3">
                    <label for="purchasePrice" class="form-label">Purchase Price</label> 
                    <input type="number" step="0.01" min="0.01" class="form-control ${not empty fieldErrors['purchasePrice'] ? 'is-invalid' : ''}" id="purchasePrice" name="purchasePrice" value="${item.purchasePrice}" required>
                    <c:if test="${not empty fieldErrors['purchasePrice']}">
                        <div class="invalid-feedback d-block">${fieldErrors['purchasePrice']}</div>
                    </c:if>
                    <c:if test="${empty fieldErrors['purchasePrice']}">
                        <div class="invalid-feedback">Please enter a valid purchase price (greater than 0).</div>
                    </c:if>
                </div>

                <!-- Sale Price -->
                <div class="mb-3">
                    <label for="salePrice" class="form-label">Sale Price</label> 
                    <input type="number" step="0.01" min="0.01" class="form-control ${not empty fieldErrors['salePrice'] ? 'is-invalid' : ''}" id="salePrice" name="salePrice" value="${item.salePrice}" required>
                    <c:if test="${not empty fieldErrors['salePrice']}">
                        <div class="invalid-feedback d-block">${fieldErrors['salePrice']}</div>
                    </c:if>
                    <c:if test="${empty fieldErrors['salePrice']}">
                        <div class="invalid-feedback">Please enter a valid sale price (greater than 0).</div>
                    </c:if>
                </div>

                <!-- Submit Button -->
                <button type="submit" class="btn btn-primary">Add Item</button>
            </form>
        </div>
    </div>

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
    </script>
</body>
</html>
