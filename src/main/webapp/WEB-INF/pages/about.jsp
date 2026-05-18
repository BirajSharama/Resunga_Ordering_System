<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us | Resunga Industries</title>
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
            max-width: 1200px;
            margin: 0 auto;
            padding: 40px 5%;
            width: 100%;
        }

        .about-hero {
            background: linear-gradient(135deg, #008080 0%, #006666 100%);
            border-radius: 16px;
            padding: 60px 40px;
            text-align: center;
            color: white;
            margin-bottom: 40px;
        }

        .about-hero h1 {
            font-size: 36px;
            margin-bottom: 10px;
        }

        .about-hero p {
            font-size: 16px;
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
            font-size: 20px;
            color: #008080;
            margin: 0;
        }

        .card-body {
            padding: 25px;
        }

        .about-text {
            font-size: 15px;
            line-height: 1.6;
            color: #2c3e50;
            margin-bottom: 20px;
        }

        .values-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 24px;
            margin-top: 20px;
        }

        .value-card {
            text-align: center;
            padding: 30px 20px;
            background: #faf9f8;
            border-radius: 12px;
            transition: transform 0.2s;
            border: 1px solid #e0e0e0;
        }

        .value-card:hover {
            transform: translateY(-4px);
        }

        .value-icon {
            font-size: 40px;
            margin-bottom: 15px;
        }

        .value-card h3 {
            font-size: 18px;
            color: #008080;
            margin-bottom: 10px;
        }

        .value-card p {
            font-size: 13px;
            color: #666;
            line-height: 1.5;
        }

        .leadership-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 24px;
            margin-top: 20px;
        }

        .leader-card {
            background: #faf9f8;
            border-radius: 12px;
            padding: 25px;
            text-align: center;
            border: 1px solid #e0e0e0;
            transition: transform 0.2s;
        }

        .leader-card:hover {
            transform: translateY(-4px);
        }

        .leader-name {
            font-size: 20px;
            font-weight: 700;
            color: #008080;
            margin-bottom: 5px;
        }

        .leader-title {
            color: #ff6b4a;
            font-size: 14px;
            font-weight: 600;
            margin-bottom: 15px;
        }

        .leader-info {
            font-size: 13px;
            color: #2c3e50;
            line-height: 1.8;
        }

        .leader-info a {
            color: #008080;
            text-decoration: none;
        }

        .leader-info a:hover {
            color: #ff6b4a;
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
            
            .about-hero h1 {
                font-size: 28px;
            }
            
            .values-grid {
                grid-template-columns: 1fr;
            }
            
            .leadership-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>

<%
    String role = (String) request.getAttribute("role");
    boolean isAdmin = "admin".equals(role);
%>

<div class="navbar">
    <div class="navbar-container">
        <a href="<%= isAdmin ? request.getContextPath() + "/admin" : request.getContextPath() + "/user" %>" class="navbar-brand">
            <div class="logo-circle">RI</div>
            <div class="brand-text">
                <h2>RESUNGA INDUSTRIES</h2>
                <p>Pvt. Ltd. | Butwal, Nepal</p>
            </div>
        </a>
        <div style="display: flex; align-items: center;">
            <div class="nav-links">
                <% if (isAdmin) { %>
                    <a href="${pageContext.request.contextPath}/admin">Dashboard</a>
                <% } else { %>
                    <a href="${pageContext.request.contextPath}/user">Products</a>
                    <a href="${pageContext.request.contextPath}/orders">My Orders</a>
                    <a href="${pageContext.request.contextPath}/profile">Profile</a>
                <% } %>
                <a href="${pageContext.request.contextPath}/about" class="active">About</a>
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
    <div class="about-hero">
        <h1>Resunga Industries</h1>
        <p>Pvt. Ltd. — Butwal, Lumbini Province, Nepal</p>
    </div>

    <div class="card">
        <div class="card-header">
            <h2>Who We Are</h2>
        </div>
        <div class="card-body">
            <p class="about-text">
                Resunga Industries Pvt. Ltd. is a forward-thinking industrial and manufacturing company dedicated to delivering premium-quality production solutions with precision, reliability, and innovation.
            </p>
            <p class="about-text">
                Headquartered in Butwal, Nepal, the company operates with a vision to contribute to the growth of Nepal's modern industrial sector through advanced manufacturing standards, strong operational capabilities, and long-term business partnerships.
            </p>
            <p class="about-text">
                Resunga Industries combines industrial expertise with a modern corporate approach, focusing on quality-driven production, efficient operations, and customer-centered service. With a commitment to excellence, the company continues to invest in infrastructure, technology, and sustainable growth to meet the evolving demands of the market.
            </p>
            <p class="about-text">
                At Resunga Industries, we believe in professionalism, integrity, and continuous progress — delivering solutions that reflect both quality craftsmanship and modern industry standards.
            </p>
        </div>
    </div>

    <div class="card">
        <div class="card-header">
            <h2>Our Values</h2>
        </div>
        <div class="card-body">
            <div class="values-grid">
                <div class="value-card">
                    <div class="value-icon">🏭</div>
                    <h3>Manufacturing</h3>
                    <p>Advanced production of premium flex rolls for Nepal's signage industry.</p>
                </div>
                <div class="value-card">
                    <div class="value-icon">✅</div>
                    <h3>Quality Assured</h3>
                    <p>Every roll is quality-checked before dispatch to ensure client satisfaction.</p>
                </div>
                <div class="value-card">
                    <div class="value-icon">🚚</div>
                    <h3>Reliable Delivery</h3>
                    <p>Timely and consistent delivery across Nepal for all confirmed orders.</p>
                </div>
                <div class="value-card">
                    <div class="value-icon">💡</div>
                    <h3>Innovation</h3>
                    <p>Continuously investing in technology and infrastructure for sustainable growth.</p>
                </div>
            </div>
        </div>
    </div>

    <div class="card">
        <div class="card-header">
            <h2>Our Leadership</h2>
        </div>
        <div class="card-body">
            <p class="about-text">
                Led by <strong>Biraj Sharama</strong> and <strong>Basanta Acharya</strong>, the company represents a new generation of ambitious entrepreneurs focused on building a trusted and future-oriented industrial brand in Nepal.
            </p>
            <div class="leadership-grid">
                <div class="leader-card">
                    <div class="leader-name">Biraj Sharama</div>
                    <div class="leader-title">Co-Founder & Director</div>
                    <div class="leader-info">
                        📞 <a href="tel:9846228468">9846228468</a><br>
                        💬 Available on WhatsApp & Viber<br>
                        ✉️ <a href="mailto:birajsharama@gmail.com">birajsharama@gmail.com</a>
                    </div>
                </div>
                <div class="leader-card">
                    <div class="leader-name">Basanta Acharya</div>
                    <div class="leader-title">Co-Founder & Director</div>
                    <div class="leader-info">
                        📞 <a href="tel:9863551274">9863551274</a><br>
                        💬 Available on WhatsApp & Viber<br>
                        ✉️ <a href="mailto:abasanta173@gmail.com">abasanta173@gmail.com</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="footer">
    &copy; 2025 Resunga Industries Pvt. Ltd. — Butwal, Lumbini Province, Nepal. All Rights Reserved.
</div>

</body>
</html>