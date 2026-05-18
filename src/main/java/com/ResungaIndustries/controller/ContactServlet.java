package com.ResungaIndustries.controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/contact")
public class ContactServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session != null) {
            req.setAttribute("role", session.getAttribute("role"));
        }
        req.getRequestDispatcher("/WEB-INF/pages/contact.jsp").forward(req, res);
    }
}