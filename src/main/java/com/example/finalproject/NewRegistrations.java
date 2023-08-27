package com.example.finalproject;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@WebServlet(name = "NewRegistrations", value = "/NewRegistrations")
public class NewRegistrations extends HttpServlet {

    private PreparedStatement preparedStatement;

    /** Initialize variables */
    public void init() {
        initializeJdbc();
    }
    private void initializeJdbc() {
        try {
            System.out.println("In initializeJdbc");
            // Load the JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("Driver loaded");

            // Establish a connection
            Connection conn = DriverManager.getConnection
                    ("jdbc:mysql://localhost/OnlineBanking?allowMultiQueries=true" , "root", "root");
            System.out.println("Database connected");

            // Create a Statement
            preparedStatement = conn.prepareStatement("insert into users (firstName,lastName,gender, email,contact,accountType, username, password) values (?, ?, ?, ?, ?,?,?, ?);INSERT INTO account(accountNumber,username,amount,accountType) values(LAST_INSERT_ID(),?, 500.00, ?);" +
                    "INSERT INTO transactions(transactiondate,accountNumber,accountType,transactionType,amount) values(?,LAST_INSERT_ID(),?, 'credit', 500.00)");

        }
        catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // Obtain parameters from the client

        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String gender = request.getParameter("gender");
        String email = request.getParameter("email");
        String phone = request.getParameter("contact");
        String accountType = request.getParameter("accountType");
        String username = request.getParameter("userid");
        String password = request.getParameter("password");


        try {
            if (lastName.length() == 0 || firstName.length() == 0) {
                out.println(" First Name and Last Name are required");
            }
            else {
                RegisterNewUser(firstName,lastName,gender, email,phone, accountType,
                        username, password);

                out.println("<html><body>");
                out.println("<br>");
                out.println("<h2>Amazing "+firstName+".! Registration Successful. We have given $500 as a welcome bonus.</h2>");
                out.println("<h4>\n" +
                        "        <p>Want to try your credentials ?? <a href=\"index.jsp\"> Click to Login </a></p>\n" +
                        "    </h4>");
                out.println("</body></html>");

            }
        }
        catch(Exception ex) {
            out.println("Error: " + ex.getMessage());
        }
        finally {
            out.close(); // Close stream
        }
    }

    private void RegisterNewUser(String firstName, String lastName,
                                 String gender, String email, String phone, String accountType, String username, String password) throws SQLException {
        preparedStatement.setString(1, firstName);
        preparedStatement.setString(2, lastName);
        preparedStatement.setString(3, gender);
        preparedStatement.setString(4, email);
        preparedStatement.setString(5, phone);
        preparedStatement.setString(6, accountType);
        preparedStatement.setString(7, username);
        preparedStatement.setString(8, password);
        preparedStatement.setString(9, username);
        preparedStatement.setString(10, accountType);
        preparedStatement.setString(11, getTodaysDate());
        preparedStatement.setString(12, accountType);
        preparedStatement.executeUpdate();
    }

    private String getTodaysDate(){
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
        LocalDateTime now = LocalDateTime.now();
        return (dtf.format(now));
    }
}
