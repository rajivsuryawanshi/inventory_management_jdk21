<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Swaraj Traders - Add Party</title>

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
        <h1><i class="fas fa-user-plus"></i> Add New Party</h1>
        
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
            <form action="/swarajtraders/addParty" method="post" class="needs-validation" novalidate>
                <!-- CSRF Token -->
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                
                <!-- Party Name -->
                <div class="mb-3">
                    <label for="partyName" class="form-label">
                        <i class="fas fa-building"></i> Party Name
                    </label> 
                    <input type="text" class="form-control ${not empty fieldErrors['partyName'] ? 'is-invalid' : ''}" id="partyName" name="partyName" value="${party.partyName}" required>
                    <c:if test="${not empty fieldErrors['partyName']}">
                        <div class="invalid-feedback d-block">
                            <i class="fas fa-times-circle"></i> ${fieldErrors['partyName']}
                        </div>
                    </c:if>
                    <c:if test="${empty fieldErrors['partyName']}">
                        <div class="invalid-feedback">
                            <i class="fas fa-times-circle"></i> Please enter a valid party name.
                        </div>
                    </c:if>
                </div>

                <!-- GST Number -->
                <div class="mb-3">
                    <label for="gstNo" class="form-label">
                        <i class="fas fa-receipt"></i> GST No
                    </label> 
                    <input type="text" class="form-control ${not empty fieldErrors['gstNo'] ? 'is-invalid' : ''}" id="gstNo" name="gstNo" value="${party.gstNo}" required>
                    <c:if test="${not empty fieldErrors['gstNo']}">
                        <div class="invalid-feedback d-block">
                            <i class="fas fa-times-circle"></i> ${fieldErrors['gstNo']}
                        </div>
                    </c:if>
                    <c:if test="${empty fieldErrors['gstNo']}">
                        <div class="invalid-feedback">
                            <i class="fas fa-times-circle"></i> Please enter a valid GST number (15 characters).
                        </div>
                    </c:if>
                </div>

                <!-- Phone Number -->
                <div class="mb-3">
                    <label for="phoneNumber" class="form-label">
                        <i class="fas fa-phone"></i> Phone Number
                    </label> 
                    <input type="tel" class="form-control ${not empty fieldErrors['phoneNumber'] ? 'is-invalid' : ''}" id="phoneNumber" name="phoneNumber" value="${party.phoneNumber}" required>
                    <c:if test="${not empty fieldErrors['phoneNumber']}">
                        <div class="invalid-feedback d-block">
                            <i class="fas fa-times-circle"></i> ${fieldErrors['phoneNumber']}
                        </div>
                    </c:if>
                    <c:if test="${empty fieldErrors['phoneNumber']}">
                        <div class="invalid-feedback">
                            <i class="fas fa-times-circle"></i> Please enter a valid phone number.
                        </div>
                    </c:if>
                </div>

                <!-- Email -->
                <div class="mb-3">
                    <label for="email" class="form-label">
                        <i class="fas fa-envelope"></i> Email
                    </label> 
                    <input type="email" class="form-control ${not empty fieldErrors['email'] ? 'is-invalid' : ''}" id="email" name="email" value="${party.email}" required>
                    <c:if test="${not empty fieldErrors['email']}">
                        <div class="invalid-feedback d-block">
                            <i class="fas fa-times-circle"></i> ${fieldErrors['email']}
                        </div>
                    </c:if>
                    <c:if test="${empty fieldErrors['email']}">
                        <div class="invalid-feedback">
                            <i class="fas fa-times-circle"></i> Please enter a valid email address.
                        </div>
                    </c:if>
                </div>

                <!-- Billing Address -->
                <div class="mb-3">
                    <label for="billingAddress" class="form-label">
                        <i class="fas fa-map-marker-alt"></i> Billing Address
                    </label> 
                    <input type="text" class="form-control ${not empty fieldErrors['billingAddress'] ? 'is-invalid' : ''}" id="billingAddress" name="billingAddress" value="${party.billingAddress}" required>
                    <c:if test="${not empty fieldErrors['billingAddress']}">
                        <div class="invalid-feedback d-block">
                            <i class="fas fa-times-circle"></i> ${fieldErrors['billingAddress']}
                        </div>
                    </c:if>
                    <c:if test="${empty fieldErrors['billingAddress']}">
                        <div class="invalid-feedback">
                            <i class="fas fa-times-circle"></i> Please enter a billing address.
                        </div>
                    </c:if>
                </div>

                <!-- Shipping Address -->
                <div class="mb-3">
                    <label for="shippingAddress" class="form-label">
                        <i class="fas fa-shipping-fast"></i> Shipping Address
                    </label> 
                    <input type="text" class="form-control ${not empty fieldErrors['shippingAddress'] ? 'is-invalid' : ''}" id="shippingAddress" name="shippingAddress" value="${party.shippingAddress}" required>
                    <c:if test="${not empty fieldErrors['shippingAddress']}">
                        <div class="invalid-feedback d-block">
                            <i class="fas fa-times-circle"></i> ${fieldErrors['shippingAddress']}
                        </div>
                    </c:if>
                    <c:if test="${empty fieldErrors['shippingAddress']}">
                        <div class="invalid-feedback">
                            <i class="fas fa-times-circle"></i> Please enter a shipping address.
                        </div>
                    </c:if>
                </div>

                <!-- Additional Fields -->
                <div class="mb-3">
                    <label for="additionalField1" class="form-label">
                        <i class="fas fa-plus-circle"></i> Additional Field 1
                    </label> 
                    <input type="text" class="form-control" id="additionalField1" name="additionalField1" value="${party.additionalField1}">
                </div>

                <div class="mb-3">
                    <label for="additionalField2" class="form-label">
                        <i class="fas fa-plus-circle"></i> Additional Field 2
                    </label> 
                    <input type="text" class="form-control" id="additionalField2" name="additionalField2" value="${party.additionalField2}">
                </div>

                <!-- Submit Button -->
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-save"></i> Add Party
                </button>
                
                <!-- Back to Dashboard Button -->
                <a href="/swarajtraders/dashboard" class="btn btn-outline-danger" style="margin-left: 1rem;">
                    <i class="fas fa-arrow-left"></i> Back to Dashboard
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
