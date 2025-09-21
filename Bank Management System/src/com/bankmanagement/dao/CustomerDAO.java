package com.bankmanagement.dao;

import com.bankmanagement.model.Customer;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CustomerDAO {
    
    private Connection connection;
    
    public CustomerDAO() {
        this.connection = DatabaseConnection.getConnection();
    }
    
    // CREATE - Add new customer
    public boolean addCustomer(Customer customer) {
        String sql = "INSERT INTO customers (customer_type, dob, first_name, last_name, email, mobile_no, city, pan) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setString(1, customer.getCustomerType());
            pstmt.setDate(2, customer.getDob());
            pstmt.setString(3, customer.getFirstName());
            pstmt.setString(4, customer.getLastName());
            pstmt.setString(5, customer.getEmail());
            pstmt.setString(6, customer.getMobileNo());
            pstmt.setString(7, customer.getCity());
            pstmt.setString(8, customer.getPan());
            
            int result = pstmt.executeUpdate();
            return result > 0;
            
        } catch (SQLException e) {
            System.err.println("Error adding customer: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    // READ - Get all customers
    public List<Customer> getAllCustomers() {
        List<Customer> customers = new ArrayList<>();
        String sql = "SELECT * FROM customers ORDER BY created_date DESC";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            
            while (rs.next()) {
                Customer customer = new Customer();
                customer.setCustomerId(rs.getInt("customer_id"));
                customer.setCustomerType(rs.getString("customer_type"));
                customer.setDob(rs.getDate("dob"));
                customer.setFirstName(rs.getString("first_name"));
                customer.setLastName(rs.getString("last_name"));
                customer.setEmail(rs.getString("email"));
                customer.setMobileNo(rs.getString("mobile_no"));
                customer.setCity(rs.getString("city"));
                customer.setPan(rs.getString("pan"));
                customer.setCreatedDate(rs.getDate("created_date"));
                
                customers.add(customer);
            }
            
        } catch (SQLException e) {
            System.err.println("Error fetching customers: " + e.getMessage());
            e.printStackTrace();
        }
        
        return customers;
    }
    
    // READ - Get customer by ID
    public Customer getCustomerById(int customerId) {
        String sql = "SELECT * FROM customers WHERE customer_id = ?";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, customerId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                Customer customer = new Customer();
                customer.setCustomerId(rs.getInt("customer_id"));
                customer.setCustomerType(rs.getString("customer_type"));
                customer.setDob(rs.getDate("dob"));
                customer.setFirstName(rs.getString("first_name"));
                customer.setLastName(rs.getString("last_name"));
                customer.setEmail(rs.getString("email"));
                customer.setMobileNo(rs.getString("mobile_no"));
                customer.setCity(rs.getString("city"));
                customer.setPan(rs.getString("pan"));
                customer.setCreatedDate(rs.getDate("created_date"));
                
                return customer;
            }
            
        } catch (SQLException e) {
            System.err.println("Error fetching customer: " + e.getMessage());
            e.printStackTrace();
        }
        
        return null;
    }
    
    // UPDATE - Update customer
    public boolean updateCustomer(Customer customer) {
        String sql = "UPDATE customers SET customer_type=?, dob=?, first_name=?, last_name=?, email=?, mobile_no=?, city=?, pan=? WHERE customer_id=?";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setString(1, customer.getCustomerType());
            pstmt.setDate(2, customer.getDob());
            pstmt.setString(3, customer.getFirstName());
            pstmt.setString(4, customer.getLastName());
            pstmt.setString(5, customer.getEmail());
            pstmt.setString(6, customer.getMobileNo());
            pstmt.setString(7, customer.getCity());
            pstmt.setString(8, customer.getPan());
            pstmt.setInt(9, customer.getCustomerId());
            
            int result = pstmt.executeUpdate();
            return result > 0;
            
        } catch (SQLException e) {
            System.err.println("Error updating customer: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    // DELETE - Delete customer
    public boolean deleteCustomer(int customerId) {
        String sql = "DELETE FROM customers WHERE customer_id = ?";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, customerId);
            int result = pstmt.executeUpdate();
            return result > 0;
            
        } catch (SQLException e) {
            System.err.println("Error deleting customer: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    // Get customer count
    public int getCustomerCount() {
        String sql = "SELECT COUNT(*) FROM customers";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            
            if (rs.next()) {
                return rs.getInt(1);
            }
            
        } catch (SQLException e) {
            System.err.println("Error getting customer count: " + e.getMessage());
            e.printStackTrace();
        }
        
        return 0;
    }
}