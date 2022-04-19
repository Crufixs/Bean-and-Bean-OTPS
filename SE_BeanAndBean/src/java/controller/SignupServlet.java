package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Cart;
import model.Security;
//import model.SignUpValidation;
import model.User;
import nl.captcha.Captcha;

public class SignupServlet extends HttpServlet {

    enum Credentials {
        Signup, Edit
    }

    Connection con;
    private String inputConfirmPassword = "";
    private String inputFirstName = "";
    private String inputLastName = "";
    private String inputEmail = "";
    private String inputPhoneNumber = "";
    private String accountType = "";
    private String street = "";
    private String barangay = "";
    private String city = "";
    private String region = "";
    private String inputUsername = "";
    private String inputPassword = "";
    private String inputCaptcha = "";
    private String generatedCaptcha = "";
    private String encryptedPsw = "";
    private Credentials state;
    private User u = null;

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        ServletContext context = getServletContext();
        con = (Connection) context.getAttribute("connection");
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // -------------------------------------------- INITIALIZING INPUTS -----------------------------------------------------

        Map<String, String> previousInput = initVariables(request);

        // ----------------------------------------- ERROR TYPES BUT WITH CONN --------------------------------------------------
        Map<String, String> errors = getErrors(previousInput);
        if (inputUsername == null || inputPassword == null) {
            response.sendRedirect("error404.jsp");
            return;
        }
        if (errors != null) {
            request.setAttribute("errors", errors);
            request.setAttribute("input", previousInput);
            switch (state) {
                case Signup:
                    request.getRequestDispatcher("register.jsp").forward(request, response);
                    break;
                case Edit:
                    request.getRequestDispatcher("success.jsp").forward(request, response);
                    break;
            }
            return;
        }

