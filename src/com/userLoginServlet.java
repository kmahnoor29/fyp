package com;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 * Created by mano on 5/5/2020.
 */
@WebServlet(name = "userLoginServlet")
@MultipartConfig(maxFileSize = 418018841)
public class userLoginServlet extends HttpServlet {
    public String username,username2, Countrow;
    String destPage = "/userLoginServlet";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8/");

        username = request.getParameter("user"); //Extract username
        username2 = request.getParameter("user2"); //Extract username

        PrintWriter out = response.getWriter();



        String user = checkUser1(username);

        String user2 = checkUser2(username2);





        if (user.equals(username) && user2.equals(username2)) {
        try {


            session = request.getSession();
            session.setAttribute("username", request.getParameter("user")); //Set Attribute
            session.setAttribute("username2", request.getParameter("user2")); //Set Attribute




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
                        "<a style=\"color:white; background-color:red;\" href=\"userChatDelete.jsp?'" + username + "' & '" + username2 + "'>" +
                        "<button type=\"button\" class=\"delete\">Delete</button>" +
                        "</a>" +
                        "<input type=\"submit\" value=\"Send\" name=\"cmdSend\"/>");
                out.println("<br><br> <a href=\"chatWindowServlet\">Refresh Chat Room</a>");
                out.println("<br> <a href=\"LogoutServlet\">Logout</a>");
                out.println("<br>  <br>");
                out.println("Messages in Chat Box:");
                out.println("<br><br>");
                out.println("<textarea  readonly=\"readonly\" id=\"output\"  name=\"txtMessage\" rows=\"20\" cols=\"60\" /> "
                );


                // Retrieve all messages from database


                try {
                    Class.forName("com.mysql.jdbc.Driver");

                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/login", "root", "");
                    Statement st = (Statement) con.createStatement();

                    ResultSet rs = st.executeQuery("select *from chat where username='" + username + "' OR username2='" + username2 + "' OR username2='" + username2 + "' OR username='" + username2 + "'");

                    // Print all retrieved messages
                    while (rs.next()) {
                        String messages = rs.getString(1) + " >> " + rs.getString(3);
                        out.println(messages);
                    }

                } catch (Exception ex1) {
                    System.err.println(ex1.getMessage());
                }

                out.println("</textarea>");
                out.println("<hr>");
                out.println("</form>");
                out.println("</body>");
                out.println("</html>");
                request.getSession(false);



        } catch (Exception e) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet </title>");
            out.println("</head>");

            out.println("</body>");
            out.println("</html>");
            System.out.println(e);
        }} else{

            RequestDispatcher dispatcher = request.getRequestDispatcher("Chaterror.jsp");
            dispatcher.forward(request, response);
        }



    }



    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
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

}
