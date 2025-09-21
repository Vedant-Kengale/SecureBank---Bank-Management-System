package com.bankmanagement.model;

import java.math.BigDecimal;
import java.sql.Date;

public class Loan {
    private int loanId;
    private int customerId;
    private String loanType;
    private BigDecimal loanAmount;
    private BigDecimal interestRate;
    private int loanTerm;
    private BigDecimal monthlyPayment;
    private String loanStatus;
    private Date applicationDate;
    private Date approvalDate;
    
    // Default Constructor
    public Loan() {}
    
    // Parameterized Constructor
    public Loan(int customerId, String loanType, BigDecimal loanAmount, 
               BigDecimal interestRate, int loanTerm) {
        this.customerId = customerId;
        this.loanType = loanType;
        this.loanAmount = loanAmount;
        this.interestRate = interestRate;
        this.loanTerm = loanTerm;
        this.loanStatus = "Pending";
        this.calculateMonthlyPayment();
    }
    
    // Business Logic Method
    public void calculateMonthlyPayment() {
        if (loanAmount != null && interestRate != null && loanTerm > 0) {
            double monthlyRate = interestRate.doubleValue() / 12 / 100;
            double payment = (loanAmount.doubleValue() * monthlyRate * 
                            Math.pow(1 + monthlyRate, loanTerm)) / 
                           (Math.pow(1 + monthlyRate, loanTerm) - 1);
            this.monthlyPayment = BigDecimal.valueOf(payment);
        }
    }
    
    // Getters and Setters
    public int getLoanId() {
        return loanId;
    }
    
    public void setLoanId(int loanId) {
        this.loanId = loanId;
    }
    
    public int getCustomerId() {
        return customerId;
    }
    
    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }
    
    public String getLoanType() {
        return loanType;
    }
    
    public void setLoanType(String loanType) {
        this.loanType = loanType;
    }
    
    public BigDecimal getLoanAmount() {
        return loanAmount;
    }
    
    public void setLoanAmount(BigDecimal loanAmount) {
        this.loanAmount = loanAmount;
    }
    
    public BigDecimal getInterestRate() {
        return interestRate;
    }
    
    public void setInterestRate(BigDecimal interestRate) {
        this.interestRate = interestRate;
    }
    
    public int getLoanTerm() {
        return loanTerm;
    }
    
    public void setLoanTerm(int loanTerm) {
        this.loanTerm = loanTerm;
    }
    
    public BigDecimal getMonthlyPayment() {
        return monthlyPayment;
    }
    
    public void setMonthlyPayment(BigDecimal monthlyPayment) {
        this.monthlyPayment = monthlyPayment;
    }
    
    public String getLoanStatus() {
        return loanStatus;
    }
    
    public void setLoanStatus(String loanStatus) {
        this.loanStatus = loanStatus;
    }
    
    public Date getApplicationDate() {
        return applicationDate;
    }
    
    public void setApplicationDate(Date applicationDate) {
        this.applicationDate = applicationDate;
    }
    
    public Date getApprovalDate() {
        return approvalDate;
    }
    
    public void setApprovalDate(Date approvalDate) {
        this.approvalDate = approvalDate;
    }
    
    @Override
    public String toString() {
        return "Loan{" +
                "loanId=" + loanId +
                ", customerId=" + customerId +
                ", loanType='" + loanType + '\'' +
                ", loanAmount=" + loanAmount +
                ", interestRate=" + interestRate +
                ", loanTerm=" + loanTerm +
                ", monthlyPayment=" + monthlyPayment +
                ", loanStatus='" + loanStatus + '\'' +
                '}';
    }
}