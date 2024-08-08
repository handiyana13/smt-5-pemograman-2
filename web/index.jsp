<%-- 
    Document   : index
    Created on : May 30, 2024, 12:17:35 AM
    Author     : HandiLaw
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Login - Library Management</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>
    <div class="container">
        <div class="left">
            <h2>Aplikasi Manajemen<br>Perpustakaan Online</h2>
        </div>
        <div class="right">
            <h2>Login</h2>
            <form action="LoginServlet" method="post">
                <label for="username">Username:</label>
                <input type="text" id="username" name="username" required>
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>
                <input type="submit" value="Login">
            </form>
            <%-- Display error message if login fails --%>
            <%
                if (request.getAttribute("errorMessage") != null) {
                    out.print("<p>" + request.getAttribute("errorMessage") + "</p>");
                }
            %>
            <div class="switch-form">
                <p>Belum punya akun? <a href="register.jsp">Daftar Disini!</a></p>
            </div>
        </div>
    </div>
</body>
</html>
