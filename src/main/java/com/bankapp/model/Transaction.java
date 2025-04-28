package com.bankapp.model;

import java.sql.Timestamp;

public class Transaction {
    private int transactionId;
    private double amount;
    private Timestamp date;
    private String type;
    private String status;
    private int fromAccountId;
    private int toAccountId;
    private String otp;

    public Transaction(int transactionId, double amount, Timestamp date, String type) {
        this.transactionId = transactionId;
        this.amount = amount;
        this.date = date;
        this.type = type;
    }

    public int getTransactionId() {
        return transactionId;
    }

    public double getAmount() {
        return amount;
    }

    public Timestamp getDate() {
        return date;
    }

    public String getType() {
        return type;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getFromAccountId() {
        return fromAccountId;
    }

    public void setFromAccountId(int fromAccountId) {
        this.fromAccountId = fromAccountId;
    }

    public int getToAccountId() {
        return toAccountId;
    }

    public void setToAccountId(int toAccountId) {
        this.toAccountId = toAccountId;
    }

    public String getOtp() {
        return otp;
    }

    public void setOtp(String otp) {
        this.otp = otp;
    }

    @Override
    public String toString() {
        return "Transaction{" +
                "transactionId=" + transactionId +
                ", amount=" + amount +
                ", date=" + date +
                ", type='" + type + '\'' +
                ", status='" + status + '\'' +
                ", fromAccountId=" + fromAccountId +
                ", toAccountId=" + toAccountId +
                ", otp='" + otp + '\'' +
                '}';
    }
}
