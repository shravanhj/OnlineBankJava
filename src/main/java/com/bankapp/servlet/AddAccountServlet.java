package com.bankapp.servlet;

import com.bankapp.dao.Database;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AddAccountServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        // Retrieve form data
        String accountNumber = request.getParameter("accountNumber");
        double balance = Double.parseDouble(request.getParameter("balance"));
        HttpSession session = request.getSession();

        // Check if the user is logged in
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            response.sendRedirect("login.jsp?error=Please log in to add an account");
            return;
        }

        try (Connection conn = Database.getConnection()) {
            // Check if the account number already exists
            String checkSql = "SELECT COUNT(*) as count FROM accounts WHERE account_number = ?";
            try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
                checkStmt.setString(1, accountNumber);
                try (ResultSet rs = checkStmt.executeQuery()) {
                    if (rs.next() && rs.getInt("count") > 0) {
                        response.sendRedirect("addAccount.jsp?error=Account number already exists");
                        return;
                    }
                }
            }

            // Insert new account for the logged-in user
            String sql = "INSERT INTO accounts (user_id, account_number, balance) VALUES (?, ?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, userId);
                stmt.setString(2, accountNumber);
                stmt.setDouble(3, balance);

                int rowsAffected = stmt.executeUpdate();
                if (rowsAffected > 0) {
                    response.sendRedirect("dashboard.jsp?message=Account added successfully");
                } else {
                    response.sendRedirect("addAccount.jsp?error=Account creation failed - no rows affected");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("addAccount.jsp?error=Database error: " + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("addAccount.jsp?error=Unexpected error: " + e.getMessage());
        }
    }
}
