<%@ page import="java.sql.*" %>

<%@ include file="signup.html" %>


<%
  // Database connection details
  String url = "jdbc:oracle:thin:@localhost:1521:XE";
  String username = "system";
  String password1 = "jp893";

  // Get the form data
  String name = request.getParameter("name");
  String email = request.getParameter("email");
  String password = request.getParameter("password");
  String userType = request.getParameter("userType");

  // Establish database connection
  try {
    Class.forName("oracle.jdbc.driver.OracleDriver");
    Connection conn = DriverManager.getConnection(url, username, password1);
    
    // Prepare the SQL statement
    PreparedStatement pstmt = conn.prepareStatement("INSERT INTO j2 (name, email, password, userType) VALUES (?, ?, ?, ?)");
    pstmt.setString(1, name);
    pstmt.setString(2, email);
    pstmt.setString(3, password);
    pstmt.setString(4, userType);

    // Execute the SQL statement

     int i = pstmt.executeUpdate();

        if (i > 0) {
            out.println("<script>alert('Signup successful!')</script>");
            response.sendRedirect("login.html");
        } else {
            out.println("<script>alert('Signup failed!')</script>");
            response.sendRedirect("signup.html");
        }

    // Close database connections
    pstmt.close();
    conn.close();
  } catch (Exception e) {
    out.println("Error: " + e.getMessage());
  }
%>

