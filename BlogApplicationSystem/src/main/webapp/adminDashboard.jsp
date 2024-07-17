<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.BlogApplicationApp.models.Post" %>
<%@ page import="com.BlogApplicationApp.utils.DatabaseUtil" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ page import="javax.servlet.http.HttpServletResponse" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>

<%
HttpSession sessions = request.getSession(false);
if (sessions == null || !"Admin".equals(session.getAttribute("userRole"))) {
    response.sendRedirect("login.jsp");
    return;
}

List<Post> posts = (List<Post>) request.getAttribute("posts");
if (posts == null) {
    posts = new ArrayList<>(); // Initialize to avoid null pointer exception
}
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 80%;
            margin: 20px auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h2, h3 {
            text-align: center;
            color: #333;
        }
        .button {
            display: inline-block;
            padding: 10px 15px;
            margin: 10px 0;
            font-size: 14px;
            cursor: pointer;
            text-align: center;
            text-decoration: none;
            outline: none;
            color: #fff;
            background-color: #4CAF50;
            border: none;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }
        .button:hover {
            background-color: #45a049;
        }
        a {
            text-decoration: none;
            color: #0066cc;
            transition: color 0.3s ease;
        }
        a:hover {
            text-decoration: underline;
            color: #004080;
        }
        .post {
            border: 1px solid #ccc;
            border-radius: 5px;
            padding: 10px;
            margin-bottom: 10px;
            background-color: #f9f9f9;
        }
        .post h2 {
            margin-top: 0;
            color: #333;
        }
        .post p {
            color: #666;
        }
        .post img {
            max-width: 100%;
            height: auto;
            border-radius: 5px;
            margin-top: 10px;
        }
        .post .actions {
            margin-top: 10px;
        }
        .post .actions a {
            margin-right: 10px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Admin Dashboard</h2>
        <a href="createPost.jsp" class="button">Create New Post</a><br><br>
        <a href="logout">Logout</a>
        <h3>Blog Posts</h3>
        <%
        // Fetch and display posts
        Connection conn = DatabaseUtil.getConnection();
        String sql = "SELECT * FROM Posts";
        PreparedStatement stmt = conn.prepareStatement(sql);
        ResultSet rs = stmt.executeQuery();
        while (rs.next()) {
        %>
            <div class="post">
                <h2><%= rs.getString("title") %></h2>
                <p><%= rs.getString("content") %></p>
                <% if (rs.getString("image_url") != null) { %>
                    <img src="<%= rs.getString("image_url") %>" width="100" height="100">
                <% } %>
                <div class="actions">
                    <a href='updatePost.jsp?id=<%= rs.getInt("id") %>'>Update</a>
                    <a href='deletePost?id=<%= rs.getInt("id") %>'>Delete</a>
                </div>
            </div>
        <%
        }
        %>
    </div>
</body>
</html>
