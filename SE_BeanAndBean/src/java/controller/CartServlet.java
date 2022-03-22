package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Cart;
import model.CartItem;
import model.ProductList;


public class CartServlet extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String action = request.getParameter("action");

        
        if(action == null){
            response.sendRedirect("error404.jsp");
            return;
        }

        if(action.equals("add")){
            addToCart(request, response);
        } else if(action.equals("deduct")){
            deductFromCart(request, response);
        } else if(action.equals("empty")){
            removeFromCart(request, response);
        }
    }
    
    protected void removeFromCart(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Cart c = (Cart) session.getAttribute("cart");
        
        String id = request.getParameter("id");
        CartItem cartItem = c.findCartItem(id);
        
        if(cartItem == null){
            response.sendRedirect("cart.jsp");
            return;
        }

        c.removeFromCart(cartItem);
        session.setAttribute("cart", c);
        response.sendRedirect("cart.jsp");
        return;
    }
    
    
    protected void addToCart(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Cart c = (Cart) session.getAttribute("cart");
        String id = request.getParameter("id");
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        System.out.println("QUANTITY: " + quantity);
//        CartItem cartItem = c.findCartItem(id);
        
        if(((ProductList)getServletContext().getAttribute("productList")).findProduct(id) == null){
            response.sendRedirect("cart.jsp");
            return;
        }
        
        c.addToCart(id, quantity);
        session.setAttribute("cart", c);
        response.sendRedirect("cart.jsp");
        return;
    }
    
    protected void deductFromCart(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Cart c = (Cart) session.getAttribute("cart");
        
        String id = request.getParameter("id");
        CartItem cartItem = c.findCartItem(id);
        
        if(cartItem == null){
            response.sendRedirect("cart.jsp");
            return;
        }

        if(cartItem.getQuantity() <= 1){
            c.removeFromCart(cartItem);
        } else {
            c.deductFromCart(cartItem);
        }
        
        session.setAttribute("cart", c);
        response.sendRedirect("cart.jsp");
        return;
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
