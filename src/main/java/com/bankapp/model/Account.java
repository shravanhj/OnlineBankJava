package com.bankapp.model;

import java.math.BigDecimal;
import java.sql.Timestamp;


public class Account {
    private int accountId;
    private String accountNumber;
    private double balance;
    private String beneficiaryName;

    public Account(int accountId, String accountNumber, double balance) {
        this.accountId = accountId;
        this.accountNumber = accountNumber;
        this.balance = balance;
    }

    public int getAccountId() {
        return accountId;
    }

    public String getAccountNumber() {
        return accountNumber;
    }

    public double getBalance() {
        return balance;
    }

    public String getBeneficiaryName() {
        return beneficiaryName;
    }

    public void setBeneficiaryName(String beneficiaryName) {
        this.beneficiaryName = beneficiaryName;
    }

    @Override
    public String toString() {
        return "Account{" +
                "accountId=" + accountId +
                ", accountNumber='" + accountNumber + '\'' +
                ", balance=" + balance +
                '}';
    }
}
