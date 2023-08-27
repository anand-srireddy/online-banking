<%--
  Created by IntelliJ IDEA.
  User: newvi
  Date: 6/24/2022
  Time: 2:46 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Withdraw Money</title>
    <link rel="icon" type="image/x-icon" href="logo.ico">
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
        .button {
            background-color: #4CAF50; /* Green */
            border: none;
            color: white;
            padding: 5px 15px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            margin: 4px 2px;
            transition-duration: 0.4s;
            cursor: pointer;
        }

        .button1 {
            background-color: white;
            color: black;
            border: 2px solid #555555;
        }

        .button1:hover {
            background-color: #555555;
            color: white;
        }
    </style>
</head>
<body style="background-color:LightGray;">
<br>
<h1 style="background-color:Tomato;">
    &emsp; Deposit. Add to your funds now.
</h1>

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

<form action="DepositServlet" method="post"><br>
    <h2>Available account balance is :
        <input type="number" id="avb" name="avb" value= <%=rs.getDouble("amount")%> readonly> </h2><br>
    <h3>Your Account : <input type="number" name="accountNumber" value =<%=session.getAttribute("accountNumber")%> readonly></h3><br>
    <h3>Deposit amount : <input type="number" name="depositMoney"/></h3><br> <br>
    &emsp; &emsp; &emsp; &emsp; &emsp; &emsp;   <input class="button button1" type="submit" value="Deposit"/>
    &emsp;<input class="button button1" type="reset" value="Reset"/>
</form>

<%
    }
%>


<br><br>
<h2>&emsp;<a href="home.jsp">Back to Summary</a> &emsp;&emsp;<a href="logout">Logout</a></h2>

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

</body>
</html>
