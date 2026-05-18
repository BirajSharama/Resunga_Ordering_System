package com.ResungaIndustries.model;

import java.sql.Timestamp;

public class Order {

    public static final String STATUS_PENDING   = "Pending";
    public static final String STATUS_CONFIRMED = "Confirmed";
    public static final String STATUS_DELIVERED = "Delivered";
    public static final String STATUS_CANCELLED = "Cancelled";

    private int       id;
    private int       userId;
    private int       productId;
    private String    productName;
    private String    customerName;
    private double    squareFeet;
    private int       gsm;
    private double    totalPrice;
    private double    fineAmount;
    private String    status;
    private Timestamp orderDate;

    public Order() {}

    // ─── Getters ──────────────────────────────────
    public int       getId()            { return id; }
    public int       getUserId()        { return userId; }
    public int       getProductId()     { return productId; }
    public String    getProductName()   { return productName; }
    public String    getCustomerName()  { return customerName; }
    public double    getSquareFeet()    { return squareFeet; }
    public int       getGsm()          { return gsm; }
    public double    getTotalPrice()    { return totalPrice; }
    public double    getFineAmount()    { return fineAmount; }
    public String    getStatus()        { return status; }
    public Timestamp getOrderDate()     { return orderDate; }

    // ─── Setters ──────────────────────────────────
    public void setId(int id)                      { this.id = id; }
    public void setUserId(int userId)              { this.userId = userId; }
    public void setProductId(int productId)        { this.productId = productId; }
    public void setProductName(String productName) { this.productName = productName; }
    public void setCustomerName(String name)       { this.customerName = name; }
    public void setSquareFeet(double squareFeet)   { this.squareFeet = squareFeet; }
    public void setGsm(int gsm)                    { this.gsm = gsm; }
    public void setTotalPrice(double totalPrice)   { this.totalPrice = totalPrice; }
    public void setFineAmount(double fineAmount)   { this.fineAmount = fineAmount; }
    public void setStatus(String status)           { this.status = status; }
    public void setOrderDate(Timestamp orderDate)  { this.orderDate = orderDate; }

    // ─── Helper ───────────────────────────────────
    public static double calculateTotal(double squareFeet, double pricePerSqFt) {
        return squareFeet * pricePerSqFt;
    }
}