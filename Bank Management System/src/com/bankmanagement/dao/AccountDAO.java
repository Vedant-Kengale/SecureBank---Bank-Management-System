package com.bankmanagement.dao;

import com.bankmanagement.model.Account;
import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AccountDAO {
    
    private Connection connection;
    
    public AccountDAO() {
        this.connection = DatabaseConnection.getConnection();
    }
    
    // CREATE - Add new account
    public boolean addAccount(Account account) {
        String sql = "INSERT INTO accounts (customer_id, account_type, current_balance) VALUES (?, ?, ?)";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, account.getCustomerId());
            pstmt.setString(2, account.getAccountType());
            pstmt.setBigDecimal(3, account.getCurrentBalance());
            
            int result = pstmt.executeUpdate();
            return result > 0;
            
        } catch (SQLException e) {
            System.err.println("Error adding account: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    // READ - Get all accounts
    public List<Account> getAllAccounts() {
        List<Account> accounts = new ArrayList<>();
        String sql = "SELECT * FROM accounts ORDER BY created_date DESC";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            
            while (rs.next()) {
                Account account = new Account();
                account.setAccountId(rs.getInt("account_id"));
                account.setAccountNo(rs.getString("account_no"));
                account.setCustomerId(rs.getInt("customer_id"));
                account.setAccountType(rs.getString("account_type"));
                account.setCurrentBalance(rs.getBigDecimal("current_balance"));
                account.setAccountStatus(rs.getString("account_status"));
                account.setCreatedDate(rs.getDate("created_date"));
                
                accounts.add(account);
            }
            
        } catch (SQLException e) {
            System.err.println("Error fetching accounts: " + e.getMessage());
            e.printStackTrace();
        }
        
        return accounts;
    }
    
    // READ - Get account by ID
    public Account getAccountById(int accountId) {
        String sql = "SELECT * FROM accounts WHERE account_id = ?";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, accountId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                Account account = new Account();
                account.setAccountId(rs.getInt("account_id"));
                account.setAccountNo(rs.getString("account_no"));
                account.setCustomerId(rs.getInt("customer_id"));
                account.setAccountType(rs.getString("account_type"));
                account.setCurrentBalance(rs.getBigDecimal("current_balance"));
                account.setAccountStatus(rs.getString("account_status"));
                account.setCreatedDate(rs.getDate("created_date"));
                
                return account;
            }
            
        } catch (SQLException e) {
            System.err.println("Error fetching account: " + e.getMessage());
            e.printStackTrace();
        }
        
        return null;
    }
    
    // UPDATE - Update account balance
    public boolean updateAccountBalance(int accountId, BigDecimal newBalance) {
        String sql = "UPDATE accounts SET current_balance = ? WHERE account_id = ?";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setBigDecimal(1, newBalance);
            pstmt.setInt(2, accountId);
            
            int result = pstmt.executeUpdate();
            return result > 0;
            
        } catch (SQLException e) {
            System.err.println("Error updating account balance: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    // Business Logic - Deposit money
    public boolean deposit(int accountId, BigDecimal amount) {
        try {
            connection.setAutoCommit(false);
            
            Account account = getAccountById(accountId);
            if (account == null) {
                connection.rollback();
                return false;
            }
            
            BigDecimal newBalance = account.getCurrentBalance().add(amount);
            boolean updated = updateAccountBalance(accountId, newBalance);
            
            if (updated) {
                connection.commit();
                return true;
            } else {
                connection.rollback();
                return false;
            }
            
        } catch (SQLException e) {
            try {
                connection.rollback();
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
            System.err.println("Error during deposit: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            try {
                connection.setAutoCommit(true);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    
    // Business Logic - Withdraw money
    public boolean withdraw(int accountId, BigDecimal amount) {
        try {
            connection.setAutoCommit(false);
            
            Account account = getAccountById(accountId);
            if (account == null) {
                connection.rollback();
                return false;
            }
            
            if (account.getCurrentBalance().compareTo(amount) < 0) {
                connection.rollback();
                return false; // Insufficient funds
            }
            
            BigDecimal newBalance = account.getCurrentBalance().subtract(amount);
            boolean updated = updateAccountBalance(accountId, newBalance);
            
            if (updated) {
                connection.commit();
                return true;
            } else {
                connection.rollback();
                return false;
            }
            
        } catch (SQLException e) {
            try {
                connection.rollback();
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
            System.err.println("Error during withdrawal: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            try {
                connection.setAutoCommit(true);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    
    // Get account count
    public int getAccountCount() {
        String sql = "SELECT COUNT(*) FROM accounts WHERE account_status = 'Active'";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            
            if (rs.next()) {
                return rs.getInt(1);
            }
            
        } catch (SQLException e) {
            System.err.println("Error getting account count: " + e.getMessage());
            e.printStackTrace();
        }
        
        return 0;
    }
    
    // Get total balance
    public BigDecimal getTotalBalance() {
        String sql = "SELECT SUM(current_balance) FROM accounts WHERE account_status = 'Active'";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            
            if (rs.next()) {
                return rs.getBigDecimal(1);
            }
            
        } catch (SQLException e) {
            System.err.println("Error getting total balance: " + e.getMessage());
            e.printStackTrace();
        }
        
        return BigDecimal.ZERO;
    }
}