        // ----------------------------------------------------------------------------------------------------------------------
        try {
            if (con != null) {
                //Finding Similar Username
                PreparedStatement updateDb = null;
                switch (state) {
                    case Signup:
                        updateDb = initNewAccount();
                        int affectedRows = updateDb.executeUpdate();
                        System.out.println(affectedRows);
                        response.sendRedirect("login.jsp");
                        return;
                    case Edit:
                        updateDb = editAccount(u.getCustomerID());
                        break;
                }
                int affectedRows = updateDb.executeUpdate();
                System.out.println(affectedRows);
                //UPDATING USER 
                PreparedStatement getUser = con.prepareStatement("SELECT * FROM customer WHERE customer_id=?");
                getUser.setString(1, "" + u.getCustomerID());
                ResultSet rs = getUser.executeQuery();

                if (rs.next()) {
                    int customerID = Integer.parseInt(rs.getString("customer_id"));
                    String role = rs.getString("account_type"); 
                    String firstName = rs.getString("first_name");
                    String lastName = rs.getString("last_name");
                    String email = rs.getString("email");
                    String phoneNumber = rs.getString("phone_number");
                    String street = rs.getString("street");
                    String barangay = rs.getString("barangay");
                    String city = rs.getString("city");
                    String region = rs.getString("region");
                    String password = rs.getString("password");
                    String username = rs.getString("username");
                    User userUpdated = new User(customerID, username, password, role, firstName, lastName, email, phoneNumber, street, barangay, city, region);
                    HttpSession session = request.getSession();
                    request.getSession().removeAttribute("user");
                    session.setAttribute("user", userUpdated); 
                }
                if (affectedRows != 0) {
                    response.sendRedirect("success.jsp");
                    return;
                }

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public PreparedStatement initNewAccount() {
        PreparedStatement createUser = null;
        try {
            createUser = con.prepareStatement("INSERT INTO CUSTOMER (username, password, first_name, last_name, email, phone_number, "
                    + "street, barangay, city, region, account_type) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
            createUser.setString(1, inputUsername);
            createUser.setString(2, encryptedPsw);
            createUser.setString(3, inputFirstName);
            createUser.setString(4, inputLastName);
            createUser.setString(5, inputEmail);
            createUser.setString(6, inputPhoneNumber);
            createUser.setString(7, street);
            createUser.setString(8, barangay);
            createUser.setString(9, city);
            createUser.setString(10, region);
            createUser.setString(11, "guest");

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return createUser;
    }

    public PreparedStatement editAccount(int customer_id) {
        PreparedStatement editUser = null;
        try {
            editUser = con.prepareStatement("UPDATE CUSTOMER SET username = ?,password = ?,first_name = ?, last_name = ?, "
                    + "email = ?, phone_number = ?, street = ?, barangay = ?, city = ?, region = ?, account_type = ? WHERE customer_id = " + customer_id);
            editUser.setString(1, inputUsername);
            editUser.setString(2, encryptedPsw);
            editUser.setString(3, inputFirstName);
            editUser.setString(4, inputLastName);
            editUser.setString(5, inputEmail);
            editUser.setString(6, inputPhoneNumber);
            editUser.setString(7, street);
            editUser.setString(8, barangay);
            editUser.setString(9, city);
            editUser.setString(10, region);
            editUser.setString(11, "guest");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return editUser;
    }

    public Map initVariables(HttpServletRequest request) {
        Security s = new Security();
        Map<String, String> previousInput = new HashMap<>();
        HttpSession session = request.getSession();
        inputUsername = request.getParameter("uname");
        inputPassword = request.getParameter("psw");
        inputConfirmPassword = request.getParameter("confirmPsw");
        inputFirstName = request.getParameter("firstName").trim();
        inputLastName = request.getParameter("lastName").trim();
        inputEmail = request.getParameter("email").trim().toLowerCase();
        inputPhoneNumber = request.getParameter("phoneNumber").trim().toLowerCase();
        accountType = "guest";
        street = request.getParameter("street");
        barangay = request.getParameter("barangay");
        city = request.getParameter("city");
        region = "NCR";
        encryptedPsw = s.encrypt(inputPassword);

        u = (User) session.getAttribute("user");
        if (request.getParameter("state").compareTo("signup") == 0) {
            state = Credentials.Signup;
            inputCaptcha = request.getParameter("captcha");
            generatedCaptcha = ((Captcha) session.getAttribute("captcha")).getAnswer();
        } else if (request.getParameter("state").compareTo("edit") == 0) {
            state = Credentials.Edit;
        }
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
        return previousInput;
    }

    public Map getErrors(Map<String, String> previousInput) {
        boolean errorPresent = false;
        Map<String, String> errors = new HashMap<>();
        //wrong format password
        String regexPw = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$";
        Pattern patternPw = Pattern.compile(regexPw, Pattern.CASE_INSENSITIVE);
        Matcher matcherPw = patternPw.matcher(inputPassword);
        if (!matcherPw.matches()) {
            errorPresent = true;
            errors.put("passwordWrongFormat", "Password must contain at least 8 characters, at least one letter and number.");
            previousInput.put("psw", "");
            previousInput.put("confirmPsw", "");
        }

        //wrong format email
        String regexEm = "^[A-Z0-9._%+-]+@[A-Z0-9.-]+.[A-Z]{2,6}$";
        Pattern patternEm = Pattern.compile(regexEm, Pattern.CASE_INSENSITIVE);
        Matcher matcherEm = patternEm.matcher(inputEmail);
        if (!matcherEm.matches()) {
            errorPresent = true;
            errors.put("emailWrongFormat", "e.g. usermail@gmail.com");
        }

        //wrong format username
        String regexUn = "^[a-zA-Z0-9._-]{6,}$";
        Pattern patternUn = Pattern.compile(regexUn);
        Matcher matcherUn = patternUn.matcher(inputUsername);
        if (!matcherUn.matches()) {
            errorPresent = true;
            errors.put("usernameWrongFormat", "Username must contain at least 6 characters (Letters, Numbers, Symbols e.g. period, dashes, underscore)");
        }

        //wrong format phone number
        String regexPn = "^(09)\\d{9}$";
        Pattern patternPn = Pattern.compile(regexPn);
        Matcher matcherPn = patternPn.matcher(inputPhoneNumber);
        if (!matcherPn.matches()) {
            errorPresent = true;
            errors.put("phoneNumberWrongFormat", "Phone number must follow format: 09*********");
        }

        //invalid captcha
        try {
            if (con != null) {
                //Finding Similar Username
                PreparedStatement psUname = con.prepareStatement("SELECT * FROM CUSTOMER WHERE username=?");
                psUname.setString(1, inputUsername);
                ResultSet rsUname = psUname.executeQuery();

                //Finding Similar Email
                PreparedStatement psEmail = con.prepareStatement("SELECT * FROM CUSTOMER WHERE email=?");
                psEmail.setString(1, inputEmail);
                ResultSet rsEmail = psEmail.executeQuery();

                if (state == Credentials.Signup) {
                    if (rsUname.next()) { //username already exists
                        errorPresent = true;
                        errors.put("usernameTaken", "Username is taken already");
                        previousInput.put("uname", "");
                    }

                    if (rsEmail.next()) { //email already exists
                        errorPresent = true;
                        errors.put("emailTaken", "This email is already being used");
                        previousInput.put("email", "");
                    }
                    if (!inputCaptcha.equals(generatedCaptcha)) {
                        errorPresent = true;
                        errors.put("captcha", "Invalid Captcha");
                    }

                    //passwords do not match
                    if (!inputPassword.equals(inputConfirmPassword)) {
                        errorPresent = true;
                        errors.put("pwMismatch", "Passwords do not match");
                        previousInput.put("psw", "");
                        previousInput.put("confirmPsw", "");
                    }
                }

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return errorPresent ? errors : null;
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
