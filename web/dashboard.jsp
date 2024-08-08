<%-- 
    Document   : dashboard
    Created on : May 30, 2024, 12:24:22 AM
    Author     : HandiLaw
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard - Library Management</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
    <div class="dashboard">
        <h2>Welcome to Library Management System</h2>
        <%
            if (session != null && session.getAttribute("username") != null) {
                out.print("<h3>Hello, " + session.getAttribute("username") + "</h3>");
            } else {
                response.sendRedirect("login.jsp");
            }
        %>
        <a href="logout.jsp" class="logout-button">Logout</a>
    </div>
</body>
</html>
