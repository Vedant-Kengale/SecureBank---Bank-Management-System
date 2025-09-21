<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Analytics & Reports - SecureBank</title>
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
                    <li class="nav-item"><a class="nav-link" href="dashboard.jsp">Dashboard</a></li>
                    <li class="nav-item"><a class="nav-link" href="customers.jsp">Customers</a></li>
                    <li class="nav-item"><a class="nav-link" href="accounts.jsp">Accounts</a></li>
                    <li class="nav-item"><a class="nav-link" href="transactions.jsp">Transactions</a></li>
                    <li class="nav-item"><a class="nav-link" href="loans.jsp">Loans</a></li>
                    <li class="nav-item"><a class="nav-link active" href="analytics.jsp">Analytics</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="row">
            <div class="col-12">
                <h2 class="mb-4"><i class="fas fa-chart-bar me-2"></i>Analytics & Reports</h2>
            </div>
        </div>

        <!-- Key Metrics -->
        <div class="row g-4 mb-5">
            <div class="col-lg-3 col-md-6">
                <div class="card text-center shadow">
                    <div class="card-body">
                        <i class="fas fa-dollar-sign fa-3x text-success mb-3"></i>
                        <h3 class="text-success">₹52.8M</h3>
                        <p class="text-muted">Total Assets</p>
                        <small class="text-success"><i class="fas fa-arrow-up"></i> +12.5%</small>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-md-6">
                <div class="card text-center shadow">
                    <div class="card-body">
                        <i class="fas fa-exchange-alt fa-3x text-primary mb-3"></i>
                        <h3 class="text-primary">156K</h3>
                        <p class="text-muted">Monthly Transactions</p>
                        <small class="text-success"><i class="fas fa-arrow-up"></i> +8.3%</small>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-md-6">
                <div class="card text-center shadow">
                    <div class="card-body">
                        <i class="fas fa-users fa-3x text-info mb-3"></i>
                        <h3 class="text-info">1,247</h3>
                        <p class="text-muted">Active Customers</p>
                        <small class="text-success"><i class="fas fa-arrow-up"></i> +5.7%</small>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-md-6">
                <div class="card text-center shadow">
                    <div class="card-body">
                        <i class="fas fa-hand-holding-usd fa-3x text-warning mb-3"></i>
                        <h3 class="text-warning">₹12.5M</h3>
                        <p class="text-muted">Loans Outstanding</p>
                        <small class="text-danger"><i class="fas fa-arrow-down"></i> -2.1%</small>
                    </div>
                </div>
            </div>
        </div>

        <!-- Reports Section -->
        <div class="row g-4">
            <!-- Generate Reports -->
            <div class="col-lg-6">
                <div class="card shadow">
                    <div class="card-header bg-primary text-white">
                        <h5 class="mb-0"><i class="fas fa-file-alt me-2"></i>Generate Reports</h5>
                    </div>
                    <div class="card-body">
                        <form id="reportForm">
                            <div class="mb-3">
                                <label class="form-label">Report Type</label>
                                <select class="form-select" id="reportType" required>
                                    <option value="">Select report type</option>
                                    <option value="DAILY">Daily Summary Report</option>
                                    <option value="WEEKLY">Weekly Analysis Report</option>
                                    <option value="MONTHLY">Monthly Financial Report</option>
                                    <option value="QUARTERLY">Quarterly Performance Report</option>
                                    <option value="YEARLY">Annual Report</option>
                                    <option value="CUSTOM">Custom Date Range Report</option>
                                </select>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <label class="form-label">From Date</label>
                                    <input type="date" class="form-control" id="fromDate">
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">To Date</label>
                                    <input type="date" class="form-control" id="toDate">
                                </div>
                            </div>
                            <div class="mt-3">
                                <label class="form-label">Report Categories</label>
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="includeTransactions" checked>
                                    <label class="form-check-label" for="includeTransactions">Transactions</label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="includeAccounts" checked>
                                    <label class="form-check-label" for="includeAccounts">Account Summary</label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="includeLoans">
                                    <label class="form-check-label" for="includeLoans">Loan Portfolio</label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="includeCustomers">
                                    <label class="form-check-label" for="includeCustomers">Customer Analytics</label>
                                </div>
                            </div>
                            <div class="text-end mt-3">
                                <button type="button" class="btn btn-primary" onclick="generateReport()">
                                    <i class="fas fa-chart-line me-2"></i>Generate Report
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Quick Analytics -->
            <div class="col-lg-6">
                <div class="card shadow">
                    <div class="card-header bg-success text-white">
                        <h5 class="mb-0"><i class="fas fa-tachometer-alt me-2"></i>Quick Analytics</h5>
                    </div>
                    <div class="card-body">
                        <div class="mb-4">
                            <h6 class="text-muted">Account Type Distribution</h6>
                            <div class="progress mb-2" style="height: 25px;">
                                <div class="progress-bar bg-success" style="width: 54%">Savings (54%)</div>
                                <div class="progress-bar bg-primary" style="width: 35%">Current (35%)</div>
                                <div class="progress-bar bg-warning" style="width: 11%">FD (11%)</div>
                            </div>
                        </div>

                        <div class="mb-4">
                            <h6 class="text-muted">Monthly Transaction Volume</h6>
                            <div class="d-flex justify-content-between mb-1">
                                <span>Deposits</span>
                                <span class="text-success">₹28.5M</span>
                            </div>
                            <div class="progress mb-2" style="height: 8px;">
                                <div class="progress-bar bg-success" style="width: 65%"></div>
                            </div>
                            <div class="d-flex justify-content-between mb-1">
                                <span>Withdrawals</span>
                                <span class="text-warning">₹19.2M</span>
                            </div>
                            <div class="progress mb-2" style="height: 8px;">
                                <div class="progress-bar bg-warning" style="width: 44%"></div>
                            </div>
                            <div class="d-flex justify-content-between mb-1">
                                <span>Transfers</span>
                                <span class="text-info">₹15.8M</span>
                            </div>
                            <div class="progress" style="height: 8px;">
                                <div class="progress-bar bg-info" style="width: 36%"></div>
                            </div>
                        </div>

                        <div class="text-center">
                            <button class="btn btn-outline-success me-2" onclick="viewDetailedAnalytics()">
                                <i class="fas fa-chart-pie me-1"></i>Detailed View
                            </button>
                            <button class="btn btn-outline-primary" onclick="exportAnalytics()">
                                <i class="fas fa-download me-1"></i>Export
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Recent Reports -->
        <div class="row mt-5">
            <div class="col-12">
                <div class="card shadow">
                    <div class="card-header bg-dark text-white">
                        <h5 class="mb-0"><i class="fas fa-history me-2"></i>Recent Reports</h5>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead class="table-primary">
                                    <tr>
                                        <th>Report ID</th>
                                        <th>Type</th>
                                        <th>Date Range</th>
                                        <th>Generated By</th>
                                        <th>Generated On</th>
                                        <th>Status</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                    String[][] reports = {
                                        {"RPT001", "Monthly Financial", "2024-01-01 to 2024-01-31", "Admin", "2024-02-01 09:30", "COMPLETED"},
                                        {"RPT002", "Weekly Analysis", "2024-01-22 to 2024-01-28", "Manager", "2024-01-29 14:15", "COMPLETED"},
                                        {"RPT003", "Daily Summary", "2024-01-28", "Admin", "2024-01-29 08:00", "COMPLETED"},
                                        {"RPT004", "Quarterly Performance", "2023-10-01 to 2023-12-31", "Director", "2024-01-15 16:45", "COMPLETED"},
                                        {"RPT005", "Custom Analysis", "2024-01-15 to 2024-01-25", "Analyst", "2024-01-26 11:20", "PROCESSING"}
                                    };
                                    
                                    for(String[] report : reports) {
                                        String statusBadge = report[5].equals("COMPLETED") ? "bg-success" : 
                                                           report[5].equals("PROCESSING") ? "bg-warning" : "bg-danger";
                                    %>
                                    <tr>
                                        <td><strong><%= report[0] %></strong></td>
                                        <td><%= report[1] %></td>
                                        <td><%= report[2] %></td>
                                        <td><%= report[3] %></td>
                                        <td><%= report[4] %></td>
                                        <td><span class="badge <%= statusBadge %>"><%= report[5] %></span></td>
                                        <td>
                                            <% if(report[5].equals("COMPLETED")) { %>
                                            <button class="btn btn-sm btn-outline-primary me-1" onclick="viewReport('<%= report[0] %>')">
                                                <i class="fas fa-eye"></i>
                                            </button>
                                            <button class="btn btn-sm btn-outline-success" onclick="downloadReport('<%= report[0] %>')">
                                                <i class="fas fa-download"></i>
                                            </button>
                                            <% } else { %>
                                            <button class="btn btn-sm btn-outline-secondary" disabled>
                                                <i class="fas fa-clock"></i>
                                            </button>
                                            <% } %>
                                        </td>
                                    </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function generateReport() {
            const reportType = document.getElementById('reportType').value;
            if(!reportType) {
                alert('Please select a report type');
                return;
            }
            
            const fromDate = document.getElementById('fromDate').value;
            const toDate = document.getElementById('toDate').value;
            
            if(reportType === 'CUSTOM' && (!fromDate || !toDate)) {
                alert('Please select date range for custom report');
                return;
            }
            
            alert('Generating ' + reportType + ' report...');
            // Implement report generation logic
        }

        function viewDetailedAnalytics() {
            alert('Opening detailed analytics dashboard...');
            // Implement detailed analytics view
        }

        function exportAnalytics() {
            alert('Exporting analytics data...');
            // Implement export functionality
        }

        function viewReport(reportId) {
            alert('Opening report: ' + reportId);
            // Implement report viewing
        }

        function downloadReport(reportId) {
            alert('Downloading report: ' + reportId);
            // Implement report download
        }

        // Auto-update date fields based on report type
        document.getElementById('reportType').addEventListener('change', function() {
            const reportType = this.value;
            const today = new Date();
            const fromDateField = document.getElementById('fromDate');
            const toDateField = document.getElementById('toDate');
            
            if(reportType === 'DAILY') {
                fromDateField.value = today.toISOString().split('T')[0];
                toDateField.value = today.toISOString().split('T')[0];
            } else if(reportType === 'WEEKLY') {
                const weekAgo = new Date(today.getTime() - 7 * 24 * 60 * 60 * 1000);
                fromDateField.value = weekAgo.toISOString().split('T')[0];
                toDateField.value = today.toISOString().split('T')[0];
            } else if(reportType === 'MONTHLY') {
                const monthAgo = new Date(today.getFullYear(), today.getMonth() - 1, 1);
                const monthEnd = new Date(today.getFullYear(), today.getMonth(), 0);
                fromDateField.value = monthAgo.toISOString().split('T')[0];
                toDateField.value = monthEnd.toISOString().split('T')[0];
            }
        });
    </script>
</body>
</html>