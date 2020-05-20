
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>

<html>
<head>
  <title>Payment Method Update</title>


<style>
  body{
    background-color: lightseagreen;
    color: white;
  }



</style>


</head>


<body>
<%

  String id = request.getParameter("id");

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
    String sql ="select * from paymentmethod where id="+id;
    resultSet = statement.executeQuery(sql);
    while(resultSet.next()){
%>

<h1>Update Payment Method</h1>
<form method="post" action="Payment-update.jsp">

  <H1>CD Service</H1>
<br>
  <br>
  <br>

  <input type="hidden" name="id" value="<%=resultSet.getString("id") %>">
  <br>

   Email<br>
  <input type="text" name="email" value="<%=resultSet.getString("email") %>">
  <br>
  Cash On Delivery<br>
  <input type="radio" name="cash" value="<%=resultSet.getString("cash") %>">
  <br>
  <h3>OR</h3>
  <br>
  Credit Card<br>
  <input type="radio" name="credit">
  <br>
  Account No.<br>
  <input type="text" name="accountno" value="<%=resultSet.getString("accountno") %>">
  <br>
  Expire Date<br>
  <input type="text" name="expirydate" value="<%=resultSet.getString("expirydate") %>">
  <br>
  CVV<br>
  <input type="text" name="cvv" value="<%=resultSet.getString("cvv") %>">
  <br>

  <br>
  <input style="  background-color: white;
  color: lightseagreen;
  border: 2px solid #555555;  "  type="submit" value="submit">
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