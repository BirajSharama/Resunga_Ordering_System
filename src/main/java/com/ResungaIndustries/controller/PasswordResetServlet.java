package com.ResungaIndustries.controller;

import com.ResungaIndustries.service.UserService;
import com.ResungaIndustries.util.ValidationUtil;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/forgot-password")
public class PasswordResetServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/pages/forgot_password.jsp")
           .forward(req, res);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String step = req.getParameter("step");

        // ── Step 1: Verify email exists ──
        if ("verify".equals(step)) {
            String email = ValidationUtil.sanitize(req.getParameter("email"));

            if (ValidationUtil.isEmpty(email) ||
                    !ValidationUtil.isValidEmail(email)) {
                req.setAttribute("error", "Please enter a valid email address.");
                req.getRequestDispatcher("/WEB-INF/pages/forgot_password.jsp")
                   .forward(req, res);
                return;
            }

            if (!UserService.emailExists(email)) {
                req.setAttribute("error",
                    "No account found with that email address.");
                req.getRequestDispatcher("/WEB-INF/pages/forgot_password.jsp")
                   .forward(req, res);
                return;
            }

            // Email exists — show reset form
            req.setAttribute("email",        email);
            req.setAttribute("showResetForm", true);
            req.getRequestDispatcher("/WEB-INF/pages/forgot_password.jsp")
               .forward(req, res);

        // ── Step 2: Reset password ──
        } else if ("reset".equals(step)) {
            String email       = ValidationUtil.sanitize(req.getParameter("email"));
            String newPassword = req.getParameter("newPassword") != null
                               ? req.getParameter("newPassword") : "";
            String confirmPass = req.getParameter("confirmPassword") != null
                               ? req.getParameter("confirmPassword") : "";

            if (!newPassword.equals(confirmPass)) {
                req.setAttribute("error", "Passwords do not match.");
                req.setAttribute("email", email);
                req.setAttribute("showResetForm", true);
                req.getRequestDispatcher("/WEB-INF/pages/forgot_password.jsp")
                   .forward(req, res);
                return;
            }

            if (!ValidationUtil.isValidPassword(newPassword)) {
                req.setAttribute("error",
                    "Password must be at least 6 characters.");
                req.setAttribute("email", email);
                req.setAttribute("showResetForm", true);
                req.getRequestDispatcher("/WEB-INF/pages/forgot_password.jsp")
                   .forward(req, res);
                return;
            }

            boolean success = UserService.resetPassword(email, newPassword);
            if (success) {
                req.setAttribute("success",
                    "Password reset successful! Please login.");
                req.getRequestDispatcher("/WEB-INF/pages/login.jsp")
                   .forward(req, res);
            } else {
                req.setAttribute("error",
                    "Password reset failed. Please try again.");
                req.getRequestDispatcher("/WEB-INF/pages/forgot_password.jsp")
                   .forward(req, res);
            }
        }
    }
}