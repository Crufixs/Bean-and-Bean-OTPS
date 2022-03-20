
package controller;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.*;
import javax.servlet.http.HttpSession;
import model.Cart;
import model.Feedback;
import model.Product;
import model.ProductList;
import model.User;
public class JDBCContextListener implements ServletContextListener{
    
    ServletContext context;
    Connection con;

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        context = sce.getServletContext();
        try{
//            System.out.print("HELLo");
            Class.forName(context.getInitParameter("jdbcClassName"));
            
            String dbUsername = context.getInitParameter("dbUsername");
            String dbPassword = context.getInitParameter("dbPassword");
            
            
            //Setting up the URL by getting the init parameters from the web.xml
            StringBuffer URL = new StringBuffer(context.getInitParameter("jdbcDriverURL"))
                                .append("://")
                                .append(context.getInitParameter("dbHostName"))
                                .append(":")
                                .append(context.getInitParameter("dbPort"))
                                .append("/")
                                .append(context.getInitParameter("dbName"));
            
            con = DriverManager.getConnection(URL.toString(), dbUsername, dbPassword);
            context.setAttribute("connection", con);
            
            ProductList pm = new ProductList(con);
            List<Product> products = pm.getProducts();
            context.setAttribute("productList", pm);
            context.setAttribute("products", products);
            
//            User u = new User();

            Cart.setCon(con);
            Cart.setProductList(pm);
            
            
            Feedback.setCon(con);
            ArrayList<Feedback> feedbackList = Feedback.getFeedbackListFromDB();
//            ArrayList<Feedback> feedbackList = new ArrayList<>();

//            FeedbackList fm = new FeedbackList(con);
//            List<Feedback> feedbackList = fm.getFeedbacks();
            context.setAttribute("feedbackList", feedbackList);
            
            
            
//            Cart c = new Cart();
            
//            context.setAttribute("guestUser", u);
//            context.setAttribute("guestCart", c);
            
            
        } catch (ClassNotFoundException e){
            
        } catch (SQLException e){
            
        }
    }
    
//    public ArrayList<Feedback> getFeedbackListFromDB(){
//        int customerID;
//        String comment;
//        int starRating;
//        String customerUsername;
//        ArrayList<Feedback> feedbackList = new ArrayList<>();
//        
//        try {
//            PreparedStatement ps = con.prepareStatement("SELECT * FROM feedback");
//            ResultSet rs = ps.executeQuery();
//            
//            while(rs.next()){
//                customerID = rs.getInt("customer_id");
//                comment = rs.getString("comment");
//                starRating = rs.getInt("star_rating");
//                
////                PreparedStatement prep = con.prepareStatement("SELECT * FROM customer WHERE customer_id=?");
////                prep.setString(1, customerID + "");
////
////                ResultSet res = prep.executeQuery();
////                res.next();
////                 customerUsername = res.getString("username");
//                
//                Feedback feedback = new Feedback(customerID, comment, starRating);
//                
//                feedbackList.add(feedback);
//            }
//        } catch (SQLException ex) {
//            Logger.getLogger(ProductList.class.getName()).log(Level.SEVERE, null, ex);
//        }
//        
//        return feedbackList;
//    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        System.out.println("Context destroyed.");
        
        try {
            con.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
    
}
