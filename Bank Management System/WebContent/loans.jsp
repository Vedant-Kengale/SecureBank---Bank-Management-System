<%-- loans.jsp - Loan Management Page --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Loan Management - Bank System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container">
            <a class="navbar-brand" href="index.jsp">
                <i class="fas fa-university me-2"></i>Bank System
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
                    <li class="nav-item"><a class="nav-link active" href="loans.jsp">Loans</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="row">
            <div class="col-12">
                <h2 class="mb-4"><i class="fas fa-hand-holding-usd me-2"></i>Loan Management</h2>
            </div>
        </div>

        <!-- Loan Application Form -->
        <div class="row g-4 mb-5">
            <div class="col-lg-8">
                <div class="card shadow">
                    <div class="card-header bg-success text-white">
                        <h5 class="mb-0"><i class="fas fa-file-alt me-2"></i>New Loan Application</h5>
                    </div>
                    <div class="card-body">
                        <form action="LoanServlet" method="post" id="loanForm">
                            <input type="hidden" name="action" value="apply">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label class="form-label">Customer Name</label>
                                    <input type="text" class="form-control" name="customerName" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Account Number</label>
                                    <input type="text" class="form-control" name="accountNumber" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Loan Type</label>
                                    <select class="form-select" name="loanType" required onchange="updateInterestRate()">
                                        <option value="">Select loan type</option>
                                        <option value="HOME" data-rate="8.5">Home Loan</option>
                                        <option value="PERSONAL" data-rate="12.0">Personal Loan</option>
                                        <option value="CAR" data-rate="9.5">Car Loan</option>
                                        <option value="EDUCATION" data-rate="7.5">Education Loan</option>
                                        <option value="BUSINESS" data-rate="11.0">Business Loan</option>
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Loan Amount (₹)</label>
                                    <input type="number" class="form-control" name="loanAmount" min="10000" step="1000" required onchange="calculateEMI()">
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Interest Rate (%)</label>
                                    <input type="number" class="form-control" name="interestRate" step="0.1" readonly>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Tenure (Years)</label>
                                    <select class="form-select" name="tenure" required onchange="calculateEMI()">
                                        <option value="">Select tenure</option>
                                        <option value="1">1 Year</option>
                                        <option value="2">2 Years</option>
                                        <option value="3">3 Years</option>
                                        <option value="5">5 Years</option>
                                        <option value="10">10 Years</option>
                                        <option value="15">15 Years</option>
                                        <option value="20">20 Years</option>
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Monthly EMI (₹)</label>
                                    <input type="text" class="form-control" name="monthlyEMI" readonly>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Annual Income (₹)</label>
                                    <input type="number" class="form-control" name="annualIncome" min="100000" required>
                                </div>
                                <div class="col-12">
                                    <label class="form-label">Purpose</label>
                                    <textarea class="form-control" name="purpose" rows="3" placeholder="Describe the purpose of the loan" required></textarea>
                                </div>
                                <div class="col-12">
                                    <div class="alert alert-info">
                                        <i class="fas fa-info-circle me-2"></i>
                                        <strong>Note:</strong> All loan applications are subject to credit verification and approval process.
                                    </div>
                                </div>
                            </div>
                            <div class="text-end mt-3">
                                <button type="reset" class="btn btn-secondary me-2">Reset</button>
                                <button type="submit" class="btn btn-success">
                                    <i class="fas fa-paper-plane me-2"></i>Submit Application
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Loan Calculator -->
            <div class="col-lg-4">
                <div class="card shadow">
                    <div class="card-header bg-info text-white">
                        <h5 class="mb-0"><i class="fas fa-calculator me-2"></i>EMI Calculator</h5>
                    </div>
                    <div class="card-body">
                        <div class="mb-3">
                            <label class="form-label">Principal Amount (₹)</label>
                            <input type="number" class="form-control" id="calcPrincipal" placeholder="Enter amount">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Interest Rate (% per annum)</label>
                            <input type="number" class="form-control" id="calcRate" placeholder="Enter rate" step="0.1">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Tenure (Years)</label>
                            <input type="number" class="form-control" id="calcTenure" placeholder="Enter years">
                        </div>
                        <button class="btn btn-info w-100" onclick="calculateStandaloneEMI()">
                            Calculate EMI
                        </button>
                        <div class="mt-3">
                            <div class="alert alert-light">
                                <strong>EMI: </strong><span id="calculatedEMI">₹0</span><br>
                                <strong>Total Interest: </strong><span id="totalInterest">₹0</span><br>
                                <strong>Total Amount: </strong><span id="totalAmount">₹0</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Existing Loans -->
        <div class="card shadow">
            <div class="card-header bg-dark text-white">
                <h5 class="mb-0"><i class="fas fa-list me-2"></i>Existing Loans</h5>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead class="table-primary">
                            <tr>
                                <th>Loan ID</th>
                                <th>Customer</th>
                                <th>Type</th>
                                <th>Amount</th>
                                <th>EMI</th>
                                <th>Status</th>
                                <th>Remaining</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                            // Sample loan data - Replace with actual database query
                            String[][] loans = {
                                {"LOAN001", "John Doe", "HOME", "2500000", "23456", "ACTIVE", "2200000", "APPROVED"},
                                {"LOAN002", "Sarah Wilson", "PERSONAL", "500000", "9234", "ACTIVE", "320000", "APPROVED"},
                                {"LOAN003", "Mike Johnson", "CAR", "800000", "8765", "CLOSED", "0", "COMPLETED"},
                                {"LOAN004", "Emma Davis", "EDUCATION", "300000", "4567", "PENDING", "300000", "UNDER_REVIEW"},
                                {"LOAN005", "Robert Brown", "BUSINESS", "1200000", "15678", "ACTIVE", "980000", "APPROVED"}
                            };
                            
                            for(String[] loan : loans) {
                                String statusBadge = "bg-success";
                                if(loan[7].equals("PENDING") || loan[7].equals("UNDER_REVIEW")) {
                                    statusBadge = "bg-warning";
                                } else if(loan[7].equals("REJECTED")) {
                                    statusBadge = "bg-danger";
                                } else if(loan[7].equals("COMPLETED")) {
                                    statusBadge = "bg-info";
                                }
                            %>
                            <tr>
                                <td><strong><%= loan[0] %></strong></td>
                                <td><%= loan[1] %></td>
                                <td><span class="badge bg-secondary"><%= loan[2] %></span></td>
                                <td>₹<%= String.format("%,d", Integer.parseInt(loan[3])) %></td>
                                <td>₹<%= loan[4] %></td>
                                <td><span class="badge <%= statusBadge %>"><%= loan[7] %></span></td>
                                <td>₹<%= String.format("%,d", Integer.parseInt(loan[6])) %></td>
                                <td>
                                    <button class="btn btn-sm btn-outline-primary me-1" onclick="viewLoan('<%= loan[0] %>')">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                    <% if(!loan[7].equals("COMPLETED") && !loan[7].equals("REJECTED")) { %>
                                    <button class="btn btn-sm btn-outline-success me-1" onclick="makePayment('<%= loan[0] %>')">
                                        <i class="fas fa-money-bill"></i>
                                    </button>
                                    <% } %>
                                    <button class="btn btn-sm btn-outline-secondary" onclick="downloadStatement('<%= loan[0] %>')">
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
        function updateInterestRate() {
            const loanTypeSelect = document.querySelector('select[name="loanType"]');
            const selectedOption = loanTypeSelect.options[loanTypeSelect.selectedIndex];
            const rate = selectedOption.getAttribute('data-rate');
            
            if (rate) {
                document.querySelector('input[name="interestRate"]').value = rate;
                calculateEMI();
            }
        }

        function calculateEMI() {
            const principal = parseFloat(document.querySelector('input[name="loanAmount"]').value) || 0;
            const rate = parseFloat(document.querySelector('input[name="interestRate"]').value) || 0;
            const tenure = parseInt(document.querySelector('select[name="tenure"]').value) || 0;
            
            if (principal > 0 && rate > 0 && tenure > 0) {
                const monthlyRate = rate / (12 * 100);
                const numPayments = tenure * 12;
                
                const emi = (principal * monthlyRate * Math.pow(1 + monthlyRate, numPayments)) / 
                           (Math.pow(1 + monthlyRate, numPayments) - 1);
                
                document.querySelector('input[name="monthlyEMI"]').value = Math.round(emi);
            }
        }

        function calculateStandaloneEMI() {
            const principal = parseFloat(document.getElementById('calcPrincipal').value) || 0;
            const rate = parseFloat(document.getElementById('calcRate').value) || 0;
            const tenure = parseFloat(document.getElementById('calcTenure').value) || 0;
            
            if (principal > 0 && rate > 0 && tenure > 0) {
                const monthlyRate = rate / (12 * 100);
                const numPayments = tenure * 12;
                
                const emi = (principal * monthlyRate * Math.pow(1 + monthlyRate, numPayments)) / 
                           (Math.pow(1 + monthlyRate, numPayments) - 1);
                
                const totalAmount = emi * numPayments;
                const totalInterest = totalAmount - principal;
                
                document.getElementById('calculatedEMI').textContent = '₹' + Math.round(emi).toLocaleString('en-IN');
                document.getElementById('totalInterest').textContent = '₹' + Math.round(totalInterest).toLocaleString('en-IN');
                document.getElementById('totalAmount').textContent = '₹' + Math.round(totalAmount).toLocaleString('en-IN');
            }
        }

        function viewLoan(loanId) {
            alert('Viewing details for loan: ' + loanId);
            // Implement view functionality
        }

        function makePayment(loanId) {
            const amount = prompt('Enter payment amount:');
            if (amount && parseFloat(amount) > 0) {
                alert('Processing payment of ₹' + amount + ' for loan: ' + loanId);
                // Implement payment functionality
            }
        }

        function downloadStatement(loanId) {
            alert('Downloading statement for loan: ' + loanId);
            // Implement download functionality
        }
    </script>
</body>
</html>