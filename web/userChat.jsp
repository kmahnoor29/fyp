<%--
  Created by IntelliJ IDEA.
  User: mano
  Date: 5/5/2020
  Time: 10:25 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>CD CHAT</title>
</head>
<body style="color:white; background-color: lightseagreen">
<center>
  <h1>CD CHAT</h1>
  <br>
  <br>


  <br><br>
  <h2>Start Chat
  <br>
    <%
      if(session.getAttribute("email")!=null){
        String email1 = (String) session.getAttribute("email");

        out.print(email1);
      }
    %>
  </h2>
  <form name="userLogin" action="userLoginServlet" method="POST">

    <table border="0" width="30" cellspacing="8" cellpadding="20">

      <tbody>
      <tr>
        <td>Your Email:</td>
        <td><input type="text" name="user" value="" data-validator="Enter Your Email" required="true"/></td>

        <td>Send To:</td>
        <td><input type="text" name="user2" value="" data-validator="Where to Send?" required="true" /></td>
      </tr>

      </tbody>
    </table>
    <input type="submit" value="JOIN CHAT ROOM" name="log in" />



  </form>


</center>
</body>

</html>
