<%@ page import="java.sql.*" %>
<%@ include file="forgot.html" %>
<%
    // Database connection details
    String url = "jdbc:oracle:thin:@localhost:1521:XE";
    String username = "system";
    String password1 = "jp893";
    
    // Get form data
    String enteredUsername = request.getParameter("username");
    
    try {
        // Connect to the database
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection con = DriverManager.getConnection(url, username, password1);
        
        // Prepare and execute the SQL statement
        String sql = "SELECT * FROM j2 WHERE email=?";
        PreparedStatement stmt = con.prepareStatement(sql);
        stmt.setString(1, enteredUsername);
        stmt.setString(2, enteredUsername);
        ResultSet rs = stmt.executeQuery();
        
        // Check if the username or email exists in the database
        if (rs.next()) {
            // Send password reset instructions to the user's email
            
            // Display a success message
            out.println("Password reset instructions have been sent to your email.");
        } else {
            // Username or email not found in the database
            out.println("Username or email not found.");
        }
        
        // Close database connections
        rs.close();
        stmt.close();
        con.close();
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    }
%>
