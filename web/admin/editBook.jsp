<%@page import="com.handilaw.DBConnection"%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Buku</title>
    <link rel="stylesheet" type="text/css" href="../css/main.css">
    <style>
        .form-container {
            display: flex;
            flex-wrap: wrap;
        }

        .form-group {
            flex: 1 1 45%;
            margin: 10px;
        }

        .submit-container {
            width: 100%;
            display: flex;
            justify-content: center;
            margin-top: 20px;
        }

        .submit-container input {
            padding: 10px 20px;
            font-size: 16px;
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <h1>Kelola Buku</h1>
            <nav>
                <ul class="nav-menu">
                    <li><a href="adminDashboard.jsp">Dashboard</a></li>
                    <li><a href="manageBooks.jsp">Tambah Buku</a></li>
                    <li><a href="dataBooks.jsp">Data Buku</a></li>
                </ul>
            </nav>
        </header>
        <main>
            <h1>Edit Buku</h1>
            <%
                int id = Integer.parseInt(request.getParameter("id"));
                String title = "", author = "", publisher = "";
                int year = 0;

                try (Connection connection = DBConnection.initializeDatabase()) {
                    String sql = "SELECT title, author, publisher, year FROM books WHERE id = ?";
                    try (PreparedStatement statement = connection.prepareStatement(sql)) {
                        statement.setInt(1, id);
                        ResultSet resultSet = statement.executeQuery();
                        if (resultSet.next()) {
                            title = resultSet.getString("title");
                            author = resultSet.getString("author");
                            publisher = resultSet.getString("publisher");
                            year = resultSet.getInt("year");
                        }
                    }
                } catch (SQLException | ClassNotFoundException e) {
                    e.printStackTrace();
                }
            %>
            <form style="padding-left: 200px; padding-right: 200px;" action="../updateBookServlet" method="post">
                <input type="hidden" name="id" value="<%= id %>">
                <table style="width:100%">
                  <tr>
                    <th style="width:400px;"><label for="title">Judul Buku</label></th>
                    <td>:</td>
                    <td style="text-align: left"><input type="text" id="title" name="title" value="<%= title %>" required></td>
                </tr>
                <tr>
                 <th><label for="author">Penulis</label></th>
                 <td>:</td>
                 <td style="text-align: left"><input type="text" id="author" name="author" value="<%= author %>" required></td>
             </tr>
             <tr>
                <th><label for="publisher">Uraian</label></th>
                <td>:</td>
                <td style="text-align: left"><textarea id="publisher" name="publisher" required><%= publisher %></textarea></td>
            </tr>
            <tr>
                <th><label for="year">Tahun Terbit</label></th>
                <td>:</td>
                <td style="text-align: left"><input type="number" id="year" name="year" value="<%= year %>" required></td>
            </tr>
        </table>
        <div class="submit-container">
            <input type="submit" value="Update Buku">
        </div>
    </form>
</main>
</div>
</body>
</html>
