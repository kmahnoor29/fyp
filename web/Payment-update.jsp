<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%! String driverName ="com.mysql.jdbc.Driver";%>
<%!String url = "jdbc:mysql://localhost:3306/login";%>
<%!String user = "root";%>
<%!String psw = "";%>
<%
  String id = request.getParameter("id");

  String email=request.getParameter("email");
  String cash=request.getParameter("cash");
  String accountno=request.getParameter("accountno");
  String expirydate=request.getParameter("expirydate");
  String cvv=request.getParameter("cvv");

  if(email != null)
  {
    Connection con = null;
    PreparedStatement ps = null;
    try
    {
      Class.forName(driverName);
      con = DriverManager.getConnection(url,user,psw);
      String sql="Update paymentmethod set id=?,email=?,cash=?,accountno=?,expirydate=?,cvv=? where id="+id ;
      ps = con.prepareStatement(sql);
      ps.setString(1,id);
      ps.setString(2,email);
      ps.setString(3, cash);
      ps.setString(4, accountno);
      ps.setString(5, expirydate);
      ps.setString(6, cvv);

      int i = ps.executeUpdate();
      if(i > 0)
      {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/PaymentMethod.jsp");
        dispatcher.forward(request, response);
      }
      else
      {
        out.print("There is a problem in updating Record.");
      }
    }
    catch(SQLException sql)
    {
      request.setAttribute("error", sql);
      out.println(sql);
    }



  }
%>