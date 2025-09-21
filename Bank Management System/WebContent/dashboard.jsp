<%-- dashboard.jsp - Main Dashboard Page --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*, java.text.SimpleDateFormat, java.text.DecimalFormat" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Bank Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary sticky-top">
        <div class="container">
            <a class="navbar-brand" href="index.jsp" style="font-size: 1.8rem;">
                <i class="fas fa-university me-2"></i>SecureBank
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link active" href="dashboard.jsp">Dashboard</a></li>
                    <li class="nav-item"><a class="nav-link" href="customers.jsp">Customers</a></li>
                    <li class="nav-item"><a class="nav-link" href="accounts.jsp">Accounts</a></li>
                    <li class="nav-item"><a class="nav-link" href="transactions.jsp">Transactions</a></li>
                    <li class="nav-item"><a class="nav-link" href="loans.jsp">Loans</a></li>
                    <li class="nav-item">
                        <a class="nav-link" href="#" onclick="logout()">
                            <i class="fas fa-sign-out-alt me-1"></i>Logout
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container-fluid mt-4">
        <!-- Welcome Section -->
        <div class="row mb-4">
            <div class="col-12">
                <div class="card border-0 shadow-sm" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);">
                    <div class="card-body text-white text-center py-5">
                        <h2 class="mb-3">
                            <i class="fas fa-tachometer-alt me-2"></i>
                            Welcome to Dashboard
                        </h2>
                        <p class="mb-0 fs-5">Comprehensive overview of your banking operations</p>
                        <small class="opacity-75">Last updated: <%= new java.util.Date() %></small>
                    </div>
                </div>
            </div>
        </div>

        <!-- Statistics Cards -->
        <div class="row g-4 mb-5">
            <%
            // Sample data - Replace with actual database queries
            String[][] stats = {
                {"1,247", "Total Customers", "fas fa-users", "primary", "+12%"},
                {"₹52.8M", "Total Balance", "fas fa-wallet", "success", "+8.5%"},
                {"3,456", "Today's Transactions", "fas fa-exchange-alt", "info", "+23%"},
                {"892", "Active Accounts", "fas fa-credit-card", "warning", "+5.2%"}
            };
            
            for(String[] stat : stats) {
            %>
            <div class="col-lg-3 col-md-6">
                <div class="card border-0 shadow-sm h-100">
                    <div class="card-body text-center">
                        <div class="mb-3">
                            <i class="<%= stat[2] %> fa-3x text-<%= stat[3] %>"></i>
                        </div>
                        <h3 class="card-title mb-1"><%= stat[0] %></h3>
                        <p class="card-text text-muted mb-2"><%= stat[1] %></p>
                        <small class="text-success">
                            <i class="fas fa-arrow-up me-1"></i><%= stat[4] %> from last month
                        </small>
                    </div>
                </div>
            </div>
            <% } %>
        </div>

        <div class="row g-4">
            <!-- Recent Transactions -->
            <div class="col-lg-8">
                <div class="card shadow-sm">
                    <div class="card-header bg-primary text-white">
                        <h5 class="mb-0">
                            <i class="fas fa-clock me-2"></i>Recent Transactions
                        </h5>
                    </div>
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table class="table table-hover mb-0">
                                <thead class="table-light">
                                    <tr>
                                        <th>ID</th>
                                        <th>Account</th>
                                        <th>Type</th>
                                        <th>Amount</th>
                                        <th>Status</th>
                                        <th>Time</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                    String[][] transactions = {
                                        {"TXN001", "John Doe", "DEPOSIT", "+25,000", "COMPLETED", "10:30 AM"},
                                        {"TXN002", "Sarah Wilson", "WITHDRAWAL", "-15,500", "COMPLETED", "09:45 AM"},
                                        {"TXN003", "Mike Johnson", "TRANSFER", "8,750", "PENDING", "09:20 AM"},
                                        {"TXN004", "Emma Davis", "DEPOSIT", "+12,000", "COMPLETED", "08:15 AM"},
                                        {"TXN005", "Robert Brown", "TRANSFER", "5,500", "COMPLETED", "07:30 AM"}
                                    };
                                    
                                    for(String[] txn : transactions) {
                                        String amountClass = txn[3].startsWith("+") ? "text-success" : 
                                                           txn[3].startsWith("-") ? "text-danger" : "text-primary";
                                        String statusBadge = txn[4].equals("COMPLETED") ? "bg-success" : 
                                                           txn[4].equals("PENDING") ? "bg-warning" : "bg-danger";
                                    %>
                                    <tr>
                                        <td><strong><%= txn[0] %></strong></td>
                                        <td><%= txn[1] %></td>
                                        <td><span class="badge bg-secondary"><%= txn[2] %></span></td>
                                        <td><strong class="<%= amountClass %>">₹<%= txn[3] %></strong></td>
                                        <td><span class="badge <%= statusBadge %>"><%= txn[4] %></span></td>
                                        <td><%= txn[5] %></td>
                                    </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="card-footer text-center">
                        <a href="transactions.jsp" class="btn btn-outline-primary">
                            <i class="fas fa-eye me-2"></i>View All Transactions
                        </a>
                    </div>
                </div>
            </div>

            <!-- Quick Actions & Account Summary -->
            <div class="col-lg-4">
                <!-- Quick Actions -->
                <div class="card shadow-sm mb-4">
                    <div class="card-header bg-success text-white">
                        <h5 class="mb-0">
                            <i class="fas fa-bolt me-2"></i>Quick Actions
                        </h5>
                    </div>
                    <div class="card-body">
                        <div class="d-grid gap-2">
                            <a href="customers.jsp" class="btn btn-outline-primary">
                                <i class="fas fa-user-plus me-2"></i>Add Customer
                            </a>
                            <a href="accounts.jsp" class="btn btn-outline-success">
                                <i class="fas fa-plus me-2"></i>Create Account
                            </a>
                            <a href="transactions.jsp" class="btn btn-outline-info">
                                <i class="fas fa-exchange-alt me-2"></i>New Transaction
                            </a>
                            <a href="loans.jsp" class="btn btn-outline-warning">
                                <i class="fas fa-hand-holding-usd me-2"></i>Loan Application
                            </a>
                        </div>
                    </div>
                </div>

                <!-- Account Types Summary -->
                <div class="card shadow-sm">
                    <div class="card-header bg-info text-white">
                        <h5 class="mb-0">
                            <i class="fas fa-chart-pie me-2"></i>Account Types
                        </h5>
                    </div>
                    <div class="card-body">
                        <%
                        String[][] accountTypes = {
                            {"Savings", "485", "54%", "success"},
                            {"Current", "312", "35%", "primary"},
                            {"Fixed Deposit", "95", "11%", "warning"}
                        };
                        
                        for(String[] acc : accountTypes) {
                        %>
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <div>
                                <h6 class="mb-0"><%= acc[0] %></h6>
                                <small class="text-muted"><%= acc[1] %> accounts</small>
                            </div>
                            <div class="text-end">
                                <span class="badge bg-<%= acc[3] %>"><%= acc[2] %></span>
                            </div>
                        </div>
                        <div class="progress mb-3" style="height: 8px;">
                            <div class="progress-bar bg-<%= acc[3] %>" style="width: <%= acc[2] %>"></div>
                        </div>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>

        <!-- Additional Dashboard Sections -->
        <div class="row g-4 mt-4">
            <!-- Recent Customers -->
            <div class="col-lg-6">
                <div class="card shadow-sm">
                    <div class="card-header bg-secondary text-white">
                        <h5 class="mb-0">
                            <i class="fas fa-users me-2"></i>Recent Customers
                        </h5>
                    </div>
                    <div class="card-body">
                        <%
                        String[][] customers = {
                            {"Alice Johnson", "alice@email.com", "2024-01-15", "Savings"},
                            {"Bob Smith", "bob@email.com", "2024-01-14", "Current"},
                            {"Carol Davis", "carol@email.com", "2024-01-13", "Savings"},
                            {"David Wilson", "david@email.com", "2024-01-12", "Fixed Deposit"}
                        };
                        
                        for(String[] customer : customers) {
                        %>
                        <div class="d-flex align-items-center mb-3">
                            <div class="bg-primary rounded-circle d-flex align-items-center justify-content-center me-3" style="width: 40px; height: 40px;">
                                <i class="fas fa-user text-white"></i>
                            </div>
                            <div class="flex-grow-1">
                                <h6 class="mb-0"><%= customer[0] %></h6>
                                <small class="text-muted"><%= customer[1] %></small>
                            </div>
                            <div class="text-end">
                                <small class="text-muted d-block"><%= customer[2] %></small>
                                <span class="badge bg-light text-dark"><%= customer[3] %></span>
                            </div>
                        </div>
                        <% } %>
                    </div>
                    <div class="card-footer text-center">
                        <a href="customers.jsp" class="btn btn-outline-secondary">
                            <i class="fas fa-users me-2"></i>View All Customers
                        </a>
                    </div>
                </div>
            </div>

            <!-- System Alerts -->
            <div class="col-lg-6">
                <div class="card shadow-sm">
                    <div class="card-header bg-warning text-dark">
                        <h5 class="mb-0">
                            <i class="fas fa-exclamation-triangle me-2"></i>System Alerts
                        </h5>
                    </div>
                    <div class="card-body">
                        <div class="alert alert-warning">
                            <i class="fas fa-exclamation-triangle me-2"></i>
                            <strong>Low Balance Alert:</strong> 15 accounts have balance below ₹10,000
                        </div>
                        <div class="alert alert-info">
                            <i class="fas fa-info-circle me-2"></i>
                            <strong>System Maintenance:</strong> Scheduled maintenance on Sunday 2AM-4AM
                        </div>
                        <div class="alert alert-success">
                            <i class="fas fa-check-circle me-2"></i>
                            <strong>Backup Complete:</strong> Daily backup completed successfully
                        </div>
                        <div class="alert alert-primary">
                            <i class="fas fa-bell me-2"></i>
                            <strong>New Feature:</strong> Mobile banking app now available for download
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="mt-5 py-4 bg-dark text-white text-center">
        <div class="container">
            <p class="mb-0">&copy; 2024 developed by Vedant Kengale. All rights reserved.</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Auto-refresh dashboard data every 30 seconds
        setInterval(function() {
            // Here you would implement AJAX calls to refresh data
            console.log('Dashboard refreshed at: ' + new Date().toLocaleTimeString());
        }, 30000);

        // Logout function
        function logout() {
            if(confirm('Are you sure you want to logout?')) {
                window.location.href = 'index.jsp';
            }
        }

        // Add smooth animations on page load
        document.addEventListener('DOMContentLoaded', function() {
            const cards = document.querySelectorAll('.card');
            cards.forEach((card, index) => {
                card.style.opacity = '0';
                card.style.transform = 'translateY(20px)';
                
                setTimeout(() => {
                    card.style.transition = 'all 0.6s ease';
                    card.style.opacity = '1';
                    card.style.transform = 'translateY(0)';
                }, index * 100);
            });
        });

        // Real-time clock
        function updateClock() {
            const now = new Date();
            const timeString = now.toLocaleTimeString();
            const dateString = now.toLocaleDateString();
            
            // Update if clock element exists
            const clockElement = document.getElementById('live-clock');
            if (clockElement) {
                clockElement.innerHTML = `${dateString} ${timeString}`;
            }
        }

        // Update clock every second
        setInterval(updateClock, 1000);
        updateClock(); // Initial call

        // Chart.js integration for future enhancements
        function initializeCharts() {
            // Transaction trends chart
            const ctx1 = document.getElementById('transactionChart');
            if (ctx1) {
                new Chart(ctx1, {
                    type: 'line',
                    data: {
                        labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
                        datasets: [{
                            label: 'Transactions',
                            data: [12, 19, 3, 5, 2, 3, 7],
                            borderColor: 'rgb(75, 192, 192)',
                            tension: 0.1
                        }]
                    }
                });
            }
        }
    </script>
</body>
</html>