package com.ResungaIndustries.controller;

import com.ResungaIndustries.model.User;
import com.ResungaIndustries.service.UserService;
import com.ResungaIndustries.util.ValidationUtil;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(req, res);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String fullName = ValidationUtil.sanitize(req.getParameter("fullName"));
        String email    = ValidationUtil.sanitize(req.getParameter("email"));
        String password = req.getParameter("password") != null
                        ? req.getParameter("password") : "";
        String phone    = ValidationUtil.sanitize(req.getParameter("phone"));

        // ── Validate all fields ──
        if (ValidationUtil.isEmpty(fullName) || ValidationUtil.isEmpty(email)
                || ValidationUtil.isEmpty(password) || ValidationUtil.isEmpty(phone)) {
            req.setAttribute("error", "All fields are required.");
            req.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(req, res);
            return;
        }

        if (!ValidationUtil.isValidEmail(email)) {
            req.setAttribute("error", "Please enter a valid email address.");
            req.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(req, res);
            return;
        }

        if (!ValidationUtil.isValidPassword(password)) {
            req.setAttribute("error", "Password must be at least 6 characters.");
            req.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(req, res);
            return;
        }

        if (!ValidationUtil.isValidPhone(phone)) {
            req.setAttribute("error",
                "Enter a valid Nepali phone number (98XXXXXXXX or 97XXXXXXXX).");
            req.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(req, res);
            return;
        }

        if (UserService.emailExists(email)) {
            req.setAttribute("error",
                "This email is already registered. Please login.");
            req.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(req, res);
            return;
        }

        // ── Build and save user ──
        User user = new User();
        user.setFullName(fullName);
        user.setEmail(email);
        user.setPassword(password);
        user.setPhone(phone);
        user.setRole("user");

        if (UserService.registerUser(user)) {
            req.setAttribute("success",
                "Registration successful! Please login.");
            req.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(req, res);
        } else {
            req.setAttribute("error", "Registration failed. Please try again.");
            req.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(req, res);
        }
    }
}