<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="_csrf" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
    <title>Purchase Entry List</title>
    
    <!-- Bootstrap CSS -->
    <link href="webjars/bootstrap/5.1.3/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Custom Modern UI Stylesheet -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/modern-ui.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">

    <!-- Font Awesome for Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .purchase-list {
            max-width: 1400px;
            margin: 20px auto;
            padding: 20px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 2px solid #e0e0e0;
        }
        
        .btn-primary {
            background: #007bff;
            color: white;
            padding: 12px 30px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            text-decoration: none;
            display: inline-block;
        }
        
        .btn-primary:hover {
            background: #0056b3;
        }
        
        .search-section {
            margin-bottom: 20px;
            padding: 20px;
            background: #f8f9fa;
            border-radius: 8px;
        }
        
        .search-row {
            display: flex;
            gap: 20px;
            margin-bottom: 15px;
            align-items: center;
        }
        
        .search-group {
            flex: 1;
            min-width: 200px;
        }
        
        .search-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: 600;
            color: #555;
        }
        
        .search-group input, .search-group select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
        }
        
        .btn-search {
            background: #28a745;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
        }
        
        .btn-search:hover {
            background: #218838;
        }
        
        .table-container {
            overflow-x: auto;
        }
        
        .purchase-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        
        .purchase-table th,
        .purchase-table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        
        .purchase-table th {
            background-color: #f8f9fa;
            font-weight: 600;
            color: #333;
        }
        
        .purchase-table tr:hover {
            background-color: #f5f5f5;
        }
        
        .status-badge {
            padding: 4px 8px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
        }
        
        .status-completed {
            background-color: #d4edda;
            color: #155724;
        }
        
        .no-entries {
            text-align: center;
            padding: 40px;
            color: #666;
            font-style: italic;
        }
        
        .pagination {
            display: flex;
            justify-content: center;
            margin-top: 30px;
            gap: 10px;
        }
        
        .pagination a {
            padding: 8px 12px;
            border: 1px solid #ddd;
            text-decoration: none;
            color: #007bff;
            border-radius: 4px;
        }
        
        .pagination a:hover {
            background-color: #007bff;
            color: white;
        }
        
        .pagination .active {
            background-color: #007bff;
            color: white;
            border-color: #007bff;
        }
    </style>
