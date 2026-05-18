package com.ResungaIndustries.controller;

import com.ResungaIndustries.model.Product;
import com.ResungaIndustries.service.OrderService;
import com.ResungaIndustries.service.ProductService;
import com.ResungaIndustries.service.UserService;
import com.ResungaIndustries.util.ValidationUtil;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin")
public class AdminDashboardServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        if (!"admin".equals(req.getSession().getAttribute("role"))) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        req.setAttribute("products",       ProductService.getAllProducts());
        req.setAttribute("recentProducts", ProductService.getRecentProducts(5));
        req.setAttribute("orders",         OrderService.getAllOrders());
        req.setAttribute("users",          UserService.getAllUsers());
        req.getRequestDispatcher("/WEB-INF/pages/admin_dashboard.jsp")
           .forward(req, res);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        if (!"admin".equals(req.getSession().getAttribute("role"))) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String action = req.getParameter("action");
        if (action == null) {
            res.sendRedirect(req.getContextPath() + "/admin");
            return;
        }

        switch (action) {

            case "addProduct": {
                String name        = ValidationUtil.sanitize(req.getParameter("name"));
                String category    = ValidationUtil.sanitize(req.getParameter("category"));
                String description = ValidationUtil.sanitize(req.getParameter("description"));
                int    gsm         = Integer.parseInt(req.getParameter("gsm"));
                double price       = Double.parseDouble(req.getParameter("price"));
                double stock       = Double.parseDouble(req.getParameter("stock"));

                Product p = new Product();
                p.setName(name);
                p.setCategory(category);
                p.setGsm(gsm);
                p.setPricePerSqFt(price);
                p.setStockSqFt(stock);
                p.setDescription(description);
                ProductService.addProduct(p);
                break;
            }

            case "editProduct": {
                int    id          = Integer.parseInt(req.getParameter("id"));
                String name        = ValidationUtil.sanitize(req.getParameter("name"));
                String category    = ValidationUtil.sanitize(req.getParameter("category"));
                String description = ValidationUtil.sanitize(req.getParameter("description"));
                int    gsm         = Integer.parseInt(req.getParameter("gsm"));
                double price       = Double.parseDouble(req.getParameter("price"));
                double stock       = Double.parseDouble(req.getParameter("stock"));

                Product p = new Product();
                p.setId(id);
                p.setName(name);
                p.setCategory(category);
                p.setGsm(gsm);
                p.setPricePerSqFt(price);
                p.setStockSqFt(stock);
                p.setDescription(description);
                ProductService.updateProduct(p);
                break;
            }

            case "deleteProduct": {
                int id = Integer.parseInt(req.getParameter("id"));
                ProductService.deleteProduct(id);
                break;
            }

            case "updateOrderStatus": {
                int    orderId = Integer.parseInt(req.getParameter("orderId"));
                String status  = req.getParameter("status");
                OrderService.updateOrderStatus(orderId, status);
                break;
            }

            case "applyFine": {
                int    orderId    = Integer.parseInt(req.getParameter("orderId"));
                double fineAmount = Double.parseDouble(req.getParameter("fineAmount"));
                OrderService.applyFine(orderId, fineAmount);
                break;
            }

            case "deleteUser": {
                int userId = Integer.parseInt(req.getParameter("userId"));
                UserService.deleteUser(userId);
                break;
            }
        }

        res.sendRedirect(req.getContextPath() + "/admin");
    }
}