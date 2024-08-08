<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.handilaw.DBConnection"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Kelola Peminjaman</title>
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

        .form-container {
            display: flex;
            flex-wrap: wrap;
            margin-top: 20px;
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
            <h1>Kelola Peminjaman</h1>
            <nav>
                <ul class="nav-menu">
                    <li><a href="adminDashboard.jsp">Dashboard</a></li>
                    <li><a href="manageLoans.jsp">Kelola Peminjaman</a></li>
                </ul>
            </nav>
        </header>
        <main>
            <h1>Daftar Peminjaman</h1>
            <table>
                <tr>
                    <th>ID</th>
                    <th>Buku</th>
                    <th>Anggota</th>
                    <th>Tanggal Pinjam</th>
                    <th>Tanggal Kembali</th>
                    <th>Dikembalikan</th>
                    <!-- <th>Aksi</th> -->
                </tr>
                <%
                    boolean hasUnreturnedBooks = false; // Flag untuk menandai jika ada buku yang belum dikembalikan
                    try (Connection connection = DBConnection.initializeDatabase()) {
                        String sql = "SELECT loans.id, books.title AS book_title, users.username AS member_name, loans.loan_date, loans.return_date, loans.returned " +
                                     "FROM loans " +
                                     "JOIN books ON loans.book_id = books.id " +
                                     "JOIN users ON loans.member_id = users.id";
                        try (Statement statement = connection.createStatement()) {
                            ResultSet resultSet = statement.executeQuery(sql);
                            while (resultSet.next()) {
                                int id = resultSet.getInt("id");
                                String bookTitle = resultSet.getString("book_title");
                                String memberName = resultSet.getString("member_name");
                                Date loanDate = resultSet.getDate("loan_date");
                                Date returnDate = resultSet.getDate("return_date");
                                boolean returned = resultSet.getBoolean("returned");
                                
                                if (!returned) {
                                    hasUnreturnedBooks = true; // Set flag jika ada buku yang belum dikembalikan
                                }
                %>
                                <tr>
                                    <td><%= id %></td>
                                    <td><%= bookTitle %></td>
                                    <td><%= memberName %></td>
                                    <td><%= loanDate %></td>
                                    <td><%= returnDate %></td>
                                    <td><%= returned ? "Ya" : "Tidak" %></td>
                                    <!-- <td>
                                        <%-- if (!returned) { %> --%>
                                            <%-- <form action="../ReturnBookServlet" method="post" style="display:inline;">
                                                <input type="hidden" name="loanId" value="<%= id %>">
                                                <input type="submit" value="Kembalikan">
                                            </form> --%>
                                        <%-- } --%>
                                    </td> -->
                                </tr>
                <%
                            }
                        }
                    } catch (SQLException | ClassNotFoundException e) {
                        e.printStackTrace();
                    }
                %>
            </table>

            <!-- Hanya tampilkan form hapus jika tidak ada buku yang belum dikembalikan -->
            <% if (!hasUnreturnedBooks) { %>
                <h2>Hapus Histori/Data Peminjaman</h2>
                <form action="../DeleteLoanServlet" method="post">
                    <div class="form-container">
                        <div class="form-group">
                            <p>Anda yakin ingin menghapus semua data peminjaman?</p>
                        </div>
                    </div>
                    <div class="submit-container">
                        <input type="submit" value="Hapus Histori/Data Peminjaman">
                    </div>
                </form>
            <% } %>
        </main>
    </div>
</body>
</html>
