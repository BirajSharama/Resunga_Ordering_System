<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.ResungaIndustries.model.Order" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Orders | Resunga Industries</title>
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
            flex-wrap: wrap;
            gap: 15px;
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
            flex-wrap: wrap;
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

        .stats-summary {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: white;
            padding: 24px 20px;
            border-radius: 12px;
            text-align: center;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            border: 1px solid #e0e0e0;
            border-left: 4px solid #008080;
        }

        .stat-card.pending {
            border-left-color: #ff6b4a;
        }

        .stat-value {
            font-size: 32px;
            font-weight: 700;
            color: #2c3e50;
            margin-bottom: 8px;
        }

        .stat-label {
            font-size: 13px;
            color: #666;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .page-header {
            background: white;
            border-radius: 12px;
            padding: 25px 30px;
            margin-bottom: 30px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 20px;
            border: 1px solid #e0e0e0;
        }

        .page-title {
            font-size: 24px;
            font-weight: 700;
            color: #008080;
            margin-bottom: 5px;
        }

        .page-subtitle {
            color: #666;
            font-size: 13px;
        }

        .btn-primary {
            background: #ff6b4a;
            color: white;
            padding: 10px 24px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s;
            border: none;
            cursor: pointer;
            display: inline-block;
        }

        .btn-primary:hover {
            background: #ff5230;
            transform: translateY(-1px);
        }

        .card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            overflow: hidden;
            border: 1px solid #e0e0e0;
        }

        .card-header {
            padding: 20px 25px;
            border-bottom: 1px solid #e0e0e0;
            background: #faf9f8;
        }

        .card-header h2 {
            font-size: 18px;
            color: #008080;
            margin: 0;
        }

        .table-wrapper {
            overflow-x: auto;
        }

        .orders-table {
            width: 100%;
            border-collapse: collapse;
            min-width: 800px;
        }

        .orders-table thead {
            background: #f8f9fa;
        }

        .orders-table th {
            padding: 16px 15px;
            text-align: left;
            font-weight: 600;
            color: #008080;
            font-size: 13px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            border-bottom: 2px solid #e0e0e0;
        }

        .orders-table td {
            padding: 16px 15px;
            border-bottom: 1px solid #f0f0f0;
            color: #2c3e50;
            vertical-align: middle;
        }

        .orders-table tr:hover {
            background: #faf9f8;
        }

        .order-id {
            font-weight: 700;
            color: #008080;
        }

        .price {
            font-weight: 700;
            color: #28a745;
        }

        .fine-amount {
            color: #e74c3c;
            font-weight: 600;
        }

        .badge {
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 600;
            display: inline-block;
        }

        .badge-warning {
            background: #fff3cd;
            color: #ff9800;
        }

        .badge-info {
            background: #d1ecf1;
            color: #17a2b8;
        }

        .badge-success {
            background: #d4edda;
            color: #28a745;
        }

        .badge-danger {
            background: #f8d7da;
            color: #dc3545;
        }

        .btn-cancel {
            background: #e74c3c;
            color: white;
            border: none;
            padding: 6px 16px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 12px;
            font-weight: 500;
            transition: all 0.3s;
        }

        .btn-cancel:hover {
            background: #c0392b;
        }

        .alert-success {
            background: #d4edda;
            border-left: 4px solid #28a745;
            padding: 15px 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            color: #155724;
        }

        .empty-state {
            text-align: center;
            padding: 60px 20px;
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
            .navbar-container {
                flex-direction: column;
                text-align: center;
            }
            
            .nav-links {
                justify-content: center;
            }
            
            .page-header {
                flex-direction: column;
                text-align: center;
            }
            
            .stats-summary {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>

<div class="navbar">
    <div class="navbar-container">
        <a href="${pageContext.request.contextPath}/user" class="navbar-brand">
            <div class="logo-circle">RI</div>
            <div class="brand-text">
                <h2>RESUNGA INDUSTRIES</h2>
                <p>Pvt. Ltd. | Butwal, Nepal</p>
            </div>
        </a>
        <div style="display: flex; align-items: center;">
            <div class="nav-links">
                <a href="${pageContext.request.contextPath}/user">Products</a>
                <a href="${pageContext.request.contextPath}/orders" class="active">My Orders</a>
                <a href="${pageContext.request.contextPath}/profile">Profile</a>
                <a href="${pageContext.request.contextPath}/about">About</a>
                <a href="${pageContext.request.contextPath}/contact">Contact</a>
            </div>
            <div class="user-section">
                <span class="user-name"><%= session.getAttribute("userName") %></span>
                <a href="${pageContext.request.contextPath}/logout" class="logout-btn">Logout</a>
            </div>
        </div>
    </div>
</div>

<div class="main-container">
    <%
        List<Order> orders = (List<Order>) request.getAttribute("orders");
        int totalOrders = (orders != null) ? orders.size() : 0;
        int pendingOrders = 0;
        double totalSpent = 0;
        
        if (orders != null && !orders.isEmpty()) {
            for (Order o : orders) {
                if ("Pending".equals(o.getStatus())) {
                    pendingOrders++;
                }
                totalSpent += o.getTotalPrice();
            }
        }
    %>

    <div class="stats-summary">
        <div class="stat-card">
            <div class="stat-value"><%= totalOrders %></div>
            <div class="stat-label">Total Orders</div>
        </div>
        <div class="stat-card pending">
            <div class="stat-value"><%= pendingOrders %></div>
            <div class="stat-label">Pending Orders</div>
        </div>
        <div class="stat-card">
            <div class="stat-value">NPR <%= String.format("%.0f", totalSpent) %></div>
            <div class="stat-label">Total Spent</div>
        </div>
    </div>

    <div class="page-header">
        <div>
            <div class="page-title">My Orders</div>
            <div class="page-subtitle">Track and manage all your orders</div>
        </div>
        <a href="${pageContext.request.contextPath}/user" class="btn-primary">Browse Products</a>
    </div>

    <% if(request.getAttribute("success") != null) { %>
        <div class="alert-success"><%= request.getAttribute("success") %></div>
    <% } %>

    <div class="card">
        <div class="card-header">
            <h2>Order History</h2>
        </div>
        <div class="table-wrapper">
            <table class="orders-table">
                <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Product</th>
                        <th>Quantity</th>
                        <th>GSM</th>
                        <th>Total Amount</th>
                        <th>Fine</th>
                        <th>Order Date</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    if (orders != null && !orders.isEmpty()) {
                        for (Order o : orders) {
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
                        <td class="order-id">#<%= o.getId() %></td>
                        <td><strong><%= o.getProductName() %></strong></td>
                        <td><%= String.format("%.2f", o.getSquareFeet()) %> sq.ft</td>
                        <td><%= o.getGsm() %> GSM</td>
                        <td class="price">NPR <%= String.format("%.2f", o.getTotalPrice()) %></td>
                        <td class="fine-amount"><%= (o.getFineAmount() > 0) ? "NPR " + String.format("%.2f", o.getFineAmount()) : "—" %></td>
                        <td><%= o.getOrderDate() %></td>
                        <td><span class="badge <%= badgeClass %>"><%= o.getStatus() %></span></td>
                        <td>
                            <% if ("Pending".equals(o.getStatus())) { %>
                                <form action="${pageContext.request.contextPath}/orders" method="post" onsubmit="return confirm('Cancel order #<%= o.getId() %>?');" style="display: inline;">
                                    <input type="hidden" name="orderId" value="<%= o.getId() %>">
                                    <button type="submit" class="btn-cancel">Cancel</button>
                                </form>
                            <% } else { %>
                                <span style="color: #999;">—</span>
                            <% } %>
                        </td>
                    </tr>
                <%  
                        }
                    } else { 
                %>
                    <tr>
                        <td colspan="9" class="empty-state">
                            No orders placed yet.
                            <br><br>
                            <a href="${pageContext.request.contextPath}/user" class="btn-primary">Browse Products</a>
                        </td>
                    </tr>
                <% } %>
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