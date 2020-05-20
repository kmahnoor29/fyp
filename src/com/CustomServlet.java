package com;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 * Created by mano on 3/24/2020.
 */
@WebServlet(name = "CustomServlet")
public class CustomServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String piece = request.getParameter("piece");
        String fabric = request.getParameter("fabric");
        String material = request.getParameter("material");
        String chest = request.getParameter("chest");
        String waist = request.getParameter("waist");
        String hip = request.getParameter("hip");
        String shoulders = request.getParameter("shoulders");
        String sleevelength = request.getParameter("sleevelength");
        String price = request.getParameter("price");
        String description = request.getParameter("description");
        String email = request.getParameter("email");
      ;


        HttpSession session = request.getSession(true);
        session.setAttribute("email",email);



        String dbURL = "jdbc:mysql://localhost:3306/login";
        String dbUser = "root";
        String dbPass = "";
        Connection conn = null; // connection to the database
        String message = null;  // message will be sent back to client
        try {
            // connects to the database
            DriverManager.registerDriver(new com.mysql.jdbc.Driver());
            conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

            // constructs SQL statement
            String sql = "INSERT IGNORE INTO custom (piece,fabric,material,chest,waist,hip,shoulders,sleevelength,price,description,email) values (?,?,?,?,?,?,?,?,?,?,?)";
            PreparedStatement statement = (PreparedStatement) conn.prepareStatement(sql);



            statement.setString(1, piece);
            statement.setString(2, fabric);
            statement.setString(3, material);
            statement.setString(4, chest);
            statement.setString(5, waist);
            statement.setString(6, hip);
            statement.setString(7, shoulders);
            statement.setString(8, sleevelength);
            statement.setString(9, price);
            statement.setString(10,description);
            statement.setString(11,email);



            // sends the statement to the database server
            int row = statement.executeUpdate();
            if (row > 0) {
                message = "File uploaded and saved into database";
            }
        } catch (SQLException ex) {
            message = "ERROR: " + ex.getMessage();
            ex.printStackTrace();
        } finally {
            if (conn != null) {
                // closes the database connection
                try {
                    conn.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
                session = request.getSession(false);

            }
        }


        RequestDispatcher dispatcher = request.getRequestDispatcher("/fileupload.jsp");
        dispatcher.forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
