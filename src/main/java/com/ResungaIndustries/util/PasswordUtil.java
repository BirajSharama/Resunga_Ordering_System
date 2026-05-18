package com.ResungaIndustries.util;

public class PasswordUtil {

    // Simple hash using Java's built-in hashCode
    // Good enough for coursework purposes
    public static String hashPassword(String password) {
        return String.valueOf(password.hashCode());
    }

    public static boolean checkPassword(String plainPassword, String hashedPassword) {
        return hashPassword(plainPassword).equals(hashedPassword);
    }
}