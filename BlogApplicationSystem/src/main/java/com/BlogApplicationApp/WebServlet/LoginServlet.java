package com.BlogApplicationApp.WebServlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.BlogApplicationApp.utils.DatabaseUtil;
import com.BlogApplicationApp.utils.PasswordUtil;



@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try (Connection connection = DatabaseUtil.getConnection()) {
            String sql = "SELECT * FROM users WHERE email = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, email);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                String hashedPassword = resultSet.getString("password");
                String role = resultSet.getString("role");

                if (PasswordUtil.checkPassword(password, hashedPassword)) {
                    HttpSession session = request.getSession();
                    session.setAttribute("userRole", role);
                    session.setAttribute("userName", resultSet.getString("name"));
                    if ("Admin".equals(role)) {
                        response.sendRedirect("adminDashboard");
                    } else {
                        response.sendRedirect("viewerDashboard.jsp");
                    }
                } else {
                    response.sendRedirect("login.jsp?error=1");
                }
            } else {
                response.sendRedirect("login.jsp?error=1");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=1");
        }
    }
}
