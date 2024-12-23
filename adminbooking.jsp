<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Booking Details</title>
    <link rel="stylesheet" href="adminbooking.css">
</head>
<body>
    <h1>Booking Details</h1>
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
                    String sql = "SELECT * FROM booking_table";
                    statement = connection.createStatement();

                    // Execute the SQL query
                    resultSet = statement.executeQuery(sql);

                    // Iterate through the result set and display booking data
                    while (resultSet.next()) {
                        
                        String engineer = resultSet.getString("engineer_username");
                        String client = resultSet.getString("client_name");
                        String projectType = resultSet.getString("project_type");
                        String projectName = resultSet.getString("project_name");

                        // Display booking data
                        %>
                        <tr>
                            
                            <td><%= engineer %></td>
                            <td><%= client %></td>
                            <td><%= projectType %></td>
                            <td><%= projectName %></td>
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
