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
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
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
    
    public void init(ServletConfig config) throws ServletException {  
        super.init(config);
        //Your code  
    }
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        Connection con = (Connection) getServletContext().getAttribute("connection");
        HttpSession session = request.getSession();
        
        ServletContext context = getServletContext();
        List<Feedback> feedbacks = (List) context.getAttribute("feedbackList");
        String requestType = request.getParameter("requestType");
        
        if(requestType.equals("sort")){
            int sort = Integer.parseInt(request.getParameter("sort"));
            request.setAttribute("selectedID", sort);

            if(sort == 2){
                Collections.sort(feedbacks, Feedback.RatingComparator);
                System.out.println("IN RATINGS SORT");
            }
            else if(sort == 1){
                Collections.sort(feedbacks, Feedback.RecencyComparator);
                System.out.println("IN RECENCY SORT");
                
            }
            context.setAttribute("feedbacks", feedbacks);
            RequestDispatcher rd = request.getRequestDispatcher("aboutus.jsp");  
            rd.forward(request,response);
            return;
        } else if(requestType.equals("comment")){
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

            Feedback.addFeedbackToDB(u.getCustomerID(), comment, starRating);
            feedbacks = Feedback.getFeedbackListFromDB();

            context.setAttribute("feedbackList", feedbacks);

            response.sendRedirect("aboutus.jsp");
            return;
        }
        
        response.sendRedirect("home.jsp");
        
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
