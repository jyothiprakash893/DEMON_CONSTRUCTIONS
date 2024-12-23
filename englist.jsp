<%@ page import="java.sql.*" %>
<%@ page import="oracle.jdbc.OracleDriver" %>

<%
    // Database connection details
    String jdbcURL = "jdbc:oracle:thin:@localhost:1521:xe";
    String dbUser = "system";
    String dbPassword = "jp893";

    Connection connection = null;
    Statement statement = null;
    ResultSet resultSet = null;

    try {
        DriverManager.registerDriver(new OracleDriver());
        connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

        // SQL query to fetch data from the Engineers table
        String sql = "SELECT * FROM engineers";
        statement = connection.createStatement();
        resultSet = statement.executeQuery(sql);

        // Create a list to hold the Engineer objects
        List<Engineer> engineers = new ArrayList<>();

        // Iterate through the result set and create Engineer objects
        while (resultSet.next()) {
            String name = resultSet.getString("name");
            String email = resultSet.getString("email");
            String specialization = resultSet.getString("specialization");
            String experience = resultSet.getString("experience");
            String photo = resultSet.getString("photo");

            // Create a new Engineer object and add it to the list
            Engineer engineer = new Engineer(name, email, specialization, experience, photo);
            engineers.add(engineer);
        }

        // Set the engineers list as an attribute to be accessed by the frontend
        request.setAttribute("engineers", engineers);

        // Forward the request to the frontend (HTML) for display
        request.getRequestDispatcher("englist.html").forward(request, response);

    } catch (SQLException e) {
        out.println("An error occurred while fetching data from the database: " + e.getMessage());
    } finally {
        // Close the database resources
        try {
            if (resultSet != null) {
                resultSet.close();
            }
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
