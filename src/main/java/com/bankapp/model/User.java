package com.bankapp.model;

public class User {
    private int userId;
    private String username;
    private String password;
    private String name;
    private String phoneNumber;

    public User() {
    }

    public User(int userId, String username, String password, String name, String phoneNumber) {
        this.userId = userId;
        this.username = username;
        this.password = password;
        this.name = name;
        this.phoneNumber = phoneNumber;
    }

    // Getters and Setters
    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }
}
