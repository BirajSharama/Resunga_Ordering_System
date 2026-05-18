package com.ResungaIndustries.controller;

import com.ResungaIndustries.model.User;
import com.ResungaIndustries.service.UserService;
import com.ResungaIndustries.util.ValidationUtil;
import com.ResungaIndustries.util.PasswordUtil;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("userId") != null) {
            String role = (String) session.getAttribute("role");
            res.sendRedirect(req.getContextPath() + ("admin".equals(role) ? "/admin" : "/user"));
            return;
        }
        req.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(req, res);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String email = ValidationUtil.sanitize(req.getParameter("email"));
        String password = req.getParameter("password");

        // Validate input
        if (ValidationUtil.isEmpty(email) || ValidationUtil.isEmpty(password)) {
            req.setAttribute("error", "Email and password are required.");
            req.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(req, res);
            return;
        }

        if (!ValidationUtil.isValidEmail(email)) {
            req.setAttribute("error", "Please enter a valid email address.");
            req.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(req, res);
            return;
        }

        // Check if account is locked
        if (UserService.isAccountLocked(email)) {
            req.setAttribute("error", 
                "Your account has been locked due to too many failed attempts. " +
                "Please reset your password.");
            req.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(req, res);
            return;
        }

        // Attempt login
        User user = UserService.loginUser(email, password);

        if (user == null) {
            req.setAttribute("error", "Invalid email or password. Please try again.");
            req.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(req, res);
            return;
        }

        // Login successful - create session
        HttpSession session = req.getSession();
        session.setAttribute("userId", user.getId());
        session.setAttribute("userName", user.getFullName());
        session.setAttribute("userEmail", user.getEmail());
        session.setAttribute("role", user.getRole());
        session.setMaxInactiveInterval(30 * 60); // 30 minutes

        // Redirect based on role
        if ("admin".equals(user.getRole())) {
            res.sendRedirect(req.getContextPath() + "/admin");
        } else {
            res.sendRedirect(req.getContextPath() + "/user");
        }
    }
}