<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Booking Details</title>
    <link rel="stylesheet" href="engbooking.css">
</head>
<body>
    <h1>Booking Details</h1>
    <% 
        String engineerUsername = request.getParameter("engineerusername");
        
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            // Establish a database connection
            Class.forName("oracle.jdbc.OracleDriver");
            String jdbcURL = "jdbc:oracle:thin:@localhost:1521:xe";
            String username = "system";
            String password = "jp893";
            connection = DriverManager.getConnection(jdbcURL, username, password);

            // Create a SQL statement
            String sql = "SELECT * FROM booking_table WHERE engineer_username = ?";
            statement = connection.prepareStatement(sql);
            statement.setString(1, engineerUsername);

            // Execute the SQL query
            resultSet = statement.executeQuery();

            // Check if bookings are found for the engineer
            if (resultSet.next()) {
    %>
    <table>
        <thead>
            <tr>
                <th>Engineer</th>
                <th>Client</th>
                <th>Project Type</th>
                <th>Project Name</th>
            </tr>
        </thead>
        <tbody>
    <% 
                // Iterate through the result set and display booking data
                do {
                    String engineer = resultSet.getString("engineer_username");
                    String client = resultSet.getString("client_username");
                    String projectType = resultSet.getString("project_type");
                    String projectName = resultSet.getString("project_name");
    %>
            <tr>
                <td><%= engineer %></td>
                <td><%= client %></td>
                <td><%= projectType %></td>
                <td><%= projectName %></td>
            </tr>
    <% 
                } while (resultSet.next());
    %>
        </tbody>
    </table>
    <% 
            } else {
    %>
    <p>No bookings found for engineer <%= engineerUsername %>.</p>
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
</body>
</html>
