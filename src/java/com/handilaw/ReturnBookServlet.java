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

@WebServlet(urlPatterns = {"/ReturnBookServlet"})
public class ReturnBookServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int loanId = Integer.parseInt(request.getParameter("loanId"));

        try {
            Connection con = DBConnection.initializeDatabase();
            // Update loans table
            PreparedStatement pst = con.prepareStatement("UPDATE loans SET returned = true, return_date = ? WHERE id = ?");
            pst.setDate(1, java.sql.Date.valueOf(java.time.LocalDate.now())); // Set return_date to current date
            pst.setInt(2, loanId);
            int rowsAffected = pst.executeUpdate();

            if (rowsAffected > 0) {
                // Update books table to increase availability
                PreparedStatement updateBookPst = con.prepareStatement("UPDATE books SET available = available + 1 WHERE id = (SELECT book_id FROM loans WHERE id = ?)");
                updateBookPst.setInt(1, loanId);
                int booksUpdated = updateBookPst.executeUpdate();

                if (booksUpdated > 0) {
                    // Redirect back to view loans page
                    response.sendRedirect("user/viewLoans.jsp");
                } else {
                    // Failed to update books table (availability)
                    request.setAttribute("errorMessage", "Failed to update book availability");
                    request.getRequestDispatcher("error.jsp").forward(request, response);
                }
            } else {
                // Failed to update loans table (return status)
                request.setAttribute("errorMessage", "Failed to return book");
                request.getRequestDispatcher("error.jsp").forward(request, response);
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error occurred");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}
