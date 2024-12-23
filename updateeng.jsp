<%@ page import="java.io.*, java.sql.*" %>
<%@ page import="oracle.jdbc.OracleDriver" %>

<%
    String email = request.getParameter("email");
    String name = request.getParameter("name");
    String specialization = request.getParameter("specialization");
    String experience = request.getParameter("experience");

    String jdbcURL = "jdbc:oracle:thin:@localhost:1521:xe";
    String dbUser = "system";
    String dbPassword = "jp893";

    Connection connection = null;
    PreparedStatement statement = null;

    try {
        DriverManager.registerDriver(new OracleDriver());
        connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
        String sql = "UPDATE engineers SET name=?, specialization=?, experience=? WHERE email=?";
        statement = connection.prepareStatement(sql);
        statement.setString(1, name);
        statement.setString(2, specialization);
        statement.setString(3, experience);
        statement.setString(4, email);
        int rowsUpdated = statement.executeUpdate();

        if (rowsUpdated > 0) {
            
            out.println("Engineer updated successfully!");
        } else {
            
            out.println("Engineer is not there");
        }
    } catch (SQLException e) {
        out.println("An error occurred while updating the engineer: " + e.getMessage());
    } finally {
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
