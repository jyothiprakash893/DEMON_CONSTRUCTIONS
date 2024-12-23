<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*, java.sql.*" %>

<%
    String engineer = request.getParameter("engineer");
    String client = request.getParameter("client");
    String projectType = request.getParameter("project-type");
    String projectName = request.getParameter("project-name");

    Connection connection = null;
    PreparedStatement statement = null;

    try {
        // Establish a database connection
        Class.forName("oracle.jdbc.OracleDriver");
        String jdbcURL = "jdbc:oracle:thin:@localhost:1521:xe";
        String username = "system";
        String password = "jp893";
        connection = DriverManager.getConnection(jdbcURL, username, password);

        // Create a SQL statement
        String sql = "INSERT INTO booking_table (engineer_username, client_name, project_type, project_name) VALUES (?, ?, ?, ?)";
        statement = connection.prepareStatement(sql);
        statement.setString(1, engineer);
        statement.setString(2, client);
        statement.setString(3, projectType);
        statement.setString(4, projectName);

        // Execute the SQL query
        int rowsInserted = statement.executeUpdate();

        // Display booking confirmation message
        if (rowsInserted > 0) {
            %>
            <p>Your booking has been confirmed. Thank you!</p>
            <%
        } else {
            %>
            <p>Sorry, there was an error processing your booking. Please try again.</p>
            <%
        }
    } catch (Exception e) {
        e.printStackTrace();
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
            e.printStackTrace();
        }
    }
%>
