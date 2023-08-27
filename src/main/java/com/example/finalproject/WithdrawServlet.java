package com.example.finalproject;

import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@WebServlet(name = "WithdrawServlet")
public class WithdrawServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final int MIN_BALANCE = 200;

    private PreparedStatement preparedStatement;

    private void initializeJdbc() {
        try {
            System.out.println("In initializeJdbc");

            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("Driver loaded");

            Connection conn = DriverManager.getConnection
                    ("jdbc:mysql://localhost/OnlineBanking?allowMultiQueries=true" , "root", "root");
            System.out.println("Database connected");

            preparedStatement = conn.prepareStatement("update account set amount = ? where accountNumber =?;" +
                    "INSERT INTO transactions(transactiondate,accountNumber,accountType,transactionType,amount) values(?,?,?, 'debit', ?)");

        }
        catch (Exception ex) {
            ex.printStackTrace();
        }
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        UserDAO userdao = new UserDAO();

        try{
            double withdrawmoney = Math.abs(Double.parseDouble(request.getParameter("withdrawMoney")));
            int acc = Integer.parseInt(request.getParameter("accountNumber"));
            double avb = Double.parseDouble(request.getParameter("avb"));
            if(withdrawmoney>0) {
                if (avb < withdrawmoney) {
                    out.println("<html><body style=\"background-color:LightGray;\">");
                    out.println("<br>");
                    out.println("<h2>Take a look at your available funds before withdrawing.</h2>");
                    out.println("<br>");
                    out.println("<h3>\n" +
                            "        <p> Try with smaller amount ? <a href=\"withdraw.jsp\">Go back</a></p>\n" +
                            "    </h3>");
                    out.println("</body></html>");
                }
                    else if ((avb - withdrawmoney) < MIN_BALANCE){
                    out.println("<html><body style=\"background-color:LightGray;\">");
                    out.println("<br>");
                    out.println("<h2>Withdrawal amount is higher that you cannot maintain minimum balance of $ 200.00</h2>");
                    out.println("<br>");
                    out.println("<h3>\n" +
                            "        <p> Try with smaller amount ? <a href=\"withdraw.jsp\">Go back</a></p>\n" +
                            "    </h3>");
                    out.println("</body></html>");

                    }

                else {
                    initializeJdbc();
                    insertIntoTransactions(userdao.findAccountRecord(acc), Math.abs(withdrawmoney), avb, acc);
                    out.println("<html><body style=\"background-color:LightGray;\">");
                    out.println("<br>");
                    out.println("<h2>Withdrawal was Successful. Statement will be updated.</h2>");
                    out.println("<br>");
                    out.println("<h3>\n" +
                            "        <p> <a href=\"home.jsp\"> Back to Summary </a></p>\n" +
                            "    </h3>");
                    out.println("</body></html>");
                }
            }
        }catch (Exception e){
            e.printStackTrace();
        }

    }

    public void insertIntoTransactions(ResultSet rs, double withdraw, double avb, int acc) throws SQLException {
        rs.last();
        preparedStatement.setDouble(1,(avb-withdraw));
        preparedStatement.setInt(2,acc);
        preparedStatement.setString(3,getTodaysDate());
        preparedStatement.setInt(4,acc);
        preparedStatement.setString(5,rs.getString("accountType"));
        preparedStatement.setDouble(6,Math.abs(withdraw));
        preparedStatement.executeUpdate();


    }

    private String getTodaysDate(){
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
        LocalDateTime now = LocalDateTime.now();
        return (dtf.format(now));
    }
}
