package com.ResungaIndustries.service;

import com.ResungaIndustries.config.DBConnection;
import com.ResungaIndustries.model.User;
import com.ResungaIndustries.util.PasswordUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserService {

    private static final int MAX_ATTEMPTS = 3;

    public static boolean registerUser(User user) {
        String sql = "INSERT INTO users " +
                     "(full_name, email, password, phone, role) " +
                     "VALUES (?, ?, ?, ?, 'user')";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, user.getFullName());
            ps.setString(2, user.getEmail());
            ps.setString(3, PasswordUtil.hashPassword(user.getPassword()));
            ps.setString(4, user.getPhone());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Register error: " + e.getMessage());
            return false;
        } finally {
            DBConnection.closeConnection(conn);
        }
    }

    public static User loginUser(String email, String password) {
        String sql = "SELECT * FROM users WHERE email = ?";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                boolean locked = rs.getInt("is_locked") == 1;
                if (locked) return null;
                String stored = rs.getString("password");
                if (PasswordUtil.checkPassword(password, stored)) {
                    resetFailedAttempts(email, conn);
                    return mapUser(rs);
                } else {
                    incrementFailedAttempts(email, conn, rs.getInt("failed_attempts"));
                    return null;
                }
            }
        } catch (SQLException e) {
            System.err.println("Login error: " + e.getMessage());
        } finally {
            DBConnection.closeConnection(conn);
        }
        return null;
    }

    public static boolean isAccountLocked(String email) {
        String sql = "SELECT is_locked FROM users WHERE email = ?";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt("is_locked") == 1;
        } catch (SQLException e) {
            System.err.println("Lock check error: " + e.getMessage());
        } finally {
            DBConnection.closeConnection(conn);
        }
        return false;
    }

    public static int getRemainingAttempts(String email) {
        String sql = "SELECT failed_attempts FROM users WHERE email = ?";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int attempts = rs.getInt("failed_attempts");
                return Math.max(0, MAX_ATTEMPTS - attempts);
            }
        } catch (SQLException e) {
            System.err.println("Get attempts error: " + e.getMessage());
        } finally {
            DBConnection.closeConnection(conn);
        }
        return MAX_ATTEMPTS;
    }

    public static boolean unlockAccount(String email) {
        String sql = "UPDATE users SET is_locked=0, failed_attempts=0 WHERE email=?";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Unlock account error: " + e.getMessage());
            return false;
        } finally {
            DBConnection.closeConnection(conn);
        }
    }

    private static void incrementFailedAttempts(String email, Connection conn, int current) throws SQLException {
        int newCount = current + 1;
        String sql = newCount >= MAX_ATTEMPTS
            ? "UPDATE users SET failed_attempts=?, is_locked=1 WHERE email=?"
            : "UPDATE users SET failed_attempts=? WHERE email=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, newCount);
        ps.setString(2, email);
        ps.executeUpdate();
    }

    private static void resetFailedAttempts(String email, Connection conn) throws SQLException {
        String sql = "UPDATE users SET failed_attempts=0, is_locked=0 WHERE email=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, email);
        ps.executeUpdate();
    }

    public static boolean emailExists(String email) {
        String sql = "SELECT id FROM users WHERE email = ?";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            return ps.executeQuery().next();
        } catch (SQLException e) {
            System.err.println("Email check error: " + e.getMessage());
        } finally {
            DBConnection.closeConnection(conn);
        }
        return false;
    }

    public static List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM users WHERE role='user' ORDER BY id DESC";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            ResultSet rs = conn.prepareStatement(sql).executeQuery();
            while (rs.next()) users.add(mapUser(rs));
        } catch (SQLException e) {
            System.err.println("Get users error: " + e.getMessage());
        } finally {
            DBConnection.closeConnection(conn);
        }
        return users;
    }

    public static boolean deleteUser(int userId) {
        String sql = "DELETE FROM users WHERE id=? AND role='user'";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Delete user error: " + e.getMessage());
            return false;
        } finally {
            DBConnection.closeConnection(conn);
        }
    }

    public static boolean updateProfile(int userId, String fullName, String phone, String newPassword) {
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            if (newPassword != null && !newPassword.isEmpty()) {
                String sql = "UPDATE users SET full_name=?, phone=?, password=? WHERE id=?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, fullName);
                ps.setString(2, phone);
                ps.setString(3, PasswordUtil.hashPassword(newPassword));
                ps.setInt(4, userId);
                return ps.executeUpdate() > 0;
            } else {
                String sql = "UPDATE users SET full_name=?, phone=? WHERE id=?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, fullName);
                ps.setString(2, phone);
                ps.setInt(3, userId);
                return ps.executeUpdate() > 0;
            }
        } catch (SQLException e) {
            System.err.println("Update profile error: " + e.getMessage());
            return false;
        } finally {
            DBConnection.closeConnection(conn);
        }
    }

    public static User getUserById(int id) {
        String sql = "SELECT * FROM users WHERE id=?";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapUser(rs);
        } catch (SQLException e) {
            System.err.println("Get user error: " + e.getMessage());
        } finally {
            DBConnection.closeConnection(conn);
        }
        return null;
    }

    public static boolean resetPassword(String email, String newPassword) {
        String sql = "UPDATE users SET password=?, failed_attempts=0, is_locked=0, reset_token=NULL WHERE email=?";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, PasswordUtil.hashPassword(newPassword));
            ps.setString(2, email);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Reset password error: " + e.getMessage());
            return false;
        } finally {
            DBConnection.closeConnection(conn);
        }
    }

    private static User mapUser(ResultSet rs) throws SQLException {
        User user = new User();
        user.setId(rs.getInt("id"));
        user.setFullName(rs.getString("full_name"));
        user.setEmail(rs.getString("email"));
        user.setPassword(rs.getString("password"));
        user.setPhone(rs.getString("phone"));
        user.setRole(rs.getString("role"));
        user.setFailedAttempts(rs.getInt("failed_attempts"));
        user.setLocked(rs.getInt("is_locked") == 1);
        return user;
    }
}