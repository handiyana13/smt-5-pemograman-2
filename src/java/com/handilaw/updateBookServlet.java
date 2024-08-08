/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.handilaw;

/**
 *
 * @author HandiLaw
 */
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

@WebServlet("/updateBookServlet")
public class updateBookServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String publisher = request.getParameter("publisher");
        int year = Integer.parseInt(request.getParameter("year"));
        HttpSession session = request.getSession();

        try (Connection connection = DBConnection.initializeDatabase()) {
            String sql = "UPDATE books SET title = ?, author = ?, publisher = ?, year = ? WHERE id = ?";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setString(1, title);
                statement.setString(2, author);
                statement.setString(3, publisher);
                statement.setInt(4, year);
                statement.setInt(5, id);
                statement.executeUpdate();
                session.setAttribute("message", "Buku berhasil diperbarui.");
                session.setAttribute("messageType", "success");
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            session.setAttribute("message", "Gagal memperbarui buku.");
            session.setAttribute("messageType", "error");
        }

        response.sendRedirect("admin/dataBooks.jsp");
    }
}

