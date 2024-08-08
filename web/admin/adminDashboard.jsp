<%-- 
    Document   : adminDashboard
    Created on : May 30, 2024, 1:32:52 AM
    Author     : HandiLaw
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <link rel="stylesheet" type="text/css" href="../css/main.css">
</head>
<body>
    <div class="container">
    <header>
    <h1>Admin Dashboard</h1>
    <nav>
        <ul class="nav-menu">
            <li><a href="manageBooks.jsp">Kelola Buku</a></li>
            <li><a href="manageMembers.jsp">Kelola Anggota</a></li>
            <li><a href="manageLoans.jsp">Kelola Peminjaman</a></li>
            <li><a href="../logout.jsp">Logout</a></li>
        </ul>
    </nav>
    </header>   
    </div>
</body>
</html>