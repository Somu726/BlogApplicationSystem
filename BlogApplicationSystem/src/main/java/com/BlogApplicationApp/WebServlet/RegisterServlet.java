package com.BlogApplicationApp.WebServlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.mindrot.jbcrypt.BCrypt;

import com.BlogApplicationApp.utils.DatabaseUtil;
import com.BlogApplicationApp.utils.PasswordUtil;


@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
 private static final long serialVersionUID = 1L;

 protected void doPost(HttpServletRequest request, HttpServletResponse response)
         throws ServletException, IOException {
     String name = request.getParameter("name");
     String email = request.getParameter("email");
     String password = request.getParameter("password");
     String role = request.getParameter("role");

     String hashedPassword = PasswordUtil.hashPassword(password);

     try(Connection conn = DatabaseUtil.getConnection()) {
         

         String sql = "INSERT INTO Users (name, email, password, role) VALUES (?, ?, ?, ?)";
         PreparedStatement stmt = conn.prepareStatement(sql);
         stmt.setString(1, name);
         stmt.setString(2, email);
         stmt.setString(3, hashedPassword);
         stmt.setString(4, role);

         stmt.executeUpdate();

         response.sendRedirect("login.jsp");
     } catch ( SQLException e) {
         e.printStackTrace();
         response.sendRedirect("error.jsp");
     }
 }
}
