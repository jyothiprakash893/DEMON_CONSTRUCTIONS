<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*" %>
<!DOCTYPE html>

    <%
        String modelNumber = request.getParameter("modelNumber");
        int price = Integer.parseInt(request.getParameter("price"));
        String buildingNumber = request.getParameter("buildingNumber");
        String type = request.getParameter("type");
        int floors = (request.getParameter("floors") != null && !request.getParameter("floors").isEmpty()) ? Integer.parseInt(request.getParameter("floors")) : 0;

        // Database connection details
        String jdbcURL =  "jdbc:oracle:thin:@localhost:1521:xe";
        String dbUser = "system";
        String dbPassword = "jp893";

        Connection connection = null;
        PreparedStatement statement = null;

        try {
            // Create a database connection
            Class.forName("oracle.jdbc.OracleDriver");
            connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

            // Prepare the SQL statement
            String sql = "UPDATE buildings SET price=? WHERE model_Number=?";
            statement = connection.prepareStatement(sql);
            statement.setInt(1, price);
          
            statement.setString(2, modelNumber);

            // Execute the SQL statement
            int rowsUpdated = statement.executeUpdate();

            // Check the number of rows updated
            if (rowsUpdated > 0) {
                out.println("building updated successfully!");
            } else {
                out.println("Failed to update building.");
            }
        } catch (Exception e) {
            out.println("An error occurred while updating the customise house: " + e.getMessage());
        } finally {
            // Close the resources
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

