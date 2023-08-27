package com.example.finalproject;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@WebServlet(name = "DepositServlet", value = "/DepositServlet")
public class DepositServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private PreparedStatement preparedStatement;

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
            preparedStatement = conn.prepareStatement("update account set amount = ? where accountNumber =?;" +
                    "INSERT INTO transactions(transactiondate,accountNumber,accountType,transactionType,amount) values(?,?,?, 'credit', ?)");

        }
        catch (Exception ex) {
            ex.printStackTrace();
        }
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        UserDAO userdao = new UserDAO();

        try{
            double depositMoney = Math.abs(Double.parseDouble(request.getParameter("depositMoney")));
            int acc = Integer.parseInt(request.getParameter("accountNumber"));
            double avb = Double.parseDouble(request.getParameter("avb"));

                initializeJdbc();
                //userdao.findAccountRecord(acc);
                insertIntoTransactions(userdao.findAccountRecord(acc), Math.abs(depositMoney), avb, acc);
                out.println("<html><body style=\"background-color:LightGray;\">");
                out.println("<br>");
                out.println("<h2>Yay.! your deposit was Successful. Statement will be updated shortly.</h2>");
                out.println("<br>");
                out.println("<h3>\n" +
                        "        <p> <a href=\"home.jsp\"> Back to Summary </a></p>\n" +
                        "    </h3>");
                out.println("</body></html>");

        }catch (Exception e){
            e.printStackTrace();
        }

    }

    public void insertIntoTransactions(ResultSet rs, double deposit, double avb, int acc) throws SQLException {
        rs.last();
        preparedStatement.setDouble(1,(avb+Math.abs(deposit)));
        preparedStatement.setInt(2,acc);
        preparedStatement.setString(3,getTodaysDate());
        preparedStatement.setInt(4,acc);
        preparedStatement.setString(5,rs.getString("accountType"));
        preparedStatement.setDouble(6,Math.abs(deposit));
        preparedStatement.executeUpdate();


    }

    private String getTodaysDate(){
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
        LocalDateTime now = LocalDateTime.now();
        return (dtf.format(now));
    }
}
