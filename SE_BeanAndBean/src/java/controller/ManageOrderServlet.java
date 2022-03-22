/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Order;
import model.User;

/**
 *
 * @author Koby
 */
public class ManageOrderServlet extends HttpServlet {

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
        
        HttpSession session = request.getSession();
        User u = (User) session.getAttribute("user");
        String userType = u.getRole();
        
        String cancel = request.getParameter("cancel");
        String process = request.getParameter("process");
        String complete = request.getParameter("complete");
        
        List<Order> orderList = (List) session.getAttribute("orderList");
        
        if(!userType.equals("admin")){
            System.out.println("hindi admin");
            response.sendRedirect("");
            return;
        } else if(cancel == null && process == null && complete == null) {
            System.out.println("null button");
            response.sendRedirect("");
            return;
        }
        
        if(cancel != null){
            System.out.println("CANCEL");
            try{
                int index = Integer.parseInt(cancel);
                Order o = orderList.get(index);
                o.cancelOrder();
                
            } catch(Exception e){
                System.out.println("EXCEPTION PAREH");
                response.sendRedirect("");
                return;
            }
        } else if(process != null){
            System.out.println("PROCESSSSS");
            try{
                int index = Integer.parseInt(process);
                
                Order o = orderList.get(index);
                o.processOrder();
                
            } catch(Exception e){
                System.out.println("EXCEPTION PAREKOY");
                response.sendRedirect("");
                return;
            }
        } else if(complete != null){
            System.out.println("COMPLETEEEEEE");
            try{
                int index = Integer.parseInt(complete);
                
                Order o = orderList.get(index);
                o.completeOrder();
                
            } catch(Exception e){
                System.out.println("EXCEPTION PAREKOY");
                response.sendRedirect("");
                return;
            }
        }
        System.out.println("OKS NA!!!!");
        response.sendRedirect("admin.jsp");
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
