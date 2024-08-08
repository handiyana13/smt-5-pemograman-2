<%-- 
    Document   : register
    Created on : May 30, 2024, 12:49:10 AM
    Author     : HandiLaw
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Register - Library Management</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>
    <div class="container">
        <div class="left">
            <h2>Aplikasi Manajemen<br>Perpustakaan Online</h2>
        </div>
        <div class="right">
            <h2>Register</h2>
            <form action="RegisterServlet" method="post">
                <label for="username">Username:</label>
                <input type="text" id="username" name="username" required>
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required><br>

                <input type="submit" value="Register">
            </form>
            <%-- Display error message if registration fails --%>
            <%
                if (request.getAttribute("errorMessage") != null) {
                    out.print("<p>" + request.getAttribute("errorMessage") + "</p>");
                }
            %>
            <div class="switch-form">
                <p>Sudah punya akun? <a href="index.jsp">Login disini!</a></p>
            </div>
        </div>
    </div>
</body>
</html>
