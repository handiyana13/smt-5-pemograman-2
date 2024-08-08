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

@WebServlet(urlPatterns = {"/DeleteLoanServlet"})
public class DeleteLoanServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Connection con = DBConnection.initializeDatabase();
            // Hapus semua data dari tabel loans
            PreparedStatement pst = con.prepareStatement("DELETE FROM loans");
            
            int rowsAffected = pst.executeUpdate();
            
            if (rowsAffected > 0) {
                // Jika berhasil dihapus, redirect kembali ke halaman manageLoans.jsp
                response.sendRedirect("admin/manageLoans.jsp");
            } else {
                // Jika tidak ada data yang terhapus (seharusnya tidak terjadi)
                request.setAttribute("errorMessage", "Gagal menghapus histori/data peminjaman");
                request.getRequestDispatcher("error.jsp").forward(request, response);
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error occurred");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Redirect ke doPost untuk menghapus data
        doPost(request, response);
    }
}
