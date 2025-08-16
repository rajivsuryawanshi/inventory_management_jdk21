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
    <title>Purchase Details</title>
    
    <!-- Bootstrap CSS -->
    <link href="webjars/bootstrap/5.1.3/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Custom Modern UI Stylesheet -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/modern-ui.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">

    <!-- Font Awesome for Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
    <style>
        .purchase-details {
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
            flex-wrap: wrap;
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
        
        .party-section {
            margin-bottom: 30px;
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            overflow: hidden;
        }
        
        .party-header {
            background: #007bff;
            color: white;
            padding: 15px 20px;
            font-weight: 600;
            font-size: 18px;
        }
        
        .party-summary {
            background: #f8f9fa;
            padding: 15px 20px;
            border-bottom: 1px solid #e0e0e0;
        }
        
        .summary-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 8px;
        }
        
        .summary-row:last-child {
            margin-bottom: 0;
            font-weight: bold;
            color: #007bff;
        }
        
        .table-container {
            overflow-x: auto;
        }
        
        .purchase-table {
            width: 100%;
            border-collapse: collapse;
            margin: 0;
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
        
        .no-entries {
            text-align: center;
            padding: 40px;
            color: #666;
            font-style: italic;
        }
        
        .loading {
            text-align: center;
            padding: 40px;
            color: #007bff;
        }
        
        .stats-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .stat-card {
            background: white;
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            padding: 20px;
            text-align: center;
        }
        
        .stat-card h3 {
            margin: 0 0 10px 0;
            color: #007bff;
            font-size: 2rem;
        }
        
        .stat-card p {
            margin: 0;
            color: #666;
            font-weight: 600;
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
        <div class="purchase-details">
            <div class="page-header">
                <h2><i class="fas fa-list-alt"></i> Purchase Details</h2>
                <div>
                    <a href="${pageContext.request.contextPath}/purchase-entry" class="btn-primary">Add New Purchase Entry</a>
                    <a href="${pageContext.request.contextPath}/purchase-entry/list" class="btn-primary" style="margin-left: 10px;">View All Entries</a>
                </div>
            </div>
            
            <!-- Statistics Cards -->
            <div class="stats-cards">
                <div class="stat-card">
                    <h3 id="totalParties">0</h3>
                    <p>Total Parties</p>
                </div>
                <div class="stat-card">
                    <h3 id="totalEntries">0</h3>
                    <p>Total Entries</p>
                </div>
                <div class="stat-card">
                    <h3 id="totalAmount">₹0.00</h3>
                    <p>Total Amount</p>
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
                        <button type="button" class="btn-search" onclick="clearFilters()" style="margin-left: 10px; background: #6c757d;">Clear</button>
                    </div>
                </div>
            </div>
            
            <div id="purchaseDataContainer">
                <div class="loading">
                    <i class="fas fa-spinner fa-spin"></i> Loading purchase data...
                </div>
            </div>
        </div>
    </div>

    <script>
        let allPurchaseData = [];
        let filteredData = [];
        
        // Helper function for date formatting
        function formatDate(dateString) {
            const date = new Date(dateString);
            return date.toLocaleDateString('en-GB') + ' ' + date.toLocaleTimeString('en-GB', {hour: '2-digit', minute: '2-digit'});
        }
        
        // Load data on page load
        document.addEventListener('DOMContentLoaded', function() {
            loadPurchaseData();
            loadPartiesForFilter();
        });
        
        function loadPurchaseData() {
            fetch('${pageContext.request.contextPath}/purchase-entry/api/purchase-entries')
                .then(response => response.json())
                .then(data => {
                    allPurchaseData = data;
                    filteredData = data;
                    displayPurchaseData();
                    updateStatistics();
                })
                .catch(error => {
                    console.error('Error loading purchase data:', error);
                    document.getElementById('purchaseDataContainer').innerHTML = 
                        '<div class="no-entries">Error loading purchase data. Please try again.</div>';
                });
        }
        
        function loadPartiesForFilter() {
            fetch('${pageContext.request.contextPath}/purchase-entry/api/parties')
                .then(response => response.json())
                .then(parties => {
                    const partyFilter = document.getElementById('partyFilter');
                    parties.forEach(party => {
                        const option = document.createElement('option');
                        option.value = party.partyId;
                        option.textContent = party.partyName;
                        partyFilter.appendChild(option);
                    });
                })
                .catch(error => {
                    console.error('Error loading parties for filter:', error);
                });
        }
        
        function displayPurchaseData() {
            const container = document.getElementById('purchaseDataContainer');
            
            if (filteredData.length === 0) {
                container.innerHTML = '<div class="no-entries">No purchase entries found</div>';
                return;
            }
            
            // Group data by party
            const groupedData = groupByParty(filteredData);
            
            let html = '';
            Object.keys(groupedData).forEach(partyId => {
                const partyData = groupedData[partyId];
                const party = partyData.party;
                const entries = partyData.entries;
                
                // Calculate party summary
                const totalEntries = entries.length;
                const totalAmount = entries.reduce((sum, entry) => sum + (entry.totalAmount || 0), 0);
                const totalQuantity = entries.reduce((sum, entry) => sum + (entry.quantity || 0), 0);
                
                html += `
                    <div class="party-section">
                        <div class="party-header">
                            <i class="fas fa-building"></i> ${party.partyName}
                        </div>
                        <div class="party-summary">
                            <div class="summary-row">
                                <span>Total Entries:</span>
                                <span>${totalEntries}</span>
                            </div>
                            <div class="summary-row">
                                <span>Total Quantity:</span>
                                <span>${totalQuantity}</span>
                            </div>
                            <div class="summary-row">
                                <span>Total Amount:</span>
                                <span>₹${totalAmount.toFixed(2)}</span>
                            </div>
                        </div>
                        <div class="table-container">
                            <table class="purchase-table">
                                <thead>
                                    <tr>
                                        <th>Date</th>
                                        <th>Item Code</th>
                                        <th>Item Name</th>
                                        <th>Category</th>
                                        <th>Quantity</th>
                                        <th>Wholesale Price</th>
                                        <th>Purchase Price</th>
                                        <th>Discount %</th>
                                        <th>Total</th>
                                    </tr>
                                </thead>
                                <tbody>
                `;
                
                entries.forEach(entry => {
                    const formattedDate = formatDate(entry.purchaseDate);
                    html += `
                        <tr>
                            <td>${formattedDate}</td>
                            <td>${entry.itemCode}</td>
                            <td>${entry.itemName}</td>
                            <td>${entry.category}</td>
                            <td>${entry.quantity}</td>
                            <td>₹${entry.wholesalePrice}</td>
                            <td>₹${entry.purchasePrice}</td>
                            <td>${entry.discountPercentage ? entry.discountPercentage.toFixed(2) + '%' : '-'}</td>
                            <td>₹${entry.totalAmount ? entry.totalAmount.toFixed(2) : '0.00'}</td>
                        </tr>
                    `;
                });
                
                html += `
                                </tbody>
                            </table>
                        </div>
                    </div>
                `;
            });
            
            container.innerHTML = html;
        }
        
        function groupByParty(data) {
            const grouped = {};
            
            data.forEach(entry => {
                const partyId = entry.party.partyId;
                if (!grouped[partyId]) {
                    grouped[partyId] = {
                        party: entry.party,
                        entries: []
                    };
                }
                grouped[partyId].entries.push(entry);
            });
            
            return grouped;
        }
        
        function updateStatistics() {
            const totalParties = new Set(filteredData.map(entry => entry.party.partyId)).size;
            const totalEntries = filteredData.length;
            const totalAmount = filteredData.reduce((sum, entry) => sum + (entry.totalAmount || 0), 0);
            
            document.getElementById('totalParties').textContent = totalParties;
            document.getElementById('totalEntries').textContent = totalEntries;
            document.getElementById('totalAmount').textContent = '₹' + totalAmount.toFixed(2);
        }
        
        function applyFilters() {
            const partyId = document.getElementById('partyFilter').value;
            const itemCode = document.getElementById('itemCodeFilter').value.toLowerCase();
            const dateFrom = document.getElementById('dateFromFilter').value;
            const dateTo = document.getElementById('dateToFilter').value;
            
            filteredData = allPurchaseData.filter(entry => {
                // Party filter
                if (partyId && entry.party.partyId != partyId) return false;
                
                // Item code filter
                if (itemCode && !entry.itemCode.toLowerCase().includes(itemCode)) return false;
                
                // Date filter
                if (dateFrom || dateTo) {
                    const entryDate = new Date(entry.purchaseDate);
                    if (dateFrom && entryDate < new Date(dateFrom)) return false;
                    if (dateTo && entryDate > new Date(dateTo + 'T23:59:59')) return false;
                }
                
                return true;
            });
            
            displayPurchaseData();
            updateStatistics();
        }
        
        function clearFilters() {
            document.getElementById('partyFilter').value = '';
            document.getElementById('itemCodeFilter').value = '';
            document.getElementById('dateFromFilter').value = '';
            document.getElementById('dateToFilter').value = '';
            
            filteredData = allPurchaseData;
            displayPurchaseData();
            updateStatistics();
        }
    </script>
</body>
</html>
