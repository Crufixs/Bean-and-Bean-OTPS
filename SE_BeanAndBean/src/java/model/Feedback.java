/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Koby
 */
public class Feedback {
    private int feedbackID;
    private int customerID;
    private String customerUsername;
    private String comment;
    private int starRating;
    private static Connection con;
//    private static ArrayList<Feedback> feedbackList;

//    public Feedback(int customerID, String comment, int starRating, String customerUsername) {
//        this.customerID = customerID;
//        this.comment = comment;
//        this.starRating = starRating;
//        this.customerUsername = customerUsername;
////        this.customerUsername = getCustomerUsernameFromDB();
//    }
    
    public Feedback(int customerID, String comment, int starRating) {
        this.customerID = customerID;
        this.comment = comment;
        this.starRating = starRating;
//        this.customerUsername = customerUsername;
        this.customerUsername = getCustomerUsernameFromDB();
    }
    
    private String getCustomerUsernameFromDB(){
        try{
            PreparedStatement prep = con.prepareStatement("SELECT * FROM customer WHERE customer_id=?");
            prep.setString(1, this.customerID+"");
            
            ResultSet res = prep.executeQuery();
            res.next();
            String username = res.getString("username");
            
            return username;
        } catch (SQLException ex) {
            Logger.getLogger(Feedback.class.getName()).log(Level.SEVERE, null, ex);
        }
        return "Unknown";
    }

    public String getCustomerUsername() {
        return customerUsername;
    }
    

    public int getCustomerID() {
        return customerID;
    }

    public int getFeedbackID() {
        return feedbackID;
    }

    public void setFeedbackID(int feedbackID) {
        this.feedbackID = feedbackID;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public int getStarRating() {
        return starRating;
    }

    public void setStarRating(int starRating) {
        this.starRating = starRating;
    }

    public static void setCon(Connection con) {
        Feedback.con = con;
    }
    
    
}
