package controller;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.*;

public class CheckoutServlet extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Cart c = (Cart) session.getAttribute("cart");
        List<CartItem> cart = c.getCart();
        Connection con = (Connection) getServletContext().getAttribute("connection");
        
        double totalPrice = c.getTotalPrice();
        
        User u = (User) session.getAttribute("user");
        int customer_id = u.getCustomerID();
        String street = request.getParameter("street");
        String barangay = request.getParameter("barangay");
        String city = request.getParameter("city");
        String region= "NCR";
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String phoneNumber = request.getParameter("phoneNumber");
        
        //invalid access; accessed through url
        if(street == null || barangay  == null){
            response.sendRedirect("error404.jsp");
            return;
        } else if(c.getQuantityInCart() == 0){
            response.sendRedirect("shop.jsp");
            return;
        }
        
        Order o = new Order(customer_id, totalPrice, street, barangay, city, region, firstName, lastName, email, phoneNumber, con);
        int orderID = o.getOrderID();
        
        for(CartItem ci : cart){
            Product p = ci.getProduct();
            int quantity = ci.getQuantity();    
            OrderItem oi = new OrderItem(p, quantity, orderID, con); 
            o.addItem(oi);
        }
        
        c.emptyCart();
        
        session.setAttribute("order", o);
        response.sendRedirect("cart.jsp");
        
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
