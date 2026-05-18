package com.ResungaIndustries.model;

public class User {
    private int     id;
    private String  fullName;
    private String  email;
    private String  password;
    private String  phone;
    private String  role;
    private int     failedAttempts;
    private boolean isLocked;
    private String  resetToken;

    public User() {}

    public User(int id, String fullName, String email,
                String password, String phone, String role) {
        this.id       = id;
        this.fullName = fullName;
        this.email    = email;
        this.password = password;
        this.phone    = phone;
        this.role     = role;
    }

    // ─── Getters ──────────────────────────────────
    public int     getId()             { return id; }
    public String  getFullName()       { return fullName; }
    public String  getEmail()          { return email; }
    public String  getPassword()       { return password; }
    public String  getPhone()          { return phone; }
    public String  getRole()           { return role; }
    public int     getFailedAttempts() { return failedAttempts; }
    public boolean isLocked()          { return isLocked; }
    public String  getResetToken()     { return resetToken; }

    // ─── Setters ──────────────────────────────────
    public void setId(int id)                        { this.id = id; }
    public void setFullName(String fullName)         { this.fullName = fullName; }
    public void setEmail(String email)               { this.email = email; }
    public void setPassword(String password)         { this.password = password; }
    public void setPhone(String phone)               { this.phone = phone; }
    public void setRole(String role)                 { this.role = role; }
    public void setFailedAttempts(int fa)            { this.failedAttempts = fa; }
    public void setLocked(boolean locked)            { this.isLocked = locked; }
    public void setResetToken(String resetToken)     { this.resetToken = resetToken; }
}