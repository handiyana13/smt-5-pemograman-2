<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Profile</title>
    <link rel="stylesheet" type="text/css" href="../css/main.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>Sistem Perpustakaan</h1>
            <nav>
                <ul class="nav-menu">
                    <li><a href="viewBooks.jsp">Lihat Buku</a></li>
                    <li><a href="viewLoans.jsp">Histori Peminjaman</a></li>
                    <li><a href="userProfile.jsp">Profil</a></li>
                    <li><a href="../logout.jsp">Keluar</a></li>
                </ul>
            </nav>
        </header>
        <main>
            <h1>Profil Pengguna</h1>
            <%-- Check for success or error message --%>
            <% String message = request.getParameter("message");
               String error = request.getParameter("error");
               if (message != null) { %>
                   <p class="success-message"><%= message %></p>
            <% } else if (error != null) { %>
                   <p class="error-message"><%= error %></p>
            <% } %>
            <form action="../UpdateProfileServlet" method="post">
                <div class="form-group">
                    <label for="username">Username:</label>
                    <input type="text" id="username" name="username" value="<%= session.getAttribute("username") %>" required>
                </div>
                <div class="form-group">
                    <label for="email">Email:</label>
                    <input type="email" id="email" name="email" value="<%= session.getAttribute("email") %>" required>
                </div>
                <div class="form-group">
                    <label for="password">Password:</label>
                    <input type="password" id="password" name="password">
                </div>
                <div class="submit-container">
                    <input type="submit" value="Simpan Perubahan">
                </div>
            </form>
        </main>
        <footer>
            <p style="color: white !important;">&copy; 2024 Sistem Perpustakaan. All rights reserved.</p>
        </footer>
    </div>
</body>
</html>
