<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Customized Houses</title>
    <link rel="stylesheet" href="service1.css">
</head>
<body>
    <div class="navbar">
        <a href="#">Home</a>
        <a href="#">Services</a>
        <a href="#">About Us</a>
        <a href="#">Contact</a>
        
    </div>
    <h1>Demon Constructions</h1>
    <div class="house-grid">
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
                String sql = "SELECT * FROM houses";
                statement = connection.createStatement();

                // Execute the SQL query
                resultSet = statement.executeQuery(sql);

                // Iterate through the result set and display house data
                while (resultSet.next()) {
                    String houseNumber = resultSet.getString("HOUSE_NUMBER");
                    String modelNumber = resultSet.getString("MODEL_NUMBER");
                    String houseType = resultSet.getString("HOUSE_TYPE");
                    int floors = resultSet.getInt("FLOORS");
                    int price = resultSet.getInt("PRICE");
                    Blob photoBlob = resultSet.getBlob("PHOTO");

                    // Convert the BLOB photo to Base64 encoded string
                    String photoSrc = "";
                    if (photoBlob != null) {
                        byte[] photoData = photoBlob.getBytes(1, (int) photoBlob.length());
                        String base64Photo = Base64.getEncoder().encodeToString(photoData);
                        photoSrc = "data:image/jpeg;base64," + base64Photo;
                    }

                    // Display house data
                    %>
                    <div class="house-item">
                        <img src="<%= photoSrc %>" alt="House Photo">
                        <div class="house-details">
                            <p>House Number: <%= houseNumber %></p>
                            <p>Model Number: <%= modelNumber %></p>
                            <p>Type: <%= houseType %></p>
                            <p>Floors: <%= floors %></p>
                            <p>Price: <%= price %></p>
                            <a class="button" href="clienteng.jsp">Book</a>
                        </div>
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
</body>
</html>
