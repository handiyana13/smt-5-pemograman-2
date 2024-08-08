<%@page import="com.handilaw.DBConnection"%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Lihat Buku</title>
    <link rel="stylesheet" type="text/css" href="../css/main.css">
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #f2f2f2;
        }
        
        .action-buttons a {
            margin-right: 10px;
            padding: 5px 10px;
            text-decoration: none;
            border-radius: 5px;
            background-color: #007bff;
            color: #fff;
        }

        .action-buttons a.disabled {
            background-color: #6c757d;
            pointer-events: none;
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <h1>Lihat Buku</h1>
            <nav>
                <ul class="nav-menu">
                    <li><a href="userDashboard.jsp">Dashboard</a></li>
                    <li><a href="viewBooks.jsp">Lihat Buku</a></li>
                    <li><a href="viewLoans.jsp">Histori Peminjaman</a></li>
                    <li><a href="../logout.jsp">Logout</a></li>
                </ul>
            </nav>
        </header>
        <main>
            <h1>Daftar Buku Yang Tersedia</h1>
            <table>
                <tr>
                    <th>Judul Buku</th>
                    <th>Penulis</th>
                    <th>Uraian</th>
                    <th>Tahun Terbit</th>
                    <th>Aksi</th>
                </tr>
                <%
                    try (Connection connection = DBConnection.initializeDatabase()) {
                        String sql = "SELECT id, title, author, publisher, year FROM books WHERE available = 1";
                        try (PreparedStatement statement = connection.prepareStatement(sql)) {
                            ResultSet resultSet = statement.executeQuery();
                            while (resultSet.next()) {
                                int id = resultSet.getInt("id");
                                String title = resultSet.getString("title");
                                String author = resultSet.getString("author");
                                String publisher = resultSet.getString("publisher");
                                int year = resultSet.getInt("year");
                %>
                                <tr>
                                    <td><%= title %></td>
                                    <td><%= author %></td>
                                    <td><%= publisher %></td>
                                    <td><%= year %></td>
                                    <td class="action-buttons">
                                        <a href="../BorrowBookServlet?id=<%= id %>">Pinjam</a>
                                    </td>
                                </tr>
                <%
                            }
                        }
                    } catch (SQLException | ClassNotFoundException e) {
                        e.printStackTrace();
                    }
                %>
            </table>
        </main>
    </div>
</body>
</html>