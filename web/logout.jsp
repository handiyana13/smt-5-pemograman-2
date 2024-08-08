<%-- 
    Document   : logout
    Created on : May 30, 2024, 12:26:34 AM
    Author     : HandiLaw
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    HttpSession logout = request.getSession();
    session.invalidate();
    response.sendRedirect("index.jsp");
%>
