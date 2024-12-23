<%@ page import="java.io.*, java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<%@ page import="oracle.jdbc.OracleDriver" %>

<%
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String specialization = request.getParameter("specialization");
    String experience = request.getParameter("experience");
    
    Part photoPart = request.getPart("photo");
    String fileName = null;
    if (photoPart != null) {
        fileName = extractFileName(photoPart);
    }
    
    InputStream photoStream = null;
    if (photoPart != null) {
        photoStream = photoPart.getInputStream();
    }

    String jdbcURL = "jdbc:oracle:thin:@localhost:1521:xe";
    String dbUser = "system";
    String dbPassword = "jp893";

    Connection connection = null;
    PreparedStatement statement = null;

    try {
        DriverManager.registerDriver(new OracleDriver());
        connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
        String sql = "INSERT INTO engineers (name, email, specialization, experience, photo) VALUES (?, ?, ?, ?, ?)";
        statement = connection.prepareStatement(sql);
        statement.setString(1, name);
        statement.setString(2, email);
        statement.setString(3, specialization);
        statement.setString(4, experience);
        if (photoStream != null) {
            statement.setBinaryStream(5, photoStream, (int) photoPart.getSize());
        } else {
            statement.setNull(5, java.sql.Types.BLOB);
        }
        statement.executeUpdate();
        
        out.println("Engineer added successfully!");
    } catch (SQLException e) {
        out.println("An error occurred while adding the engineer: " + e.getMessage());
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

<%!
    private String extractFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        String[] tokens = contentDisposition.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }
%>
