<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reset Password | Resunga Industries</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #008080 0%, #006666 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .auth-card {
            background: white;
            border-radius: 16px;
            padding: 40px;
            max-width: 450px;
            width: 100%;
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
        }

        .auth-logo {
            text-align: center;
            margin-bottom: 30px;
        }

        .logo-circle {
            width: 60px;
            height: 60px;
            background: #008080;
            border-radius: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
            font-size: 24px;
            margin: 0 auto 15px;
        }

        .auth-logo h1 {
            font-size: 24px;
            color: #2c3e50;
            letter-spacing: 2px;
        }

        .auth-subtitle {
            color: #5a6c7e;
            font-size: 13px;
            margin-top: 5px;
        }

        .auth-divider {
            height: 2px;
            background: #e0e0e0;
            margin: 20px 0;
        }

        .input-group {
            margin-bottom: 20px;
        }

        .input-group label {
            display: block;
            font-size: 13px;
            font-weight: 600;
            color: #2c3e50;
            margin-bottom: 8px;
        }

        .input-group input {
            width: 100%;
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

        .btn {
            width: 100%;
            padding: 12px;
            border: none;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
        }

        .btn-primary {
            background: #ff6b4a;
            color: white;
        }

        .btn-primary:hover {
            background: #ff5230;
            transform: translateY(-1px);
        }

        .alert {
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-size: 13px;
        }

        .alert-error {
            background: #fdedec;
            border-left: 4px solid #e74c3c;
            color: #c0392b;
        }

        .auth-link {
            text-align: center;
            margin-top: 20px;
            font-size: 13px;
            color: #5a6c7e;
        }

        .auth-link a {
            color: #ff6b4a;
            text-decoration: none;
            font-weight: 600;
        }

        .auth-link a:hover {
            text-decoration: underline;
        }

        .info-text {
            color: #5a6c7e;
            font-size: 13px;
            margin-bottom: 20px;
            line-height: 1.5;
        }
    </style>
</head>
<body>
    <div class="auth-card">
        <div class="auth-logo">
            <div class="logo-circle">RI</div>
            <h1>RESUNGA</h1>
            <p class="auth-subtitle">Reset Your Password</p>
        </div>

        <div class="auth-divider"></div>

        <% if(request.getAttribute("error") != null) { %>
            <div class="alert alert-error"><%= request.getAttribute("error") %></div>
        <% } %>

        <% if(request.getAttribute("showResetForm") != null) { %>
            <p class="info-text">Enter your new password below.</p>
            <form action="${pageContext.request.contextPath}/forgot-password" method="post">
                <input type="hidden" name="step" value="reset">
                <input type="hidden" name="email" value="<%= request.getAttribute("email") %>">
                <div class="input-group">
                    <label>New Password</label>
                    <input type="password" name="newPassword" placeholder="Minimum 6 characters" required>
                </div>
                <div class="input-group">
                    <label>Confirm Password</label>
                    <input type="password" name="confirmPassword" placeholder="Repeat your new password" required>
                </div>
                <button type="submit" class="btn btn-primary">Reset Password</button>
            </form>
        <% } else { %>
            <p class="info-text">Enter your registered email address and we will verify your account.</p>
            <form action="${pageContext.request.contextPath}/forgot-password" method="post">
                <input type="hidden" name="step" value="verify">
                <div class="input-group">
                    <label>Registered Email Address</label>
                    <input type="email" name="email" placeholder="you@example.com" required>
                </div>
                <button type="submit" class="btn btn-primary">Verify Email</button>
            </form>
        <% } %>

        <p class="auth-link">
            <a href="${pageContext.request.contextPath}/login">← Back to Login</a>
        </p>
    </div>
</body>
</html>