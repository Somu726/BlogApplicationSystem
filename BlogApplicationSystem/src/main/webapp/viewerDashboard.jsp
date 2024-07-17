<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.BlogApplicationApp.utils.DatabaseUtil" %>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Viewer Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 20px;
        }
        h1 {
            text-align: center;
            margin-bottom: 20px;
        }
        a {
            display: block;
            margin-bottom: 20px;
            text-align: right;
            text-decoration: none;
            color: #333;
        }
        form {
            margin-bottom: 20px;
        }
        input[type="text"] {
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 3px;
            width: 300px;
            box-sizing: border-box;
        }
        button[type="submit"] {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 3px;
            cursor: pointer;
            font-size: 16px;
        }
        button[type="submit"]:hover {
            background-color: #45a049;
        }
        .post-container {
            background-color: #ffffff;
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .post-container h2 {
            margin-top: 0;
        }
        .post-container p {
            margin-top: 5px;
        }
        .post-container img {
            margin-top: 10px;
            display: block;
            border-radius: 3px;
            max-width: 100%;
            height: auto;
        }
        .post-container p.timestamp {
            font-style: italic;
            color: #888;
            margin-top: 5px;
        }
    </style>
</head>
<body>
    <h1>Viewer Dashboard</h1>
    <a href="logout">Logout</a>

    <form action="searchPosts" method="get">
        <input type="text" name="query" placeholder="Search by title or date">
        <button type="submit">Search</button>
    </form>

    <!-- Display posts -->
    <%
        Connection conn = DatabaseUtil.getConnection();
        String sql = "SELECT * FROM Posts";
        PreparedStatement stmt = conn.prepareStatement(sql);
        ResultSet rs = stmt.executeQuery();
        while (rs.next()) {
    %>
            <div class="post-container">
                <h2><%= rs.getString("title") %></h2>
                <p><%= rs.getString("content") %></p>
                <% if (rs.getString("image_url") != null) { %>
                    <img src="<%= rs.getString("image_url") %>" width="100" height="100">
                <% } %>
                <p class="timestamp"><%= rs.getTimestamp("created_at") %></p>
            </div>
    <%
        }
    %>

</body>
</html>
