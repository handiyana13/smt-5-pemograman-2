<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="com.handilaw.DBConnection" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Lihat Peminjaman</title>
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
    </style>
</head>
<body>
    <div class="container">
        <header>
            <h1>Histori Peminjaman</h1>
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
            <h1>Status Peminjaman</h1>
            <table>
                <tr>
                    <th>ID</th>
                    <th>Judul Buku</th>
                    <th>Tanggal Pinjam</th>
                    <th>Tanggal Kembali</th>
                    <th>Dikembalikan</th>
                    <th>Aksi</th>
                </tr>
                <%
                    Integer userId = (Integer) request.getSession().getAttribute("userId");
                    if (userId != null) {
                        try (Connection connection = DBConnection.initializeDatabase()) {
                            String sql = "SELECT loans.id, books.title, loans.loan_date, loans.return_date, loans.returned " +
                                         "FROM loans " +
                                         "JOIN books ON loans.book_id = books.id " +
                                         "WHERE loans.member_id = ?";
                            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                                statement.setInt(1, userId);
                                ResultSet resultSet = statement.executeQuery();
                                while (resultSet.next()) {
                                    int id = resultSet.getInt("id");
                                    String title = resultSet.getString("title");
                                    Date loanDate = resultSet.getDate("loan_date");
                                    Date returnDate = resultSet.getDate("return_date");
                                    boolean returned = resultSet.getBoolean("returned");
                %>
                                    <tr>
                                        <td><%= id %></td>
                                        <td><%= title %></td>
                                        <td><%= loanDate %></td>
                                        <td><%= returnDate %></td>
                                        <td><%= returned ? "Ya" : "Tidak" %></td>
                                        <td>
                                            <% if (!returned) { %>
                                                <form action="../ReturnBookServlet" method="post">
                                                    <input type="hidden" name="loanId" value="<%= id %>">
                                                    <button type="submit">Kembalikan</button>
                                                </form>
                                            <% } else { %>
                                                Sudah Dikembalikan
                                            <% } %>
                                        </td>
                                    </tr>
                <%
                                }
                            }
                        } catch (SQLException | ClassNotFoundException e) {
                            e.printStackTrace();
                        }
                    } else {
                        out.println("<tr><td colspan='6'>User ID tidak ditemukan dalam sesi.</td></tr>");
                    }
                %>
            </table>
        </main>
    </div>
</body>
</html>
