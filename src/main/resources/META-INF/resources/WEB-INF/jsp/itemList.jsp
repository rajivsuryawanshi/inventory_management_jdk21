<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="_csrf" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
    <title>Item List</title>
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

    <!-- Success Message -->
    <c:if test="${not empty message}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            ${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <!-- Error Message -->
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            ${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <div class="container mt-5">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2>Item List</h2>
            <a href="/swarajtraders/addItem" class="btn btn-primary">Add New Item</a>
        </div>

        <c:choose>
            <c:when test="${not empty items}">
                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead class="table-dark">
                            <tr>
                                <th>Item ID</th>
                                <th>Item Name</th>
                                <th>Item Code</th>
                                <th>Category</th>
                                <th>Sub Category</th>
                                <th>Wholesale Price</th>
                                <th>Purchase Price</th>
                                <th>Sale Price</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="item" items="${items}">
                                <tr>
                                    <td>${item.itemId}</td>
                                    <td>${item.itemName}</td>
                                    <td>${item.itemCode}</td>
                                    <td>${item.category}</td>
                                    <td>${item.subCategory}</td>
                                    <td>
                                        <fmt:formatNumber value="${item.wholesalePrice}" type="currency" currencySymbol="Rs"/>
                                    </td>
                                    <td>
                                        <fmt:formatNumber value="${item.purchasePrice}" type="currency" currencySymbol="Rs"/>
                                    </td>
                                    <td>
                                        <fmt:formatNumber value="${item.salePrice}" type="currency" currencySymbol="Rs"/>
                                    </td>
                                    <td>
                                        <form action="/swarajtraders/deleteItem" method="post" style="display: inline;" 
                                              onsubmit="return confirm('Are you sure you want to delete this item?');">
                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                            <input type="hidden" name="itemId" value="${item.itemId}"/>
                                            <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:when>
            <c:otherwise>
                <div class="alert alert-info">
                    <h4>No Items Found</h4>
                    <p>There are no items in the system yet. <a href="/swarajtraders/addItem">Add the first item</a> to get started.</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <script src="webjars/bootstrap/5.1.3/js/bootstrap.bundle.min.js"></script>
    
    <!-- Session Timeout Handler -->
    <script src="/swarajtraders/js/session-timeout.js"></script>
</body>
</html>
