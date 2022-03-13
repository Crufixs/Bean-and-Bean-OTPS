/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Feedback;
import model.User;

/**
 *
 * @author Koby
 */
public class FeedbackServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        Connection con = (Connection) getServletContext().getAttribute("connection");
        HttpSession session = request.getSession();
        
        User u = (User) session.getAttribute("user");
        
        if(u == null){
            response.sendRedirect("login.jsp");
            return;
        }
        
        String comment = (String) request.getParameter("comment");
        int starRating = Integer.parseInt(request.getParameter("starRating"));
        
        if(starRating < 1)
            starRating = 1;
        else if(starRating > 5)
            starRating = 5;
        
//        System.out.println("Comment: " + comment + "\n");
//        System.out.println("Star Rating: " + starRating);

//        Feedback.setCon(con);
        Feedback feedback = new Feedback(u.getCustomerID(), comment, starRating);
        
        try{
            PreparedStatement insert = 
                    con.prepareStatement("INSERT INTO feedback(customer_id, comment, star_rating) VALUES (?, ?, ?)");
            
            insert.setString(1, feedback.getCustomerID()+"");
            insert.setString(2, feedback.getComment());
            insert.setString(3, feedback.getStarRating()+"");
            
            int affectedRows = insert.executeUpdate();

            
        } catch (SQLException ex) {
            Logger.getLogger(FeedbackServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        response.sendRedirect("aboutus.jsp");
        
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
