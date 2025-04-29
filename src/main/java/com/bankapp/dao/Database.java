package com.bankapp.dao;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class Database {
    private static Properties properties = new Properties();
    
    static {
        try {
            // Load database properties
            try (InputStream input = Database.class.getClassLoader().getResourceAsStream("database.properties")) {
                if (input == null) {
                    throw new RuntimeException("Unable to find database.properties");
                }
                properties.load(input);
            }
            
            // Load MySQL driver
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
            } catch (ClassNotFoundException e) {
                throw new RuntimeException("MySQL JDBC Driver not found. Please ensure it's included in the WAR file.", e);
            }
            
        } catch (IOException e) {
            throw new RuntimeException("Error loading database configuration", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        String url = properties.getProperty("db.url");
        String username = properties.getProperty("db.username");
        String password = properties.getProperty("db.password");
        
        if (url == null || username == null || password == null) {
            throw new SQLException("Database configuration is incomplete. Please check database.properties");
        }
        
        try {
            System.out.println("Attempting to connect to database with URL: " + url);
            Connection conn = DriverManager.getConnection(url, username, password);
            System.out.println("Database connection established successfully");
            return conn;
        } catch (SQLException e) {
            System.err.println("Database connection failed: " + e.getMessage());
            System.err.println("SQL State: " + e.getSQLState());
            System.err.println("Error Code: " + e.getErrorCode());
            throw e;
        }
    }
}
