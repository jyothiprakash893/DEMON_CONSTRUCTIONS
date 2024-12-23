<%@ page import="java.io.*, java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload" %>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory" %>
<%@ page import="org.apache.commons.fileupload.FileItem" %>
<%@ page import="java.util.List" %>

<%@ page import="oracle.jdbc.OracleDriver" %>

<%
    // Initialize form field variables
    String name = "";
    String email = "";
    String specialization = "";
    String experience = "";
    String fileName = "";
    InputStream photoStream = null;

    // Check if the request contains multipart form data
    if (ServletFileUpload.isMultipartContent(request)) {
        // Create a file upload handler
        DiskFileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);

        try {
            // Parse the form fields and file items
            List<FileItem> items = upload.parseRequest(request);
            for (FileItem item : items) {
                if (item.isFormField()) {
                    // Process form fields
                    String fieldName = item.getFieldName();
                    String fieldValue = item.getString();

                    if (fieldName.equals("name")) {
                        name = fieldValue;
                    } else if (fieldName.equals("email")) {
                        email = fieldValue;
                    } else if (fieldName.equals("specialization")) {
                        specialization = fieldValue;
                    } else if (fieldName.equals("experience")) {
                        experience = fieldValue;
                    }
                } else {
                    // Process file field
                    fileName = item.getName();
                    photoStream = item.getInputStream();
                }
            }
        } catch (Exception e) {
            out.println("An error occurred while processing the form data: " + e.getMessage());
            return;
        }

        // Database connection details
        String jdbcURL = "jdbc:oracle:thin:@localhost:1521:xe";
        String dbUser = "system";
        String dbPassword = "jp893";

        Connection connection = null;
        PreparedStatement statement = null;

        try {
            // Register the Oracle JDBC driver
            DriverManager.registerDriver(new OracleDriver());

            // Create a database connection
            connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

            // Prepare the SQL statement
            String sql = "INSERT INTO engineers (name, email, specialization, experience, photo) VALUES (?, ?, ?, ?, ?)";
            statement = connection.prepareStatement(sql);
            statement.setString(1, name);
            statement.setString(2, email);
            statement.setString(3, specialization);
            statement.setString(4, experience);
            statement.setBinaryStream(5, photoStream, (int) photoStream.available());

            // Execute the SQL statement
            statement.executeUpdate();

            out.println("Engineer added successfully!");
        } catch (SQLException e) {
            out.println("An error occurred while adding the engineer: " + e.getMessage());
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
    } else {
        out.println("Invalid request");
    }
%>
