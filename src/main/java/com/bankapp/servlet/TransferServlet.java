package com.bankapp.servlet;

import com.bankapp.dao.Database;
import com.bankapp.model.Account;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

@WebServlet(
    name = "TransferServlet",
    urlPatterns = {"/transfer"},
    loadOnStartup = 1
)
public class TransferServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Ensure UTF-8 encoding for the request
        request.setCharacterEncoding("UTF-8");
        
        // Retrieve the userId from the session
        HttpSession session = request.getSession();
        String phoneNumber = (String) session.getAttribute("phoneNumber");

        if (phoneNumber == null) {
            response.sendRedirect("login.jsp?error=You must be logged in to access this page");
            return;
        }

        try (Connection conn = Database.getConnection()) {
            // Get user's accounts
            List<Account> userAccounts = new ArrayList<>();
            String userAccountsSql = "SELECT a.* FROM accounts a JOIN users u ON a.user_id = u.user_id WHERE u.phone_number = ?";
            try (PreparedStatement stmt = conn.prepareStatement(userAccountsSql)) {
                stmt.setString(1, phoneNumber);
                try (ResultSet rs = stmt.executeQuery()) {
                    while (rs.next()) {
                        int accountId = rs.getInt("account_id");
                        String accountNumber = rs.getString("account_number");
                        double balance = rs.getDouble("balance");
                        Account account = new Account(accountId, accountNumber, balance);
                        userAccounts.add(account);
                    }
                }
            }

            // Get all accounts (excluding user's own accounts)
            List<Account> allAccounts = new ArrayList<>();
            String allAccountsSql = "SELECT a.*, u.name as beneficiary_name FROM accounts a " +
                                  "JOIN users u ON a.user_id = u.user_id " +
                                  "WHERE a.user_id != (SELECT user_id FROM users WHERE phone_number = ?)";
            try (PreparedStatement stmt = conn.prepareStatement(allAccountsSql)) {
                stmt.setString(1, phoneNumber);
                try (ResultSet rs = stmt.executeQuery()) {
                    while (rs.next()) {
                        int accountId = rs.getInt("account_id");
                        String accountNumber = rs.getString("account_number");
                        double balance = rs.getDouble("balance");
                        String beneficiaryName = rs.getString("beneficiary_name");
                        Account account = new Account(accountId, accountNumber, balance);
                        account.setBeneficiaryName(beneficiaryName);
                        allAccounts.add(account);
                    }
                }
            }

            request.setAttribute("userAccounts", userAccounts);
            request.setAttribute("allAccounts", allAccounts);
            request.getRequestDispatcher("transfer.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("transfer.jsp?error=Database error: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        // Retrieve form data
        int fromAccountId = Integer.parseInt(request.getParameter("fromAccount"));
        int toAccountId = Integer.parseInt(request.getParameter("toAccount"));
        double amount = Double.parseDouble(request.getParameter("amount"));
        
        HttpSession session = request.getSession();
        String phoneNumber = (String) session.getAttribute("phoneNumber");

        if (phoneNumber == null) {
            response.sendRedirect("login.jsp?error=You must be logged in to make a transfer");
            return;
        }

        try (Connection conn = Database.getConnection()) {
            // Get account details for display
            String fromAccountSql = "SELECT account_number FROM accounts WHERE account_id = ?";
            String toAccountSql = "SELECT a.account_number, u.name as beneficiary_name FROM accounts a " +
                                "JOIN users u ON a.user_id = u.user_id " +
                                "WHERE a.account_id = ?";
            
            String fromAccountNumber = "";
            String toAccountNumber = "";
            String beneficiaryName = "";
            
            try (PreparedStatement stmt = conn.prepareStatement(fromAccountSql)) {
                stmt.setInt(1, fromAccountId);
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        fromAccountNumber = rs.getString("account_number");
                    }
                }
            }
            
            try (PreparedStatement stmt = conn.prepareStatement(toAccountSql)) {
                stmt.setInt(1, toAccountId);
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        toAccountNumber = rs.getString("account_number");
                        beneficiaryName = rs.getString("beneficiary_name");
                    }
                }
            }

            // Verify from account belongs to user and has sufficient balance
            String verifySql = "SELECT a.balance FROM accounts a " +
                             "JOIN users u ON a.user_id = u.user_id " +
                             "WHERE a.account_id = ? AND u.phone_number = ? AND a.user_id = u.user_id";
            try (PreparedStatement verifyStmt = conn.prepareStatement(verifySql)) {
                verifyStmt.setInt(1, fromAccountId);
                verifyStmt.setString(2, phoneNumber);
                try (ResultSet rs = verifyStmt.executeQuery()) {
                    if (!rs.next()) {
                        throw new SQLException("Invalid account or insufficient permissions");
                    }
                    double currentBalance = rs.getDouble("balance");
                    if (currentBalance < amount) {
                        throw new SQLException("Insufficient funds");
                    }
                }
            }

            // Generate OTP
            String otp = generateOTP();
            
            // Store transaction details in session
            session.setAttribute("fromAccountId", fromAccountId);
            session.setAttribute("toAccountId", toAccountId);
            session.setAttribute("amount", amount);
            session.setAttribute("fromAccountNumber", fromAccountNumber);
            session.setAttribute("toAccountNumber", toAccountNumber);
            session.setAttribute("beneficiaryName", beneficiaryName);
            session.setAttribute("otp", otp);

            // Forward to confirmation page
            request.setAttribute("fromAccount", fromAccountNumber);
            request.setAttribute("toAccount", toAccountNumber);
            request.setAttribute("beneficiaryName", beneficiaryName);
            request.setAttribute("amount", amount);
            request.setAttribute("otp", otp); // For demo purposes only
            request.getRequestDispatcher("transfer-confirm.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("transfer.jsp?error=" + e.getMessage());
        }
    }

    private String generateOTP() {
        Random random = new Random();
        int otp = 100000 + random.nextInt(900000);
        return String.valueOf(otp);
    }
} 