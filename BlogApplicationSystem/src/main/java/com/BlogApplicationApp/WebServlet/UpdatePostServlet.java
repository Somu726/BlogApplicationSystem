package com.BlogApplicationApp.WebServlet;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import com.BlogApplicationApp.models.Post;
import com.BlogApplicationApp.utils.DatabaseUtil;

@WebServlet("/updatePost")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
                 maxFileSize = 1024 * 1024 * 10,      // 10MB
                 maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class UpdatePostServlet extends HttpServlet {
    private static final String SAVE_DIR = "uploadFiles";
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int postId = Integer.parseInt(request.getParameter("id"));
        try (Connection connection = DatabaseUtil.getConnection()) {
            String sql = "SELECT * FROM Posts WHERE id = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, postId);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                Post post = new Post();
                post.setId(resultSet.getInt("id"));
                post.setTitle(resultSet.getString("title"));
                post.setContent(resultSet.getString("content"));
                post.setImageUrl(resultSet.getString("image_url"));
                request.setAttribute("post", post);
                request.getRequestDispatcher("updatePost.jsp").forward(request, response); 
            } else {
                response.sendRedirect("adminDashboard.jsp");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("adminDashboard.jsp");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int postId = Integer.parseInt(request.getParameter("id"));
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        Part filePart = request.getPart("image");

        String fileName = extractFileName(filePart);
        String savePath = getServletContext().getRealPath("") + File.separator + SAVE_DIR;
        File fileSaveDir = new File(savePath);
        if (!fileSaveDir.exists()) {
            fileSaveDir.mkdir();
        }
        filePart.write(savePath + File.separator + fileName);

        try (Connection connection = DatabaseUtil.getConnection()) {
            String sql = "UPDATE Posts SET title = ?, content = ?, image_url = ? WHERE id = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, title);
            statement.setString(2, content);
            statement.setString(3, SAVE_DIR + File.separator + fileName);
            statement.setInt(4, postId);
            statement.executeUpdate();
            response.sendRedirect("adminDashboard");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("updatePost.jsp?id=" + postId + "&error=1");
        }
    }

    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }
        return "";
    }
}
