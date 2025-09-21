<%-- index.jsp - Main Landing Page --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bank Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <!-- Header -->
    <header class="header-section">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <div class="d-flex align-items-center">
                        <i class="fas fa-university brand-icon me-3"></i>
                        <div>
                            <h1 class="mb-0 text-white" style="font-size: 2.5rem;">SecureBank</h1>
                            <p class="mb-0 text-white-50">Professional Banking Solution with Advanced Database Features</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 text-end">
                    <div class="nav-menu">
                        <a href="index.jsp" class="nav-item active">Home</a>
                        <a href="dashboard.jsp" class="nav-item">Dashboard</a>
                        <a href="customers.jsp" class="nav-item">Customers</a>
                        <a href="accounts.jsp" class="nav-item">Accounts</a>
                        <a href="transactions.jsp" class="nav-item">Transactions</a>
                        <a href="loans.jsp" class="nav-item">Loans</a>
                    </div>
                </div>
            </div>
        </div>
    </header>

    <!-- Access Dashboard -->
    <section class="access-dashboard">
        <div class="container text-center">
            <a href="dashboard.jsp" class="btn btn-primary btn-lg dashboard-btn">
                <i class="fas fa-tachometer-alt me-2"></i>
                Access Dashboard
            </a>
        </div>
    </section>

    <!-- Main Content -->
    <main class="main-content">
        <div class="container">
            <div class="row g-4">
                <!-- Customer Management -->
                <div class="col-lg-4 col-md-6">
                    <div class="feature-card h-100">
                        <div class="text-center">
                            <i class="fas fa-users feature-icon"></i>
                            <h3 class="feature-title">Customer Management</h3>
                            <p class="feature-description">
                                Complete customer lifeCycle management with advanced CRUD operations and validation
                            </p>
                            <a href="customers.jsp" class="btn btn-primary feature-btn">
                                <i class="fas fa-eye me-2"></i>Manage Customers
                            </a>
                        </div>
                    </div>
                </div>

                <!-- Account Operations -->
                <div class="col-lg-4 col-md-6">
                    <div class="feature-card h-100">
                        <div class="text-center">
                            <i class="fas fa-university feature-icon"></i>
                            <h3 class="feature-title">Account Operations</h3>
                            <p class="feature-description">
                                Handle multiple account types with real-time balance management and automated triggers
                            </p>
                            <a href="accounts.jsp" class="btn btn-primary feature-btn">
                                <i class="fas fa-eye me-2"></i>Manage Accounts
                            </a>
                        </div>
                    </div>
                </div>

                <!-- Transaction Processing -->
                <div class="col-lg-4 col-md-6">
                    <div class="feature-card h-100">
                        <div class="text-center">
                            <i class="fas fa-exchange-alt feature-icon"></i>
                            <h3 class="feature-title">Transaction Processing</h3>
                            <p class="feature-description">
                                Secure transaction processing with automated logging and comprehensive audit trails
                            </p>
                            <a href="transactions.jsp" class="btn btn-primary feature-btn">
                                <i class="fas fa-eye me-2"></i>View Transactions
                            </a>
                        </div>
                    </div>
                </div>

                <!-- Loan Management -->
                <div class="col-lg-4 col-md-6">
                    <div class="feature-card h-100">
                        <div class="text-center">
                            <i class="fas fa-hand-holding-usd feature-icon"></i>
                            <h3 class="feature-title">Loan Management</h3>
                            <p class="feature-description">
                                Complete loan lifecycle from application to closure with automated calculations
                            </p>
                            <a href="loans.jsp" class="btn btn-primary feature-btn">
                                <i class="fas fa-eye me-2"></i>Manage Loans
                            </a>
                        </div>
                    </div>
                </div>

                <!-- Advanced Analytics -->
                <div class="col-lg-4 col-md-6">
                    <div class="feature-card h-100">
                        <div class="text-center">
                            <i class="fas fa-chart-bar feature-icon"></i>
                            <h3 class="feature-title">Advanced Analytics</h3>
                            <p class="feature-description">
                                Comprehensive reporting with GROUP BY, HAVING clauses and complex JOIN operations
                            </p>
                            <a href="analytics.jsp" class="btn btn-primary feature-btn">
                                <i class="fas fa-eye me-2"></i>View Analytics
                            </a>
                        </div>
                    </div>
                </div>

                <!-- Database Features -->
                <!-- div class="col-lg-4 col-md-6">
                    <div class="feature-card h-100">
                        <div class="text-center">
                            <i class="fas fa-database feature-icon"></i>
                            <h3 class="feature-title">Database Features</h3>
                            <p class="feature-description">
                                Stored procedures, functions, triggers, cursors with comprehensive exception handling
                            </p>
                            <a href="database.jsp" class="btn btn-primary feature-btn">
                                <i class="fas fa-cog me-2"></i>Database Tools
                            </a>
                        </div>
                    </div>
                </div-->
            </div>
        </div>
    </main>

    <!-- Footer -->
    <footer class="footer-section">
        <div class="container text-center">
            <div class="d-flex justify-content-center align-items-center mb-3">
                <i class="fas fa-university me-2"></i>
                <span class="fw-bold">SecureBank Management System</span>
            </div>
            <p class="mb-2">Professional banking solution demonstrating advanced database management</p>
            <p>&copy; 2024 developed by Vedant Kengale</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="js/main.js"></script>
</body>
</html>