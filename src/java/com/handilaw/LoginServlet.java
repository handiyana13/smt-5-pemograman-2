package com.handilaw;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import java.io.IOException;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


/**
 *
 * @author HandiLaw
 */
@WebServlet(urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private static final long serialVersionUID = 1L;
    private static final Logger LOGGER = Logger.getLogger(LoginServlet.class.getName());

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            // Encrypt the password using MD5
            String encryptedPassword = encryptPassword(password);

            Connection con = DBConnection.initializeDatabase();
            PreparedStatement pst = con.prepareStatement("SELECT id, role, email FROM users WHERE username = ? AND password = ?");
            pst.setString(1, username);
            pst.setString(2, encryptedPassword);

            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                int userId = rs.getInt("id"); // Ambil ID dari hasil query
                String role = rs.getString("role");
                String email = rs.getString("email"); // Ambil email dari hasil query
                HttpSession session = request.getSession();
                session.setAttribute("username", username);
                session.setAttribute("role", role);
                session.setAttribute("userId", userId); // Simpan userId dalam sesi
                session.setAttribute("email", email); // Simpan email dalam sesi

                LOGGER.info("User logged in successfully. Username: " + username + ", userId: " + userId + ", role: " + role);

                if ("admin".equals(role)) {
                    response.sendRedirect("admin/adminDashboard.jsp");
                } else if ("user".equals(role)) {
                    response.sendRedirect("user/userDashboard.jsp");
                }
            } else {
                LOGGER.warning("Login failed for username: " + username);
                request.setAttribute("errorMessage", "Username dan Password Salah!");
                request.getRequestDispatcher("index.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred");
            request.getRequestDispatcher("index.jsp").forward(request, response);
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
