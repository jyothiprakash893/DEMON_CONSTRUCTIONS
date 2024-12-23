<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Contact Us</title>
    <link rel="stylesheet" type="text/css" href="displaycontact.css">
</head>
<body>
    
    <section id="contact">
        <div class="container">
            <h1>Contact Us</h1>
            <table>
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>                        </th>
                        <th>                        </th>
                        <th>Email</th>
                        <th>                        </th>
                        <th>                        </th>
                        <th>Message</th>
                        <th>                        </th>
                        <th>                        </th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        Connection connection = null;
                        Statement statement = null;
                        ResultSet resultSet = null;

                        try {
                            // Establish a database connection
                            Class.forName("oracle.jdbc.OracleDriver");
                            String jdbcURL = "jdbc:oracle:thin:@localhost:1521:xe";
                            String username = "system";
                            String password = "jp893";
                            connection = DriverManager.getConnection(jdbcURL, username, password);

                            // Create a SQL statement
                            String sql = "SELECT * FROM contact_us";
                            statement = connection.createStatement();

                            // Execute the SQL query
                            resultSet = statement.executeQuery(sql);

                            // Iterate through the result set and display contact data
                            while (resultSet.next()) {
                                String name = resultSet.getString("name");
                                String email = resultSet.getString("email");
                                String message = resultSet.getString("message");

                                // Display contact data row-wise
                                %>
                                <tr>
                                    
                                    <td><%= name %></td>
                                    <th>            </th>
                                    <th>            </th>
                                    <td><%= email %></td>
                                    <th>            </th>
                                    <th>            </th>
                                    <td><%= message %></td>
                                    <th>            </th>
                                    <th>            </th>
                                </tr>
                                <%
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
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
                                e.printStackTrace();
                            }
                        }
                    %>
                </tbody>
            </table>
        </div>
    </section>
   
</body>
</html>
