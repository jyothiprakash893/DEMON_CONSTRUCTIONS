<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Customized Houses</title>
    <link rel="stylesheet" href="displayadmincommercail.css">
</head>
<body>
    <h1>Customized Houses</h1>
    <table>
        <thead>
            <tr>
                <th>Photo</th>
                <th>building Number</th>
                <th>Model Number</th>
                <th>Building Type</th>
                <th>Floors</th>
                <th>Price</th>
            </tr>
        </thead>
        <tbody>
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
                    String sql = "SELECT * FROM buildings";
                    statement = connection.createStatement();

                    // Execute the SQL query
                    resultSet = statement.executeQuery(sql);

                    // Iterate through the result set and display house data
                    while (resultSet.next()) {
                        String buildingNumber = resultSet.getString("building_NUMBER");
                        String modelNumber = resultSet.getString("MODEL_NUMBER");
                        String buildingType = resultSet.getString("building_TYPE");
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
                        <tr>
                            <td><img src="<%= photoSrc %>" alt="House Photo"></td>
                            <td><%= buildingNumber %></td>
                            <td><%= modelNumber %></td>
                            <td><%= buildingType %></td>
                            <td><%= floors %></td>
                            <td><%= price %></td>
                        </tr>
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
        </tbody>
    </table>
</body>
</html>
