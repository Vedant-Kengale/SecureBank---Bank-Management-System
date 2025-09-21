package com.bankmanagement.servlet;

import com.bankmanagement.dao.LoanDAO;
import com.bankmanagement.model.Loan;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.util.List;

public class LoanServlet extends HttpServlet {

    private LoanDAO loanDAO;

    @Override
    public void init() throws ServletException {
        loanDAO = new LoanDAO();
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
                List<Loan> loans = loanDAO.getAllLoans();
                out.print(toJsonArray(loans));

            } else if ("count".equals(action)) {
                int count = loanDAO.getActiveLoanCount();
                out.print("{\"count\":" + count + "}");

            } else {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.print("{\"error\":\"Invalid action\"}");
            }

        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"error\":\"Server error: " + e.getMessage().replace("\"", "\\\"") + "\"}");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        String action = request.getParameter("action");

        try {
            String jsonResult;
            if ("add".equals(action)) {
                Loan loan = new Loan();
                loan.setCustomerId(Integer.parseInt(request.getParameter("customerId")));
                loan.setLoanType(request.getParameter("loanType"));
                loan.setLoanAmount(new BigDecimal(request.getParameter("loanAmount")));
                loan.setInterestRate(new BigDecimal(request.getParameter("interestRate")));
                loan.setLoanTerm(Integer.parseInt(request.getParameter("loanTerm")));
                loan.calculateMonthlyPayment();
                loan.setLoanStatus("Pending");

                boolean success = loanDAO.addLoan(loan);
                if (success) {
                    jsonResult = "{\"status\":\"success\",\"message\":\"Loan application submitted successfully!\"}";
                } else {
                    jsonResult = "{\"status\":\"error\",\"message\":\"Failed to submit loan application\"}";
                }

            } else if ("approve".equals(action) || "reject".equals(action)) {
                int loanId = Integer.parseInt(request.getParameter("loanId"));
                String status = action.equals("approve") ? "Approved" : "Rejected";
                boolean success = loanDAO.updateLoanStatus(loanId, status);
                if (success) {
                    jsonResult = "{\"status\":\"success\",\"message\":\"Loan " + status.toLowerCase() + " successfully!\"}";
                } else {
                    jsonResult = "{\"status\":\"error\",\"message\":\"Failed to " + action + " loan\"}";
                }

            } else {
                jsonResult = "{\"status\":\"error\",\"message\":\"Invalid action\"}";
            }

            out.print(jsonResult);

        } catch (NumberFormatException e) {
            out.print("{\"status\":\"error\",\"message\":\"Invalid number format: " + e.getMessage() + "\"}");
        } catch (Exception e) {
            out.print("{\"status\":\"error\",\"message\":\"Server error: " + e.getMessage().replace("\"", "\\\"") + "\"}");
        }
    }

    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        try {
            String action = request.getParameter("action");
            int loanId = Integer.parseInt(request.getParameter("loanId"));
            String status = request.getParameter("status");

            String jsonResult;
            if ("updateStatus".equals(action)) {
                boolean success = loanDAO.updateLoanStatus(loanId, status);
                if (success) {
                    jsonResult = "{\"status\":\"success\",\"message\":\"Loan status updated to " + status + "\"}";
                } else {
                    jsonResult = "{\"status\":\"error\",\"message\":\"Failed to update loan status\"}";
                }
            } else {
                jsonResult = "{\"status\":\"error\",\"message\":\"Invalid action\"}";
            }

            out.print(jsonResult);

        } catch (Exception e) {
            out.print("{\"status\":\"error\",\"message\":\"Server error: " + e.getMessage().replace("\"", "\\\"") + "\"}");
        }
    }

    // Helper method to convert a list of Loan objects to JSON manually
    private String toJsonArray(List<Loan> loans) {
        StringBuilder json = new StringBuilder();
        json.append("[");
        for (int i = 0; i < loans.size(); i++) {
            Loan loan = loans.get(i);
            json.append("{")
                    .append("\"loanId\":").append(loan.getLoanId()).append(",")
                    .append("\"customerId\":").append(loan.getCustomerId()).append(",")
                    .append("\"loanType\":\"").append(loan.getLoanType()).append("\",")
                    .append("\"loanAmount\":").append(loan.getLoanAmount()).append(",")
                    .append("\"interestRate\":").append(loan.getInterestRate()).append(",")
                    .append("\"loanTerm\":").append(loan.getLoanTerm()).append(",")
                    .append("\"loanStatus\":\"").append(loan.getLoanStatus()).append("\"")
                    .append("}");
            if (i < loans.size() - 1) {
                json.append(",");
            }
        }
        json.append("]");
        return json.toString();
    }
}
