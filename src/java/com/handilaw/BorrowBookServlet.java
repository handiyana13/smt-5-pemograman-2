package com.handilaw;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(urlPatterns = {"/BorrowBookServlet"})
public class BorrowBookServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userIdObj = (Integer) session.getAttribute("userId");
        
        // Pastikan userId tidak null
        if (userIdObj == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        int userId = userIdObj.intValue();
        
        // Pastikan parameter bookId tidak null
        String bookIdParam = request.getParameter("id");
        if (bookIdParam == null || bookIdParam.isEmpty()) {
            request.setAttribute("errorMessage", "Parameter bookId tidak valid");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }
        
        int bookId = Integer.parseInt(bookIdParam);

        // Lanjutkan dengan proses pinjam buku
        LocalDate loanDate = LocalDate.now(); // Tanggal pinjam saat ini
        
        try {
            Connection con = DBConnection.initializeDatabase();
            
            // Cek apakah bookId valid di database
            if (!isBookAvailable(con, bookId)) {
                request.setAttribute("errorMessage", "Buku tidak tersedia atau tidak valid");
                request.getRequestDispatcher("error.jsp").forward(request, response);
                return;
            }
            
            PreparedStatement pst = con.prepareStatement("INSERT INTO loans (book_id, member_id, loan_date, return_date, returned) VALUES (?, ?, ?, ?, ?)");
            pst.setInt(1, bookId);
            pst.setInt(2, userId);
            pst.setDate(3, java.sql.Date.valueOf(loanDate)); // Set tanggal pinjam
            pst.setDate(4, null); // Return date awalnya null
            pst.setBoolean(5, false); // Peminjaman belum dikembalikan

            int rowsAffected = pst.executeUpdate();

            if (rowsAffected > 0) {
                // Berhasil meminjam buku
                updateBookAvailability(con, bookId); // Update ketersediaan buku
                response.sendRedirect("user/viewLoans.jsp");
            } else {
                // Gagal meminjam buku
                request.setAttribute("errorMessage", "Gagal meminjam buku");
                request.getRequestDispatcher("error.jsp").forward(request, response);
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error occurred");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
    
    private boolean isBookAvailable(Connection con, int bookId) throws SQLException {
        String sql = "SELECT available FROM books WHERE id = ?";
        try (PreparedStatement statement = con.prepareStatement(sql)) {
            statement.setInt(1, bookId);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                int available = resultSet.getInt("available");
                return available > 0; // Buku tersedia jika available > 0
            }
        }
        return false; // Buku tidak ditemukan atau tidak tersedia
    }
    
    private void updateBookAvailability(Connection con, int bookId) throws SQLException {
        String sql = "UPDATE books SET available = available - 1 WHERE id = ?";
        try (PreparedStatement statement = con.prepareStatement(sql)) {
            statement.setInt(1, bookId);
            statement.executeUpdate();
        }
    }
}
