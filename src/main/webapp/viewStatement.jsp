<%--
  Created by IntelliJ IDEA.
  User: newvi
  Date: 6/24/2022
  Time: 3:04 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<html>
<head>
    <title>View e-Statement</title>
    <link rel="icon" type="image/x-icon" href="logo.ico">
    <style>
        table, tr, td {
            border: 1px solid black;
            border-collapse: collapse;
        }

        tr:nth-child(even),tr:nth-child(odd) {
            background-color: #D6EEEE;
        }
        th, td {
            padding: 15px;
        }
        tr:first-child {
            background-color:Tomato;
        }
    </style>
    <script type="text/javascript">
        function preventBack() {
            window.history.forward();
        }
        setTimeout("preventBack()", 0);
        window.onunload = function () { null };
    </script>
</head>
<body style="background-color:LightGray;" >
<br>
<h1 style="background-color:Tomato;">
    &emsp; Your Statement. Let's keep track.
</h1>
<br>
<%
    try {
        String connectionURL = "jdbc:mysql://localhost/OnlineBanking";

        Connection connection = null;
        Statement statement = null;
        ResultSet rs = null;

        Class.forName("com.mysql.jdbc.Driver");

        connection = DriverManager.getConnection(connectionURL, "root", "root");
        statement = connection.createStatement();

        String QueryString = "SELECT * from transactions where accountNumber = "+session.getAttribute("accountNumber")+" order by transactiondate desc";
        rs = statement.executeQuery(QueryString);
%>
<TABLE id = "statement" border="2" style="width:65%" style="background-color: #ffffcc;">
    <tr>
        <th>Transaction Id</th>
        <th>Transaction Date</th>
        <th>Account Number</th>
        <th>Trasaction Type</th>
        <th>Amount</th>
    </tr>
    <%
        while (rs.next()) {
    %>

    <TR>
        <TD align = "center"><%=rs.getInt(1)%></TD>
        <TD align = "center"><%=rs.getString(2)%></TD>
        <TD align = "center"><%=rs.getInt(3)%></TD>
        <TD align = "center"><%=rs.getString(5)%></TD>
        <TD align = "center">$<%=rs.getDouble(6)%></TD>

    </TR>

    <% } %>
    <%
        // close all the connections.
        rs.close();
        statement.close();
        connection.close();
    } catch (Exception ex) {
    %>

            <%

}
%>
</TABLE> <br><br>
<h2>&emsp;<a href="home.jsp">Back to Summary</a> &emsp;&emsp;<a href="logout">Logout</a></h2>
<input type="button" value="Create PDF"
       id="btPrint" onclick="createPDF()" />
<script>
    function createPDF() {
        const sTable = document.getElementById('statement').innerHTML;

        let style = "<style>";
        style = style + "table {width: 100%;font: 17px Calibri;}";
        style = style + "table, th, td {border: solid 1px #DDD; border-collapse: collapse;";
        style = style + "padding: 2px 3px;text-align: center;}";
        style = style + "</style>";

        // CREATE A WINDOW OBJECT.
        const win = window.open('', '', 'height=700,width=700');

        win.document.write('<html><head>');
        win.document.write('<title>Account Statement</title>');
        win.document.write(style);          // ADD STYLE INSIDE THE HEAD TAG.
        win.document.write('</head>');
        win.document.write('<body>');
        win.document.write(sTable);         // THE TABLE CONTENTS INSIDE THE BODY TAG.
        win.document.write('</body></html>');

        win.document.close(); 	// CLOSE THE CURRENT WINDOW.

        win.print();    // PRINT THE CONTENTS.
    }
</script>

</body>
</html>