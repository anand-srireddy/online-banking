<%--
  Created by IntelliJ IDEA.
  User: newvi
  Date: 6/21/2022
  Time: 2:41 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*,java.util.*"%>
<%@ page import="java.io.PrintWriter" %>


<%
    try {

        PrintWriter output = response.getWriter();

            output.println("<html><body style=\"background-color:LightGray;\">");
            output.println("<br>");
            output.println("<h3>Sorry, that seems to be an invalid username or password </h3>");
            output.println("<h3>Please make sure to register yourself first. In case if not yet.</h3>");
            output.println("<br>");
            output.println("<h4>\n" +
                    "        <p><a href=\"index.jsp\"> Take me back to home. </a></p>\n" +
                    "    </h4>");
            output.println("</body></html>");

    } catch (Exception e) {
        e.printStackTrace();
    }
%>
