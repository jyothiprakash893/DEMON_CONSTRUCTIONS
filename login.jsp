<%@ page import="java.sql.*" %>
<%@ include file="login.html" %>

<%
    // Database connection details
    String url = "jdbc:oracle:thin:@localhost:1521:XE";
    String username = "system";
    String password1 = "jp893";
    
    // Get form data
    String enteredUsername = request.getParameter("username");
    String enteredPassword = request.getParameter("password");
    
    try {
        // Connect to the database
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection con = DriverManager.getConnection(url, username, password1);
        
        // Prepare and execute the SQL statement
        String sql = "SELECT * FROM j2 WHERE email=? AND password=?";
        PreparedStatement stmt = con.prepareStatement(sql);
        stmt.setString(1, enteredUsername);
        stmt.setString(2, enteredPassword);
        ResultSet rs = stmt.executeQuery();
        
        // Check if the login credentials are valid
        if (rs.next()) {
            String usertype = rs.getString("usertype");
            
            // Redirect to the respective pages based on the role

            if (usertype.equals("admin")) {
                response.sendRedirect("admin.html");
            } else if (usertype.equals("engineer")) {
                response.sendRedirect("engineer.html");
            } else if (usertype.equals("client")) {
                response.sendRedirect("home.html");
            }
        } else {
            // Invalid login credentials
            out.println("Invalid username or password");
        }
        
        // Close database connections
        rs.close();
        stmt.close();
        con.close();
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    }
%>
