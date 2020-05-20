package com;


import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.*;

/**
 * Created by mano on 5/5/2020.
 */
@WebServlet(name = "chatWindowServlet")
public class chatWindowServlet extends HttpServlet {

    String username,tempName,username2;
    String Countrow;
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {




        response.setContentType("text/html;charset=UTF-8");


        try
        {



            PrintWriter out = response.getWriter();
            String message = request.getParameter("txtMsg"); //Extract Message
            //Extract Image
            InputStream inputStream = null;



            String username = session.getAttribute("username").toString(); //Extract Username
            String username2 = session.getAttribute("username2").toString(); //Extract Username


            //Display Chat Room
            out.println("<html>  <head> <body bgcolor=\"#20B2AA\" style=\"color:white;\"> <meta http-equiv=\"Content-Type\" content=\"text/html/; charset=UTF-8\"> <title>Chat Room</title>  </head>");
            out.println("<meta http-equiv=\"Content-Type\" content=\"text/html/; charset=UTF-8\"> <center>");
            out.println("<h2>Hi ");
            out.println(username);
            out.println("<br> Welcome to CD Service Chat ");
            out.println("</h2><br><hr>");
            out.println("  <body>");
            out.println("      <form  name=\"chatWindow\" action=\"chatWindowServlet\"> ");
            out.println("Message: <input type=\"text\" name=\"txtMsg\" value=\"\" />" +
                            "<a style=\"color:white; background-color:red;\" href=\"userChatDelete.jsp?'"+username+"' & '"+username2+"'>" +
                            "<button type=\"button\" class=\"delete\">Delete</button>" +
                            "</a>"+
                    "<input type=\"submit\" value=\"Send\" name=\"cmdSend\"/>");
            out.println("<br><br> <a href=\"chatWindowServlet\">Refresh Chat Room</a>");
            out.println("<br> <a href=\"LogoutServlet\">Logout</a>");
            out.println("<br>  <br>");
            out.println("Messages in Chat Box:");
            out.println("<br><br>");
            out.println("<textarea  readonly=\"readonly\" id=\"output\"  name=\"txtMessage\" rows=\"20\" cols=\"60\" /> "
            );



            //If eneterd message != null then insert into database



         String user =    checkUser1(username);

     String user2 =  checkUser2(username2);

            if(request.getParameter("txtMsg")!=null && user.equals(username) && user2.equals(username2) )
            {

                try
                {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con= DriverManager.getConnection("jdbc:mysql://localhost:3306/login", "root", "");

                    Statement st=con.createStatement();


                    String sql = "insert into chat values ('"+username+"','"+username2+"','"+message+"')";
                    st.executeUpdate(sql);

                    st.execute("commit");

                }
                catch(ClassNotFoundException   ex1)
                {
                    System.err.println(ex1.getMessage());
                    String messages = "No";
                    out.println(messages);
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            // Retrieve all messages from database

            try
            {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/login","root","");

                Statement st=con.createStatement();

                ResultSet rs=st.executeQuery("select *from chat where username='"+username+"' OR username2='"+username2+"' OR username2='"+username2+"' OR username='"+username2+"'");

                // Print all retrieved messages
                while(rs.next())
                {
                    String messages =rs.getString(1)+ " >> " + rs.getString(3);

                    out.println(messages);
                }

                con.close();
            }
            catch(Exception ex1)
            {
                System.err.println(ex1.getMessage());
            }





            out.println("</textarea>");
            out.println("<hr>");
            out.println("</form>");
            out.println("</body>");
            out.println("</html>");
        }catch (Exception ex){
            System.err.println(ex.getMessage());
        }


    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        //Session

        session = request.getSession();

        if(username!=null)
        {
            tempName=username;
        }

        processRequest(request, response);

    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);




    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
    HttpSession session;


    public String checkUser1(String username){

        try
        {
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            Connection con= DriverManager.getConnection("jdbc:mysql://localhost:3306/login", "root", "");
            Statement st=con.createStatement();

            String strQuery = "SELECT email FROM customer where email='"+username+"'";
            ResultSet rs = st.executeQuery(strQuery);
            rs.next();
            Countrow = rs.getString(1);
           // if(Countrow.equals("1")){

            System.out.println("Customer Email:\n"+username);
            //}
           // else{
             //   System.out.println("Invalid Email Id !");
            //}
        }
        catch (Exception e){
            e.printStackTrace();
        }

return username;
    }



    public String checkUser2(String username){

        try
        {
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            Connection con= DriverManager.getConnection("jdbc:mysql://localhost:3306/login", "root", "");
            Statement st=con.createStatement();

            String strQuery = "SELECT email FROM producer where email='"+username+"'";
            ResultSet rs = st.executeQuery(strQuery);
            rs.next();
            Countrow = rs.getString(1);
            // if(Countrow.equals("1")){

            System.out.println("Producer Email:\n"+username);
            //}
            // else{
            //   System.out.println("Invalid Email Id !");
            //}
        }
        catch (Exception e){
            e.printStackTrace();
        }

return username;
    }

public void deleteChat(String username , String username2){


    try
    {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/login", "root", "");
        Statement st=conn.createStatement();
        st.executeUpdate("DELETE FROM chat WHERE username='"+username+"' AND username2='"+username2+"' OR username2='"+username2+"' AND username='"+username+"'");
    }
    catch(Exception e)
    {
        System.out.print(e);
        e.printStackTrace();
    }

}



}
