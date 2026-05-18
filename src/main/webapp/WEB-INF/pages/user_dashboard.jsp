<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.ResungaIndustries.model.Product" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Products | Resunga Industries</title>
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

        .welcome-banner {
            background: linear-gradient(135deg, #008080 0%, #006666 100%);
            border-radius: 16px;
            padding: 35px 40px;
            margin-bottom: 30px;
            color: white;
        }

        .welcome-banner h2 {
            font-size: 28px;
            margin-bottom: 10px;
        }

        .welcome-banner p {
            font-size: 14px;
            opacity: 0.9;
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
            font-size: 18px;
            color: #008080;
            margin: 0;
        }

        .card-body {
            padding: 25px;
        }

        .search-form {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            align-items: end;
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
        .input-group select {
            padding: 10px 12px;
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            font-size: 14px;
            transition: border-color 0.3s;
        }

        .input-group input:focus,
        .input-group select:focus {
            outline: none;
            border-color: #008080;
        }

        .btn {
            padding: 10px 20px;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            border: none;
        }

        .btn-primary {
            background: #ff6b4a;
            color: white;
        }

        .btn-primary:hover {
            background: #ff5230;
            transform: translateY(-1px);
        }

        .btn-full {
            width: 100%;
        }

        .product-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 24px;
        }

        .product-card {
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            transition: transform 0.2s;
            border: 1px solid #e0e0e0;
        }

        .product-card:hover {
            transform: translateY(-4px);
        }

        .product-card-header {
            background: #008080;
            padding: 20px;
            color: white;
        }

        .product-category {
            font-size: 11px;
            text-transform: uppercase;
            letter-spacing: 1px;
            opacity: 0.8;
            margin-bottom: 8px;
        }

        .product-name {
            font-size: 18px;
            font-weight: 600;
            margin: 0;
        }

        .product-card-body {
            padding: 20px;
        }

        .product-gsm {
            display: inline-block;
            background: #f0f0f0;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            color: #008080;
            margin-bottom: 15px;
        }

        .product-price {
            font-size: 24px;
            font-weight: 700;
            color: #ff6b4a;
            margin-bottom: 10px;
        }

        .product-price span {
            font-size: 12px;
            font-weight: normal;
            color: #666;
        }

        .product-desc {
            font-size: 13px;
            color: #666;
            margin-bottom: 15px;
            line-height: 1.5;
        }

        .product-stock {
            font-size: 12px;
            color: #666;
            margin-bottom: 15px;
            padding-top: 10px;
            border-top: 1px solid #eee;
        }

        .alert {
            padding: 15px 20px;
            border-radius: 8px;
            margin-bottom: 20px;
        }

        .alert-error {
            background: #fdedec;
            border-left: 4px solid #e74c3c;
            color: #c0392b;
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
            
            .search-form {
                grid-template-columns: 1fr;
            }
            
            .product-grid {
                grid-template-columns: 1fr;
            }
            
            .welcome-banner {
                text-align: center;
                padding: 25px;
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
                <a href="${pageContext.request.contextPath}/user" class="active">Products</a>
                <a href="${pageContext.request.contextPath}/orders">My Orders</a>
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
    <div class="welcome-banner">
        <h2>Welcome back, <%= session.getAttribute("userName") %>!</h2>
        <p>Browse our premium flex roll catalog below. Select your product, enter square footage, and place your order.</p>
    </div>

    <div class="card">
        <div class="card-header">
            <h2>Search Products</h2>
        </div>
        <div class="card-body">
            <form action="${pageContext.request.contextPath}/user" method="get" class="search-form">
                <div class="input-group">
                    <label>Keyword</label>
                    <input type="text" name="keyword" placeholder="e.g. Glossy, Matte, Backlit" value="${keyword}">
                </div>
                <div class="input-group">
                    <label>Filter by GSM</label>
                    <select name="gsm">
                        <option value="0">All GSM</option>
                        <option value="280" <%= "280".equals(request.getParameter("gsm")) ? "selected" : "" %>>280 GSM</option>
                        <option value="300" <%= "300".equals(request.getParameter("gsm")) ? "selected" : "" %>>300 GSM</option>
                    </select>
                </div>
                <div>
                    <button type="submit" class="btn btn-primary">Search</button>
                </div>
            </form>
        </div>
    </div>

    <%
        String err = request.getParameter("error");
        if ("stock".equals(err)) {
    %>
        <div class="alert alert-error">Insufficient stock available for your requested quantity.</div>
    <%  } else if ("invalid".equals(err)) { %>
        <div class="alert alert-error">Invalid input. Please check your order details and try again.</div>
    <% } %>

    <div class="product-grid">
    <%
        List<Product> products = (List<Product>) request.getAttribute("products");
        if (products != null && !products.isEmpty()) {
            for (Product p : products) {
                boolean outOfStock = p.getStockSqFt() <= 0;
    %>
        <div class="product-card">
            <div class="product-card-header">
                <div class="product-category"><%= p.getCategory() %></div>
                <h3 class="product-name"><%= p.getName() %></h3>
            </div>
            <div class="product-card-body">
                <div class="product-gsm"><%= p.getGsm() %> GSM</div>
                <div class="product-price">
                    NPR <%= String.format("%.2f", p.getPricePerSqFt()) %>
                    <span>/ sq.ft</span>
                </div>
                <p class="product-desc"><%= (p.getDescription() != null) ? p.getDescription() : "Premium quality flex roll for professional printing." %></p>
                <div class="product-stock">
                    Stock Available: <strong><%= String.format("%.2f", p.getStockSqFt()) %> sq.ft</strong>
                </div>
                <form action="${pageContext.request.contextPath}/user" method="post">
                    <input type="hidden" name="productId" value="<%= p.getId() %>">
                    <input type="hidden" name="gsm" value="<%= p.getGsm() %>">
                    <div class="input-group" style="margin-bottom: 15px;">
                        <label>Square Feet Required</label>
                        <input type="number" name="squareFeet" step="0.01" min="1" max="<%= p.getStockSqFt() %>" placeholder="e.g. 100.00" required>
                    </div>
                    <button type="submit" class="btn btn-primary btn-full" <%= outOfStock ? "disabled" : "" %>>
                        <%= outOfStock ? "Out of Stock" : "Place Order" %>
                    </button>
                </form>
            </div>
        </div>
    <%  }
        } else { %>
        <div class="empty-state" style="text-align: center; padding: 60px; background: white; border-radius: 12px;">
            <p>No products found. Try a different keyword or clear the search filter.</p>
        </div>
    <% } %>
    </div>
</div>

<div class="footer">
    &copy; 2025 Resunga Industries Pvt. Ltd. — Butwal, Lumbini Province, Nepal. All Rights Reserved.
</div>

</body>
</html>