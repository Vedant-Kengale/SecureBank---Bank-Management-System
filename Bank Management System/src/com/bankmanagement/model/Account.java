package com.bankmanagement.model;

import java.math.BigDecimal;
import java.sql.Date;

public class Account {
    private int accountId;
    private String accountNo;
    private int customerId;
    private String accountType;
    private BigDecimal currentBalance;
    private String accountStatus;
    private Date createdDate;
    
    // Default Constructor
    public Account() {}
    
    // Parameterized Constructor
    public Account(int customerId, String accountType, BigDecimal initialBalance) {
        this.customerId = customerId;
        this.accountType = accountType;
        this.currentBalance = initialBalance;
        this.accountStatus = "Active";
    }
    
    // Getters and Setters
    public int getAccountId() {
        return accountId;
    }
    
    public void setAccountId(int accountId) {
        this.accountId = accountId;
    }
    
    public String getAccountNo() {
        return accountNo;
    }
    
    public void setAccountNo(String accountNo) {
        this.accountNo = accountNo;
    }
    
    public int getCustomerId() {
        return customerId;
    }
    
    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }
    
    public String getAccountType() {
        return accountType;
    }
    
    public void setAccountType(String accountType) {
        this.accountType = accountType;
    }
    
    public BigDecimal getCurrentBalance() {
        return currentBalance;
    }
    
    public void setCurrentBalance(BigDecimal currentBalance) {
        this.currentBalance = currentBalance;
    }
    
    public String getAccountStatus() {
        return accountStatus;
    }
    
    public void setAccountStatus(String accountStatus) {
        this.accountStatus = accountStatus;
    }
    
    public Date getCreatedDate() {
        return createdDate;
    }
    
    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }
    
    @Override
    public String toString() {
        return "Account{" +
                "accountId=" + accountId +
                ", accountNo='" + accountNo + '\'' +
                ", customerId=" + customerId +
                ", accountType='" + accountType + '\'' +
                ", currentBalance=" + currentBalance +
                ", accountStatus='" + accountStatus + '\'' +
                '}';
    }
}