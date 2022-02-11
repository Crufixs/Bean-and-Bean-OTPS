package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Security;
//import model.SignUpValidation;
import model.User;
import nl.captcha.Captcha;

public class SignupServlet extends HttpServlet {
    
    Connection con;
    
    @Override
    public void init(ServletConfig config) throws ServletException{
        super.init(config);
        
        ServletContext context = getServletContext();
        con = (Connection) context.getAttribute("connection");
    }
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String inputUsername = request.getParameter("uname");
        String inputPassword = request.getParameter("psw");
        
        
        
        
        
        
        //---------------------------------------------------------------------
        
//        invalid access
        HttpSession session = request.getSession();
        if(inputUsername == null || inputPassword  == null){
            response.sendRedirect("error404.jsp");
            return;
        }
        
        String inputConfirmPassword = request.getParameter("confirmPsw");
        String inputFirstName = request.getParameter("firstName").trim();
        String inputLastName = request.getParameter("lastName").trim();
        String inputEmail = request.getParameter("email").trim().toLowerCase();
        String inputPhoneNumber = request.getParameter("phoneNumber").trim().toLowerCase();
        String accountType = "guest";
        String street = request.getParameter("street");
        String barangay = request.getParameter("barangay");
        String city = request.getParameter("city");
        String region = "NCR";
        
        inputUsername = inputUsername.toLowerCase();
        
        
        String inputCaptcha = request.getParameter("captcha");
        String generatedCaptcha = ((Captcha)session.getAttribute("captcha")).getAnswer();
        
        Map<String, String> errors = new HashMap<>();
        Map<String, String> previousInput = new HashMap<>();
        
        
        previousInput.put("uname", inputUsername);
        previousInput.put("psw", inputPassword);
        previousInput.put("confirmPsw", inputConfirmPassword);
        previousInput.put("firstName", inputFirstName);
        previousInput.put("lastName", inputLastName);
        previousInput.put("email", inputEmail);
        previousInput.put("phoneNumber", inputPhoneNumber);
        previousInput.put("street", street);
        previousInput.put("barangay", barangay);
        previousInput.put("city", city);
        previousInput.put("region", region);
        
        
        boolean errorPresent = false;
        

    
        
        // -------------------------------------------- ERROR TYPES ------------------------------------------------
        //valid access
        
        //invalid captcha
        if(!inputCaptcha.equals(generatedCaptcha)){ 
            errorPresent = true;
            errors.put("captcha", "Invalid Captcha");
        } 
        //passwords do not match
        if(!inputPassword.equals(inputConfirmPassword)){
            errorPresent = true;
            errors.put("pwMismatch", "Passwords do not match");
            previousInput.put("psw", "");
            previousInput.put("confirmPsw", "");
        } 
        
        
        if(errorPresent){
            request.setAttribute("errors", errors);
            request.setAttribute("input", previousInput);
            request.getRequestDispatcher("register.jsp").forward(request,response);
            return;
        }
        
        // -------------------------------------------- END OF ERROR TYPES ------------------------------------------------
        
        Security s = new Security();
        String encryptedPsw = s.encrypt(inputPassword);
        
        try{
            if(con != null){
               //Finding Similar Username
               PreparedStatement psUname = con.prepareStatement("SELECT * FROM CUSTOMER WHERE username=?");
               psUname.setString(1, inputUsername);
               ResultSet rsUname = psUname.executeQuery();
               
               //Finding Similar Email
               PreparedStatement psEmail = con.prepareStatement("SELECT * FROM CUSTOMER WHERE email=?");
               psEmail.setString(1, inputEmail);
               ResultSet rsEmail = psEmail.executeQuery();
               
               if(rsUname.next()){ //username already exists
                   errorPresent = true;
                    errors.put("usernameTaken", "Username is taken already");
                    previousInput.put("uname", "");
               }
               
               if(rsEmail.next()){ //email already exists
                   errorPresent = true;
                    errors.put("emailTaken", "This email is already being used");
                    previousInput.put("email", "");
               }
               
               if(errorPresent){
                   request.setAttribute("errors", errors);
                    request.setAttribute("input", previousInput);
                    request.getRequestDispatcher("register.jsp").forward(request,response);
                    return;
               }
               
               
                psUname = con.prepareStatement("INSERT INTO CUSTOMER (username, password, first_name, last_name, email, phone_number, "
                        + "street, barangay, city, region, account_type) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
                psUname.setString(1, inputUsername);
                psUname.setString(2, encryptedPsw);
                psUname.setString(3, inputFirstName);
                psUname.setString(4, inputLastName);
                psUname.setString(5, inputEmail);
                psUname.setString(6, inputPhoneNumber);
                psUname.setString(7, street);
                psUname.setString(8, barangay);
                psUname.setString(9, city);
                psUname.setString(10, region);
                psUname.setString(11, "guest");
                
                int affectedRows = psUname.executeUpdate();

                if (affectedRows != 0){
                    response.sendRedirect("login.jsp");
                    return;
                }
            }
        } catch(SQLException e){
            e.printStackTrace();
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
