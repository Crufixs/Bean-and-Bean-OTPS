package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class OrderItem {
    private int orderID;
    private Connection con;
    private Product product;
    private int quantity;

    public OrderItem(Product product, int quantity, int orderID, Connection con) {
        this.product = product;
        this.quantity = quantity;
        this.con = con;
        this.orderID = orderID;
        addOrderItemToDB();
    }

    
    public void addOrderItemToDB(){
        try {
            PreparedStatement insert = con.prepareStatement("INSERT INTO order_item(order_id, product_id, quantity) VALUES (?, ?, ?)");
            insert.setString(1, this.orderID+"");
            insert.setString(2, this.product.getId()+"");
            insert.setString(3, this.quantity+"");
            
            int affectedRows = insert.executeUpdate();
            
            
        } catch (SQLException ex) {
            Logger.getLogger(OrderItem.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    
    
}
