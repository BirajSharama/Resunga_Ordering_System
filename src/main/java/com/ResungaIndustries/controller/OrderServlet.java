package com.ResungaIndustries.controller;

import com.ResungaIndustries.service.OrderService;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/orders")
public class OrderServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || !"user".equals(session.getAttribute("role"))) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        if ("true".equals(req.getParameter("success"))) {
            req.setAttribute("success",
                "Your order has been placed successfully!");
        }

        int userId = (int) session.getAttribute("userId");
        req.setAttribute("orders", OrderService.getOrdersByUser(userId));
        req.getRequestDispatcher("/WEB-INF/pages/order_history.jsp")
           .forward(req, res);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || !"user".equals(session.getAttribute("role"))) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        int orderId = Integer.parseInt(req.getParameter("orderId"));
        int userId  = (int) session.getAttribute("userId");
        OrderService.cancelOrder(orderId, userId);
        res.sendRedirect(req.getContextPath() + "/orders");
    }
}