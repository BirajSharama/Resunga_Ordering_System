package com.ResungaIndustries.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebFilter("/*")
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String path = req.getRequestURI();
        String contextPath = req.getContextPath();
        String page = path.substring(contextPath.length());

        // List of public pages (no login required)
        boolean isPublic = 
            page.equals("/login") ||
            page.equals("/register") ||
            page.equals("/forgot-password") ||
            page.startsWith("/css/") ||
            page.startsWith("/js/") ||
            page.startsWith("/images/") ||
            page.equals("/error_404.jsp") ||
            page.equals("/error_500.jsp");

        // Allow public pages
        if (isPublic) {
            chain.doFilter(request, response);
            return;
        }

        // Check if user is logged in
        HttpSession session = req.getSession(false);
        boolean isLoggedIn = (session != null && session.getAttribute("userId") != null);

        // Not logged in - redirect to login page
        if (!isLoggedIn) {
            res.sendRedirect(contextPath + "/login");
            return;
        }

        // Get user role
        String role = (String) session.getAttribute("role");

        // Admin pages - only allow admin role
        if (page.startsWith("/admin") && !"admin".equals(role)) {
            res.sendRedirect(contextPath + "/user");
            return;
        }

        // User pages - allow both admin and user, but admin goes to admin panel
        if (page.startsWith("/user") && "admin".equals(role)) {
            // Admin trying to access user page - redirect to admin dashboard
            res.sendRedirect(contextPath + "/admin");
            return;
        }

        // Allow access
        chain.doFilter(request, response);
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization code if needed
    }

    @Override
    public void destroy() {
        // Cleanup code if needed
    }
}