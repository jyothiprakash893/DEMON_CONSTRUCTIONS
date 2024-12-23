<%@ page import="java.io.*, java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload" %>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory" %>
<%@ page import="org.apache.commons.fileupload.FileItem" %>
<%@ page import="java.util.List" %>

<%@ page import="oracle.jdbc.OracleDriver" %>

<%
    // Initialize form field variables
    String houseNumber = "";
    String modelNumber = "";
    String houseType = "";
    int floors = 0;
    int price = 0;
    byte[] photoData = null;

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

                    if (fieldName.equals("houseNumber")) {
                        houseNumber = fieldValue;
                    } else if (fieldName.equals("modelNumber")) {
                        modelNumber = fieldValue;
                    } else if (fieldName.equals("houseType")) {
                        houseType = fieldValue;
                    } else if (fieldName.equals("floors")) {
                        floors = Integer.parseInt(fieldValue);
                    } else if (fieldName.equals("price")) {
                        price = Integer.parseInt(fieldValue);
                    }
                } else {
                    // Process file field (photo)
                    String fileName = item.getName();
                    if (fileName != null && !fileName.isEmpty()) {
                        InputStream inputStream = item.getInputStream();
                        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();

                        // Read photo data into byte array
                        byte[] buffer = new byte[1024];
                        int length;
                        while ((length = inputStream.read(buffer)) != -1) {
                            outputStream.write(buffer, 0, length);
                        }

                        photoData = outputStream.toByteArray();
                        outputStream.close();
                        inputStream.close();
                    }
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
            String sql = "INSERT INTO houses (house_number, model_number, house_type, floors, price, photo) VALUES (?, ?, ?, ?, ?, ?)";
            statement = connection.prepareStatement(sql);
            statement.setString(1, houseNumber);
            statement.setString(2, modelNumber);
            statement.setString(3, houseType);
            statement.setInt(4, floors);
            statement.setInt(5, price);
            statement.setBytes(6, photoData);

            // Execute the SQL statement
            statement.executeUpdate();

            out.println("House added successfully!");
        } catch (SQLException e) {
            out.println("An error occurred while adding the house: " + e.getMessage());
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
