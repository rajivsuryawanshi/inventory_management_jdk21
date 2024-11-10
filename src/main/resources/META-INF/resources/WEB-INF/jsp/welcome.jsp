<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome Page</title>

    <!-- Bootstrap CSS -->
    <link href="webjars/bootstrap/5.1.3/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom Styles (Optional) -->
    <style>
        body {
            background-color: #f8f9fa;
            font-family: Arial, sans-serif;
        }
        .container {
            margin-top: 50px;
        }
        .welcome-message {
            font-size: 1.5rem;
            font-weight: 600;
        }
        .user-info {
            margin-top: 30px;
        }
        .table th, .table td {
            vertical-align: middle;
        }
        .table-responsive {
            margin-top: 20px;
        }
    </style>
</head>
<body>

    <div class="container">
        <!-- Welcome Section -->
        <div class="welcome-message text-center mb-4">
            <h2>Welcome to Swaraj Traders</h2>
            <p>Your Name: <strong>${user.getUserName()}</strong></p>
            <a href="login">logout</a>
        </div>

        <!-- User List Section -->
        <div class="user-info">
            <h3 class="text-center">Your Users</h3>
            
            <!-- User Table -->
            <div class="table-responsive">
                <table class="table table-bordered table-striped">
                    <thead class="table-light">
                        <tr>
                            <th>ID</th>
                            <th>User Name</th>
                            <th>Password</th>
                            <th>User Type</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${userList}" var="user">
                            <tr>
                                <td>${user.userId}</td>
                                <td>${user.userName}</td>
                                <!-- In production, consider not showing the password -->
                                <td>******</td> <!-- Password is hidden for security reasons -->
                                <td>${user.userType}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS and jQuery -->
    <script src="webjars/jquery/3.6.0/jquery.min.js"></script>
    <script src="webjars/bootstrap/5.1.3/js/bootstrap.bundle.min.js"></script>
</body>
</html>
