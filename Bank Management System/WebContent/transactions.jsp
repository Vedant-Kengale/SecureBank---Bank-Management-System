<%-- transactions.jsp - Transaction Management Page --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*, java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Transaction Management - Bank System</title>
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
                    <li class="nav-item"><a class="nav-link active" href="transactions.jsp">Transactions</a></li>
                    <li class="nav-item"><a class="nav-link" href="loans.jsp">Loans</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="row">
            <div class="col-12">
                <h2 class="mb-4"><i class="fas fa-exchange-alt me-2"></i>Transaction Management</h2>
            </div>
        </div>

        <!-- Transaction Forms -->
        <div class="row g-4 mb-5">
            <!-- Fund Transfer -->
            <div class="col-lg-6">
                <div class="card shadow">
                    <div class="card-header bg-primary text-white">
                        <h5 class="mb-0"><i class="fas fa-money-bill-transfer me-2"></i>Fund Transfer</h5>
                    </div>
                    <div class="card-body">
                        <form action="TransactionServlet" method="post" id="transferForm">
                            <input type="hidden" name="action" value="transfer">
                            <div class="mb-3">
                                <label class="form-label">From Account</label>
                                <select class="form-select" name="fromAccount" required>
                                    <option value="">Select source account</option>
                                    <option value="ACC001">ACC001 - John Doe (₹45,000)</option>
                                    <option value="ACC002">ACC002 - Sarah Wilson (₹32,500)</option>
                                    <option value="ACC003">ACC003 - Mike Johnson (₹28,750)</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">To Account</label>
                                <input type="text" class="form-control" name="toAccount" placeholder="Enter destination account number" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Amount (₹)</label>
                                <input type="number" class="form-control" name="amount" placeholder="Enter transfer amount" min="1" step="0.01" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Description</label>
                                <textarea class="form-control" name="description" rows="2" placeholder="Enter transfer description (optional)"></textarea>
                            </div>
                            <button type="submit" class="btn btn-success w-100">
                                <i class="fas fa-paper-plane me-2"></i>Transfer Funds
                            </button>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Cash Deposit/Withdrawal -->
            <div class="col-lg-6">
                <div class="card shadow">
                    <div class="card-header bg-info text-white">
                        <h5 class="mb-0"><i class="fas fa-money-bills me-2"></i>Cash Transaction</h5>
                    </div>
                    <div class="card-body">
                        <form action="TransactionServlet" method="post" id="cashForm">
                            <input type="hidden" name="action" value="cash">
                            <div class="mb-3">
                                <label class="form-label">Account Number</label>
                                <input type="text" class="form-control" name="accountNumber" placeholder="Enter account number" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Transaction Type</label>
                                <select class="form-select" name="transactionType" required>
                                    <option value="">Select transaction type</option>
                                    <option value="DEPOSIT">Deposit</option>
                                    <option value="WITHDRAWAL">Withdrawal</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Amount (₹)</label>
                                <input type="number" class="form-control" name="amount" placeholder="Enter amount" min="1" step="0.01" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Notes</label>
                                <textarea class="form-control" name="notes" rows="2" placeholder="Enter transaction notes"></textarea>
                            </div>
                            <button type="submit" class="btn btn-primary w-100">
                                <i class="fas fa-check-circle me-2"></i>Process Transaction
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Recent Transactions -->
        <div class="card shadow">
            <div class="card-header bg-dark text-white">
                <h5 class="mb-0"><i class="fas fa-clock me-2"></i>Recent Transactions</h5>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead class="table-primary">
                            <tr>
                                <th>Transaction ID</th>
                                <th>Account</th>
                                <th>Type</th>
                                <th>Amount</th>
                                <th>Status</th>
                                <th>Date</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                            // Sample transaction data - Replace with actual database query
                            String[][] transactions = {
                                {"TXN001", "John Doe (ACC001)", "DEPOSIT", "+25000", "COMPLETED", "2024-01-15 10:30:00"},
                                {"TXN002", "Sarah Wilson (ACC002)", "WITHDRAWAL", "-15500", "COMPLETED", "2024-01-15 09:45:00"},
                                {"TXN003", "Mike Johnson (ACC003)", "TRANSFER", "8750", "PENDING", "2024-01-15 09:20:00"},
                                {"TXN004", "John Doe (ACC001)", "TRANSFER", "-5000", "COMPLETED", "2024-01-14 16:30:00"},
                                {"TXN005", "Sarah Wilson (ACC002)", "DEPOSIT", "+12000", "COMPLETED", "2024-01-14 14:15:00"}
                            };
                            
                            for(String[] txn : transactions) {
                                String badgeClass = "success";
                                String amountClass = "text-success";
                                String statusBadge = "bg-success";
                                
                                if(txn[2].equals("WITHDRAWAL") || txn[3].startsWith("-")) {
                                    amountClass = "text-danger";
                                } else if(txn[2].equals("TRANSFER")) {
                                    amountClass = "text-primary";
                                }
                                
                                if(txn[4].equals("PENDING")) {
                                    statusBadge = "bg-warning";
                                } else if(txn[4].equals("FAILED")) {
                                    statusBadge = "bg-danger";
                                }
                            %>
                            <tr>
                                <td><strong><%= txn[0] %></strong></td>
                                <td><%= txn[1] %></td>
                                <td><span class="badge bg-primary"><%= txn[2] %></span></td>
                                <td><strong class="<%= amountClass %>">₹<%= txn[3] %></strong></td>
                                <td><span class="badge <%= statusBadge %>"><%= txn[4] %></span></td>
                                <td><%= txn[5] %></td>
                                <td>
                                    <button class="btn btn-sm btn-outline-primary" onclick="viewTransaction('<%= txn[0] %>')">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                    <button class="btn btn-sm btn-outline-secondary" onclick="printReceipt('<%= txn[0] %>')">
                                        <i class="fas fa-print"></i>
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
        // Form validation
        document.getElementById('transferForm').addEventListener('submit', function(e) {
            const fromAccount = document.querySelector('select[name="fromAccount"]').value;
            const toAccount = document.querySelector('input[name="toAccount"]').value;
            const amount = document.querySelector('input[name="amount"]').value;
            
            if(fromAccount === toAccount) {
                e.preventDefault();
                alert('Source and destination accounts cannot be the same!');
                return false;
            }
            
            if(parseFloat(amount) <= 0) {
                e.preventDefault();
                alert('Amount must be greater than zero!');
                return false;
            }
        });

        function viewTransaction(txnId) {
            alert('Viewing transaction: ' + txnId);
            // Implement view functionality
        }

        function printReceipt(txnId) {
            alert('Printing receipt for transaction: ' + txnId);
            // Implement print functionality
        }
    </script>
</body>
</html>