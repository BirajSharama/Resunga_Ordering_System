<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ResungaIndustries.model.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile | Resunga Industries</title>
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
            max-width: 800px;
            margin: 0 auto;
            padding: 40px 5%;
            width: 100%;
        }

        .profile-header {
            background: white;
            border-radius: 16px;
            padding: 30px;
            margin-bottom: 30px;
            text-align: center;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            border: 1px solid #e0e0e0;
        }

        .profile-avatar {
            width: 80px;
            height: 80px;
            background: #008080;
            color: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 32px;
            font-weight: 700;
            margin: 0 auto 20px;
        }

        .profile-name {
            font-size: 24px;
            font-weight: 700;
            color: #2c3e50;
            margin-bottom: 5px;
        }

        .profile-role {
            color: #ff6b4a;
            font-size: 14px;
            font-weight: 600;
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

        .card-body {
            padding: 25px;
        }

        .input-group {
            display: flex;
            flex-direction: column;
            gap: 8px;
            margin-bottom: 20px;
        }

        .input-group label {
            font-size: 13px;
            font-weight: 600;
            color: #2c3e50;
        }

        .input-group input {
            padding: 12px;
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            font-size: 14px;
            transition: border-color 0.3s;
        }

        .input-group input:focus {
            outline: none;
            border-color: #008080;
        }

        .input-group input:disabled {
            background: #f5f5f5;
            color: #999;
        }

        .btn {
            padding: 12px 24px;
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
            width: 100%;
        }

        .btn-primary:hover {
            background: #ff5230;
        }

        .alert {
            padding: 12px 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-size: 13px;
        }

        .alert-success {
            background: #e8f8f0;
            border-left: 4px solid #2ecc71;
            color: #27ae60;
        }

        .alert-error {
            background: #fdedec;
            border-left: 4px solid #e74c3c;
            color: #c0392b;
        }

        .info-note {
            background: #e8f4f8;
            padding: 12px 15px;
            border-radius: 8px;
            font-size: 12px;
            color: #008080;
            margin-bottom: 20px;
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
                gap: 15px;
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
                <a href="${pageContext.request.contextPath}/orders">My Orders</a>
                <a href="${pageContext.request.contextPath}/profile" class="active">Profile</a>
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
        User user = (User) request.getAttribute("user");
        if (user != null) {
            String initials = (user.getFullName().length() >= 2)
                ? user.getFullName().substring(0, 2).toUpperCase()
                : user.getFullName().toUpperCase();
    %>

    <div class="profile-header">
        <div class="profile-avatar"><%= initials %></div>
        <div class="profile-name"><%= user.getFullName() %></div>
        <div class="profile-role">Customer Account</div>
    </div>

    <div class="card">
        <div class="card-header">
            <h2>Account Details</h2>
        </div>
        <div class="card-body">
            <% if(request.getAttribute("error") != null) { %>
                <div class="alert alert-error"><%= request.getAttribute("error") %></div>
            <% } %>
            <% if(request.getAttribute("success") != null) { %>
                <div class="alert alert-success"><%= request.getAttribute("success") %></div>
            <% } %>

            <form action="${pageContext.request.contextPath}/profile" method="post">
                <div class="input-group">
                    <label>Full Name</label>
                    <input type="text" name="fullName" value="<%= user.getFullName() %>" required>
                </div>
                <div class="input-group">
                    <label>Email Address</label>
                    <input type="email" value="<%= user.getEmail() %>" disabled>
                    <small style="color: #999; font-size: 11px;">Email cannot be changed</small>
                </div>
                <div class="input-group">
                    <label>Phone Number</label>
                    <input type="text" name="phone" value="<%= user.getPhone() %>" required>
                </div>

                <div class="info-note">
                    Leave the password fields empty to keep your current password.
                </div>

                <div class="input-group">
                    <label>New Password</label>
                    <input type="password" name="newPassword" placeholder="Enter new password (minimum 6 characters)">
                </div>
                <div class="input-group">
                    <label>Confirm New Password</label>
                    <input type="password" name="confirmPassword" placeholder="Confirm your new password">
                </div>

                <button type="submit" class="btn btn-primary">Save Changes</button>
            </form>
        </div>
    </div>

    <% } %>
</div>

<div class="footer">
    &copy; 2025 Resunga Industries Pvt. Ltd. — Butwal, Lumbini Province, Nepal. All Rights Reserved.
</div>

</body>
</html>