<%-- 
    Document   : manageMembers
    Created on : Jul 2, 2024, 1:15:40 AM
    Author     : HandiLaw
--%>

<%@page import="com.handilaw.DBConnection"%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Kelola Anggota</title>
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
        
        .action-buttons a.delete-button {
            background-color: #ff0000;
        }

        .action-buttons a.role-button {
            background-color: #ffa500; /* Warna oranye */
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <h1>Kelola Anggota</h1>
            <nav>
                <ul class="nav-menu">
                    <li><a href="adminDashboard.jsp">Dashboard</a></li>
                    <li><a href="manageMembers.jsp">Data Anggota</a></li>
                </ul>
            </nav>
        </header>
        <main>
            <h1>Data Anggota</h1>
            <table>
                <tr>
                    <th>ID</th>
                    <th>Nama</th>
                    <th>Email</th>
                    <th>Role</th>
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
                        String sql = "SELECT id, username, email, role FROM users LIMIT ? OFFSET ?";
                        try (PreparedStatement statement = connection.prepareStatement(sql)) {
                            statement.setInt(1, recordsPerPage);
                            statement.setInt(2, startRecord);
                            ResultSet resultSet = statement.executeQuery();
                            while (resultSet.next()) {
                                int id = resultSet.getInt("id");
                                String name = resultSet.getString("username");
                                String email = resultSet.getString("email");
                                String role = resultSet.getString("role");
                %>
                                <tr>
                                    <td><%= id %></td>
                                    <td><%= name %></td>
                                    <td><%= email %></td>
                                    <td><%= role %></td>
                                    <td class="action-buttons">
                                        <a class="role-button" href="../changeRoleServlet?id=<%= id %>&currentRole=<%= role %>">
                                            <% if ("admin".equals(role)) { %>
                                                Jadikan User
                                            <% } else { %>
                                                Jadikan Admin
                                            <% } %>
                                        </a>
                                        <a class="delete-button" href="../deleteMemberServlet?id=<%= id %>" onclick="return confirm('Apakah Anda yakin ingin menghapus anggota ini?');">Delete</a>
                                    </td>
                                </tr>
                <%
                            }
                        }
                        
                        // Get the total number of records
                        String countSql = "SELECT COUNT(*) FROM users";
                        try (Statement countStatement = connection.createStatement()) {
                            ResultSet countResultSet = countStatement.executeQuery(countSql);
                            if (countResultSet.next()) {
                                int totalRecords = countResultSet.getInt(1);
                                int totalPages = (int) Math.ceil((double) totalRecords / recordsPerPage);
                %>
                            <div class="pagination">
                                <a class="<%= (currentPage == 1) ? "disabled" : "" %>" href="manageMembers.jsp?page=<%= (currentPage - 1) %>">Previous</a>
                                <a class="<%= (currentPage == totalPages) ? "disabled" : "" %>" href="manageMembers.jsp?page=<%= (currentPage + 1) %>">Next</a>
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
