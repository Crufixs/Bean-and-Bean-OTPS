/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import controller.FeedbackServlet;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
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
    
    public Feedback(int feedbackID, int customerID, String comment, int starRating) {
        this.feedbackID = feedbackID;
        this.customerID = customerID;
        this.comment = comment;
        this.starRating = starRating;
        this.customerUsername = getCustomerUsernameFromDB();
    }
    
//    public Feedback(int customerID, String comment, int starRating) {
//        this.feedbackID = getFeedbackIDFromDB();
//        this.customerID = customerID;
//        this.comment = comment;
//        this.starRating = starRating;
//        this.customerUsername = getCustomerUsernameFromDB();
//    }
//    
//    public int getFeedbackIDFromDB(){
//        try{
//            PreparedStatement prep = con.prepareStatement("SELECT * FROM feedback");
//            prep.setString(1, this.customerID+"");
//            
//            ResultSet res = prep.executeQuery();
//            res.next();
//            String username = res.getString("username");
//            
//            return username;
//        } catch (SQLException ex) {
//            Logger.getLogger(Feedback.class.getName()).log(Level.SEVERE, null, ex);
//        }
//        return 0;
//    }
    
    public static void addFeedbackToDB(int customerID, String comment, int starRating){
                try{
            PreparedStatement insert = 
                    con.prepareStatement("INSERT INTO feedback(customer_id, comment, star_rating) VALUES (?, ?, ?)");
            
            insert.setString(1, customerID+"");
            insert.setString(2, comment);
            insert.setString(3, starRating+"");
            
            int affectedRows = insert.executeUpdate();

            
        } catch (SQLException ex) {
            Logger.getLogger(FeedbackServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public static ArrayList<Feedback> getFeedbackListFromDB(){
        int feedbackID;
        int customerID;
        String comment;
        int starRating;
        String customerUsername;
        ArrayList<Feedback> feedbackList = new ArrayList<>();
        
        try {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM feedback");
            ResultSet rs = ps.executeQuery();
            
            while(rs.next()){
                feedbackID = rs.getInt("feedback_id");
                customerID = rs.getInt("customer_id");
                comment = rs.getString("comment");
                starRating = rs.getInt("star_rating");
                
//                PreparedStatement prep = con.prepareStatement("SELECT * FROM customer WHERE customer_id=?");
//                prep.setString(1, customerID + "");
//
//                ResultSet res = prep.executeQuery();
//                res.next();
//                 customerUsername = res.getString("username");
                
                Feedback feedback = new Feedback(feedbackID, customerID, comment, starRating);
                
                feedbackList.add(feedback);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductList.class.getName()).log(Level.SEVERE, null, ex);
        }
        Collections.sort(feedbackList, Feedback.RecencyComparator);
        return feedbackList;
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
    
        public static Comparator<Feedback> RatingComparator = new Comparator<Feedback>() {
        public int compare(Feedback feedback1, Feedback feedback2) {

          int rating1 = feedback1.getStarRating();
          int rating2 = feedback2.getStarRating();

          //ascending order
          return rating2 - rating1;
          //descending order
          //return fruitName2.compareTo(fruitName1);
        }
    };
    
    public static Comparator<Feedback> RecencyComparator = new Comparator<Feedback>() {
        public int compare(Feedback feedback1, Feedback feedback2) {

          int id1 = feedback1.getFeedbackID();
          int id2 = feedback2.getFeedbackID();

          //ascending order
          return id1 - id2;
          //descending order
        }
    };

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
