/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.sql.Connection;
import java.util.ArrayList;

/**
 *
 * @author Koby
 */
public class Feedback {
    private int feedbackID;
    private int customerID;
    private String comment;
    private int starRating;
    private static Connection con;
    private static ArrayList<Feedback> feedbackList;

    public Feedback(int customerID, String comment, int starRating) {
        this.customerID = customerID;
        this.comment = comment;
        this.starRating = starRating;
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
