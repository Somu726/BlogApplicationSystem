package com.BlogApplicationApp.WebServlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.BlogApplicationApp.utils.DatabaseUtil;


@WebServlet("/deletePost")
public class DeletePostServlet extends HttpServlet {
 private static final long serialVersionUID = 1L;

 protected void doGet(HttpServletRequest request, HttpServletResponse response)
         throws ServletException, IOException {
     int id = Integer.parseInt(request.getParameter("id"));

     try (Connection conn = DatabaseUtil.getConnection()){
        
         String sql = "DELETE FROM Posts WHERE id = ?";
         PreparedStatement stmt = conn.prepareStatement(sql);
         stmt.setInt(1, id);

         stmt.executeUpdate();

         response.sendRedirect("adminDashboard");
     } catch (SQLException e) {
         e.printStackTrace();
         response.sendRedirect("error.jsp");
     }
 }
}