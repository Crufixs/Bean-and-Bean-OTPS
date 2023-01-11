
package controller;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
//import model.AuthenticationException;
import model.Cart;
import model.Order;
//import model.NullValueException;
import model.Product;
import model.ProductList;
import model.Security;
import model.User;

public class LoginServlet extends HttpServlet {
    Connection con;
    
    @Override
    public void init(ServletConfig config) throws ServletException{
        super.init(config);
        
        ServletContext context = getServletContext();
        con = (Connection) context.getAttribute("connection");
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
                
        HttpSession session = request.getSession();
//        ProductList pm = new ProductList(con);
        
        //Input from the Log in form
        String inputUsername=request.getParameter("uname");
        String inputPassword = request.getParameter("psw");
        System.out.println("inputUsername = " + inputUsername);
        System.out.println("inputPassword = " + inputPassword);
        //invalid access
        if(inputUsername == null || inputPassword  == null){
            response.sendRedirect("error404.jsp");
            return;
        }
        
        inputUsername = inputUsername.toLowerCase();

        //For Encryption
        Security s = new Security();
        inputPassword = s.encrypt(inputPassword);

        //New User object
        User user;
        
        //Boolean values for the validity of username and password
        boolean unameMatch = false;
        boolean passMatch = false;
        
        try{
            if(con != null){
               //PreparedStatement to avoid SQLInjection
               System.out.println("b4" + inputUsername);
               PreparedStatement ps = con.prepareStatement("SELECT * FROM customer WHERE username=?");
               System.out.println("after" + inputUsername);
               ps.setString(1, inputUsername);
               //PreparedStatement ps = con.prepareStatement("SELECT * FROM customer");
               ResultSet rs = ps.executeQuery();
               
               //Checks if the inputted username matches a record in the UserDB
               //rs.next() returns true if the ResultSet finds a record
               if(rs.next()){
                   unameMatch = true;
                   String uname = rs.getString("username"); //Returns the corresponding password of the given username
                   System.out.println("realuname = " + uname);
                   String password = rs.getString("password"); //Returns the corresponding password of the given username
                   System.out.println("realpassword = " + s.decrypt(password));
                   if(password.equals(inputPassword)){ //Checks if the returned password matches the user input
                       passMatch = true;
                       
                       int customerID = Integer.parseInt(rs.getString("customer_id"));
                       
                       String role = rs.getString("account_type"); //Returns the corresponding role of the given username
                       String firstName = rs.getString("first_name");
                       String lastName = rs.getString("last_name");
                       String email = rs.getString("email");
                       String phoneNumber = rs.getString("phone_number");                
                       String street = rs.getString("street");
                       String barangay = rs.getString("barangay");
                       String city = rs.getString("city");
                       String region = rs.getString("region");
                       String isVeriifed = rs.getString("isverified");
                       boolean isVerifiedBool = false;
                       if (isVeriifed.equalsIgnoreCase("t")) {
                           isVerifiedBool = true;
                       }
                       //int customerID, String username, String password, String role, String firstName, String lastName, String email, String phoneNumber, 
                       //String street, String barangay, String city, String province, String region, String accountType
                       user = new User(customerID, inputUsername, password, role, firstName, lastName, email, phoneNumber, street, barangay, city, region, isVerifiedBool);
                       
                       Cart c = new Cart(customerID);
                       
                       session.setAttribute("cart", c);
                       session.setAttribute("user", user); //We set the User object we created as a Session Attribute (To print the Username & Role)
                       if(role.equals("guest"))
                            response.sendRedirect("success.jsp"); //success page
                       else if(role.equals("admin")){
                           List<Order> orderList = getOrderList();
//                           List<Order> pendingOrders = new ArrayList<>();
//                           List<Order> processingOrders = new ArrayList<>();
//                           List<Order> completedOrders = new ArrayList<>();
//                           for
                           session.setAttribute("orderList", orderList);
                           System.out.println("Order list: " + orderList.size() + " items");
                           response.sendRedirect("admin.jsp");
                       }
                       
                       return;
                   }
                   else{
                       passMatch = false; //The inputted password did not match the corresponding password of the inputted username
                   }
               }

               
               Map<String, String> errors = new HashMap<>();
               Map<String, String> previousInput = new HashMap<>();
               
               if(!unameMatch){ //Error 1 - Username not found
                   errors.put("username", "Username not found");
                   previousInput.put("username", "");
                   previousInput.put("password", "");
               } else if (unameMatch && !passMatch){ //Error 2 - The username is correct but the password is incorrect
                   errors.put("password", "Incorrect Password");
                   previousInput.put("username", inputUsername);
                   previousInput.put("password", "");
                   request.setAttribute("errors", errors);
               }
               request.setAttribute("errors", errors);
               request.setAttribute("input", previousInput);
               request.getRequestDispatcher("login.jsp").forward(request,response);
               return;
            }
        } catch (SQLException e){
            e.printStackTrace();
        }
        
        
        
    }
    
    private List<Order> getOrderList(){
        List <Order> orderList = new ArrayList<>();
        
        try{
            PreparedStatement ps = con.prepareStatement("SELECT * FROM orders");
            ResultSet rs = ps.executeQuery();
            
            while(rs.next()){
                int orderID = rs.getInt("order_id");
                int customerID = rs.getInt("customer_id");
                String status = rs.getString("status");
                double total_price = rs.getDouble("total_price");
                String placed_at = rs.getString("placed_at");
                String street = rs.getString("street");
                String barangay = rs.getString("barangay");
                String city = rs.getString("city");
                String region = rs.getString("region");
                String first_name = rs.getString("first_name");
                String last_name = rs.getString("last_name");
                String email = rs.getString("email");
                String phone_number = rs.getString("phone_number");
                
                Order feedback = new Order(orderID, customerID, status, total_price, placed_at, street, barangay, city, region,
                first_name, last_name, email, phone_number, con);
                
                orderList.add(feedback);
            }
            
            
        } catch(Exception e){
            
        }
        
        return orderList;
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
