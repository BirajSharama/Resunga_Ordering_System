package com.ResungaIndustries.controller;

import com.ResungaIndustries.model.Order;
import com.ResungaIndustries.model.Product;
import com.ResungaIndustries.service.OrderService;
import com.ResungaIndustries.service.ProductService;
import com.ResungaIndustries.util.ValidationUtil;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/user")
public class UserDashboardServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        if (!"user".equals(req.getSession().getAttribute("role"))) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String keyword  = req.getParameter("keyword");
        String gsmParam = req.getParameter("gsm");
        List<Product> products;

        // Parse GSM parameter
        int gsm = 0;
        if (gsmParam != null && !gsmParam.isEmpty() && !"0".equals(gsmParam)) {
            try {
                gsm = Integer.parseInt(gsmParam);
            } catch (NumberFormatException e) {
                gsm = 0;
            }
        }

        // CASE 1: Both keyword AND GSM filter are present
        if (keyword != null && !keyword.trim().isEmpty() && gsm > 0) {
            products = ProductService.searchProducts(keyword.trim(), gsm);
            req.setAttribute("keyword", keyword);
            req.setAttribute("selectedGsm", String.valueOf(gsm));
        }
        // CASE 2: Only keyword, no GSM filter
        else if (keyword != null && !keyword.trim().isEmpty()) {
            products = ProductService.searchProducts(keyword.trim(), 0);
            req.setAttribute("keyword", keyword);
        }
        // CASE 3: Only GSM filter, no keyword
        else if (gsm > 0) {
            products = ProductService.getProductsByGsm(gsm);
            req.setAttribute("selectedGsm", String.valueOf(gsm));
        }
        // CASE 4: No filters - show all products
        else {
            products = ProductService.getAllProducts();
        }

        req.setAttribute("products", products);
        req.setAttribute("recentProducts", ProductService.getRecentProducts(3));
        req.getRequestDispatcher("/WEB-INF/pages/user_dashboard.jsp")
           .forward(req, res);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || !"user".equals(session.getAttribute("role"))) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        try {
            int    productId  = Integer.parseInt(req.getParameter("productId"));
            double squareFeet = Double.parseDouble(req.getParameter("squareFeet"));
            int    gsm        = Integer.parseInt(req.getParameter("gsm"));
            int    userId     = (int) session.getAttribute("userId");

            if (!ValidationUtil.isValidGsm(gsm) || !ValidationUtil.isValidSquareFeet(squareFeet)) {
                res.sendRedirect(req.getContextPath() + "/user?error=invalid");
                return;
            }

            Product product = ProductService.getProductById(productId);
            if (product == null || !product.hasSufficientStock(squareFeet)) {
                res.sendRedirect(req.getContextPath() + "/user?error=stock");
                return;
            }

            double totalPrice = Order.calculateTotal(squareFeet, product.getPricePerSqFt());

            Order order = new Order();
            order.setUserId(userId);
            order.setProductId(productId);
            order.setSquareFeet(squareFeet);
            order.setGsm(gsm);
            order.setTotalPrice(totalPrice);

            if (OrderService.placeOrder(order)) {
                ProductService.reduceStock(productId, squareFeet);
                res.sendRedirect(req.getContextPath() + "/orders?success=true");
            } else {
                res.sendRedirect(req.getContextPath() + "/user?error=failed");
            }

        } catch (NumberFormatException e) {
            res.sendRedirect(req.getContextPath() + "/user?error=invalid");
        }
    }
}