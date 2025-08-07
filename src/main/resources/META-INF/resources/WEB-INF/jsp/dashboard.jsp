<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Main Dashboard</title>

    <!-- Bootstrap 5 CSS -->
    <link href="webjars/bootstrap/5.1.3/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom Stylesheet -->
    <link rel="stylesheet" href="/css/styles.css">

</head>
<body>
    <!-- Navigation Bar with Home and Logout buttons -->
    <nav class="navbar">
        <a href="/dashboard">Home</a>
        <h3 class="text-center">Hello, ${name}</h3>
        <!-- Logout Button: Using Spring Security logout -->
        <form action="/logout" method="post" style="display: inline;">
            <button type="submit" class="btn btn-outline-danger">Logout</button>
        </form>
    </nav>

    <div class="container">
        <h1 class="text-center mt-5">Welcome to Swaraj Traders</h1>

        <div class="list-group mt-4">
            <a href="/parties" class="list-group-item list-group-item-action">Party Details</a>
            <a href="/productEntry" class="list-group-item list-group-item-action">Product / Item Entry</a>
            <a href="/purchaseEntry" class="list-group-item list-group-item-action">Purchase Entry</a>
            <a href="/saleEntry" class="list-group-item list-group-item-action">Sale / Bill Entry</a>
            <a href="/stockDetails" class="list-group-item list-group-item-action">Stock Details</a>
            <a href="/stockAdjustment" class="list-group-item list-group-item-action">Stock Adjustment</a>
            <a href="/expenseEntry" class="list-group-item list-group-item-action">Expense Entry</a>
        </div>
    </div>

    <!-- Bootstrap JS and jQuery -->
    <script src="webjars/jquery/3.6.0/jquery.min.js"></script>
    <script src="webjars/bootstrap/5.1.3/js/bootstrap.bundle.min.js"></script>
</body>
</html>