</head>
<body>
    <!-- Modern Navigation Bar -->
    <nav class="navbar">
        <a href="${pageContext.request.contextPath}/dashboard" class="nav-link">
            <i class="fas fa-home"></i> Dashboard
        </a>
        <h3><i class="fas fa-user-circle"></i> Welcome, ${name}</h3>
        <!-- Logout Button: Using Spring Security logout with CSRF token -->
        <form action="${pageContext.request.contextPath}/logout" method="post" style="display: inline;">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <button type="submit" class="btn btn-outline-danger">
                <i class="fas fa-sign-out-alt"></i> Logout
            </button>
        </form>
    </nav>

    <div class="container">
        <div class="purchase-list">
            <div class="page-header">
                <h2>Purchase Entry List</h2>
                <div>
                    <a href="${pageContext.request.contextPath}/purchase-entry" class="btn-primary">Add New Purchase Entry</a>
                    <button type="button" class="btn-secondary" onclick="testAPI()" style="margin-left: 10px;">Test API</button>
                </div>
            </div>
            
            <div class="search-section">
                <h3>Search & Filter</h3>
                <div class="search-row">
                    <div class="search-group">
                        <label for="partyFilter">Party</label>
                        <select id="partyFilter">
                            <option value="">All Parties</option>
                        </select>
                    </div>
                    <div class="search-group">
                        <label for="itemCodeFilter">Item Code</label>
                        <input type="text" id="itemCodeFilter" placeholder="Enter item code">
                    </div>
                    <div class="search-group">
                        <label for="dateFromFilter">Date From</label>
                        <input type="date" id="dateFromFilter">
                    </div>
                    <div class="search-group">
                        <label for="dateToFilter">Date To</label>
                        <input type="date" id="dateToFilter">
                    </div>
                    <div class="search-group">
                        <button type="button" class="btn-search" onclick="applyFilters()">Search</button>
                    </div>
                </div>
            </div>
            
            <div class="table-container">
                <table class="purchase-table">
                    <thead>
                        <tr>
                            <th>Purchase ID</th>
                            <th>Date</th>
                            <th>Party</th>
                            <th>Item Code</th>
                            <th>Item Name</th>
                            <th>Category</th>
                            <th>Quantity</th>
                            <th>Wholesale Price</th>
                            <th>Purchase Price</th>
                            <th>Discount %</th>
                            <th>Total Amount</th>
                        </tr>
                    </thead>
                    <tbody id="purchaseTableBody">
                        <c:choose>
                            <c:when test="${not empty purchaseEntries}">
                                <c:forEach var="entry" items="${purchaseEntries}">
                                    <tr>
                                        <td>${entry.purchaseId}</td>
                                        <td>
                                            <fmt:formatDate value="${entry.purchaseDate}" pattern="dd/MM/yyyy HH:mm"/>
                                        </td>
                                        <td>${entry.party.partyName}</td>
                                        <td>${entry.itemCode}</td>
                                        <td>${entry.itemName}</td>
                                        <td>${entry.category}</td>
                                        <td>${entry.quantity}</td>
                                        <td>₹${entry.wholesalePrice}</td>
                                        <td>₹${entry.purchasePrice}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${entry.discountPercentage != null}">
                                                    ${entry.discountPercentage}%
                                                </c:when>
                                                <c:otherwise>
                                                    -
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>₹${entry.totalAmount}</td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="11" class="no-entries">No purchase entries found</td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
            
            <div class="pagination">
                <a href="#" onclick="changePage(1)">1</a>
                <a href="#" onclick="changePage(2)">2</a>
                <a href="#" onclick="changePage(3)">3</a>
                <a href="#" onclick="changePage(4)">4</a>
                <a href="#" onclick="changePage(5)">5</a>
            </div>
        </div>
    </div>

    <script>
        // Helper function for date formatting
        function formatDate(dateString) {
            const date = new Date(dateString);
            return date.toLocaleDateString('en-GB') + ' ' + date.toLocaleTimeString('en-GB', {hour: '2-digit', minute: '2-digit'});
        }
        
        // Load parties for filter dropdown
        document.addEventListener('DOMContentLoaded', function() {
            loadPartiesForFilter();
        });

        function loadPartiesForFilter() {
            console.log('Loading parties for filter from:', '${pageContext.request.contextPath}/purchase-entry/api/parties');
            
            fetch('${pageContext.request.contextPath}/purchase-entry/api/parties')
                .then(response => {
                    console.log('Filter response status:', response.status);
                    return response.json();
                })
                .then(parties => {
                    console.log('Parties for filter loaded:', parties);
                    const partyFilter = document.getElementById('partyFilter');
                    if (parties && parties.length > 0) {
                        parties.forEach(party => {
                            const option = document.createElement('option');
                            option.value = party.partyId;
                            option.textContent = party.partyName;
                            partyFilter.appendChild(option);
                        });
                    } else {
                        console.log('No parties found for filter');
                        partyFilter.innerHTML = '<option value="">-- No Parties Available --</option>';
                    }
                })
                .catch(error => {
                    console.error('Error loading parties for filter:', error);
                    const partyFilter = document.getElementById('partyFilter');
                    partyFilter.innerHTML = '<option value="">-- Error Loading Parties --</option>';
                });
        }

        function applyFilters() {
            const partyId = document.getElementById('partyFilter').value;
            const itemCode = document.getElementById('itemCodeFilter').value;
            const dateFrom = document.getElementById('dateFromFilter').value;
            const dateTo = document.getElementById('dateToFilter').value;
            
            // Build filter URL
            let filterUrl = '${pageContext.request.contextPath}/purchase-entry/api/purchase-entries?';
            const params = new URLSearchParams();
            
            if (partyId) params.append('partyId', partyId);
            if (itemCode) params.append('itemCode', itemCode);
            if (dateFrom) params.append('dateFrom', dateFrom);
            if (dateTo) params.append('dateTo', dateTo);
            
            filterUrl += params.toString();
            
            // Apply filters and update table
            fetch(filterUrl)
                .then(response => response.json())
                .then(entries => {
                    updatePurchaseTable(entries);
                })
                .catch(error => {
                    console.error('Error applying filters:', error);
                });
        }

        function updatePurchaseTable(entries) {
            const tbody = document.getElementById('purchaseTableBody');
            
            if (entries.length === 0) {
                tbody.innerHTML = '<tr><td colspan="11" class="no-entries">No purchase entries found</td></tr>';
                return;
            }
            
            tbody.innerHTML = '';
            entries.forEach(entry => {
                const formattedDate = formatDate(entry.purchaseDate);
                const row = document.createElement('tr');
                row.innerHTML = `
                    <td>${entry.purchaseId}</td>
                    <td>${formattedDate}</td>
                    <td>${entry.party.partyName}</td>
                    <td>${entry.itemCode}</td>
                    <td>${entry.itemName}</td>
                    <td>${entry.category}</td>
                    <td>${entry.quantity}</td>
                    <td>₹${entry.wholesalePrice}</td>
                    <td>₹${entry.purchasePrice}</td>
                    <td>${entry.discountPercentage ? entry.discountPercentage + '%' : '-'}</td>
                    <td>₹${entry.totalAmount}</td>
                `;
                tbody.appendChild(row);
            });
        }

        function changePage(pageNumber) {
            // Implement pagination logic here
            console.log('Changing to page:', pageNumber);
        }
        
        function testAPI() {
            console.log('Testing API endpoint...');
            fetch('${pageContext.request.contextPath}/purchase-entry/api/test')
                .then(response => response.json())
                .then(data => {
                    console.log('Test API response:', data);
                    alert('API test successful: ' + data.message);
                })
                .catch(error => {
                    console.error('Test API error:', error);
                    alert('API test failed: ' + error.message);
                });
        }
    </script>
</body>
</html>
