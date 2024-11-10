<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Main Dashboard</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="webjars/bootstrap/5.1.3/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom Styles -->
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Arial', sans-serif;
        }

        .container {
            background-color: #ffffff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            margin-top: 50px;
        }

        h1 {
            color: #007bff;
            font-weight: 700;
        }

        h3 {
            color: #343a40;
            font-weight: 500;
        }

        .list-group-item {
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 18px;
            font-weight: 600;
            background-color: #f1f1f1;
            transition: background-color 0.3s ease, color 0.3s ease;
        }

        .list-group-item:hover {
            background-color: #007bff;
            color: white;
            cursor: pointer;
        }

        .list-group-item:active {
            background-color: #0056b3;
            color: white;
        }

        .list-group-item:focus {
            box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.5);
        }

        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
        }

        .btn-primary:hover {
            background-color: #0056b3;
            border-color: #0056b3;
        }
    </style>
</head>
<body>

    <div class="container">
        <h1 class="text-center mt-5">Welcome to Swaraj Traders</h1>
        <h3 class="text-center">Hello, ${user.getUserName()}</h3>

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
