// ===== Global utility functions =====
function showAlert(message, type = 'info') {
    // Remove existing alerts
    document.querySelectorAll('.alert').forEach(alert => alert.remove());

    // Create alert element
    const alertDiv = document.createElement('div');
    alertDiv.className = `alert alert-${type} alert-dismissible fade show position-fixed`;
    alertDiv.style.cssText = 'top: 100px; right: 20px; z-index: 9999; min-width: 300px;';
    alertDiv.innerHTML = `
        ${message}
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    `;

    // Insert into body
    document.body.appendChild(alertDiv);

    // Auto dismiss after 5 seconds
    setTimeout(() => {
        if (alertDiv && alertDiv.parentNode) {
            alertDiv.remove();
        }
    }, 5000);
}

function formatCurrency(amount) {
    const num = parseFloat(amount);
    if (isNaN(num)) return '$0.00';
    return new Intl.NumberFormat('en-US', {
        style: 'currency',
        currency: 'USD'
    }).format(num);
}

function getStatusBadge(status) {
    const statusClass = {
        'Active': 'status-active',
        'Pending': 'status-pending',
        'Closed': 'status-closed',
        'Approved': 'status-active'
    };
    const cssClass = statusClass[status] || 'status-pending';
    return `<span class="status-badge ${cssClass}">${status || 'Unknown'}</span>`;
}

function formatDate(dateString) {
    if (!dateString) return 'N/A';
    return new Date(dateString).toLocaleDateString('en-US');
}

// ===== Customer management functions =====
function editCustomer(customerId) {
    fetch(`customer?action=get&id=${customerId}`)
        .then(response => response.json())
        .then(customer => {
            if (customer) {
                console.log('Customer data:', customer);
                showAlert('Edit functionality will be implemented in next version', 'info');
            } else {
                showAlert('Customer not found', 'danger'); // ✅ danger instead of error
            }
        })
        .catch(error => {
            console.error('Error:', error);
            showAlert('Error loading customer data', 'danger');
        });
}

function deleteCustomer(customerId) {
    if (confirm('Are you sure you want to delete this customer? This action cannot be undone.')) {
        showAlert('Delete functionality will be implemented with proper validations', 'warning');
    }
}

// ===== Account management functions =====
function deposit(accountId) {
    const amount = prompt('Enter deposit amount:');
    if (amount && !isNaN(amount) && parseFloat(amount) > 0) {
        showAlert(`Deposit of ${formatCurrency(amount)} will be processed`, 'success');
    } else if (amount !== null) {
        showAlert('Please enter a valid amount', 'danger');
    }
}

function withdraw(accountId) {
    const amount = prompt('Enter withdrawal amount:');
    if (amount && !isNaN(amount) && parseFloat(amount) > 0) {
        showAlert(`Withdrawal of ${formatCurrency(amount)} will be processed`, 'success');
    } else if (amount !== null) {
        showAlert('Please enter a valid amount', 'danger');
    }
}

function transfer(accountId) {
    const targetAccount = prompt('Enter target account number:');
    if (!targetAccount) return;

    const amount = prompt('Enter transfer amount:');
    if (amount && !isNaN(amount) && parseFloat(amount) > 0) {
        showAlert(`Transfer of ${formatCurrency(amount)} to ${targetAccount} will be processed`, 'success');
    } else if (amount !== null) {
        showAlert('Please enter a valid amount', 'danger');
    }
}

// ===== Loading spinner functions =====
function showLoading(elementId = 'loadingSpinner') {
    const spinner = document.getElementById(elementId);
    if (spinner) spinner.classList.remove('d-none');
}

function hideLoading(elementId = 'loadingSpinner') {
    const spinner = document.getElementById(elementId);
    if (spinner) spinner.classList.add('d-none');
}

// ===== Form validation =====
function validateForm(formId) {
    const form = document.getElementById(formId);
    if (!form) return false;

    const inputs = form.querySelectorAll('input[required], select[required]');
    let isValid = true;

    inputs.forEach(input => {
        if (!input.value.trim()) {
            input.classList.add('is-invalid');
            isValid = false;
        } else {
            input.classList.remove('is-invalid');
        }
    });
    return isValid;
}

// ===== Initialize Bootstrap tooltips =====
document.addEventListener('DOMContentLoaded', () => {
    if (typeof bootstrap !== 'undefined') {
        [...document.querySelectorAll('[data-bs-toggle="tooltip"]')]
            .forEach(el => new bootstrap.Tooltip(el));
    }
});
