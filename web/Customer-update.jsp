<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%! String driverName ="com.mysql.jdbc.Driver";%>
<%!String url = "jdbc:mysql://localhost:3306/login";%>
<%!String user = "root";%>
<%!String psw = "";%>
<%
  String id = request.getParameter("id");
  String firstname=request.getParameter("firstname");
  String lastname=request.getParameter("lastname");
  String phone=request.getParameter("phone");
  String cnic=request.getParameter("cnic");
  String address=request.getParameter("address");
  if(id != null)
  {
    Connection con = null;
    PreparedStatement ps = null;
    try
    {
      Class.forName(driverName);
      con = DriverManager.getConnection(url,user,psw);
      String sql="Update customer set id=?, firstname=?,lastname=?,phone=?,cnic=?,address=? where id="+id ;
      ps = con.prepareStatement(sql);
      ps.setString(1,id);
      ps.setString(2,firstname);
      ps.setString(3, lastname);
      ps.setString(4, phone);
      ps.setString(5, cnic);
      ps.setString(6, address);
      int i = ps.executeUpdate();
      if(i > 0)
      {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/customerinfo.jsp");
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