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
    <link rel="stylesheet" href="/css/header.css">
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
        <a href="/dashboard">Home</a>
        <h3 class="text-center">Hello, ${user.getUserName()}</h3>
        <!-- Logout Button: Display only if the user is logged in -->
        <c:if test="${not empty sessionScope.user}">
            <a href="/logout">Logout</a>
        </c:if>
    </nav>
	<div class="container mt-5">
		<h2 class="text-center">Party List</h2>
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
							<form action="/deleteParty" method="POST"
								style="display: inline;" id="deleteForm-${party.getPartyId()}">
								<input type="hidden" name="partyId"
									value="${party.getPartyId()}" />
								<button type="button" class="btn btn-danger"
									onclick="confirmDelete(${party.getPartyId()})">Delete
									Party</button>
							</form>
						</td>

					</tr>
				</c:forEach>
				<tr>
					<td colspan="8"><a href="/addParty" class="btn btn-success">Add
							New Party</a></td>
				</tr>
			</tbody>
		</table>
	</div>

	<script src="webjars/bootstrap/5.1.3/js/bootstrap.bundle.min.js"></script>
</body>
</html>
