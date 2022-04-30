/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.util.Properties;
import java.util.Random;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Security;
import model.User;

/**
 *
 * @author Carlo
 */
public class SendVerificationServlet extends HttpServlet {

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
        Connection con = (Connection) getServletContext().getAttribute("connection");
        HttpSession session = request.getSession();
        User u = (User) session.getAttribute("user");
        try (PrintWriter out = response.getWriter()) {
            //get the 6-digit code
            String verificationCode = getRandom();
            session.setAttribute(u.getEmail(),verificationCode);
            //Lagay sa DB ung code??
         
            //call the send email method
            boolean test = sendEmail(u, verificationCode);

            //check if the email send successfully
            if (test) {
                response.sendRedirect("verificationPage.jsp");
            } else {
                out.println("Failed to send verification email");
            }

        }
    }

    public String getRandom() {
        Random rnd = new Random();
        int number = rnd.nextInt(999999);
        return String.format("%06d", number);
    }

    //send email to the user email
    public boolean sendEmail(User user, String verificationCode) {
        boolean test = false;

        String toEmail = user.getEmail();
        String fromEmail = "beanandbean.business@gmail.com";
        String password = "beanNbean1";

        try {
            // your host email smtp server details
            Properties properties = new Properties();
            properties.put("mail.smtp.auth", "true");
            properties.put("mail.smtp.starttls.enable", "true");
            properties.put("mail.smtp.host", "smtp.gmail.com");
            properties.put("mail.smtp.port", "587");

            //get session to authenticate the host email address and password
            Session session = Session.getInstance(properties, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(fromEmail, password);
                }
            });

            //set email message details
            Message mess = new MimeMessage(session);

            //set from email address
            mess.setFrom(new InternetAddress(fromEmail));
            //set to email address or destination email address
            mess.setRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));

            //set email subject
            mess.setSubject("User Email Verification");
            
            Security s = new Security();
            String encryptedEmail = user.getEmail();
            System.out.println("encryptedEmail = " + encryptedEmail);
            String encryptedCode = verificationCode;
            //set message text
            String link = "http://localhost:8080/SE_BeanAndBean/"
                    + "VerifyCodeServlet?key1=" + encryptedEmail + "&key2=" + encryptedCode;

            mess.setContent("<h2>Account Verification </h2>" + 
                        "<p> Hi " + user.getUsername() + ", please click on the button to verify your account. The verification link will expire once your session in the website has ended. \n </p> "+
                        " <a href="+ link +">" +"<button>Verify Account</button></a>",
                        "text/html");

            //send the message
            Transport.send(mess);

            test = true;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return test;
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
