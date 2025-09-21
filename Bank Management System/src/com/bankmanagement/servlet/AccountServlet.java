package com.bankmanagement.servlet;

import com.bankmanagement.dao.AccountDAO;
import com.bankmanagement.model.Account;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.util.List;

public class AccountServlet extends HttpServlet {

    private AccountDAO accountDAO;

    @Override
    public void init() throws ServletException {
        accountDAO = new AccountDAO();
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
                List<Account> accounts = accountDAO.getAllAccounts();
                out.print(listToJson(accounts));

            } else if ("get".equals(action)) {
                int accountId = Integer.parseInt(request.getParameter("id"));
                Account account = accountDAO.getAccountById(accountId);
                out.print(accountToJson(account));

            } else if ("count".equals(action)) {
                int count = accountDAO.getAccountCount();
                out.print("{\"count\":" + count + "}");

            } else if ("totalBalance".equals(action)) {
                BigDecimal total = accountDAO.getTotalBalance();
                out.print("{\"totalBalance\":" + total + "}");

            } else {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.print("{\"error\":\"Invalid action\"}");
            }

        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"error\":\"Server error: " + e.getMessage() + "\"}");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        String action = request.getParameter("action");
        String jsonResult = "";

        try {
            if ("add".equals(action)) {
                Account account = new Account();
                account.setCustomerId(Integer.parseInt(request.getParameter("customerId")));
                account.setAccountType(request.getParameter("accountType"));
                account.setCurrentBalance(new BigDecimal(request.getParameter("initialBalance")));
                account.setAccountStatus("Active");

                boolean success = accountDAO.addAccount(account);
                jsonResult = "{\"status\":\"" + (success ? "success" : "error") + "\","
                        + "\"message\":\"" + (success ? "Account created successfully!" : "Failed to create account") + "\"}";

            } else if ("deposit".equals(action)) {
                int accountId = Integer.parseInt(request.getParameter("accountId"));
                BigDecimal amount = new BigDecimal(request.getParameter("amount"));

                boolean success = accountDAO.deposit(accountId, amount);
                jsonResult = "{\"status\":\"" + (success ? "success" : "error") + "\","
                        + "\"message\":\"" + (success ? "Deposit successful!" : "Deposit failed") + "\"}";

            } else if ("withdraw".equals(action)) {
                int accountId = Integer.parseInt(request.getParameter("accountId"));
                BigDecimal amount = new BigDecimal(request.getParameter("amount"));

                boolean success = accountDAO.withdraw(accountId, amount);
                jsonResult = "{\"status\":\"" + (success ? "success" : "error") + "\","
                        + "\"message\":\"" + (success ? "Withdrawal successful!" : "Withdrawal failed - insufficient funds or account error") + "\"}";

            } else {
                jsonResult = "{\"status\":\"error\",\"message\":\"Invalid action\"}";
            }

        } catch (Exception e) {
            jsonResult = "{\"status\":\"error\",\"message\":\"Server error: " + e.getMessage() + "\"}";
        }

        out.print(jsonResult);
    }

    // Helper methods to convert Account or List<Account> to JSON
    private String accountToJson(Account account) {
        if (account == null) return "{}";
        return "{"
                + "\"accountId\":" + account.getAccountId() + ","
                + "\"customerId\":" + account.getCustomerId() + ","
                + "\"accountType\":\"" + account.getAccountType() + "\","
                + "\"currentBalance\":" + account.getCurrentBalance() + ","
                + "\"accountStatus\":\"" + account.getAccountStatus() + "\""
                + "}";
    }

    private String listToJson(List<Account> accounts) {
        StringBuilder sb = new StringBuilder();
        sb.append("[");
        for (int i = 0; i < accounts.size(); i++) {
            sb.append(accountToJson(accounts.get(i)));
            if (i < accounts.size() - 1) sb.append(",");
        }
        sb.append("]");
        return sb.toString();
    }
}
