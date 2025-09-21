package com.bankmanagement.servlet;

import com.bankmanagement.dao.CustomerDAO;
import com.bankmanagement.model.Customer;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.List;

public class CustomerServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private CustomerDAO customerDAO;

    @Override
    public void init() throws ServletException {
        customerDAO = new CustomerDAO();
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
                List<Customer> list = customerDAO.getAllCustomers();
                out.print(customersToJson(list));

            } else if ("get".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                Customer c = customerDAO.getCustomerById(id);
                out.print(customerToJson(c));

            } else if ("count".equals(action)) {
                int count = customerDAO.getCustomerCount();
                out.print("{\"count\":" + count + "}");

            } else {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.print("{\"error\":\"Invalid action\"}");
            }

        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"error\":\"Server error: " + escape(e.getMessage()) + "\"}");
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
            if ("add".equals(action)) {
                Customer c = buildCustomer(request);
                boolean ok = customerDAO.addCustomer(c);
                out.print(statusJson(ok, ok ? "Customer added successfully!" : "Failed to add customer"));

            } else if ("update".equals(action)) {
                int id = Integer.parseInt(request.getParameter("customerId"));
                Customer c = customerDAO.getCustomerById(id);
                if (c != null) {
                    updateCustomerFields(c, request);
                    boolean ok = customerDAO.updateCustomer(c);
                    out.print(statusJson(ok, ok ? "Customer updated successfully!" : "Failed to update customer"));
                } else {
                    out.print(statusJson(false, "Customer not found"));
                }

            } else {
                out.print(statusJson(false, "Invalid action"));
            }
        } catch (Exception e) {
            out.print(statusJson(false, "Server error: " + escape(e.getMessage())));
        }
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            boolean ok = customerDAO.deleteCustomer(id);
            out.print(statusJson(ok, ok ? "Customer deleted successfully!" : "Failed to delete customer"));
        } catch (Exception e) {
            out.print(statusJson(false, "Server error: " + escape(e.getMessage())));
        }
    }

    /* ---------- Helper Methods ---------- */

    private Customer buildCustomer(HttpServletRequest req) {
        Customer c = new Customer();
        updateCustomerFields(c, req);
        return c;
    }

    private void updateCustomerFields(Customer c, HttpServletRequest req) {
        c.setCustomerType(req.getParameter("customerType"));
        c.setDob(Date.valueOf(req.getParameter("dob")));
        c.setFirstName(req.getParameter("firstName"));
        c.setLastName(req.getParameter("lastName"));
        c.setEmail(req.getParameter("email"));
        c.setMobileNo(req.getParameter("mobileNo"));
        c.setCity(req.getParameter("city"));
        c.setPan(req.getParameter("pan"));
    }

    private String customersToJson(List<Customer> list) {
        StringBuilder sb = new StringBuilder("[");
        for (int i = 0; i < list.size(); i++) {
            if (i > 0) sb.append(',');
            sb.append(customerToJson(list.get(i)));
        }
        sb.append(']');
        return sb.toString();
    }

    private String customerToJson(Customer c) {
        if (c == null) return "null";
        return new StringBuilder("{")
            .append("\"customerId\":").append(c.getCustomerId()).append(',')
            .append("\"firstName\":\"").append(escape(c.getFirstName())).append("\",")
            .append("\"lastName\":\"").append(escape(c.getLastName())).append("\",")
            .append("\"email\":\"").append(escape(c.getEmail())).append("\",")
            .append("\"mobileNo\":\"").append(escape(c.getMobileNo())).append("\",")
            .append("\"city\":\"").append(escape(c.getCity())).append("\",")
            .append("\"customerType\":\"").append(escape(c.getCustomerType())).append("\",")
            .append("\"pan\":\"").append(escape(c.getPan())).append("\",")
            .append("\"dob\":\"").append(c.getDob()).append("\"")
            .append('}')
            .toString();
    }

    private String statusJson(boolean success, String msg) {
        return "{\"status\":\"" + (success ? "success" : "error") +
               "\",\"message\":\"" + escape(msg) + "\"}";
    }

    /** Basic JSON string escape (quotes + backslashes) */
    private String escape(String s) {
        if (s == null) return "";
        return s.replace("\\", "\\\\").replace("\"", "\\\"");
    }
}
