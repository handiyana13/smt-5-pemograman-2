package com.handilaw;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/AddBookServlet")
public class AddBookServlet extends HttpServlet {
    private static final String DEFAULT_IMAGE = "cover/cover.png";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String publisher = request.getParameter("publisher");
        int yearPublished = Integer.parseInt(request.getParameter("year"));
        HttpSession session = request.getSession();

        // Menyimpan detail buku ke database
        try (Connection connection = DBConnection.initializeDatabase()) {
            String sql = "INSERT INTO books (title, author, publisher, year, image_url) VALUES (?, ?, ?, ?, ?)";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setString(1, title);
                statement.setString(2, author);
                statement.setString(3, publisher);
                statement.setInt(4, yearPublished);
                statement.setString(5, DEFAULT_IMAGE);
                statement.executeUpdate();
                session.setAttribute("message", "Buku berhasil ditambahkan.");
                session.setAttribute("messageType", "success");
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            session.setAttribute("message", "Gagal menambahkan buku.");
            session.setAttribute("messageType", "error");
        }

        response.sendRedirect("admin/manageBooks.jsp");
    }
}
