<%-- customers.jsp - Customer Management Page --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Management - SecureBank</title>
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
                    <li class="nav-item"><a class="nav-link active" href="customers.jsp">Customers</a></li>
                    <li class="nav-item"><a class="nav-link" href="accounts.jsp">Accounts</a></li>
                    <li class="nav-item"><a class="nav-link" href="transactions.jsp">Transactions</a></li>
                    <li class="nav-item"><a class="nav-link" href="loans.jsp">Loans</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="row">
            <div class="col-12">
                <h2 class="mb-4"><i class="fas fa-users me-2"></i>Customer Management</h2>
            </div>
        </div>

        <!-- Add New Customer -->
        <div class="row g-4 mb-5">
            <div class="col-lg-8">
                <div class="card shadow">
                    <div class="card-header bg-success text-white">
                        <h5 class="mb-0"><i class="fas fa-user-plus me-2"></i>Add New Customer</h5>
                    </div>
                    <div class="card-body">
                        <form action="CustomerServlet" method="post" id="customerForm">
                            <input type="hidden" name="action" value="add">
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
                                <div class="col-md-6">
                                    <label class="form-label">Date of Birth</label>
                                    <input type="date" class="form-control" name="dateOfBirth" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Gender</label>
                                    <select class="form-select" name="gender" required>
                                        <option value="">Select gender</option>
                                        <option value="MALE">Male</option>
                                        <option value="FEMALE">Female</option>
                                        <option value="OTHER">Other</option>
                                    </select>
                                </div>
                                <div class="col-12">
                                    <label class="form-label">Address</label>
                                    <textarea class="form-control" name="address" rows="3" required></textarea>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">City</label>
                                    <input type="text" class="form-control" name="city" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Postal Code</label>
                                    <input type="text" class="form-control" name="postalCode" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">ID Proof Type</label>
                                    <select class="form-select" name="idProofType" required>
                                        <option value="">Select ID proof</option>
                                        <option value="AADHAAR">Aadhaar Card</option>
                                        <option value="PAN">PAN Card</option>
                                        <option value="PASSPORT">Passport</option>
                                        <option value="VOTER_ID">Voter ID</option>
                                        <option value="DRIVING_LICENSE">Driving License</option>
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">ID Proof Number</label>
                                    <input type="text" class="form-control" name="idProofNumber" required>
                                </div>
                            </div>
                            <div class="text-end mt-3">
                                <button type="reset" class="btn btn-secondary me-2">Reset</button>
                                <button type="submit" class="btn btn-success">
                                    <i class="fas fa-check me-2"></i>Add Customer
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Customer Statistics -->
            <div class="col-lg-4">
                <div class="card shadow">
                    <div class="card-header bg-primary text-white">
                        <h5 class="mb-0"><i class="fas fa-chart-bar me-2"></i>Customer Statistics</h5>
                    </div>
                    <div class="card-body">
                        <div class="row text-center">
                            <div class="col-12 mb-3">
                                <h3 class="text-primary">1,247</h3>
                                <small class="text-muted">Total Customers</small>
                            </div>
                            <div class="col-6 mb-3">
                                <h4 class="text-success">156</h4>
                                <small class="text-muted">This Month</small>
                            </div>
                            <div class="col-6 mb-3">
                                <h4 class="text-warning">23</h4>
                                <small class="text-muted">Today</small>
                            </div>
                            <div class="col-6 mb-3">
                                <h4 class="text-info">892</h4>
                                <small class="text-muted">Active</small>
                            </div>
                            <div class="col-6 mb-3">
                                <h4 class="text-secondary">355</h4>
                                <small class="text-muted">Premium</small>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Quick Search -->
                <div class="card shadow mt-4">
                    <div class="card-header bg-info text-white">
                        <h5 class="mb-0"><i class="fas fa-search me-2"></i>Quick Search</h5>
                    </div>
                    <div class="card-body">
                        <div class="mb-3">
                            <input type="text" class="form-control" id="searchInput" placeholder="Search by name, email, phone...">
                        </div>
                        <button class="btn btn-info w-100" onclick="searchCustomer()">
                            <i class="fas fa-search me-2"></i>Search
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Customer List -->
        <div class="card shadow">
            <div class="card-header bg-dark text-white">
                <div class="d-flex justify-content-between align-items-center">
                    <h5 class="mb-0"><i class="fas fa-list me-2"></i>Customer List</h5>
                    <div>
                        <button class="btn btn-outline-light btn-sm me-2" onclick="exportCustomers()">
                            <i class="fas fa-download me-1"></i>Export
                        </button>
                        <button class="btn btn-outline-light btn-sm" onclick="refreshList()">
                            <i class="fas fa-refresh me-1"></i>Refresh
                        </button>
                    </div>
                </div>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead class="table-primary">
                            <tr>
                                <th>Customer ID</th>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Phone</th>
                                <th>City</th>
                                <th>Accounts</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                            String[][] customers = {
                                {"CUST001", "John Doe", "john.doe@email.com", "9876543210", "Mumbai", "2", "ACTIVE"},
                                {"CUST002", "Sarah Wilson", "sarah.wilson@email.com", "9876543211", "Delhi", "1", "ACTIVE"},
                                {"CUST003", "Mike Johnson", "mike.johnson@email.com", "9876543212", "Bangalore", "3", "ACTIVE"},
                                {"CUST004", "Emma Davis", "emma.davis@email.com", "9876543213", "Chennai", "1", "INACTIVE"},
                                {"CUST005", "Robert Brown", "robert.brown@email.com", "9876543214", "Kolkata", "2", "ACTIVE"},
                                {"CUST006", "Lisa Garcia", "lisa.garcia@email.com", "9876543215", "Hyderabad", "1", "ACTIVE"},
                                {"CUST007", "David Lee", "david.lee@email.com", "9876543216", "Pune", "2", "PREMIUM"}
                            };
                            
                            for(String[] cust : customers) {
                                String statusBadge = "bg-success";
                                if(cust[6].equals("INACTIVE")) statusBadge = "bg-warning";
                                else if(cust[6].equals("PREMIUM")) statusBadge = "bg-info";
                                else if(cust[6].equals("BLOCKED")) statusBadge = "bg-danger";
                            %>
                            <tr>
                                <td><strong><%= cust[0] %></strong></td>
                                <td><%= cust[1] %></td>
                                <td><%= cust[2] %></td>
                                <td><%= cust[3] %></td>
                                <td><%= cust[4] %></td>
                                <td><span class="badge bg-secondary"><%= cust[5] %> accounts</span></td>
                                <td><span class="badge <%= statusBadge %>"><%= cust[6] %></span></td>
                                <td>
                                    <button class="btn btn-sm btn-outline-primary me-1" onclick="viewCustomer('<%= cust[0] %>')">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                    <button class="btn btn-sm btn-outline-success me-1" onclick="editCustomer('<%= cust[0] %>')">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                    <button class="btn btn-sm btn-outline-info me-1" onclick="viewAccounts('<%= cust[0] %>')">
                                        <i class="fas fa-university"></i>
                                    </button>
                                    <button class="btn btn-sm btn-outline-secondary" onclick="generateReport('<%= cust[0] %>')">
                                        <i class="fas fa-file-alt"></i>
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
        function searchCustomer() {
            const searchTerm = document.getElementById('searchInput').value;
            if(searchTerm.trim() !== '') {
                alert('Searching for: ' + searchTerm);
                // Implement search functionality
            } else {
                alert('Please enter a search term');
            }
        }

        function exportCustomers() {
            alert('Exporting customer data...');
            // Implement export functionality
        }

        function refreshList() {
            alert('Refreshing customer list...');
            location.reload();
        }

        function viewCustomer(customerId) {
            alert('Viewing customer: ' + customerId);
            // Implement view functionality
        }

        function editCustomer(customerId) {
            alert('Editing customer: ' + customerId);
            // Implement edit functionality
        }

        function viewAccounts(customerId) {
            alert('Viewing accounts for customer: ' + customerId);
            // Redirect to accounts page with filter
        }

        function generateReport(customerId) {
            alert('Generating report for customer: ' + customerId);
            // Implement report generation
        }
    </script>
</body>
</html>