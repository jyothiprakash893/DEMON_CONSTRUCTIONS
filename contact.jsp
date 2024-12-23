<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*" %>

<%
    // Database connection details
    String url = "jdbc:oracle:thin:@localhost:1521:xe";
    String username = "system";
    String password = "jp893";

    // Get form data
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String message = request.getParameter("message");

    // Insert the data into the database
    Connection connection = null;
    PreparedStatement statement = null;

    try {
        // Establish database connection
        Class.forName("oracle.jdbc.driver.OracleDriver");
        connection = DriverManager.getConnection(url, username, password);

        // Prepare SQL statement
        String sql = "INSERT INTO contact_us (name, email, message) VALUES (?, ?, ?)";
        statement = connection.prepareStatement(sql);

        // Set parameter values
        statement.setString(1, name);
        statement.setString(2, email);
        statement.setString(3, message);

        // Execute the statement
        statement.executeUpdate();

        // Redirect to a success page
        out.println("msg successfully inserted!");
    } catch (Exception e) {
        e.printStackTrace();
        // Handle the error or redirect to an error page
        out.println("msg not inserted");
    } finally {
        // Close the database resources
        if (statement != null) {
            statement.close();
        }
        if (connection != null) {
            connection.close();
        }
    }
%>
