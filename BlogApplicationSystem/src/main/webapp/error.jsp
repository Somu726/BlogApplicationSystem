<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Error</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            color: #333;
            text-align: center;
            margin-top: 50px;
        }
        .error-container {
            display: inline-block;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #fff;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .error-message {
            font-size: 18px;
            color: #e74c3c;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <h1>Something went wrong</h1>
        <p class="error-message">An unexpected error occurred. Please try again later.</p>
        <p>If the problem persists, contact the site administrator.</p>
    </div>
</body>
</html>


<error-page>
    <error-code>500</error-code>
    <location>/error.jsp</location>
</error-page>
<error-page>
    <exception-type>java.lang.Throwable</exception-type>
    <location>/error.jsp</location>
</error-page>