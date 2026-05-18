package com.ResungaIndustries.service;

import com.ResungaIndustries.config.DBConnection;
import com.ResungaIndustries.model.Product;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductService {

    public static boolean addProduct(Product product) {
        String sql = "INSERT INTO products " +
                     "(name, category, gsm, price_per_sqft, " +
                     "stock_sqft, description) VALUES (?,?,?,?,?,?)";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, product.getName());
            ps.setString(2, product.getCategory());
            ps.setInt(3, product.getGsm());
            ps.setDouble(4, product.getPricePerSqFt());
            ps.setDouble(5, product.getStockSqFt());
            ps.setString(6, product.getDescription());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Add product error: " + e.getMessage());
            return false;
        } finally {
            DBConnection.closeConnection(conn);
        }
    }

    public static List<Product> getAllProducts() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM products ORDER BY id DESC";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            ResultSet rs = conn.prepareStatement(sql).executeQuery();
            while (rs.next()) {
                list.add(mapProduct(rs));
            }
        } catch (SQLException e) {
            System.err.println("Get products error: " + e.getMessage());
        } finally {
            DBConnection.closeConnection(conn);
        }
        return list;
    }

    public static List<Product> getRecentProducts(int limit) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM products ORDER BY created_at DESC LIMIT ?";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapProduct(rs));
            }
        } catch (SQLException e) {
            System.err.println("Recent products error: " + e.getMessage());
        } finally {
            DBConnection.closeConnection(conn);
        }
        return list;
    }

    public static Product getProductById(int id) {
        String sql = "SELECT * FROM products WHERE id=?";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapProduct(rs);
            }
        } catch (SQLException e) {
            System.err.println("Get product error: " + e.getMessage());
        } finally {
            DBConnection.closeConnection(conn);
        }
        return null;
    }

    public static List<Product> getProductsByGsm(int gsm) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM products WHERE gsm = ? ORDER BY id DESC";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, gsm);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapProduct(rs));
            }
        } catch (SQLException e) {
            System.err.println("Get products by GSM error: " + e.getMessage());
        } finally {
            DBConnection.closeConnection(conn);
        }
        return list;
    }

    public static boolean updateProduct(Product product) {
        String sql = "UPDATE products SET name=?, category=?, gsm=?, " +
                     "price_per_sqft=?, stock_sqft=?, description=? WHERE id=?";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, product.getName());
            ps.setString(2, product.getCategory());
            ps.setInt(3, product.getGsm());
            ps.setDouble(4, product.getPricePerSqFt());
            ps.setDouble(5, product.getStockSqFt());
            ps.setString(6, product.getDescription());
            ps.setInt(7, product.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Update product error: " + e.getMessage());
            return false;
        } finally {
            DBConnection.closeConnection(conn);
        }
    }

    public static boolean deleteProduct(int id) {
        String sql = "DELETE FROM products WHERE id=?";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Delete product error: " + e.getMessage());
            return false;
        } finally {
            DBConnection.closeConnection(conn);
        }
    }

    public static List<Product> searchProducts(String keyword, int gsm) {
        List<Product> list = new ArrayList<>();
        String sql;
        Connection conn = null;
        
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps;
            
            if (gsm == 280 || gsm == 300) {
                sql = "SELECT * FROM products WHERE (name LIKE ? OR category LIKE ?) AND gsm = ?";
                ps = conn.prepareStatement(sql);
                String kw = "%" + keyword + "%";
                ps.setString(1, kw);
                ps.setString(2, kw);
                ps.setInt(3, gsm);
            } else {
                sql = "SELECT * FROM products WHERE name LIKE ? OR category LIKE ?";
                ps = conn.prepareStatement(sql);
                String kw = "%" + keyword + "%";
                ps.setString(1, kw);
                ps.setString(2, kw);
            }
            
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapProduct(rs));
            }
        } catch (SQLException e) {
            System.err.println("Search error: " + e.getMessage());
        } finally {
            DBConnection.closeConnection(conn);
        }
        return list;
    }

    public static boolean reduceStock(int productId, double sqFt) {
        String sql = "UPDATE products SET stock_sqft = stock_sqft - ? " +
                     "WHERE id=? AND stock_sqft >= ?";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setDouble(1, sqFt);
            ps.setInt(2, productId);
            ps.setDouble(3, sqFt);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Reduce stock error: " + e.getMessage());
            return false;
        } finally {
            DBConnection.closeConnection(conn);
        }
    }

    private static Product mapProduct(ResultSet rs) throws SQLException {
        Product p = new Product();
        p.setId(rs.getInt("id"));
        p.setName(rs.getString("name"));
        p.setCategory(rs.getString("category"));
        p.setGsm(rs.getInt("gsm"));
        p.setPricePerSqFt(rs.getDouble("price_per_sqft"));
        p.setStockSqFt(rs.getDouble("stock_sqft"));
        p.setDescription(rs.getString("description"));
        p.setCreatedAt(rs.getTimestamp("created_at"));
        return p;
    }
}