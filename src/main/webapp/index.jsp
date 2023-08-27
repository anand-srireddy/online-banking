<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Internet Banking</title>
    <link rel="icon" type="image/x-icon" href="logo.ico">

    <style>
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
    <script type="text/javascript">
        function preventBack() {
            window.history.forward();
        }
        setTimeout("preventBack()", 0);
        window.onunload = function () { null };
    </script>
</head>
<body align = "center" style="background-color:LightGray;">
<h1 align="center" style="background-color:Tomato;font-size:44px"><%= "Welcome to American Bank!" %>
</h1>
<br/>
<h3 style="font-size:20px;">    
    Personal Login
</h3>
<br>

<form action="Dashboard" method="post">
    Username : <input type="text" name="userid" /><br><br>
    Password : <input type="password" name="password" /><br> <br>
&emsp; &emsp; &emsp; &emsp; &emsp; &emsp;   <input class="button button1" type="submit" value="Login"/>
    &emsp;<input class="button button1" type="reset" value="Reset"/>
</form>
<h4>
    <%-- <a href="hello-servlet">Personal Login</a>--%> <br>
    <p>Forgot your password ? <a href="ForgotPassword.html"> Ways to Retrieve</a></p>
</h4>
<h3 style="font-size:20px;">
   <%-- <a href="hello-servlet">Personal Login</a>--%><br>
    <p>New User ?? <a href="Registration.html"> Register Here </a></p>
</h3>

</body>
</html>