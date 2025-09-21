package com.bankmanagement.dao;

import com.bankmanagement.model.Loan;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class LoanDAO {
    
    private Connection connection;
    
    public LoanDAO() {
        this.connection = DatabaseConnection.getConnection();
    }
    
    // CREATE - Add new loan
    public boolean addLoan(Loan loan) {
        String sql = "INSERT INTO loans (customer_id, loan_type, loan_amount, interest_rate, loan_term, monthly_payment) VALUES (?, ?, ?, ?, ?, ?)";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, loan.getCustomerId());
            pstmt.setString(2, loan.getLoanType());
            pstmt.setBigDecimal(3, loan.getLoanAmount());
            pstmt.setBigDecimal(4, loan.getInterestRate());
            pstmt.setInt(5, loan.getLoanTerm());
            pstmt.setBigDecimal(6, loan.getMonthlyPayment());
            
            int result = pstmt.executeUpdate();
            return result > 0;
            
        } catch (SQLException e) {
            System.err.println("Error adding loan: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    // READ - Get all loans
    public List<Loan> getAllLoans() {
        List<Loan> loans = new ArrayList<>();
        String sql = "SELECT * FROM loans ORDER BY application_date DESC";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            
            while (rs.next()) {
                Loan loan = new Loan();
                loan.setLoanId(rs.getInt("loan_id"));
                loan.setCustomerId(rs.getInt("customer_id"));
                loan.setLoanType(rs.getString("loan_type"));
                loan.setLoanAmount(rs.getBigDecimal("loan_amount"));
                loan.setInterestRate(rs.getBigDecimal("interest_rate"));
                loan.setLoanTerm(rs.getInt("loan_term"));
                loan.setMonthlyPayment(rs.getBigDecimal("monthly_payment"));
                loan.setLoanStatus(rs.getString("loan_status"));
                loan.setApplicationDate(rs.getDate("application_date"));
                loan.setApprovalDate(rs.getDate("approval_date"));
                
                loans.add(loan);
            }
            
        } catch (SQLException e) {
            System.err.println("Error fetching loans: " + e.getMessage());
            e.printStackTrace();
        }
        
        return loans;
    }
    
    // UPDATE - Update loan status
    public boolean updateLoanStatus(int loanId, String status) {
        String sql = "UPDATE loans SET loan_status = ?, approval_date = ? WHERE loan_id = ?";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setString(1, status);
            if (status.equals("Approved")) {
                pstmt.setDate(2, new Date(System.currentTimeMillis()));
            } else {
                pstmt.setDate(2, null);
            }
            pstmt.setInt(3, loanId);
            
            int result = pstmt.executeUpdate();
            return result > 0;
            
        } catch (SQLException e) {
            System.err.println("Error updating loan status: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    // Get active loans count
    public int getActiveLoanCount() {
        String sql = "SELECT COUNT(*) FROM loans WHERE loan_status = 'Approved'";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            
            if (rs.next()) {
                return rs.getInt(1);
            }
            
        } catch (SQLException e) {
            System.err.println("Error getting active loan count: " + e.getMessage());
            e.printStackTrace();
        }
        
        return 0;
    }
}