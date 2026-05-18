package com.ResungaIndustries.model;

import java.sql.Timestamp;

public class Product {

    public static final int GSM_280 = 280;
    public static final int GSM_300 = 300;

    private int       id;
    private String    name;
    private String    category;
    private int       gsm;
    private double    pricePerSqFt;
    private double    stockSqFt;
    private String    description;
    private Timestamp createdAt;

    public Product() {}

    public Product(int id, String name, String category, int gsm,
                   double pricePerSqFt, double stockSqFt, String description) {
        this.id           = id;
        this.name         = name;
        this.category     = category;
        this.gsm          = gsm;
        this.pricePerSqFt = pricePerSqFt;
        this.stockSqFt    = stockSqFt;
        this.description  = description;
    }

    // ─── Getters ──────────────────────────────────
    public int       getId()            { return id; }
    public String    getName()          { return name; }
    public String    getCategory()      { return category; }
    public int       getGsm()           { return gsm; }
    public double    getPricePerSqFt()  { return pricePerSqFt; }
    public double    getStockSqFt()     { return stockSqFt; }
    public String    getDescription()   { return description; }
    public Timestamp getCreatedAt()     { return createdAt; }

    // ─── Setters ──────────────────────────────────
    public void setId(int id)                        { this.id = id; }
    public void setName(String name)                 { this.name = name; }
    public void setCategory(String category)         { this.category = category; }
    public void setGsm(int gsm)                      { this.gsm = gsm; }
    public void setPricePerSqFt(double p)            { this.pricePerSqFt = p; }
    public void setStockSqFt(double s)               { this.stockSqFt = s; }
    public void setDescription(String description)   { this.description = description; }
    public void setCreatedAt(Timestamp createdAt)    { this.createdAt = createdAt; }

    // ─── Helpers ──────────────────────────────────
    public boolean hasSufficientStock(double requiredSqFt) {
        return this.stockSqFt >= requiredSqFt;
    }

    public static boolean isValidGsm(int gsm) {
        return gsm == GSM_280 || gsm == GSM_300;
    }
}