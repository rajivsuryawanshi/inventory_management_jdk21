<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Party</title>
    <link href="webjars/bootstrap/5.1.3/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom Stylesheet -->
    <link rel="stylesheet" href="/css/styles.css">
    </head>
<body>

    <!-- Navigation Bar with Home and Logout buttons -->
    <nav class="navbar">
        <a href="/dashboard">Home</a>
        <h3 class="text-center">Hello, ${user.getUserName()}</h3>
        <!-- Logout Button: Using Spring Security logout with CSRF token -->
        <form action="/logout" method="post" style="display: inline;">
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

    <div class="container mt-5">
        <div class="form-section">
            <h3>Add Party</h3>

            <!-- Form starts here -->
            <form action="/addParty" method="post" class="needs-validation" novalidate>
                <!-- CSRF Token -->
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                
                <!-- Party Name -->
                <div class="mb-3">
                    <label for="partyName" class="form-label">Party Name</label> 
                    <input type="text" class="form-control" id="partyName" name="partyName" required>
                    <div class="invalid-feedback">Please enter a valid party name.</div>
                </div>

                <!-- GST Number -->
                <div class="mb-3">
                    <label for="gstNo" class="form-label">GST No</label> 
                    <input type="text" class="form-control" id="gstNo" name="gstNo" required>
                    <div class="invalid-feedback">Please enter a valid GST number.</div>
                </div>

                <!-- Phone Number -->
                <div class="mb-3">
                    <label for="phoneNumber" class="form-label">Phone Number</label> 
                    <input type="tel" class="form-control" id="phoneNumber" name="phoneNumber" required>
                    <div class="invalid-feedback">Please enter a valid phone number.</div>
                </div>

                <!-- Email -->
                <div class="mb-3">
                    <label for="email" class="form-label">Email</label> 
                    <input type="email" class="form-control" id="email" name="email" required>
                    <div class="invalid-feedback">Please enter a valid email address.</div>
                </div>

                <!-- Billing Address -->
                <div class="mb-3">
                    <label for="billingAddress" class="form-label">Billing Address</label> 
                    <input type="text" class="form-control" id="billingAddress" name="billingAddress" required>
                    <div class="invalid-feedback">Please enter a billing address.</div>
                </div>

                <!-- Shipping Address -->
                <div class="mb-3">
                    <label for="shippingAddress" class="form-label">Shipping Address</label> 
                    <input type="text" class="form-control" id="shippingAddress" name="shippingAddress" required>
                    <div class="invalid-feedback">Please enter a shipping address.</div>
                </div>

                <!-- Additional Fields -->
                <div class="mb-3">
                    <label for="additionalField1" class="form-label">Additional Field 1</label> 
                    <input type="text" class="form-control" id="additionalField1" name="additionalField1">
                </div>

                <div class="mb-3">
                    <label for="additionalField2" class="form-label">Additional Field 2</label> 
                    <input type="text" class="form-control" id="additionalField2" name="additionalField2">
                </div>

                <!-- Submit Button -->
                <button type="submit" class="btn btn-primary">Add Party</button>
            </form>
        </div>
    </div>

    <script src="webjars/bootstrap/5.1.3/js/bootstrap.bundle.min.js"></script>
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
