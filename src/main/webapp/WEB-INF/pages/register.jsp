<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register | Resunga Industries</title>
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
            max-width: 500px;
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
    </style>
</head>
<body>
    <div class="auth-card">
        <div class="auth-logo">
            <div class="logo-circle">RI</div>
            <h1>RESUNGA</h1>
            <p class="auth-subtitle">Create Your Account</p>
        </div>

        <div class="auth-divider"></div>

        <% if(request.getAttribute("error") != null) { %>
            <div class="alert alert-error"><%= request.getAttribute("error") %></div>
        <% } %>

        <form action="${pageContext.request.contextPath}/register" method="post">
            <div class="input-group">
                <label>Full Name</label>
                <input type="text" name="fullName" placeholder="Ram Bahadur Thapa" required>
            </div>
            <div class="input-group">
                <label>Email Address</label>
                <input type="email" name="email" placeholder="you@example.com" required>
            </div>
            <div class="input-group">
                <label>Phone Number</label>
                <input type="text" name="phone" placeholder="98XXXXXXXX" required>
            </div>
            <div class="input-group">
                <label>Password</label>
                <input type="password" name="password" placeholder="Minimum 6 characters" required>
            </div>
            <button type="submit" class="btn btn-primary">Create Account</button>
        </form>

        <p class="auth-link">
            Already have an account?
            <a href="${pageContext.request.contextPath}/login">Sign in here</a>
        </p>
    </div>
</body>
</html>