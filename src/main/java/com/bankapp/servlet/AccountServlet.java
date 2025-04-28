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
import com.bankapp.model.Account;
import com.bankapp.model.Transaction;
import java.util.List;
import java.util.ArrayList;

public class AccountServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Ensure UTF-8 encoding for the request
        request.setCharacterEncoding("UTF-8");
        
        // Retrieve the userId from the session
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        System.out.println("=== AccountServlet Debug Log ===");
        System.out.println("Session ID: " + session.getId());
        System.out.println("User ID from session: " + userId);

        if (userId == null) {
            // If user is not logged in, log and redirect to login
            System.out.println("No userId found in session. Redirecting to login.");
            response.sendRedirect("login.jsp?error=You must be logged in to access this page");
            return;
        } else {
            System.out.println("User ID retrieved from session: " + userId);
        }

        // Lists to hold account and transaction data
        List<Account> accounts = new ArrayList<>();
        List<Transaction> transactions = new ArrayList<>();

        // Use try-with-resources to automatically close connections
        try (Connection conn = Database.getConnection()) {
            System.out.println("Database connection established successfully");
            
            // First, verify the user exists
            String userCheckSql = "SELECT COUNT(*) as count FROM users WHERE user_id = ?";
            try (PreparedStatement userCheckStmt = conn.prepareStatement(userCheckSql)) {
                userCheckStmt.setInt(1, userId);
                try (ResultSet userRs = userCheckStmt.executeQuery()) {
                    if (userRs.next()) {
                        int userCount = userRs.getInt("count");
                        System.out.println("User exists check: " + (userCount > 0 ? "Yes" : "No"));
                    }
                }
            }
            
            // Query for all accounts associated with the user
            String accountSql = "SELECT account_id, account_number, balance FROM accounts WHERE user_id = ?";
            System.out.println("Executing account query: " + accountSql + " with userId: " + userId);
            
            try (PreparedStatement accountStmt = conn.prepareStatement(accountSql)) {
                accountStmt.setInt(1, userId);
                try (ResultSet accountRs = accountStmt.executeQuery()) {
                    System.out.println("Account ResultSet metadata:");
                    System.out.println("Column count: " + accountRs.getMetaData().getColumnCount());
                    for (int i = 1; i <= accountRs.getMetaData().getColumnCount(); i++) {
                        System.out.println("Column " + i + ": " + accountRs.getMetaData().getColumnName(i));
                    }
                    
                    boolean hasAccounts = false;
                    while (accountRs.next()) {
                        hasAccounts = true;
                        int accountId = accountRs.getInt("account_id");
                        String accountNumber = accountRs.getString("account_number");
                        double balance = accountRs.getDouble("balance");
                        System.out.println("Found account - ID: " + accountId + ", Number: " + accountNumber + ", Balance: " + balance);
                        accounts.add(new Account(accountId, accountNumber, balance));
                    }
                    System.out.println("Has accounts: " + hasAccounts);
                }
            }

            System.out.println("Total accounts found: " + accounts.size());

            if (accounts.isEmpty()) {
                System.out.println("No accounts found for user. Redirecting with error.");
                response.sendRedirect("accounts.jsp?error=No accounts found");
                return;
            }

            // Query for transaction history
            String transactionSql = "SELECT t.transaction_id, t.amount, t.transaction_date, t.transaction_type, t.status, " +
                                  "t.from_account_id, t.to_account_id, t.otp " +
                                  "FROM transactions t " +
                                  "WHERE t.user_id = ? " +
                                  "ORDER BY t.transaction_date DESC";
            System.out.println("Executing transaction query: " + transactionSql + " with userId: " + userId);
            
            try (PreparedStatement transactionStmt = conn.prepareStatement(transactionSql)) {
                transactionStmt.setInt(1, userId);
                try (ResultSet transactionRs = transactionStmt.executeQuery()) {
                    System.out.println("Transaction ResultSet metadata:");
                    System.out.println("Column count: " + transactionRs.getMetaData().getColumnCount());
                    for (int i = 1; i <= transactionRs.getMetaData().getColumnCount(); i++) {
                        System.out.println("Column " + i + ": " + transactionRs.getMetaData().getColumnName(i));
                    }
                    
                    boolean hasTransactions = false;
                    while (transactionRs.next()) {
                        hasTransactions = true;
                        int transactionId = transactionRs.getInt("transaction_id");
                        double amount = transactionRs.getDouble("amount");
                        java.sql.Timestamp date = transactionRs.getTimestamp("transaction_date");
                        String type = transactionRs.getString("transaction_type");
                        String status = transactionRs.getString("status");
                        int fromAccountId = transactionRs.getInt("from_account_id");
                        int toAccountId = transactionRs.getInt("to_account_id");
                        String otp = transactionRs.getString("otp");
                        
                        System.out.println("Found transaction - ID: " + transactionId + 
                                         ", Amount: " + amount + 
                                         ", Date: " + date + 
                                         ", Type: " + type +
                                         ", Status: " + status +
                                         ", From: " + fromAccountId +
                                         ", To: " + toAccountId);
                                         
                        Transaction transaction = new Transaction(transactionId, amount, date, type);
                        transaction.setStatus(status);
                        transaction.setOtp(otp);
                        transaction.setFromAccountId(fromAccountId);
                        transaction.setToAccountId(toAccountId);
                        transactions.add(transaction);
                    }
                    System.out.println("Has transactions: " + hasTransactions);
                }
            }

            System.out.println("Total transactions found: " + transactions.size());

            // Set attributes to be accessed in JSP
            request.setAttribute("accounts", accounts);
            request.setAttribute("transactions", transactions);
            
            // Debug the data being set
            System.out.println("=== Setting Request Attributes ===");
            System.out.println("Accounts list size: " + accounts.size());
            for (Account account : accounts) {
                System.out.println("Account: " + account.toString());
            }
            
            System.out.println("Transactions list size: " + transactions.size());
            for (Transaction transaction : transactions) {
                System.out.println("Transaction: " + transaction.toString());
            }
            
            System.out.println("Attributes set in request: accounts and transactions");

            // Forward to account page to display account and transaction details
            System.out.println("Forwarding to accounts.jsp");
            request.getRequestDispatcher("accounts.jsp").forward(request, response);

        } catch (SQLException e) {
            System.out.println("SQL Exception occurred: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("accounts.jsp?error=Database error: " + e.getMessage());
        } catch (Exception e) {
            System.out.println("Unexpected Exception occurred: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("accounts.jsp?error=Unexpected error: " + e.getMessage());
        }
    }
}
