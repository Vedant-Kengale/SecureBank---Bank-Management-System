package com.bankmanagement.servlet;

import com.bankmanagement.dao.TransactionDAO;
import com.bankmanagement.model.Transaction;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

public class TransactionServlet extends HttpServlet {

    private TransactionDAO transactionDAO;

    @Override
    public void init() throws ServletException {
        transactionDAO = new TransactionDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        String action = request.getParameter("action");

        try {
            if ("list".equals(action)) {
                List<Transaction> transactions = transactionDAO.getAllTransactions();
                out.print(toJsonArray(transactions));

            } else if ("byAccount".equals(action)) {
                int accountId = Integer.parseInt(request.getParameter("accountId"));
                List<Transaction> transactions = transactionDAO.getTransactionsByAccountId(accountId);
                out.print(toJsonArray(transactions));

            } else {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.print("{\"error\":\"Invalid action\"}");
            }

        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"error\":\"Server error: " + e.getMessage().replace("\"", "\\\"") + "\"}");
        }
    }

    // Helper method to convert a list of transactions to JSON manually
    private String toJsonArray(List<Transaction> transactions) {
        StringBuilder json = new StringBuilder();
        json.append("[");
        for (int i = 0; i < transactions.size(); i++) {
            Transaction t = transactions.get(i);
            json.append("{")
                .append("\"transactionId\":").append(t.getTransactionId()).append(",")
                .append("\"accountId\":").append(t.getAccountId()).append(",")
                .append("\"amount\":").append(t.getAmount()).append(",")
                .append("\"transactionDate\":\"").append(t.getTransactionDate()).append("\"")
                .append("}");
            if (i < transactions.size() - 1) {
                json.append(",");
            }
        }
        json.append("]");
        return json.toString();
    }
}
