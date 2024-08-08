package com.handilaw;

import java.io.IOException;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(urlPatterns = {"/UpdateProfileServlet"})
public class UpdateProfileServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            // Encrypt the password using MD5 if it is not empty
            String encryptedPassword = password.isEmpty() ? "" : encryptPassword(password);

            Connection con = DBConnection.initializeDatabase();
            PreparedStatement pst = con.prepareStatement("UPDATE users SET username = ?, email = ?, password = ? WHERE id = ?");
            pst.setString(1, username);
            pst.setString(2, email);
            pst.setString(3, encryptedPassword);
            
            // Get userId from session
            HttpSession session = request.getSession(false);
            if (session != null && session.getAttribute("userId") != null) {
                int userId = (int) session.getAttribute("userId");
                pst.setInt(4, userId);

                int row = pst.executeUpdate();

                if (row > 0) {
                    // Update session attributes
                    session.setAttribute("username", username);
                    session.setAttribute("email", email);
                    // Redirect to profile page with success message
                    response.sendRedirect("user/userProfile.jsp?message=Profile updated successfully");
                } else {
                    // Redirect to profile page with error message
                    response.sendRedirect("user/userProfile.jsp?error=Failed to update profile");
                }
            } else {
                // Redirect to login page if session is invalid
                response.sendRedirect("index.jsp");
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            // Redirect to profile page with error message
            response.sendRedirect("user/userProfile.jsp?error=An error occurred");
        }
    }

    private String encryptPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] messageDigest = md.digest(password.getBytes());
            BigInteger no = new BigInteger(1, messageDigest);
            String hashtext = no.toString(16);
            while (hashtext.length() < 32) {
                hashtext = "0" + hashtext;
            }
            return hashtext;
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }

}
