<%-- 
    Document   : student
    Created on : 9 Aug, 2024, 11:20:56 PM
    Author     : aswin
--%>

<%@page contentType="text/html" language="java" import="java.sql.*"%> 
<html> 
<head> 
<title>Student Mark Display</title> 
<style type="text/css"> 
    body {
        background-color: white; 
        font-family: courier; 
        color: black;
    } 
</style>  
</head> 
<body> 
    <h2 style="text-align:center">Student Mark</h2> 
    <p> 
        <a href="index.html">Back To Main Page</a> 
    </p> 
    <hr/> 
    <%
    String dbDriver = "com.mysql.cj.jdbc.Driver";  // Updated for MySQL 8.0+
    String url = "jdbc:mysql://localhost:3306/student";  // Replace with your actual database URL
    String username = "root"; 
    String password = "root"; 

    Connection con = null;
    PreparedStatement insertSt = null;
    PreparedStatement selectSt = null;
    ResultSet rs = null;

    try {
        Class.forName(dbDriver);
        con = DriverManager.getConnection(url, username, password);
        
        // Insert operation
        String studentIdStr = request.getParameter("studentid");
        String studentName = request.getParameter("studentname");
        String markStr = request.getParameter("mark");
        
        if (studentIdStr == null || studentName == null || markStr == null ||
            studentIdStr.isEmpty() || studentName.isEmpty() || markStr.isEmpty()) {
            throw new IllegalArgumentException("All fields are required.");
        }
        
        int studentId = Integer.parseInt(studentIdStr);
        int mark = Integer.parseInt(markStr);
        
        insertSt = con.prepareStatement("INSERT INTO student VALUES (?, ?, ?)");
        insertSt.setInt(1, studentId);
        insertSt.setString(2, studentName);
        insertSt.setInt(3, mark);
        insertSt.executeUpdate();
        
        out.println("<html><body><b>Successfully Inserted</b></body></html>");
        
        // Select operation
        selectSt = con.prepareStatement("SELECT * FROM student");
        rs = selectSt.executeQuery();
        
        out.print("<table border=1><tr><td>Student ID</td><td>Name</td><td>Mark</td></tr>");
        while (rs.next()) {
            int id = rs.getInt("studentid");
            String name = rs.getString("studentname");
            int studentMark = rs.getInt("mark");
            out.print("<tr><td>" + id + "</td><td>" + name + "</td><td>" + studentMark + "</td></tr>");
        }
        out.print("</table>");
        
    } catch (Exception e) {
        out.println("<html><body><b>Error: " + e.getMessage() + "</b></body></html>");
    } finally {
        try {
            if (rs != null) rs.close();
            if (insertSt != null) insertSt.close();
            if (selectSt != null) selectSt.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    %> 
</body> 
</html>





