<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>404 Not Found | Resunga Industries</title>
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

        .error-card {
            background: white;
            border-radius: 16px;
            padding: 50px;
            max-width: 550px;
            width: 100%;
            text-align: center;
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
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
            margin: 0 auto 20px;
        }

        .error-code {
            font-size: 80px;
            font-weight: 800;
            color: #008080;
            margin-bottom: 10px;
        }

        .error-title {
            font-size: 24px;
            font-weight: 700;
            color: #2c3e50;
            margin-bottom: 15px;
        }

        .error-msg {
            color: #5a6c7e;
            font-size: 14px;
            margin-bottom: 30px;
            line-height: 1.6;
        }

        .error-links {
            display: flex;
            gap: 15px;
            justify-content: center;
            flex-wrap: wrap;
        }

        .btn {
            padding: 12px 24px;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s;
            display: inline-block;
        }

        .btn-primary {
            background: #ff6b4a;
            color: white;
        }

        .btn-primary:hover {
            background: #ff5230;
            transform: translateY(-2px);
        }

        .btn-secondary {
            background: #e0e0e0;
            color: #2c3e50;
        }

        .btn-secondary:hover {
            background: #d0d0d0;
        }
    </style>
</head>
<body>
    <div class="error-card">
        <div class="logo-circle">RI</div>
        <div class="error-code">404</div>
        <div class="error-title">Page Not Found</div>
        <p class="error-msg">
            The page you are looking for does not exist or has been moved.
            Please check the URL or navigate back to the homepage.
        </p>
        <div class="error-links">
            <a href="${pageContext.request.contextPath}/login" class="btn btn-primary">Go to Login</a>
            <a href="javascript:history.back()" class="btn btn-secondary">Go Back</a>
        </div>
    </div>
</body>
</html>