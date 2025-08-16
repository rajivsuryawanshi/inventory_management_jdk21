<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="_csrf" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
    <title>Purchase Entry Dashboard</title>
    
    <!-- Bootstrap CSS -->
    <link href="webjars/bootstrap/5.1.3/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Custom Modern UI Stylesheet -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/modern-ui.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">

    <!-- Font Awesome for Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .purchase-form {
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        
        .form-section {
            margin-bottom: 30px;
            padding: 20px;
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            background: #fafafa;
        }
        
        .form-section h3 {
            margin-top: 0;
            color: #333;
            border-bottom: 2px solid #007bff;
            padding-bottom: 10px;
        }
        
        .form-row {
            display: flex;
            gap: 20px;
            margin-bottom: 15px;
            align-items: center;
        }
        
        .form-group {
            flex: 1;
            min-width: 200px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: 600;
            color: #555;
        }
        
        .form-group input, .form-group select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
        }
        
        .form-group input:focus, .form-group select:focus {
            outline: none;
            border-color: #007bff;
            box-shadow: 0 0 0 2px rgba(0, 123, 255, 0.25);
        }
        
        .form-group input[readonly] {
            background-color: #f8f9fa;
            color: #495057;
            font-weight: 500;
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
        }
        
        .btn-primary:hover {
            background: #0056b3;
        }
        
        .btn-secondary {
            background: #6c757d;
            color: white;
            padding: 12px 30px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            margin-left: 10px;
        }
        
        .btn-secondary:hover {
            background: #545b62;
        }
        
        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 5px;
        }
        
        .alert-success {
            background-color: #d4edda;
            border-color: #c3e6cb;
            color: #155724;
        }
        
        .alert-danger {
            background-color: #f8d7da;
            border-color: #f5c6cb;
            color: #721c24;
        }
        
        .alert-warning {
            background-color: #fff3cd;
            border-color: #ffeaa7;
            color: #856404;
        }
        

        
        .loading {
            display: none;
            color: #007bff;
            font-style: italic;
        }
        
        .entries-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            font-size: 14px;
        }
        
        .entries-table th,
        .entries-table td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        
        .entries-table th {
            background-color: #f8f9fa;
            font-weight: 600;
            color: #333;
        }
        
        .entries-table tr:hover {
            background-color: #f5f5f5;
        }
        
        .btn-remove {
            background: #dc3545;
            color: white;
            border: none;
            padding: 5px 10px;
            border-radius: 3px;
            cursor: pointer;
            font-size: 12px;
        }
        
        .btn-remove:hover {
            background: #c82333;
        }
        
        .grand-total-section {
            background: #e8f5e8;
            border: 2px solid #28a745;
            padding: 20px;
            border-radius: 8px;
            margin-top: 20px;
        }
        
        .grand-total-section h3 {
            color: #28a745;
            margin-top: 0;
        }
        
        .grand-total-section .total-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 0;
            border-bottom: 1px solid #ddd;
        }
        
        .grand-total-section .total-row:last-child {
            border-bottom: none;
            font-weight: bold;
            font-size: 18px;
            color: #28a745;
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
        <div class="purchase-form">
            <h2>Purchase Entry Dashboard</h2>
            
            <div id="alert-container"></div>
            
            <form id="purchaseForm">
                <div class="form-section">
                    <h3>Party Information</h3>
                    <div class="form-row">
                        <div class="form-group">
                            <label for="partySelect">Select Party *</label>
                            <select id="partySelect" name="partyId" required>
                                <option value="">-- Select Party --</option>
                            </select>
                            <div class="loading" id="partyLoading">Loading parties...</div>
                        </div>
                        <div class="form-group">
                            <label for="partyDetails">Party Information</label>
                            <input type="text" id="partyDetails" readonly placeholder="GST, Phone, and other details will appear here">
                        </div>
                    </div>
                </div>

                <div class="form-section">
                    <h3>Item Information</h3>
                    <div class="form-row">
                        <div class="form-group">
                            <label for="itemCode">Item Code *</label>
                            <input type="text" id="itemCode" name="itemCode" required placeholder="Enter item code">
                        </div>
                        <div class="form-group">
                            <label for="itemName">Item Name *</label>
                            <input type="text" id="itemName" name="itemName" required placeholder="Enter item name">
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label for="category">Category *</label>
                            <input type="text" id="category" name="category" required placeholder="Enter category">
                        </div>
                        <div class="form-group">
                            <label for="subCategory">Sub Category *</label>
                            <input type="text" id="subCategory" name="subCategory" required placeholder="Enter sub category">
                        </div>
                    </div>
                </div>

                <div class="form-section">
                    <h3>Purchase Details</h3>
                    <div class="form-row">
                        <div class="form-group">
                            <label for="quantity">Quantity *</label>
                            <input type="number" id="quantity" name="quantity" required min="1" placeholder="Enter quantity">
                        </div>
                        <div class="form-group">
                            <label for="wholesalePrice">Wholesale Price *</label>
                            <input type="number" id="wholesalePrice" name="wholesalePrice" required min="0.01" step="0.01" placeholder="Enter wholesale price">
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label for="purchasePrice">Purchase Price *</label>
                            <input type="number" id="purchasePrice" name="purchasePrice" required min="0.01" step="0.01" placeholder="Enter purchase price">
                        </div>
                        <div class="form-group">
                            <label for="discountPercentage">Discount Percentage</label>
                            <input type="number" id="discountPercentage" name="discountPercentage" min="0" max="100" step="0.01" placeholder="Auto-calculated" readonly>
                        </div>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="totalAmount">Total Amount</label>
                        <input type="number" id="totalAmount" name="totalAmount" min="0" step="0.01" placeholder="Auto-calculated" readonly>
                    </div>
                </div>
                
                <div class="form-section">
                    <h3>Add Entry to List</h3>
                    <div style="text-align: center; margin: 20px 0;">
                        <button type="button" class="btn-primary" onclick="addEntryToList()">Add Entry to List</button>
                    </div>
                </div>
                
                <div class="form-section" id="entriesListSection" style="display: none;">
                    <h3>Purchase Entries List</h3>
                    <div class="table-container">
                        <table class="entries-table">
                            <thead>
                                <tr>
                                    <th>Item Code</th>
                                    <th>Item Name</th>
                                    <th>Category</th>
                                    <th>Quantity</th>
                                    <th>Wholesale Price</th>
                                    <th>Purchase Price</th>
                                    <th>Discount %</th>
                                    <th>Total</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody id="entriesTableBody">
                            </tbody>
                        </table>
                    </div>
                    
                    <div class="grand-total-section">
                        <h3>Grand Total</h3>
                        <div class="total-row">
                            <span>Total Items:</span>
                            <span id="totalItems">0</span>
                        </div>
                        <div class="total-row">
                            <span>Total Amount:</span>
                            <span id="grandTotal">₹0.00</span>
                        </div>
                    </div>
                </div>

                            <div style="text-align: center; margin-top: 30px;">
                <button type="submit" class="btn-primary">Save Purchase Entry</button>
                <button type="button" class="btn-secondary" onclick="resetForm()">Reset Form</button>
                <button type="button" class="btn-secondary" onclick="testAPI()" style="margin-left: 10px;">Test API</button>
                <button type="button" class="btn-secondary" onclick="testTable()" style="margin-left: 10px;">Test Table</button>
                <button type="button" class="btn-secondary" onclick="testPartyData()" style="margin-left: 10px;">Test Party Data</button>
            </div>
            </form>
        </div>
    </div>

    <script>
                // Global variables
        let parties = [];
        let purchaseEntries = [];
        
        // Load parties on page load
        document.addEventListener('DOMContentLoaded', function() {
            loadParties();
            setupEventListeners();
        });

        function loadParties() {
            const partySelect = document.getElementById('partySelect');
            const partyLoading = document.getElementById('partyLoading');
            
            partyLoading.style.display = 'block';
            console.log('Loading parties from:', '${pageContext.request.contextPath}/purchase-entry/api/parties');
            
            fetch('${pageContext.request.contextPath}/purchase-entry/api/parties')
                .then(response => {
                    console.log('Response status:', response.status);
                    console.log('Response headers:', response.headers);
                    return response.json();
                })
                .then(partiesData => {
                    console.log('Parties loaded:', partiesData);
                    console.log('First party structure:', partiesData[0]);
                    
                    // Store parties globally
                    parties = partiesData;
                    
                    partySelect.innerHTML = '<option value="">-- Select Party --</option>';
                    if (parties && parties.length > 0) {
                        parties.forEach((party, index) => {
                            console.log(`Party ${index}:`, party);
                            const option = document.createElement('option');
                            option.value = party.partyId;
                            option.textContent = party.partyName;
                            partySelect.appendChild(option);
                        });
                    } else {
                        console.log('No parties found in response');
                        partySelect.innerHTML = '<option value="">-- No Parties Available --</option>';
                    }
                    partyLoading.style.display = 'none';
                })
                .catch(error => {
                    console.error('Error loading parties:', error);
                    partyLoading.style.display = 'none';
                    showAlert('Error loading parties. Please try again.', 'danger');
                    partySelect.innerHTML = '<option value="">-- Error Loading Parties --</option>';
                });
        }

        function setupEventListeners() {
            // Party selection change
            document.getElementById('partySelect').addEventListener('change', function() {
                const selectedOption = this.options[this.selectedIndex];
                const partyDetails = document.getElementById('partyDetails');
                if (this.value) {
                    // Find the selected party object to get full details
                    const selectedPartyId = this.value;
                    console.log('Selected party ID:', selectedPartyId);
                    console.log('Available parties:', parties);
                    
                    const selectedParty = parties.find(p => p.partyId == selectedPartyId);
                    console.log('Found selected party:', selectedParty);
                    
                    if (selectedParty) {
                        // Handle different possible property names and log all properties
                        console.log('Selected party object:', selectedParty);
                        console.log('All party properties:', Object.keys(selectedParty));
                        
                        // Try to get party name
                        let partyName = selectedParty.partyName;
                        if (!partyName) {
                            partyName = selectedParty.partyname || selectedParty.name || selectedParty.party_name || 'N/A';
                        }
                        
                        // Try to get GST number
                        let gstNo = selectedParty.gstNo;
                        if (!gstNo) {
                            gstNo = selectedParty.gstno || selectedParty.gst || selectedParty.gst_no || 'N/A';
                        }
                        
                        // Try to get phone number
                        let phoneNumber = selectedParty.phoneNumber;
                        if (!phoneNumber) {
                            phoneNumber = selectedParty.phonenumber || selectedParty.phone || selectedParty.phone_number || 'N/A';
                        }
                        
                        console.log('Extracted values - Name:', partyName, 'GST:', gstNo, 'Phone:', phoneNumber);
                        
                        const partyInfo = `${partyName} - GST: ${gstNo} - Phone: ${phoneNumber}`;
                        console.log('Setting party info:', partyInfo);
                        partyDetails.value = partyInfo;
                    } else {
                        console.log('Party not found in array, using option text');
                        partyDetails.value = selectedOption.textContent;
                    }
                } else {
                    partyDetails.value = '';
                }
            });

            // Quantity and price change for total calculation and discount
            document.getElementById('quantity').addEventListener('input', calculateTotalAndDiscount);
            document.getElementById('wholesalePrice').addEventListener('input', calculateTotalAndDiscount);
            document.getElementById('purchasePrice').addEventListener('input', calculateTotalAndDiscount);
        }

        function calculateTotalAndDiscount() {
            const quantity = parseFloat(document.getElementById('quantity').value) || 0;
            const wholesalePrice = parseFloat(document.getElementById('wholesalePrice').value) || 0;
            const purchasePrice = parseFloat(document.getElementById('purchasePrice').value) || 0;

            // Auto-calculate discount percentage
            let discountPercentage = 0;
            if (wholesalePrice > 0 && purchasePrice > 0) {
                discountPercentage = ((wholesalePrice - purchasePrice) / wholesalePrice) * 100;
                discountPercentage = Math.max(0, Math.min(100, discountPercentage)); // Clamp between 0-100
            }
            
            // Set the calculated discount percentage
            document.getElementById('discountPercentage').value = discountPercentage.toFixed(2);

            // Calculate total amount (Purchase Price × Quantity)
            const totalAmount = quantity * purchasePrice;
            document.getElementById('totalAmount').value = totalAmount.toFixed(2);
        }

        function resetForm() {
            document.getElementById('purchaseForm').reset();
            document.getElementById('partyDetails').value = '';
            
            // Clear entries list
            purchaseEntries = [];
            document.getElementById('entriesListSection').style.display = 'none';
            updateEntriesTable();
            updateGrandTotal();
            
            calculateTotalAndDiscount();
            showAlert('Form has been reset.', 'success');
        }

        function showAlert(message, type) {
            const alertContainer = document.getElementById('alert-container');
            const alertDiv = document.createElement('div');
            alertDiv.className = `alert alert-${type}`;
            alertDiv.textContent = message;
            
            alertContainer.appendChild(alertDiv);
            
            // Auto-remove after 5 seconds
            setTimeout(() => {
                alertDiv.remove();
            }, 5000);
        }
        
        function testAPI() {
            console.log('Testing API endpoint...');
            fetch('${pageContext.request.contextPath}/purchase-entry/api/test')
                .then(response => response.json())
                .then(data => {
                    console.log('Test API response:', data);
                    showAlert('API test successful: ' + data.message, 'success');
                })
                .catch(error => {
                    console.error('Test API error:', error);
                    showAlert('API test failed: ' + error.message, 'danger');
                });
        }
        
        function testTable() {
            console.log('Testing table functionality...');
            
            // Create a test entry
            const testEntry = {
                partyId: '1',
                itemCode: 'TEST001',
                itemName: 'Test Item',
                category: 'Test Category',
                subCategory: 'Test Sub Category',
                quantity: 5,
                wholesalePrice: 100,
                purchasePrice: 80,
                discountPercentage: 20,
                total: 400
            };
            
            console.log('Adding test entry:', testEntry);
            purchaseEntries.push(testEntry);
            
            // Show entries section
            document.getElementById('entriesListSection').style.display = 'block';
            
            // Update display
            updateEntriesTable();
            updateGrandTotal();
            
            showAlert('Test entry added! Check console for details.', 'success');
        }
        
        function testPartyData() {
            console.log('=== PARTY DATA TEST ===');
            console.log('Global parties array:', parties);
            console.log('Parties length:', parties ? parties.length : 'undefined');
            
            if (parties && parties.length > 0) {
                console.log('First party object:', parties[0]);
                console.log('First party keys:', Object.keys(parties[0]));
                console.log('First party values:', Object.values(parties[0]));
                
                // Test property access with more variations
                const firstParty = parties[0];
                console.log('=== PROPERTY ACCESS TEST ===');
                console.log('partyName:', firstParty.partyName);
                console.log('partyname:', firstParty.partyname);
                console.log('name:', firstParty.name);
                console.log('party_name:', firstParty.party_name);
                console.log('gstNo:', firstParty.gstNo);
                console.log('gstno:', firstParty.gstno);
                console.log('gst:', firstParty.gst);
                console.log('gst_no:', firstParty.gst_no);
                console.log('phoneNumber:', firstParty.phoneNumber);
                console.log('phonenumber:', firstParty.phonenumber);
                console.log('phone:', firstParty.phone);
                console.log('phone_number:', firstParty.phone_number);
                
                // Test JSON stringify to see exact structure
                console.log('Raw JSON:', JSON.stringify(firstParty, null, 2));
            } else {
                console.log('No parties available');
            }
            
            // Test current selection
            const partySelect = document.getElementById('partySelect');
            const selectedIndex = partySelect.selectedIndex;
            console.log('Selected index:', selectedIndex);
            if (selectedIndex > 0) {
                const selectedOption = partySelect.options[selectedIndex];
                console.log('Selected option value:', selectedOption.value);
                console.log('Selected option text:', selectedOption.textContent);
            }
            
            showAlert('Party data test completed! Check console for details.', 'success');
        }
        
        function addEntryToList() {
            // Validate required fields
            const partyId = document.getElementById('partySelect').value;
            const itemCode = document.getElementById('itemCode').value;
            const itemName = document.getElementById('itemName').value;
            const category = document.getElementById('category').value;
            const subCategory = document.getElementById('subCategory').value;
            const quantity = parseFloat(document.getElementById('quantity').value);
            const wholesalePrice = parseFloat(document.getElementById('wholesalePrice').value);
            const purchasePrice = parseFloat(document.getElementById('purchasePrice').value);
            
            console.log('Form values:', {
                partyId, itemCode, itemName, category, subCategory, 
                quantity, wholesalePrice, purchasePrice
            });
            
            if (!partyId || !itemCode || !itemName || !category || !subCategory || !quantity || !wholesalePrice || !purchasePrice) {
                showAlert('Please fill in all required fields before adding entry.', 'danger');
                return;
            }
            
            // Create entry object
            const entry = {
                partyId: partyId,
                itemCode: itemCode,
                itemName: itemName,
                category: category,
                subCategory: subCategory,
                quantity: quantity,
                wholesalePrice: wholesalePrice,
                purchasePrice: purchasePrice,
                discountPercentage: parseFloat(document.getElementById('discountPercentage').value) || 0,
                total: parseFloat(document.getElementById('totalAmount').value) || 0
            };
            
            console.log('Created entry object:', entry);
            
            // Add to entries list
            purchaseEntries.push(entry);
            console.log('Updated purchaseEntries array:', purchaseEntries);
            
            // Update display
            updateEntriesTable();
            updateGrandTotal();
            
            // Show entries section
            document.getElementById('entriesListSection').style.display = 'block';
            
            // Clear form for next entry
            clearEntryForm();
            
            showAlert('Entry added to list successfully!', 'success');
        }
        
        function updateEntriesTable() {
            const tbody = document.getElementById('entriesTableBody');
            if (!tbody) {
                console.error('Table body element not found!');
                return;
            }
            
            tbody.innerHTML = '';
            console.log('Updating entries table with:', purchaseEntries);
            
            if (purchaseEntries.length === 0) {
                console.log('No entries to display');
                return;
            }
            
            purchaseEntries.forEach((entry, index) => {
                console.log('Creating row for entry:', entry);
                
                // Create row element
                const row = document.createElement('tr');
                
                // Create individual cells
                const itemCodeCell = document.createElement('td');
                itemCodeCell.textContent = entry.itemCode || '';
                
                const itemNameCell = document.createElement('td');
                itemNameCell.textContent = entry.itemName || '';
                
                const categoryCell = document.createElement('td');
                categoryCell.textContent = entry.category || '';
                
                const quantityCell = document.createElement('td');
                quantityCell.textContent = entry.quantity || 0;
                
                const wholesalePriceCell = document.createElement('td');
                wholesalePriceCell.textContent = '₹' + (entry.wholesalePrice || 0);
                
                const purchasePriceCell = document.createElement('td');
                purchasePriceCell.textContent = '₹' + (entry.purchasePrice || 0);
                
                const discountCell = document.createElement('td');
                discountCell.textContent = (entry.discountPercentage || 0).toFixed(2) + '%';
                
                const totalCell = document.createElement('td');
                totalCell.textContent = '₹' + (entry.total || 0).toFixed(2);
                
                const actionCell = document.createElement('td');
                const removeButton = document.createElement('button');
                removeButton.type = 'button';
                removeButton.className = 'btn-remove';
                removeButton.textContent = 'Remove';
                removeButton.onclick = function() { removeEntry(index); };
                actionCell.appendChild(removeButton);
                
                // Append cells to row
                row.appendChild(itemCodeCell);
                row.appendChild(itemNameCell);
                row.appendChild(categoryCell);
                row.appendChild(quantityCell);
                row.appendChild(wholesalePriceCell);
                row.appendChild(purchasePriceCell);
                row.appendChild(discountCell);
                row.appendChild(totalCell);
                row.appendChild(actionCell);
                
                // Append row to table
                tbody.appendChild(row);
                console.log('Row added to table:', row);
            });
        }
        
        function updateGrandTotal() {
            const totalItems = purchaseEntries.length;
            const grandTotal = purchaseEntries.reduce((sum, entry) => sum + entry.total, 0);
            
            document.getElementById('totalItems').textContent = totalItems;
            document.getElementById('grandTotal').textContent = '₹' + grandTotal.toFixed(2);
        }
        
        function removeEntry(index) {
            purchaseEntries.splice(index, 1);
            updateEntriesTable();
            updateGrandTotal();
            
            if (purchaseEntries.length === 0) {
                document.getElementById('entriesListSection').style.display = 'none';
            }
            
            showAlert('Entry removed from list.', 'success');
        }
        
        function clearEntryForm() {
            document.getElementById('itemCode').value = '';
            document.getElementById('itemName').value = '';
            document.getElementById('category').value = '';
            document.getElementById('subCategory').value = '';
            document.getElementById('quantity').value = '';
            document.getElementById('wholesalePrice').value = '';
            document.getElementById('purchasePrice').value = '';
            document.getElementById('discountPercentage').value = '';
            document.getElementById('totalAmount').value = '';
            
            // Reset calculations
            calculateTotalAndDiscount();
        }

        // Form submission
        document.getElementById('purchaseForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            // Check if there are entries to submit
            if (purchaseEntries.length === 0) {
                showAlert('Please add at least one entry to the list before submitting.', 'danger');
                return;
            }
            
            // Validate party selection
            const partyId = document.getElementById('partySelect').value;
            if (!partyId) {
                showAlert('Please select a party before submitting.', 'danger');
                return;
            }
            
            // Submit all entries
            submitAllEntries();
        });
        
        function submitAllEntries() {
            const partyId = document.getElementById('partySelect').value;
            const partyName = document.getElementById('partySelect').options[document.getElementById('partySelect').selectedIndex].text;
            
            showAlert(`Submitting ${purchaseEntries.length} entries for party: ${partyName}`, 'success');
            
            // Prepare bulk data
            const bulkData = purchaseEntries.map(entry => ({
                partyId: partyId,
                itemCode: entry.itemCode,
                itemName: entry.itemName,
                category: entry.category,
                subCategory: entry.subCategory,
                quantity: entry.quantity,
                wholesalePrice: entry.wholesalePrice,
                purchasePrice: entry.purchasePrice,
                discountPercentage: entry.discountPercentage
            }));
            
            // Submit all entries at once
            fetch('${pageContext.request.contextPath}/purchase-entry/api/purchase-entries-bulk', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(bulkData)
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    if (data.partialSuccess) {
                        showAlert(`${data.message}. Some entries failed.`, 'warning');
                        if (data.errors) {
                            console.log('Errors:', data.errors);
                        }
                    } else {
                        showAlert(`${data.message}!`, 'success');
                    }
                    resetForm();
                } else {
                    showAlert(data.message || 'Error saving entries.', 'danger');
                    if (data.errors) {
                        console.log('Errors:', data.errors);
                    }
                }
            })
            .catch(error => {
                console.error('Bulk save error:', error);
                showAlert('Error saving entries. Please try again.', 'danger');
            });
        }
    </script>
</body>
</html>
