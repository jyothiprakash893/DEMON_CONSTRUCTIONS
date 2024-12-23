<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Engineer List</title>
    <link rel="stylesheet" href="displayeng.css">
</head>
<body>
    <h1>Engineer List</h1>
    <table>
        <thead>
            <tr>
                <th>Name</th>
                <th>Email</th>
                <th>Specialization</th>
                <th>Experience</th>
                <th>Photo</th>
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
                    String sql = "SELECT * FROM engineers";
                    statement = connection.createStatement();

                    // Execute the SQL query
                    resultSet = statement.executeQuery(sql);

                    // Iterate through the result set and display engineer data
                    while (resultSet.next()) {
                        String name = resultSet.getString("name");
                        String email = resultSet.getString("email");
                        String specialization = resultSet.getString("specialization");
                        String experience = resultSet.getString("experience");
                        Blob photoBlob = resultSet.getBlob("photo");

                        // Convert the BLOB photo to Base64 encoded string
                        String photoSrc = "";
                        if (photoBlob != null) {
                            byte[] photoData = photoBlob.getBytes(1, (int) photoBlob.length());
                            String base64Photo = Base64.getEncoder().encodeToString(photoData);
                            photoSrc = "data:image/jpeg;base64," + base64Photo;
                        }

                        // Display engineer data
                        %>
                        <tr>
                            <td><%= name %></td>
                            <td><%= email %></td>
                            <td><%= specialization %></td>
                            <td><%= experience %></td>
                            <td><img src="<%= photoSrc %>" alt="Engineer Photo"></td>
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
