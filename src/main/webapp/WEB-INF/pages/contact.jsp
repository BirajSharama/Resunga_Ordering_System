<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us | Resunga Industries</title>
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
            color: #666;
            font-size: 14px;
        }

        .contact-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 24px;
            margin-bottom: 40px;
        }

        .contact-card {
            background: white;
            border-radius: 12px;
            padding: 25px;
            text-align: center;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            transition: transform 0.2s;
            border: 1px solid #e0e0e0;
        }

        .contact-card:hover {
            transform: translateY(-4px);
        }

        .contact-icon {
            font-size: 36px;
            margin-bottom: 15px;
        }

        .contact-card h3 {
            font-size: 18px;
            color: #008080;
            margin-bottom: 12px;
        }

        .contact-card p {
            font-size: 13px;
            color: #666;
            line-height: 1.6;
        }

        .contact-card a {
            color: #ff6b4a;
            text-decoration: none;
        }

        .contact-card a:hover {
            text-decoration: underline;
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

        .full-width {
            grid-column: span 2;
        }

        .btn {
            padding: 12px 24px;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            border: none;
            background: #ff6b4a;
            color: white;
            margin-top: 10px;
        }

        .btn:hover {
            background: #ff5230;
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
            
            .form-grid {
                grid-template-columns: 1fr;
            }
            
            .full-width {
                grid-column: span 1;
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
                <a href="${pageContext.request.contextPath}/about">About</a>
                <a href="${pageContext.request.contextPath}/contact" class="active">Contact</a>
            </div>
            <div class="user-section">
                <span class="user-name"><%= session.getAttribute("userName") %></span>
                <a href="${pageContext.request.contextPath}/logout" class="logout-btn">Logout</a>
            </div>
        </div>
    </div>
</div>

<div class="main-container">
    <div class="page-header">
        <div class="page-title">Contact Us</div>
        <div class="page-subtitle">Get in touch with our team for inquiries and support</div>
    </div>

    <div class="contact-grid">
        <div class="contact-card">
            <div class="contact-icon">📍</div>
            <h3>Head Office</h3>
            <p>Resunga Industries Pvt. Ltd.<br>Butwal, Lumbini Province<br>Nepal</p>
        </div>
        <div class="contact-card">
            <div class="contact-icon">📞</div>
            <h3>Biraj Sharama</h3>
            <p>
                <a href="tel:9846228468">9846228468</a><br>
                WhatsApp & Viber<br>
                <a href="mailto:birajsharama@gmail.com">birajsharama@gmail.com</a>
            </p>
        </div>
        <div class="contact-card">
            <div class="contact-icon">📞</div>
            <h3>Basanta Acharya</h3>
            <p>
                <a href="tel:9863551274">9863551274</a><br>
                WhatsApp & Viber<br>
                <a href="mailto:abasanta173@gmail.com">abasanta173@gmail.com</a>
            </p>
        </div>
        <div class="contact-card">
            <div class="contact-icon">🕒</div>
            <h3>Business Hours</h3>
            <p>Sunday – Friday<br>9:00 AM – 6:00 PM<br>NPT (UTC+5:45)</p>
        </div>
    </div>

    <div class="card">
        <div class="card-header">
            <h2>Send Us a Message</h2>
        </div>
        <div class="card-body">
            <form action="#" method="post" onsubmit="alert('Thank you for your message. We will get back to you soon. For immediate assistance, please call us directly.'); return false;">
                <div class="form-grid">
                    <div class="input-group">
                        <label>Full Name</label>
                        <input type="text" placeholder="Ram Bahadur Thapa" required>
                    </div>
                    <div class="input-group">
                        <label>Email Address</label>
                        <input type="email" placeholder="you@example.com" required>
                    </div>
                    <div class="input-group">
                        <label>Phone Number</label>
                        <input type="text" placeholder="98XXXXXXXX">
                    </div>
                    <div class="input-group">
                        <label>Subject</label>
                        <select required>
                            <option value="">-- Select Subject --</option>
                            <option>Product Inquiry</option>
                            <option>Order Support</option>
                            <option>Pricing & Quotation</option>
                            <option>Partnership</option>
                            <option>Other</option>
                        </select>
                    </div>
                    <div class="input-group full-width">
                        <label>Your Message</label>
                        <textarea rows="5" placeholder="Describe your inquiry in detail..." required></textarea>
                    </div>
                </div>
                <button type="submit" class="btn">Send Message</button>
            </form>
            <p style="font-size: 12px; color: #666; margin-top: 15px; text-align: center;">
                For urgent inquiries, please call us directly at the numbers above.
            </p>
        </div>
    </div>
</div>

<div class="footer">
    &copy; 2025 Resunga Industries Pvt. Ltd. — Butwal, Lumbini Province, Nepal. All Rights Reserved.
</div>

</body>
</html>