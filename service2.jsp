<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Interior</title>
    <link rel="stylesheet" href="service2.css">
</head>
<body>
    <nav class="navbar">
        <a href="#">Home</a>
        <a href="#">Services</a>
        <a href="#">About Us</a>
        <a href="#">Contact</a>
    </nav>

    <div class="container">
        <h1>Demon construction Interior</h1>
        <div class="interior-grid">
            <% 
                Connection connection = null;
                Statement statement = null;
                ResultSet resultSet = null;

                try {
                    // Establish a database connection
                    Class.forName("oracle.jdbc.OracleDriver");
                    String jdbcURL = "jdbc:oracle:thin:@localhost:1521:xe";
                    String username = "system";
                    String password = "jp893";
                    connection = DriverManager.getConnection(jdbcURL, username, password);

                    // Create a SQL statement
                    String sql = "SELECT * FROM interior";
                    statement = connection.createStatement();

                    // Execute the SQL query
                    resultSet = statement.executeQuery(sql);

                    // Iterate through the result set and display interior data
                    while (resultSet.next()) {
                        String interiorNumber = resultSet.getString("INTERIOR_NUMBER");
                        String modelNumber = resultSet.getString("MODEL_NUMBER");
                       
                        int sqfeet = resultSet.getInt("SQFEET");
                        int price = resultSet.getInt("PRICE");
                        Blob photoBlob = resultSet.getBlob("PHOTO");

                        // Convert the BLOB photo to Base64 encoded string
                        String photoSrc = "";
                        if (photoBlob != null) {
                            byte[] photoData = photoBlob.getBytes(1, (int) photoBlob.length());
                            String base64Photo = Base64.getEncoder().encodeToString(photoData);
                            photoSrc = "data:image/jpeg;base64," + base64Photo;
                        }

                        // Display interior data
                        %>
                        <div class="interior-item">
                            <img src="<%= photoSrc %>" alt="Interior Photo">
                            <p>Interior Number: <%= interiorNumber %></p>
                            <p>Model Number: <%= modelNumber %></p>
                           
                            <p>Sqfeet: <%= sqfeet %></p>
                            <p>Price: <%= price %></p>
                            <a class="button" href="clienteng.jsp">Book</a>
                        </div>
                        <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    // Close the database resources
                    try {
                        if (resultSet != null) {
                            resultSet.close();
                        }
                        if (statement != null) {
                            statement.close();
                        }
                        if (connection != null) {
                            connection.close();
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            %>
        </div>
    </div>
</body>
</html>
