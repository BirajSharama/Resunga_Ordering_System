package com.ResungaIndustries.controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/about")
public class AboutServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session != null) {
            req.setAttribute("role", session.getAttribute("role"));
        }
        req.getRequestDispatcher("/WEB-INF/pages/about.jsp").forward(req, res);
    }
}