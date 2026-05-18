<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | Resunga Industries</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', sans-serif;
            min-height: 100vh;
            display: flex;
            background: #f5f0e8;
        }

        /* Left Side - Brand Section */
        .brand-section {
            flex: 1;
            background: linear-gradient(135deg, #008080 0%, #006666 100%);
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding: 40px;
            position: relative;
            overflow: hidden;
        }

        .brand-section::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.06) 1%, transparent 1%);
            background-size: 50px 50px;
            animation: patternMove 20s linear infinite;
        }

        @keyframes patternMove {
            0% { transform: translate(0, 0); }
            100% { transform: translate(50px, 50px); }
        }

        .brand-content {
            position: relative;
            z-index: 1;
            text-align: center;
            color: white;
        }

        .logo-large {
            width: 100px;
            height: 100px;
            background: rgba(255,255,255,0.12);
            border-radius: 24px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 30px;
            backdrop-filter: blur(8px);
            border: 1px solid rgba(255,255,255,0.15);
        }

        .logo-large span {
            font-size: 48px;
            font-weight: 700;
            color: white;
        }

        .brand-content h1 {
            font-size: 42px;
            font-weight: 700;
            letter-spacing: 2px;
            margin-bottom: 15px;
        }

        .brand-content p {
            font-size: 16px;
            opacity: 0.85;
            line-height: 1.6;
            max-width: 380px;
            margin-top: 20px;
        }

        .stats-badge {
            display: flex;
            gap: 40px;
            margin-top: 60px;
            justify-content: center;
        }

        .stat-item {
            text-align: center;
        }

        .stat-number {
            font-size: 28px;
            font-weight: 700;
        }

        .stat-label {
            font-size: 12px;
            opacity: 0.7;
            margin-top: 6px;
            letter-spacing: 0.5px;
        }

        /* Right Side - Login Form - Creamy Background */
        .form-section {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 40px;
            background: #fdfaf6;
        }

        .login-container {
            max-width: 420px;
            width: 100%;
        }

        .form-header {
            margin-bottom: 35px;
        }

        .form-header h2 {
            font-size: 32px;
            font-weight: 600;
            color: #1a2c2c;
            margin-bottom: 8px;
        }

        .form-header p {
            color: #6b7b7b;
            font-size: 14px;
        }

        .input-group {
            margin-bottom: 24px;
        }

        .input-group label {
            display: block;
            font-size: 13px;
            font-weight: 600;
            color: #1a2c2c;
            margin-bottom: 8px;
        }

        .input-field {
            position: relative;
        }

        .input-field input {
            width: 100%;
            padding: 14px 16px;
            border: 1px solid #e2dcd4;
            border-radius: 12px;
            font-size: 14px;
            transition: all 0.3s;
            background: white;
        }

        .input-field input:focus {
            outline: none;
            border-color: #008080;
            background: white;
            box-shadow: 0 0 0 3px rgba(0,128,128,0.08);
        }

        .form-options {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 28px;
        }

        .remember-me {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .remember-me input {
            width: 16px;
            height: 16px;
            cursor: pointer;
            accent-color: #008080;
        }

        .remember-me label {
            font-size: 13px;
            color: #6b7b7b;
            cursor: pointer;
        }

        .forgot-link {
            font-size: 13px;
            color: #008080;
            text-decoration: none;
            font-weight: 500;
        }

        .forgot-link:hover {
            text-decoration: underline;
        }

        .btn-login {
            width: 100%;
            background: #008080;
            color: white;
            padding: 14px;
            border: none;
            border-radius: 12px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
        }

        .btn-login:hover {
            background: #006666;
            transform: translateY(-1px);
        }

        .register-link {
            text-align: center;
            margin-top: 28px;
            padding-top: 28px;
            border-top: 1px solid #e8e0d6;
        }

        .register-link p {
            font-size: 14px;
            color: #6b7b7b;
        }

        .register-link a {
            color: #008080;
            text-decoration: none;
            font-weight: 600;
        }

        .register-link a:hover {
            text-decoration: underline;
        }

        .alert {
            padding: 14px 16px;
            border-radius: 10px;
            margin-bottom: 24px;
            font-size: 13px;
        }

        .alert-error {
            background: #fef5f0;
            border-left: 4px solid #e74c3c;
            color: #c0392b;
        }

        .alert-success {
            background: #eef5ea;
            border-left: 4px solid #28a745;
            color: #1e6b3b;
        }

        /* Responsive */
        @media (max-width: 900px) {
            body {
                flex-direction: column;
            }
            
            .brand-section {
                padding: 50px 40px;
            }
            
            .brand-content h1 {
                font-size: 32px;
            }
            
            .stats-badge {
                margin-top: 35px;
                gap: 30px;
            }
        }

        @media (max-width: 480px) {
            .brand-section {
                padding: 40px 20px;
            }
            
            .brand-content h1 {
                font-size: 28px;
            }
            
            .stat-number {
                font-size: 22px;
            }
            
            .form-section {
                padding: 30px 20px;
            }
            
            .form-header h2 {
                font-size: 28px;
            }
        }
    </style>
</head>
<body>

    <!-- Left Side - Brand Section -->
    <div class="brand-section">
        <div class="brand-content">
            <div class="logo-large">
                <span>RI</span>
            </div>
            <h1>RESUNGA<br>INDUSTRIES</h1>
            <p>Premium Flex Roll Solutions for Nepal's Signage Industry</p>
            
            <div class="stats-badge">
                <div class="stat-item">
                    <div class="stat-number">280/300</div>
                    <div class="stat-label">GSM OPTIONS</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">24/7</div>
                    <div class="stat-label">ORDER ACCESS</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">100%</div>
                    <div class="stat-label">QUALITY</div>
                </div>
            </div>
        </div>
    </div>

    <!-- Right Side - Login Form -->
    <div class="form-section">
        <div class="login-container">
            <div class="form-header">
                <h2>Welcome Back</h2>
                <p>Sign in to access your account</p>
            </div>

            <% if(request.getAttribute("error") != null) { %>
                <div class="alert alert-error">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>
            <% if(request.getAttribute("success") != null) { %>
                <div class="alert alert-success">
                    <%= request.getAttribute("success") %>
                </div>
            <% } %>

            <form action="${pageContext.request.contextPath}/login" method="post">
                <div class="input-group">
                    <label>Email Address</label>
                    <div class="input-field">
                        <input type="email" name="email" placeholder="you@example.com" required>
                    </div>
                </div>

                <div class="input-group">
                    <label>Password</label>
                    <div class="input-field">
                        <input type="password" name="password" placeholder="Enter your password" required>
                    </div>
                </div>

                <div class="form-options">
                    <label class="remember-me">
                        <input type="checkbox" name="remember">
                        <span>Remember me</span>
                    </label>
                    <a href="${pageContext.request.contextPath}/forgot-password" class="forgot-link">Forgot password?</a>
                </div>

                <button type="submit" class="btn-login">Sign In</button>
            </form>

            <div class="register-link">
                <p>Don't have an account? <a href="${pageContext.request.contextPath}/register">Create an account</a></p>
            </div>
        </div>
    </div>

</body>
</html>