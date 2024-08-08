<%-- 
Document   : manageBooks
Created on : Jul 1, 2024, 6:47:53 AM
Author     : HandiLaw
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Kelola Buku</title>
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
            <h1>Tambah Buku Baru</h1>
            <form style="padding-left: 200px; padding-right: 200px;" action="../AddBookServlet" method="post">
                <table style="width:100%">
                  <tr>
                    <th style="width:400px;"><label for="title">Judul Buku</label></th>
                    <td>:</td>
                    <td style="text-align: left"><input type="text" id="title" name="title" required></td>
                </tr>
                <tr>
                 <th><label for="publisher">Penulis</label></th>
                 <td>:</td>
                 <td style="text-align: left"><input type="text" id="author" name="author" required></td>
             </tr>
             <tr>
                <th><label for="publisher">Uraian</label></th>
                <td>:</td>
                <td style="text-align: left"><textarea id="publisher" name="publisher" required></textarea></td>
            </tr>
            <tr>
                <th><label for="year_published">Tahun Terbit</label></th>
                <td>:</td>
                <td style="text-align: left"><input type="number" id="year" name="year" required></td>
            </tr>
        </table>
        <div class="submit-container">
            <input type="submit" value="Tambah Buku">
        </div>
    </form>
</main>
</div>
</body>
</html>
