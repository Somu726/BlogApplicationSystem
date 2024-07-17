package com.BlogApplicationApp.WebServlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.BlogApplicationApp.utils.DatabaseUtil;

@WebServlet("/searchPosts")
public class SearchPostsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String query = request.getParameter("query");
        

        try {
        	Connection conn = DatabaseUtil.getConnection();
            String sql = "SELECT * FROM Posts WHERE title LIKE ? OR DATE_FORMAT(created_at, '%Y-%m-%d') LIKE ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, "%" + query + "%");
            stmt.setString(2, "%" + query + "%");

            ResultSet rs = stmt.executeQuery();

            request.setAttribute("searchResults",rs);

            // Forward to searchPosts.jsp for displaying search results or no results message
            request.getRequestDispatcher("searchPosts.jsp").forward(request, response);

        } catch ( SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
