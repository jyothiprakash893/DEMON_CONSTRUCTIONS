<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Delete Interior</title>
</head>
<body>
    <%
        String modelNumber = request.getParameter("modelNumber");

        Connection connection = null;
        PreparedStatement statement = null;

        try {
            // Create a database connection
            Class.forName("oracle.jdbc.OracleDriver");
            String jdbcURL = "jdbc:oracle:thin:@localhost:1521:xe";
            String username = "system";
            String password = "jp893";
            connection = DriverManager.getConnection(jdbcURL, username, password);

            // Prepare the SQL statement
            String sql = "DELETE FROM interior WHERE model_number = ?";
            statement = connection.prepareStatement(sql);
            statement.setString(1, modelNumber);

            // Execute the SQL statement
            int rowsAffected = statement.executeUpdate();

            if (rowsAffected > 0) {
                out.println("interior deleted successfully!");
            } else {
                out.println("House with model number " + modelNumber + " not found.");
            }
        } catch (Exception e) {
            out.println("An error occurred while deleting the house: " + e.getMessage());
        } finally {
            // Close the database resources
            try {
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                out.println("An error occurred while closing the connection: " + e.getMessage());
            }
        }
    %>
</body>
</html>
