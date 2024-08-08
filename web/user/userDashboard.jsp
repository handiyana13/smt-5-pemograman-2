<%-- 
    Document   : userDashboard
    Created on : May 30, 2024, 1:33:26 AM
    Author     : HandiLaw
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@page import="com.handilaw.DBConnection"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Dashboard</title>
    <link rel="stylesheet" type="text/css" href="../css/main.css">
    <style>
        .book-container {
            display: flex;
            justify-content: space-around;
            flex-wrap: wrap;
            margin-top: 20px;
        }
        
        .book-item {
            width: 30%;
            text-align: center;
            margin-bottom: 20px;
        }
        
        .book-image {
            height: 100px;
            width: 100px;
            object-fit: cover;
        }
        
        .book-title {
            font-size: 18px;
            font-weight: bold;
            margin-top: 10px;
        }
        
        .book-description {
            font-size: 14px;
            margin-top: 5px;
        }
    </style>
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
            <h1>Selamat Datang, <%= session.getAttribute("username") %></h1>
            <p></p>
            <section>
                <h3>Rekomendasi Buku Hari Ini</h3>
                <div class="book-container">
                    <% 
                    try {
                        Connection connection = DBConnection.initializeDatabase();
                        String sql = "SELECT * FROM books ORDER BY RAND() LIMIT 3";
                        try (PreparedStatement statement = connection.prepareStatement(sql)) {
                            ResultSet resultSet = statement.executeQuery();
                            while (resultSet.next()) {
                                int id = resultSet.getInt("id");
                                String title = resultSet.getString("title");
                                String author = resultSet.getString("author");
                                String description = resultSet.getString("publisher");
                                String imageUrl = resultSet.getString("image_url");
                    %>
                                <div class="book-item">
                                    <img src="../<%= imageUrl %>" alt="<%= title %>" class="book-image">
                                    <div class="book-title"><%= title %></div>
                                    <div class="book-description">
                                        <p><strong>Penulis:</strong> <%= author %></p>
                                        <p><%= description %></p>
                                    </div>
                                </div>
                    <% 
                            }
                        }
                    } catch (SQLException | ClassNotFoundException e) {
                        e.printStackTrace();
                    }
                    %>
                </div>
            </section>
        </main>
        <footer>
            <p style="color: white !important;">&copy; 2024 Sistem Perpustakaan. All rights reserved.</p>
        </footer>
    </div>
</body>
</html>
