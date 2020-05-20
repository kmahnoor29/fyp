
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>

<html>
<head>
  <title>Tailor Profile Update</title>


  <style>
    body{
      background-color: lightseagreen;
      color: white;
    }



  </style>
<body>
<%

  String id = request.getParameter("id");
  String email = request.getParameter("email");
  String driver = "com.mysql.jdbc.Driver";
  String connectionUrl = "jdbc:mysql://localhost:3306/";
  String database = "login";
  String userid = "root";
  String password = "";
  try {
    Class.forName(driver);
  } catch (ClassNotFoundException e) {
    e.printStackTrace();
  }
  Connection connection = null;
  Statement statement = null;
  ResultSet resultSet = null;
%>
<%
  try{
    connection = DriverManager.getConnection(connectionUrl+database, userid, password);
    statement=connection.createStatement();
    String sql ="select * from producer where id="+id;
    resultSet = statement.executeQuery(sql);
    while(resultSet.next()){
%>

<h1>Update Profile Data</h1>
<form method="post" action="Producer-update.jsp">
  <input type="hidden" name="id" value="<%=resultSet.getString("id") %>">
  <br>
  Experiences<br>
  <input style=" width:30%; height:20%; " type="text" name="firstname" value="<%=resultSet.getString("firstname") %>">
  <br>
  Skills <br>
  <input style=" width:30%; height:20%; " type="text" name="lastname" value="<%=resultSet.getString("lastname") %>">
  <br>
  Phone #<br>
  <input type="text" name="phone" value="<%=resultSet.getString("phone") %>">
  <br>
  Cnic<br>
  <input type="text" name="cnic" value="<%=resultSet.getString("cnic") %>">
  <br>
  Address<br>
  <input type="text" name="address" value="<%=resultSet.getString("address") %>">
  <br>
  <br>
  <input style="  background-color: white;
  color: lightseagreen;
  border: 2px solid #555555;  "
          type="submit" value="submit">
</form>
<%
    }
    connection.close();
  } catch (Exception e) {
    e.printStackTrace();
  }
%>
</body>
</html>