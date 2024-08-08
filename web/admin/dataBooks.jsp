<%@page import="com.handilaw.DBConnection"%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Data Buku</title>
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
        
        .pagination {
            margin: 20px 0;
            display: flex;
            justify-content: center;
        }

        .pagination a {
            margin: 0 5px;
            padding: 10px 15px;
            text-decoration: none;
            border: 1px solid #ddd;
            color: #007bff;
        }

        .pagination a.disabled {
            color: #6c757d;
            pointer-events: none;
        }
        
        .action-buttons a {
            margin-right: 10px;
            padding: 5px 10px;
            color: #fff;
            text-decoration: none;
            border-radius: 5px;
        }
        
        .action-buttons a.edit-button {
            background-color: #ffa500;
        }
        
        .action-buttons a.delete-button {
            background-color: #ff0000;
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
            <h1>Daftar Buku</h1>
            <table>
                <tr>
                    <th>Judul Buku</th>
                    <th>Penulis</th>
                    <th>Uraian</th>
                    <th>Tahun Terbit</th>
                    <th>Aksi</th>
                </tr>
                <%
                    int currentPage = 1;
                    int recordsPerPage = 10;
                    if (request.getParameter("page") != null) {
                        currentPage = Integer.parseInt(request.getParameter("page"));
                    }

                    int startRecord = (currentPage - 1) * recordsPerPage;

                    try (Connection connection = DBConnection.initializeDatabase()) {
                        String sql = "SELECT id, title, author, publisher, year FROM books LIMIT ? OFFSET ?";
                        try (PreparedStatement statement = connection.prepareStatement(sql)) {
                            statement.setInt(1, recordsPerPage);
                            statement.setInt(2, startRecord);
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
                                        <a class="edit-button" href="editBook.jsp?id=<%= id %>">Edit</a>
                                        <a class="delete-button" href="../deleteBookServlet?id=<%= id %>" onclick="return confirm('Apakah Anda yakin ingin menghapus buku ini?');">Delete</a>
                                    </td>
                                </tr>
                <%
                            }
                        }
                        
                        // Get the total number of records
                        String countSql = "SELECT COUNT(*) FROM books";
                        try (Statement countStatement = connection.createStatement()) {
                            ResultSet countResultSet = countStatement.executeQuery(countSql);
                            if (countResultSet.next()) {
                                int totalRecords = countResultSet.getInt(1);
                                int totalPages = (int) Math.ceil((double) totalRecords / recordsPerPage);
                %>
                            <div class="pagination">
                                <a class="<%= (currentPage == 1) ? "disabled" : "" %>" href="dataBooks.jsp?page=<%= (currentPage - 1) %>">Previous</a>
                                <a class="<%= (currentPage == totalPages) ? "disabled" : "" %>" href="dataBooks.jsp?page=<%= (currentPage + 1) %>">Next</a>
                            </div>
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
