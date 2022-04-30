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
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.User;
import model.Security;

/**
 *
 * @author Carlo
 */
public class VerifyCodeServlet extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            Security s = new Security();
            HttpSession session = request.getSession();
            Connection con = (Connection) getServletContext().getAttribute("connection");
            String email = s.decrypt(request.getParameter("key1"));
            String code = s.decrypt(request.getParameter("key2"));
            
            User user = (User) session.getAttribute("user");
            String sessionCode = (String) session.getAttribute(email);
            if(code.equals(sessionCode)){
                //UDDATE DB
                try {
                    PreparedStatement verifyUser = con.prepareStatement("UPDATE CUSTOMER SET isverified = 't' WHERE customer_id = " + user.getCustomerID());
                    int affectedRows = verifyUser.executeUpdate();
                    user.setIsVerified(true);
                } catch (Exception e) {
                    e.printStackTrace();
                }
                out.println("Verification done");
                
            } else if (sessionCode == null || sessionCode == "") {
                out.println("Session has timed out");
            } else {
                out.println("Incorrect verification code");
            }
            
        }
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
