package com.ResungaIndustries.controller;

import com.ResungaIndustries.model.User;
import com.ResungaIndustries.service.UserService;
import com.ResungaIndustries.util.ValidationUtil;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("role") == null) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        int  userId = (int) session.getAttribute("userId");
        User user   = UserService.getUserById(userId);
        req.setAttribute("user", user);
        req.getRequestDispatcher("/WEB-INF/pages/profile.jsp").forward(req, res);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("role") == null) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        int    userId      = (int) session.getAttribute("userId");
        String fullName    = ValidationUtil.sanitize(req.getParameter("fullName"));
        String phone       = ValidationUtil.sanitize(req.getParameter("phone"));
        String newPassword = req.getParameter("newPassword") != null
                           ? req.getParameter("newPassword") : "";

        // ── Validate ──
        if (ValidationUtil.isEmpty(fullName)) {
            req.setAttribute("error", "Full name is required.");
            req.setAttribute("user", UserService.getUserById(userId));
            req.getRequestDispatcher("/WEB-INF/pages/profile.jsp").forward(req, res);
            return;
        }

        if (!ValidationUtil.isValidPhone(phone)) {
            req.setAttribute("error",
                "Enter a valid Nepali phone number (98XXXXXXXX).");
            req.setAttribute("user", UserService.getUserById(userId));
            req.getRequestDispatcher("/WEB-INF/pages/profile.jsp").forward(req, res);
            return;
        }

        if (!newPassword.isEmpty() && !ValidationUtil.isValidPassword(newPassword)) {
            req.setAttribute("error", "New password must be at least 6 characters.");
            req.setAttribute("user", UserService.getUserById(userId));
            req.getRequestDispatcher("/WEB-INF/pages/profile.jsp").forward(req, res);
            return;
        }

        boolean success = UserService.updateProfile(userId, fullName,
                              phone, newPassword);
        if (success) {
            // Update session name
            session.setAttribute("userName", fullName);
            req.setAttribute("success", "Profile updated successfully!");
        } else {
            req.setAttribute("error", "Update failed. Please try again.");
        }

        req.setAttribute("user", UserService.getUserById(userId));
        req.getRequestDispatcher("/WEB-INF/pages/profile.jsp").forward(req, res);
    }
}