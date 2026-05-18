package com.ResungaIndustries.util;

public class ValidationUtil {

    public static boolean isEmpty(String value) {
        return value == null || value.trim().isEmpty();
    }

    public static boolean isValidEmail(String email) {
        if (isEmpty(email)) return false;
        return email.matches("^[\\w.-]+@[\\w.-]+\\.[a-zA-Z]{2,}$");
    }

    public static boolean isValidPassword(String password) {
        return password != null && password.length() >= 6;
    }

    public static boolean isValidPhone(String phone) {
        if (isEmpty(phone)) return false;
        return phone.matches("^(97|98)\\d{8}$");
    }

    public static boolean isValidGsm(int gsm) {
        return gsm == 280 || gsm == 300;
    }

    public static boolean isValidSquareFeet(double sqFt) {
        return sqFt > 0 && sqFt <= 100000;
    }

    public static boolean isValidPrice(double price) {
        return price > 0;
    }

    public static String sanitize(String input) {
        if (input == null) return "";
        return input.trim()
                    .replace("<", "&lt;")
                    .replace(">", "&gt;")
                    .replace("\"", "&quot;");
    }
}