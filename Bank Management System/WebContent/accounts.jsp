<%-- accounts.jsp - Account Management Page --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Account Management - SecureBank</title>
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
                    <li class="nav-item"><a class="nav-link active" href="accounts.jsp">Accounts</a></li>
                    <li class="nav-item"><a class="nav-link" href="transactions.jsp">Transactions</a></li>
                    <li class="nav-item"><a class="nav-link" href="loans.jsp">Loans</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="row">
            <div class="col-12">
                <h2 class="mb-4"><i class="fas fa-university me-2"></i>Account Management</h2>
            </div>
        </div>

        <!-- Create New Account -->
        <div class="row g-4 mb-5">
            <div class="col-lg-8">
                <div class="card shadow">
                    <div class="card-header bg-primary text-white">
                        <h5 class="mb-0"><i class="fas fa-plus-circle me-2"></i>Create New Account</h5>
                    </div>
                    <div class="card-body">
                        <form action="AccountServlet" method="post" id="accountForm">
                            <input type="hidden" name="action" value="create">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label class="form-label">First Name</label>
                                    <input type="text" class="form-control" name="firstName" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Last Name</label>
                                    <input type="text" class="form-control" name="lastName" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Email Address</label>
                                    <input type="email" class="form-control" name="email" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Phone Number</label>
                                    <input type="tel" class="form-control" name="phone" required>
                                </div>
                                <div class="col-12">
                                    <label class="form-label">Address</label>
                                    <textarea class="form-control" name="address" rows="3" required></textarea>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Account Type</label>
                                    <select class="form-select" name="accountType" required>
                                        <option value="">Select account type</option>
                                        <option value="SAVINGS">Savings Account</option>
                                        <option value="CURRENT">Current Account</option>
                                        <option value="FIXED_DEPOSIT">Fixed Deposit</option>
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Initial Deposit (₹)</label>
                                    <input type="number" class="form-control" name="initialDeposit" min="1000" required>
                                </div>
                            </div>
                            <div class="text-end mt-3">
                                <button type="reset" class="btn btn-secondary me-2">Reset</button>
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-check me-2"></i>Create Account
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Quick Actions -->
            <div class="col-lg-4">
                <div class="card shadow">
                    <div class="card-header bg-success text-white">
                        <h5 class="mb-0"><i class="fas fa-bolt me-2"></i>Quick Actions</h5>
                    </div>
                    <div class="card-body">
                        <div class="d-grid gap-2">
                            <button class="btn btn-outline-primary" onclick="searchAccount()">
                                <i class="fas fa-search me-2"></i>Search Accounts
                            </button>
                            <button class="btn btn-outline-success" onclick="exportData()">
                                <i class="fas fa-file-export me-2"></i>Export Data
                            </button>
                            <button class="btn btn-outline-warning" onclick="generateReport()">
                                <i class="fas fa-chart-line me-2"></i>Account Reports
                            </button>
                            <button class="btn btn-outline-danger" onclick="viewBlocked()">
                                <i class="fas fa-ban me-2"></i>Blocked Accounts
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Account Statistics -->
                <div class="card shadow mt-4">
                    <div class="card-header bg-info text-white">
                        <h5 class="mb-0"><i class="fas fa-chart-pie me-2"></i>Account Statistics</h5>
                    </div>
                    <div class="card-body">
                        <div class="row text-center">
                            <div class="col-6 mb-3">
                                <h4 class="text-primary">892</h4>
                                <small class="text-muted">Total Accounts</small>
                            </div>
                            <div class="col-6 mb-3">
                                <h4 class="text-success">485</h4>
                                <small class="text-muted">Savings</small>
                            </div>
                            <div class="col-6 mb-3">
                                <h4 class="text-warning">312</h4>
                                <small class="text-muted">Current</small>
                            </div>
                            <div class="col-6 mb-3">
                                <h4 class="text-info">95</h4>
                                <small class="text-muted">Fixed Deposit</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Existing Accounts -->
        <div class="card shadow">
            <div class="card-header bg-dark text-white">
                <h5 class="mb-0"><i class="fas fa-list me-2"></i>Existing Accounts</h5>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead class="table-primary">
                            <tr>
                                <th>Account No.</th>
                                <th>Customer</th>
                                <th>Type</th>
                                <th>Balance</th>
                                <th>Status</th>
                                <th>Created</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                            String[][] accounts = {
                                {"ACC001", "John Doe", "SAVINGS", "45000", "ACTIVE", "2024-01-10"},
                                {"ACC002", "Sarah Wilson", "CURRENT", "32500", "ACTIVE", "2024-01-08"},
                                {"ACC003", "Mike Johnson", "SAVINGS", "28750", "ACTIVE", "2024-01-05"},
                                {"ACC004", "Emma Davis", "FIXED_DEPOSIT", "150000", "ACTIVE", "2024-01-03"},
                                {"ACC005", "Robert Brown", "CURRENT", "67890", "ACTIVE", "2024-01-01"},
                                {"ACC006", "Lisa Garcia", "SAVINGS", "23400", "INACTIVE", "2023-12-28"},
                                {"ACC007", "David Lee", "CURRENT", "89250", "ACTIVE", "2023-12-25"}
                            };
                            
                            for(String[] acc : accounts) {
                                String statusBadge = "bg-success";
                                if(acc[4].equals("INACTIVE")) statusBadge = "bg-warning";
                                else if(acc[4].equals("CLOSED")) statusBadge = "bg-danger";
                                
                                String typeBadge = "bg-primary";
                                if(acc[2].equals("SAVINGS")) typeBadge = "bg-success";
                                else if(acc[2].equals("FIXED_DEPOSIT")) typeBadge = "bg-info";
                            %>
                            <tr>
                                <td><strong><%= acc[0] %></strong></td>
                                <td><%= acc[1] %></td>
                                <td><span class="badge <%= typeBadge %>"><%= acc[2] %></span></td>
                                <td>₹<%= String.format("%,d", Integer.parseInt(acc[3])) %></td>
                                <td><span class="badge <%= statusBadge %>"><%= acc[4] %></span></td>
                                <td><%= acc[5] %></td>
                                <td>
                                    <button class="btn btn-sm btn-outline-primary me-1" onclick="viewAccount('<%= acc[0] %>')">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                    <button class="btn btn-sm btn-outline-success me-1" onclick="editAccount('<%= acc[0] %>')">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                    <button class="btn btn-sm btn-outline-secondary" onclick="downloadStatement('<%= acc[0] %>')">
                                        <i class="fas fa-download"></i>
                                    </button>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function searchAccount() {
            const accountNo = prompt('Enter account number to search:');
            if(accountNo) {
                alert('Searching for account: ' + accountNo);
                // Implement search functionality
            }
        }

        function exportData() {
            alert('Exporting account data...');
            // Implement export functionality
        }

        function generateReport() {
            alert('Generating account reports...');
            // Implement report generation
        }

        function viewBlocked() {
            alert('Showing blocked accounts...');
            // Implement blocked accounts view
        }

        function viewAccount(accountNo) {
            alert('Viewing account: ' + accountNo);
            // Implement view functionality
        }

        function editAccount(accountNo) {
            alert('Editing account: ' + accountNo);
            // Implement edit functionality
        }

        function downloadStatement(accountNo) {
            alert('Downloading statement for: ' + accountNo);
            // Implement download functionality
        }
    </script>
</body>
</html>