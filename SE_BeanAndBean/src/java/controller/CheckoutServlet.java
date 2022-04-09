package controller;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
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
        if(street == null || barangay  == null) {
            response.sendRedirect("error404.jsp");
            return;
        } else if(c.getQuantityInCart() == 0) {
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
        sendEmail(o);
        
        session.setAttribute("order", o);
        response.sendRedirect("cart.jsp");
        
    }
    
    private static void sendEmail(Order order){
        Properties properties = new Properties();

        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.host", "smtp.gmail.com");
        properties.put("mail.smtp.port", "587");

        //BUSINESS EMAIL
        String myAccountEmail = "beanandbean.business@gmail.com";
        String password = "beanNbean1";

        Session session = Session.getInstance(properties, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(myAccountEmail, password);
            }
        });
        
        String messageOrders = "";
        
        int i=1;
        for(OrderItem oi : order.getItems()){
            messageOrders += i + ". Product: " + oi.getProduct().getName() + " - Quantity: " + oi.getQuantity() + "\n";
            i++;
        }
        
        String emailMessage = "Order #" + order.getOrderID() + "\nCustomer # " + order.getCustomerID() 
                + "\nOrders: \n" + messageOrders;
        
        //LAGAY DITO HOST EMAIL
//        Message message = prepareMessage(session, myAccountEmail, "beanandbean.business@gmail.com", emailMessage);
        
        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(myAccountEmail));
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(myAccountEmail));
            message.setSubject("New Order: #" + order.getOrderID());
            message.setText(emailMessage);

            Transport.send(message);
        }
        catch (Exception ex) {
            ex.printStackTrace();
        }
        
        System.out.println("Message sent successfully");
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
