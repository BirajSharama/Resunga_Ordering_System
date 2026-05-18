<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.ResungaIndustries.model.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard | Resunga Industries</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #faf9f8;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        .navbar {
            background: #008080;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            padding: 0 5%;
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .navbar-container {
            max-width: 1600px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 0;
        }

        .navbar-brand {
            display: flex;
            align-items: center;
            gap: 12px;
            text-decoration: none;
        }

        .logo-circle {
            width: 45px;
            height: 45px;
            background: white;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #008080;
            font-weight: bold;
            font-size: 18px;
        }

        .brand-text h2 {
            font-size: 18px;
            color: white;
            margin-bottom: 2px;
        }

        .brand-text p {
            font-size: 10px;
            color: #b2dfdb;
        }

        .nav-links {
            display: flex;
            gap: 30px;
            align-items: center;
        }

        .nav-links a {
            text-decoration: none;
            color: white;
            font-weight: 500;
            transition: color 0.3s;
            font-size: 14px;
        }

        .nav-links a:hover {
            color: #ff6b4a;
        }

        .nav-links a.active {
            color: #ff6b4a;
            font-weight: 600;
        }

        .user-section {
            display: flex;
            align-items: center;
            gap: 20px;
            margin-left: 20px;
            padding-left: 20px;
            border-left: 1px solid #4db6ac;
        }

        .user-name {
            font-weight: 600;
            color: white;
        }

        .logout-btn {
            background: #e74c3c;
            color: white;
            padding: 8px 20px;
            border-radius: 6px;
            text-decoration: none;
            font-weight: 500;
            transition: background 0.3s;
            font-size: 13px;
        }

        .logout-btn:hover {
            background: #c0392b;
        }

        .main-container {
            flex: 1;
            max-width: 1600px;
            margin: 0 auto;
            padding: 30px 5%;
            width: 100%;
        }

        .page-header {
            margin-bottom: 30px;
        }

        .page-title {
            font-size: 28px;
            font-weight: 700;
            color: #008080;
            margin-bottom: 8px;
        }

        .page-subtitle {
            color: #5a6c7e;
            font-size: 14px;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 24px;
            margin-bottom: 40px;
        }

        .stat-card {
            background: white;
            padding: 24px 20px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            transition: transform 0.2s, box-shadow 0.2s;
            border-left: 4px solid #008080;
        }

        .stat-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.1);
        }

        .stat-card.pending {
            border-left-color: #ff6b4a;
        }

        .stat-number {
            font-size: 36px;
            font-weight: 700;
            color: #2c3e50;
            margin-bottom: 8px;
        }

        .stat-label {
            font-size: 14px;
            color: #5a6c7e;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            margin-bottom: 30px;
            overflow: hidden;
            border: 1px solid #e0e0e0;
        }

        .card-header {
            padding: 20px 25px;
            border-bottom: 1px solid #e0e0e0;
            background: #faf9f8;
        }

        .card-header h2 {
            font-size: 20px;
            color: #008080;
            margin: 0;
        }

        .card-body {
            padding: 25px;
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
        }

        .input-group {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .input-group label {
            font-size: 13px;
            font-weight: 600;
            color: #2c3e50;
        }

        .input-group input,
        .input-group select,
        .input-group textarea {
            padding: 10px 12px;
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            font-size: 14px;
            transition: border-color 0.3s;
        }

        .input-group input:focus,
        .input-group select:focus,
        .input-group textarea:focus {
            outline: none;
            border-color: #008080;
        }

        .table-wrapper {
            overflow-x: auto;
        }

        .data-table {
            width: 100%;
            border-collapse: collapse;
        }

        .data-table thead {
            background: #faf9f8;
        }

        .data-table th {
            padding: 16px 15px;
            text-align: left;
            font-weight: 600;
            color: #008080;
            font-size: 13px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            border-bottom: 2px solid #e0e0e0;
        }

        .data-table td {
            padding: 16px 15px;
            border-bottom: 1px solid #f0f0f0;
            color: #2c3e50;
            vertical-align: middle;
        }

        .data-table tr:hover {
            background: #faf9f8;
        }

        .btn {
            padding: 8px 16px;
            border-radius: 6px;
            font-size: 13px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s;
            border: none;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .btn-primary {
            background: #008080;
            color: white;
        }

        .btn-primary:hover {
            background: #006666;
        }

        .btn-edit {
            background: #2ecc71;
            color: white;
        }

        .btn-edit:hover {
            background: #27ae60;
        }

        .btn-danger {
            background: #e74c3c;
            color: white;
        }

        .btn-danger:hover {
            background: #c0392b;
        }

        .action-group {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
        }

        .badge {
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 600;
            display: inline-block;
        }

        .badge-warning {
            background: #fef5e7;
            color: #f39c12;
        }

        .badge-info {
            background: #e8f4f8;
            color: #008080;
        }

        .badge-success {
            background: #e8f8f0;
            color: #2ecc71;
        }

        .badge-danger {
            background: #fdedec;
            color: #e74c3c;
        }

        .footer {
            background: #2c3e50;
            text-align: center;
            padding: 20px;
            color: white;
            font-size: 13px;
            margin-top: auto;
        }

        @media (max-width: 768px) {
            .form-grid {
                grid-template-columns: 1fr;
            }
            
            .stats-grid {
                grid-template-columns: 1fr;
            }
            
            .navbar-container {
                flex-direction: column;
                gap: 15px;
            }
        }
    </style>
</head>
<body>

<div class="navbar">
    <div class="navbar-container">
        <a href="${pageContext.request.contextPath}/admin" class="navbar-brand">
            <div class="logo-circle">RI</div>
            <div class="brand-text">
                <h2>RESUNGA INDUSTRIES</h2>
                <p>Admin Console</p>
            </div>
        </a>
        <div style="display: flex; align-items: center;">
            <div class="nav-links">
                <a href="${pageContext.request.contextPath}/admin" class="active">Dashboard</a>
                <a href="${pageContext.request.contextPath}/about">About</a>
                <a href="${pageContext.request.contextPath}/contact">Contact</a>
            </div>
            <div class="user-section">
                <span class="user-name">Admin</span>
                <a href="${pageContext.request.contextPath}/logout" class="logout-btn">Logout</a>
            </div>
        </div>
    </div>
</div>

<div class="main-container">
    <div class="page-header">
        <div class="page-title">Admin Dashboard</div>
        <div class="page-subtitle">Manage products, orders, and customers</div>
    </div>

    <%
        List<Product> allProducts = (List<Product>) request.getAttribute("products");
        List<Order> allOrders = (List<Order>) request.getAttribute("orders");
        List<User> allUsers = (List<User>) request.getAttribute("users");

        int totalProducts = (allProducts != null) ? allProducts.size() : 0;
        int totalOrders = (allOrders != null) ? allOrders.size() : 0;
        int totalUsers = (allUsers != null) ? allUsers.size() : 0;
        int pendingOrders = 0;
        
        if (allOrders != null) {
            for (Order o : allOrders) {
                if ("Pending".equals(o.getStatus())) {
                    pendingOrders++;
                }
            }
        }
    %>

    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-number"><%= totalProducts %></div>
            <div class="stat-label">Total Products</div>
        </div>
        <div class="stat-card pending">
            <div class="stat-number"><%= pendingOrders %></div>
            <div class="stat-label">Pending Orders</div>
        </div>
        <div class="stat-card">
            <div class="stat-number"><%= totalOrders %></div>
            <div class="stat-label">Total Orders</div>
        </div>
        <div class="stat-card">
            <div class="stat-number"><%= totalUsers %></div>
            <div class="stat-label">Registered Customers</div>
        </div>
    </div>

    <!-- Add Product Section -->
    <div class="card">
        <div class="card-header">
            <h2>Add New Flex Roll Product</h2>
        </div>
        <div class="card-body">
            <form action="${pageContext.request.contextPath}/admin" method="post">
                <input type="hidden" name="action" value="addProduct">
                <div class="form-grid">
                    <div class="input-group">
                        <label>Product Name</label>
                        <input type="text" name="name" placeholder="e.g. Glossy Flex Roll" required>
                    </div>
                    <div class="input-group">
                        <label>Category</label>
                        <select name="category" required>
                            <option value="">-- Select Category --</option>
                            <option value="Glossy">Glossy</option>
                            <option value="Matte">Matte</option>
                            <option value="Backlit">Backlit</option>
                            <option value="Star">Star</option>
                            <option value="Cold Lamination">Cold Lamination</option>
                        </select>
                    </div>
                    <div class="input-group">
                        <label>GSM Rating</label>
                        <select name="gsm" required>
                            <option value="280">280 GSM</option>
                            <option value="300">300 GSM</option>
                        </select>
                    </div>
                    <div class="input-group">
                        <label>Price per Sq.Ft (NPR)</label>
                        <input type="number" step="0.01" name="price" placeholder="e.g. 45.00" required>
                    </div>
                    <div class="input-group">
                        <label>Initial Stock (Sq.Ft)</label>
                        <input type="number" step="0.01" name="stock" placeholder="e.g. 5000.00" required>
                    </div>
                    <div class="input-group">
                        <label>Description</label>
                        <input type="text" name="description" placeholder="Short product description">
                    </div>
                </div>
                <div style="margin-top: 24px;">
                    <button type="submit" class="btn btn-primary">Add Product</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Product Catalog -->
    <div class="card">
        <div class="card-header">
            <h2>Flex Roll Catalog</h2>
        </div>
        <div class="table-wrapper">
            <table class="data-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Product Name</th>
                        <th>Category</th>
                        <th>GSM</th>
                        <th>Price</th>
                        <th>Stock</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    if (allProducts != null && !allProducts.isEmpty()) {
                        for (Product p : allProducts) {
                            boolean lowStock = p.getStockSqFt() < 500;
                %>
                    <tr>
                        <td>#<%= p.getId() %></td>
                        <td><strong><%= p.getName() %></strong></td>
                        <td><%= p.getCategory() %></td>
                        <td><%= p.getGsm() %> GSM</td>
                        <td>NPR <%= String.format("%.2f", p.getPricePerSqFt()) %></td>
                        <td style="color: <%= lowStock ? "#f39c12" : "#2ecc71" %>; font-weight: 600;">
                            <%= String.format("%.2f", p.getStockSqFt()) %> sq.ft
                        </td>
                        <td>
                            <span class="badge <%= lowStock ? "badge-warning" : "badge-success" %>">
                                <%= lowStock ? "Low Stock" : "In Stock" %>
                            </span>
                        </td>
                        <td>
                            <div class="action-group">
                                <form action="${pageContext.request.contextPath}/admin" method="post" style="display: inline;">
                                    <input type="hidden" name="action" value="editProduct">
                                    <input type="hidden" name="id" value="<%= p.getId() %>">
                                    <input type="hidden" name="name" value="<%= p.getName() %>">
                                    <input type="hidden" name="category" value="<%= p.getCategory() %>">
                                    <input type="hidden" name="gsm" value="<%= p.getGsm() %>">
                                    <input type="hidden" name="description" value="<%= (p.getDescription() != null) ? p.getDescription() : "" %>">
                                    <input type="number" name="price" value="<%= p.getPricePerSqFt() %>" step="0.01" style="width: 80px; padding: 6px;">
                                    <input type="number" name="stock" value="<%= p.getStockSqFt() %>" step="0.01" style="width: 80px; padding: 6px;">
                                    <button type="submit" class="btn btn-edit">Update</button>
                                </form>
                                <form action="${pageContext.request.contextPath}/admin" method="post" style="display: inline;" onsubmit="return confirm('Delete this product?');">
                                    <input type="hidden" name="action" value="deleteProduct">
                                    <input type="hidden" name="id" value="<%= p.getId() %>">
                                    <button type="submit" class="btn btn-danger">Delete</button>
                                </form>
                            </div>
                        </td>
                    </tr>
                <%
                        }
                    } else {
                %>
                    <tr>
                        <td colspan="8" style="text-align: center; padding: 60px;">No products found. Add one above.</td>
                    </tr>
                <%
                    }
                %>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Orders Section -->
    <div class="card">
        <div class="card-header">
            <h2>Customer Orders</h2>
        </div>
        <div class="table-wrapper">
            <table class="data-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Customer</th>
                        <th>Product</th>
                        <th>Sq.Ft</th>
                        <th>Total</th>
                        <th>Fine</th>
                        <th>Date</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    if (allOrders != null && !allOrders.isEmpty()) {
                        for (Order o : allOrders) {
                            String badgeClass = "";
                            if ("Pending".equals(o.getStatus())) {
                                badgeClass = "badge-warning";
                            } else if ("Confirmed".equals(o.getStatus())) {
                                badgeClass = "badge-info";
                            } else if ("Delivered".equals(o.getStatus())) {
                                badgeClass = "badge-success";
                            } else {
                                badgeClass = "badge-danger";
                            }
                %>
                    <tr>
                        <td>#<%= o.getId() %></td>
                        <td><strong><%= o.getCustomerName() %></strong></td>
                        <td><%= o.getProductName() %></td>
                        <td><%= o.getSquareFeet() %></td>
                        <td>NPR <%= String.format("%.2f", o.getTotalPrice()) %></td>
                        <td style="color: #e74c3c;"><%= (o.getFineAmount() > 0) ? "NPR " + String.format("%.2f", o.getFineAmount()) : "—" %></td>
                        <td style="font-size: 12px;"><%= o.getOrderDate() %></td>
                        <td><span class="badge <%= badgeClass %>"><%= o.getStatus() %></span></td>
                        <td>
                            <div class="action-group">
                                <form action="${pageContext.request.contextPath}/admin" method="post" style="display: inline;">
                                    <input type="hidden" name="action" value="updateOrderStatus">
                                    <input type="hidden" name="orderId" value="<%= o.getId() %>">
                                    <select name="status" style="padding: 6px;">
                                        <option value="Pending" <%= "Pending".equals(o.getStatus()) ? "selected" : "" %>>Pending</option>
                                        <option value="Confirmed" <%= "Confirmed".equals(o.getStatus()) ? "selected" : "" %>>Confirmed</option>
                                        <option value="Delivered" <%= "Delivered".equals(o.getStatus()) ? "selected" : "" %>>Delivered</option>
                                        <option value="Cancelled" <%= "Cancelled".equals(o.getStatus()) ? "selected" : "" %>>Cancelled</option>
                                    </select>
                                    <button type="submit" class="btn btn-edit">Update</button>
                                </form>
                                <form action="${pageContext.request.contextPath}/admin" method="post" style="display: inline;">
                                    <input type="hidden" name="action" value="applyFine">
                                    <input type="hidden" name="orderId" value="<%= o.getId() %>">
                                    <input type="number" name="fineAmount" step="0.01" placeholder="Fine" style="width: 80px; padding: 6px;">
                                    <button type="submit" class="btn btn-danger">Apply</button>
                                </form>
                            </div>
                        </td>
                    </tr>
                <%
                        }
                    } else {
                %>
                    <tr>
                        <td colspan="9" style="text-align: center; padding: 60px;">No orders placed yet.</td>
                    </tr>
                <%
                    }
                %>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Customers Section -->
    <div class="card">
        <div class="card-header">
            <h2>Registered Customers</h2>
        </div>
        <div class="table-wrapper">
            <table class="data-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Full Name</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    if (allUsers != null && !allUsers.isEmpty()) {
                        for (User u : allUsers) {
                %>
                    <tr>
                        <td>#<%= u.getId() %></td>
                        <td><strong><%= u.getFullName() %></strong></td>
                        <td><%= u.getEmail() %></td>
                        <td><%= u.getPhone() %></td>
                        <td>
                            <form action="${pageContext.request.contextPath}/admin" method="post" onsubmit="return confirm('Remove this customer?');">
                                <input type="hidden" name="action" value="deleteUser">
                                <input type="hidden" name="userId" value="<%= u.getId() %>">
                                <button type="submit" class="btn btn-danger">Remove</button>
                            </form>
                        </td>
                    </tr>
                <%
                        }
                    } else {
                %>
                    <tr>
                        <td colspan="5" style="text-align: center; padding: 60px;">No customers registered yet.</td>
                    </tr>
                <%
                    }
                %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<div class="footer">
    &copy; 2025 Resunga Industries Pvt. Ltd. — Butwal, Lumbini Province, Nepal. All Rights Reserved.
</div>

</body>
</html>