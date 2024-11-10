<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Add Party</title>
<link href="webjars/bootstrap/5.1.3/css/bootstrap.min.css"
	rel="stylesheet">
<style>
body {
	background-color: #f8f9fa;
	font-family: 'Arial', sans-serif;
}

.container {
	max-width: 600px;
}

.form-label {
	font-weight: bold;
}

.btn-primary {
	width: 100%;
}

.form-section {
	padding: 15px;
	border: 1px solid #ddd;
	border-radius: 8px;
	background-color: #ffffff;
}

.form-section h3 {
	text-align: center;
	color: #007bff;
}
</style>
</head>
<body>
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
			<form action="/addParty" method="post" class="needs-validation"
				novalidate>

				<!-- Party Name -->
				<div class="mb-3">
					<label for="partyName" class="form-label">Party Name</label> <input
						type="text" class="form-control" id="partyName" name="partyName"
						required>
					<div class="invalid-feedback">Please enter a valid party
						name.</div>
				</div>

				<!-- GST Number -->
				<div class="mb-3">
					<label for="gstNo" class="form-label">GST No</label> <input
						type="text" class="form-control" id="gstNo" name="gstNo" required>
					<div class="invalid-feedback">Please enter a valid GST
						number.</div>
				</div>

				<!-- Phone Number -->
				<div class="mb-3">
					<label for="phoneNumber" class="form-label">Phone Number</label> <input
						type="tel" class="form-control" id="phoneNumber"
						name="phoneNumber" required>
					<div class="invalid-feedback">Please enter a valid phone
						number.</div>
				</div>

				<!-- Email -->
				<div class="mb-3">
					<label for="email" class="form-label">Email</label> <input
						type="email" class="form-control" id="email" name="email" required>
					<div class="invalid-feedback">Please enter a valid email
						address.</div>
				</div>

				<!-- Billing Address -->
				<div class="mb-3">
					<label for="billingAddress" class="form-label">Billing
						Address</label> <input type="text" class="form-control"
						id="billingAddress" name="billingAddress" required>
					<div class="invalid-feedback">Please enter a billing address.</div>
				</div>

				<!-- Shipping Address -->
				<div class="mb-3">
					<label for="shippingAddress" class="form-label">Shipping
						Address</label> <input type="text" class="form-control"
						id="shippingAddress" name="shippingAddress" required>
					<div class="invalid-feedback">Please enter a shipping
						address.</div>
				</div>

				<!-- Additional Fields -->
				<div class="mb-3">
					<label for="additionalField1" class="form-label">Additional
						Field 1</label> <input type="text" class="form-control"
						id="additionalField1" name="additionalField1">
				</div>

				<div class="mb-3">
					<label for="additionalField2" class="form-label">Additional
						Field 2</label> <input type="text" class="form-control"
						id="additionalField2" name="additionalField2">
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
