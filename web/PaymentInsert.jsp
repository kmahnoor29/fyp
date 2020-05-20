<%@page import="com.sun.xml.internal.bind.CycleRecoverable.Context"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>Insert</title>
</head>
<body>
<%
  Connection conn=null;
  PreparedStatement pstmt = null;
  ResultSet rs=null;
  String url="jdbc:mysql://localhost:3306/login";

  String email=request.getParameter("email");
  String cash=request.getParameter("cash");
  String accountno=request.getParameter("accountno");
  String expirydate=request.getParameter("expirydate");
  String cvv=request.getParameter("cvv");
//out.print("First Name :"+fname+"myloc="+myloc);
  try{
    Class.forName("com.mysql.jdbc.Driver").newInstance();
    conn=DriverManager.getConnection(url, "", "");

    pstmt = conn.prepareStatement("insert into paymentmethod(email, cash, accountno,expirydate,cvv) " + "values(?,?,?,?,?)");
    pstmt.setString(1, email);
    pstmt.setString(2, cash);
    pstmt.setString(3, accountno);
    pstmt.setString(4, expirydate);
    pstmt.setString(5, cvv);

    int count = pstmt.executeUpdate();
    if(count>0)
    {
      out.println("insert successfully");
    }
    else
    {
      out.println("not successfully");
    }
  }
  catch(Exception ex)
  {
    ex.printStackTrace();
  }
  finally{
    try{
      if(rs!=null){
        rs.close();
        rs= null;
      }
      if(pstmt !=null)
      {
        pstmt.close();
        pstmt=null;
      }
      if(conn!=null)
      {
        conn.close();
        conn=null;
      }
    }
    catch(Exception e)
    {
      e.printStackTrace();
    }

    RequestDispatcher dispatcher = request.getRequestDispatcher("PaymentMethod.jsp");
    dispatcher.forward(request, response);


  }




%>
</body>
</html>