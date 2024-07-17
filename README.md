
# Blog Application with User Roles and Authentication

This project is a Java-based web application designed to manage blog posts with user authentication and roles. It includes functionalities for user registration, login, admin dashboard for post management, and a viewer interface for browsing and searching blog posts.





## Project structure
```bash
BlogApplicationSystem/
├── src/
│   ├── com/
│   │   ├── BlogApplicationApp/
│   │   │   ├── WebServlet/
│   │   │   │   ├── AdminServlet.java
│   │   │   │   ├── CreatePostServlet.java
│   │   │   │   ├── DeletePostServlet.java
│   │   │   │   ├── EditPostServlet.java
│   │   │   │   ├── LoginServlet.java
│   │   │   │   ├── LogoutServlet.java
│   │   │   │   ├── RegisterServlet.java
│   │   │   │   ├── SearchPostsServlet.java
│   │   │   ├── models/
│   │   │   │   ├── Post.java
│   │   │   │   ├── User.java
│   │   │   ├── utils/
│   │   │   │   ├── DatabaseUtil.java
│   │   │   │   ├── PasswordUtil.java
├── WebContent/
│   ├── WEB-INF/
│   │   ├── web.xml
│   ├── adminDashboard.jsp
│   ├── updatePost.jsp
│   ├── createPost.jsp
│   ├── searchPosts.jsp
│   ├── error.jsp
│   ├── index.jsp
│   ├── login.jsp
│   ├── register.jsp
│   ├── adminDashboard.jsp
├── lib/
│   ├── jakarta.servlet-api-5.0.0-javadoc.jar
│   ├── javax.servlet-api-3.1.0-javadoc.jar
│   ├── mysql-connector-java-8.0.33.jar
│   ├── jbcrypt-0.4.jar
├── README.md

```


## Technologies Used


- Java Development Kit (JDK) 8 or higher
- Backend: Java Servlets
- Frontend: JSP (JavaServer Pages)
- Database: MySQL
- Security: Password hashing (BCrypt), input validation (prepared statements

#  Projectphases

## Phase 1: User Registration and Login
- User Registration:

    - Capture user details (name, email, password, role) in a registration form.
    - Servlet validates user data, securely stores in MySQL database with hashed passwords.
- User Login:

    - Login page with username/email and password fields.
    - Servlet authenticates users against the database, establishes sessions based on role (Admin/Viewer).
## Phase 2: Admin Dashboard
- Admin Dashboard:

    - Accessible after successful login with Admin role.
- Functionalities:
    - Create new blog posts with title, content, and optional image/video upload.
    - Update existing blog posts (title, content, image/video).
    - Delete blog posts.
- Backend Implementation:

    - Servlets handle CRUD operations securely.
    - Image/video uploads stored securely in the database (consider using separate table/blob storage).
## Phase 3: Viewer Interface
- Viewer Interface:
    - User-friendly interface for viewers to browse blog posts.
    - Functionalities include searching posts by title or date, pagination, and sorting of search results.
## Phase 4: Security Enhancements
- Security Measures:
    - Passwords hashed securely using BCrypt.
    - Input validation and sanitization to prevent SQL injection attacks (prepared statements).
##  Setup Instructions

## Database Setup


- Install MySQL server and create a database (BlogApp).
- Execute SQL scripts to create tables and insert sample data.

Sql
```sql
  CREATE DATABASE BlogApp;
USE BlogApp;

CREATE TABLE Users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(50) UNIQUE,
    password VARCHAR(255),
    role ENUM('Admin', 'Viewer')
);

CREATE TABLE Posts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255),
    content TEXT,
    image_url VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

```

Update the database connection details in DatabaseUtil.java:

java
```java
private static final String URL = "jdbc:mysql://localhost:3306/BlogApp";
private static final String USER = "your_username";
private static final String PASSWORD = "your_password";

```
## Project Setup

1. Clone the repository:

```bash
  git clone https://github.com/yourusername/BlogApplicationSystem.git

```
2. Open the project in your IDE (Eclipse or IntelliJ IDEA).

3. Add the necessary JAR files for JDBC and Servlets to the project's build path.

4. Configure Tomcat in your IDE and deploy the project.


5. Access the application at http://localhost:8080/BlogApplicationSystem.
    
##  Deployment

- Ensure MySQL is running and the BlogApp database is created.
- Deploy the application on Tomcat.
- Navigate to http://localhost:8080/BlogApplicationSystem to access the application.
## TroubleShooting
- Ensure the database connection details are correct in DatabaseUtil.java.
- Verify Tomcat is running on the specified port (default is 8080).
- Check the Tomcat logs for any errors during deployment.


Feel free to adjust any part of the description to better fit your project specifics or personal preferences.
