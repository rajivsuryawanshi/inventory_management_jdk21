<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Party List</title>
<link href="webjars/bootstrap/5.1.3/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Custom Stylesheet -->
    <link rel="stylesheet" href="/swarajtraders/css/header.css">
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
	<!-- Navigation Bar with Home and Logout buttons -->
    <nav class="navbar">
        <a href="/swarajtraders/dashboard">Home</a>
        <h3 class="text-center">Hello, ${user.getUserName()}</h3>
        <!-- Logout Button: Using Spring Security logout with CSRF token -->
        <form action="/swarajtraders/logout" method="post" style="display: inline;">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <button type="submit" class="btn btn-outline-danger">Logout</button>
        </form>
    </nav>
	<div class="container mt-5">
		<h2 class="text-center">Party List</h2>
		
		<!-- Display success message -->
		<c:if test="${not empty message}">
			<div class="alert alert-success alert-dismissible fade show" role="alert">
				${message}
				<button type="button" class="btn-close" data-bs-dismiss="alert"></button>
			</div>
		</c:if>
		
		<!-- Display error message -->
		<c:if test="${not empty error}">
			<div class="alert alert-danger alert-dismissible fade show" role="alert">
				${error}
				<button type="button" class="btn-close" data-bs-dismiss="alert"></button>
			</div>
		</c:if>
		
		<table class="table table-striped">
			<thead>
				<tr>
					<th>ID</th>
					<th>Party Name</th>
					<th>GST No</th>
					<th>Phone Number</th>
					<th>Email</th>
					<th>Billing Address</th>
					<th>Shipping Address</th>
					<th>Actions</th>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${not empty parties}">
						<c:forEach items="${parties}" var="party">
							<tr>
								<td>${party.getPartyId()}</td>
								<td>${party.getPartyName()}</td>
								<td>${party.getGstNo()}</td>
								<td>${party.getPhoneNumber()}</td>
								<td>${party.getEmail()}</td>
								<td>${party.getBillingAddress()}</td>
								<td>${party.getShippingAddress()}</td>
								<td>
									<!-- Form that submits a POST request to delete the party -->
									<form action="/swarajtraders/deleteParty" method="POST"
										style="display: inline;" id="deleteForm-${party.getPartyId()}">
										<!-- CSRF Token -->
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
										<input type="hidden" name="partyId"
											value="${party.getPartyId()}" />
										<button type="button" class="btn btn-danger"
											onclick="confirmDelete(${party.getPartyId()})">Delete
											Party</button>
									</form>
								</td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="8" class="text-center">No parties found. <a href="/swarajtraders/addParty" class="btn btn-success">Add New Party</a></td>
						</tr>
					</c:otherwise>
				</c:choose>
				<tr>
					<td colspan="8"><a href="/swarajtraders/addParty" class="btn btn-success">Add
							New Party</a></td>
				</tr>
			</tbody>
		</table>
	</div>

	    <script src="webjars/bootstrap/5.1.3/js/bootstrap.bundle.min.js"></script>
    
    <!-- Session Timeout Handler -->
    <script src="/swarajtraders/js/session-timeout.js"></script>
</body>
</html>
