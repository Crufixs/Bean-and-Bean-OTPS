
package controller;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.*;
import javax.servlet.http.HttpSession;
import model.Cart;
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
//            Cart c = new Cart();
            
//            context.setAttribute("guestUser", u);
//            context.setAttribute("guestCart", c);
            
            
        } catch (ClassNotFoundException e){
            
        } catch (SQLException e){
            
        }
    }

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
