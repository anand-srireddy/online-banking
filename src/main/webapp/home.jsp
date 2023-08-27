<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: newvi
  Date: 6/23/2022
  Time: 9:14 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Account Summary</title>
    <link rel="icon" type="image/x-icon" href="logo.ico">
    <script type="text/javascript">
        function preventBack() {
            window.history.forward();
        }
        setTimeout("preventBack()", 0);
        window.onunload = function () { null };
    </script>
    <style>
        table, tr, td {
            border: 1px solid black;
            border-collapse: collapse;
        }

        td:nth-child(even),tr:nth-child(even) {
            background-color: #D6EEEE;
        }
        th, td {
            padding: 15px;
        }
        th {
            background-color: Tomato;
        }
    </style>
</head>
<body style="background-color:LightGray;">
<br>
<h1 style="background-color:Tomato;">
    &emsp; Account Summary
</h1>

<form method="post">
    <h2> &emsp;<a href="withdraw.jsp">Withdraw</a> &emsp; &emsp;
     &emsp;<a href="deposit.jsp">Deposit</a>&emsp; &emsp;
    &emsp;<a href="viewStatement.jsp">View Statement</a></h2>
    <table border="2" style="width:35%">
        <%
            try
            {
                Class.forName("com.mysql.jdbc.Driver");
                String url="jdbc:mysql://localhost/OnlineBanking";
                String username="root";
                String password="root";
                String query="select * from account where accountNumber ="+session.getAttribute("accountNumber");
                Connection conn= DriverManager.getConnection(url,username,password);
                Statement stmt=conn.createStatement();
                ResultSet rs=stmt.executeQuery(query);
                while(rs.next())
                {

        %>
        <th colspan="2" style="width:30%;font-family:verdana;"><strong>Account Details</strong></th>&emsp;
        <tr style="width:30%;font-family:verdana;"><td><strong>Account Number : </strong></td>&emsp;
            <td><%=rs.getInt("accountNumber") %></td></tr>
        <tr style="width:30%;font-family:verdana;"><td><strong>User name : </strong></td>&emsp;
            <td><%=rs.getString("username") %></td></tr>
        <tr style="width:30%;font-family:verdana;"><td><strong>Account Type : </strong></td>&emsp;
            <td><%=rs.getString("accountType") %></tr>
        <tr style="width:30%;font-family:verdana;"><td><strong>Available Balance : </strong></td>&emsp;
            <td>$ <%=rs.getDouble("amount") %></td></tr>

        <%

            }
        %>


    </table>

    <br><br>
    <h2> &emsp;<a href="logout">Logout</a></h2>

    <%
            rs.close();
            stmt.close();
            conn.close();
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
    %>
</form>
</body>
</html>
