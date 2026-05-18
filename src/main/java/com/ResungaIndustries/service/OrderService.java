package com.ResungaIndustries.service;

import com.ResungaIndustries.config.DBConnection;
import com.ResungaIndustries.model.Order;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderService {

    // ─── Place order ───────────────────────────────
    public static boolean placeOrder(Order order) {
        String sql = "INSERT INTO orders (user_id, product_id, square_feet, " +
                     "gsm, total_price, status) VALUES (?, ?, ?, ?, ?, 'Pending')";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, order.getUserId());
            ps.setInt(2, order.getProductId());
            ps.setDouble(3, order.getSquareFeet());
            ps.setInt(4, order.getGsm());
            ps.setDouble(5, order.getTotalPrice());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Place order error: " + e.getMessage());
            return false;
        } finally {
            DBConnection.closeConnection(conn);
        }
    }

    // ─── Get orders by user ────────────────────────
    public static List<Order> getOrdersByUser(int userId) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT o.*, p.name AS product_name " +
                     "FROM orders o JOIN products p ON o.product_id = p.id " +
                     "WHERE o.user_id = ? ORDER BY o.order_date DESC";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order o = mapOrder(rs);
                o.setProductName(rs.getString("product_name"));
                list.add(o);
            }
        } catch (SQLException e) {
            System.err.println("Get user orders error: " + e.getMessage());
        } finally {
            DBConnection.closeConnection(conn);
        }
        return list;
    }

    // ─── Get all orders (admin) ────────────────────
    public static List<Order> getAllOrders() {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT o.*, p.name AS product_name, u.full_name AS customer_name " +
                     "FROM orders o " +
                     "JOIN products p ON o.product_id = p.id " +
                     "JOIN users u ON o.user_id = u.id " +
                     "ORDER BY o.order_date DESC";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            ResultSet rs = conn.prepareStatement(sql).executeQuery();
            while (rs.next()) {
                Order o = mapOrder(rs);
                o.setProductName(rs.getString("product_name"));
                o.setCustomerName(rs.getString("customer_name"));
                list.add(o);
            }
        } catch (SQLException e) {
            System.err.println("Get all orders error: " + e.getMessage());
        } finally {
            DBConnection.closeConnection(conn);
        }
        return list;
    }

    // ─── Update order status ───────────────────────
    public static boolean updateOrderStatus(int orderId, String status) {
        String sql = "UPDATE orders SET status = ? WHERE id = ?";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, status);
            ps.setInt(2, orderId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Update status error: " + e.getMessage());
            return false;
        } finally {
            DBConnection.closeConnection(conn);
        }
    }

    // ─── Cancel order ──────────────────────────────
    public static boolean cancelOrder(int orderId, int userId) {
        String sql = "UPDATE orders SET status = 'Cancelled' " +
                     "WHERE id = ? AND user_id = ? AND status = 'Pending'";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, orderId);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Cancel order error: " + e.getMessage());
            return false;
        } finally {
            DBConnection.closeConnection(conn);
        }
    }

    // ─── Apply fine to order ───────────────────────
    public static boolean applyFine(int orderId, double fineAmount) {
        String sql = "UPDATE orders SET fine_amount = ? WHERE id = ?";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setDouble(1, fineAmount);
            ps.setInt(2, orderId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Apply fine error: " + e.getMessage());
            return false;
        } finally {
            DBConnection.closeConnection(conn);
        }
    }

    // ─── Map ResultSet to Order ────────────────────
    private static Order mapOrder(ResultSet rs) throws SQLException {
        Order o = new Order();
        o.setId(rs.getInt("id"));
        o.setUserId(rs.getInt("user_id"));
        o.setProductId(rs.getInt("product_id"));
        o.setSquareFeet(rs.getDouble("square_feet"));
        o.setGsm(rs.getInt("gsm"));
        o.setTotalPrice(rs.getDouble("total_price"));
        o.setFineAmount(rs.getDouble("fine_amount"));
        o.setStatus(rs.getString("status"));
        o.setOrderDate(rs.getTimestamp("order_date"));
        return o;
    }
}