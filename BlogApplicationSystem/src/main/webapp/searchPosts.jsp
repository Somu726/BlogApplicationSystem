<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Search Results</title>
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
        form {
            margin-bottom: 20px;
        }
        input[type="text"] {
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 3px;
        }
        button[type="submit"] {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 3px;
            cursor: pointer;
            font-size: 16px;
        }
        button[type="submit"]:hover {
            background-color: #45a049;
        }
        .search-results {
            background-color: #ffffff;
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .search-results div {
            margin-bottom: 15px;
            border-bottom: 1px solid #ccc;
            padding-bottom: 15px;
        }
        .search-results h2 {
            margin-top: 0;
        }
        .search-results p {
            margin-top: 5px;
        }
        .search-results img {
            margin-top: 10px;
            display: block;
            border-radius: 3px;
        }
    </style>
</head>
<body>
    <h1>Search Results</h1>

    <a href="logout">Logout</a>
    
    <form action="searchPosts" method="get">
        <input type="text" name="query" placeholder="Search by title or date">
        <button type="submit">Search</button>
    </form>

     <!-- Display search results -->
    <%
        ResultSet searchResults = (ResultSet) request.getAttribute("searchResults");
   

    if (searchResults != null) {
            while (searchResults.next()) {
                out.println("<div>");
                out.println("<h2>" + searchResults.getString("title") + "</h2>");
                out.println("<p>" + searchResults.getString("content") + "</p>");
                if (searchResults.getString("image_url") != null) {
                    out.println("<img src='" + searchResults.getString("image_url") + "' width='100' height='100'><br>");
                }
                out.println("<p>" + searchResults.getTimestamp("created_at") + "</p>");
                out.println("</div>");
            }
        } else {
        	
            out.println("<h3>No results found.</h3>");
            
        }
    %>
</body>
</html>
