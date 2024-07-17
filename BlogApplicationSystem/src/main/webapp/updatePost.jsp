<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.io.IOException" %>
<%@ page import="javax.servlet.ServletException" %>
<%@ page import="javax.servlet.annotation.WebServlet" %>
<%@ page import="javax.servlet.http.HttpServlet" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ page import="javax.servlet.http.HttpServletResponse" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%@ page import="com.BlogApplicationApp.models.Post" %>
<%@ page import="com.BlogApplicationApp.utils.DatabaseUtil" %>

<%

Post post = new Post();

String id = request.getParameter("id");
try (Connection conn = DatabaseUtil.getConnection()) {
    
    String sql = "SELECT * FROM Posts WHERE id = ?";
    PreparedStatement stmt = conn.prepareStatement(sql);
    stmt.setInt(1, Integer.parseInt(id));

    ResultSet rs = stmt.executeQuery();
    if (rs.next()) {
        post.setId(rs.getInt("id"));
        post.setTitle(rs.getString("title"));
        post.setContent(rs.getString("content"));
        post.setImageUrl(rs.getString("image_url"));
    } else {
        response.sendRedirect("adminDashboard.jsp");
    }
} catch (SQLException e) {
    e.printStackTrace();
    response.sendRedirect("adminDashboard.jsp");
}
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Post</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 20px;
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        form {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 60%;
            margin: 0 auto;
        }
        label {
            font-weight: bold;
        }
        input[type="text"], textarea, input[type="file"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 3px;
            font-size: 16px;
            box-sizing: border-box;
        }
        textarea {
            height: 150px;
        }
        img {
            max-width: 100%;
            height: auto;
            margin-top: 10px;
            border-radius: 5px;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
        }
        input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 3px;
            cursor: pointer;
            font-size: 16px;
            margin-top: 10px;
        }
        input[type="submit"]:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <h2>Update Post</h2>
    <form action="updatePost" method="post" enctype="multipart/form-data">
        <input type="hidden" name="id" value="<%= post.getId() %>">
        <label for="title">Title:</label><br>
        <input type="text" id="title" name="title" value="<%= post.getTitle() %>"><br><br>
        <label for="content">Content:</label><br>
        <textarea id="content" name="content" rows="10" cols="30"><%= post.getContent() %></textarea><br><br>
        <label for="image">Image:</label><br>
        <input type="file" id="image" name="image"><br>
        <% if (post.getImageUrl() != null && !post.getImageUrl().isEmpty()) { %>
            <img src="<%= request.getContextPath() + "/" + post.getImageUrl() %>" alt="Current Image"><br>
        <% } %>
        <input type="submit" value="Update Post">
    </form>
</body>
</html>
