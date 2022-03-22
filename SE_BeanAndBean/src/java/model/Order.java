package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Order {
    private List<OrderItem> items;
    private int orderID;
    private int customerID;
    private String status;
    private double totalPrice;
    private String placed_at;
    private String street;
    private String barangay;
    private String city;
    private String region;
    private String firstName;
    private String lastName;
    private String email;
    private String phoneNumber;
    private Connection con;

    public Order(int customerID, double totalPrice, String street, String barangay, String city, String region, 
            String firstName, String lastName, String email, String phoneNumber, Connection con) {
        items = new ArrayList<>();
        this.orderID = orderID;
        this.customerID = customerID;
        this.status = "pending";
        this.totalPrice = totalPrice;
        this.placed_at = getDateTimeNow();
        this.street = street;
        this.barangay = barangay;
        this.city = city;
        this.region = region;
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.con = con;
        addOrderToDB();
    }
    
    public Order(int orderID, int customerID, String status, double totalPrice, String placed_at, String street, String barangay, String city, String region, 
            String firstName, String lastName, String email, String phoneNumber, Connection con) {
        
        items = new ArrayList<>();
        this.orderID = orderID;
        this.customerID = customerID;
        this.status = status;
        this.totalPrice = totalPrice;
        this.placed_at = placed_at;
        this.street = street;
        this.barangay = barangay;
        this.city = city;
        this.region = region;
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.con = con;
    }
    
    private void addOrderToDB(){
        try {
            System.out.println("IN ADD ORDER TO DB");
            
            PreparedStatement insert = con.prepareStatement("INSERT INTO orders(customer_id, status, total_price, placed_at, "
                    + "street, barangay, city, region, first_name, last_name, email, phone_number) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
            
            insert.setString(1, this.customerID+"");
            insert.setString(2, this.status+"");
            insert.setString(3, this.totalPrice+"");
            insert.setString(4, this.placed_at+"");
            insert.setString(5, this.street+"");
            insert.setString(6, this.barangay+"");
            insert.setString(7, this.city+"");
            insert.setString(8, this.region+"");
            insert.setString(9, this.firstName+"");
            insert.setString(10, this.lastName+"");
            insert.setString(11, this.email+"");
            insert.setString(12, this.phoneNumber+"");
            
            
            int affectedRows = insert.executeUpdate();
            
            System.out.println("AFFECTED ROWS: " + affectedRows);
            
            PreparedStatement lastRow = con.prepareStatement("SELECT * FROM orders WHERE order_id=(SELECT max(order_id) FROM orders)");
            ResultSet rs = lastRow.executeQuery();
            rs.next();
            
            this.orderID = Integer.parseInt(rs.getString("order_id"));
            
        } catch (SQLException ex) {
            Logger.getLogger(Order.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public void cancelOrder(){
        try{
            PreparedStatement insert = con.prepareStatement("UPDATE orders SET status = 'cancelled' WHERE order_id = ?");
            insert.setInt(1, this.orderID);
            insert.executeUpdate();
            
            this.status = "cancelled";
        }catch(SQLException ex){
            
        }
    }
    
    public void processOrder(){
        try{
            PreparedStatement insert = con.prepareStatement("UPDATE orders SET status = 'processing' WHERE order_id = ?");
            insert.setInt(1, this.orderID);
            insert.executeUpdate();
            
            this.status = "processing";
        }catch(SQLException ex){
            
        }
    }
    
    public void completeOrder(){
        try{
            PreparedStatement insert = con.prepareStatement("UPDATE orders SET status = 'completed' WHERE order_id = ?");
            insert.setInt(1, this.orderID);
            insert.executeUpdate();
            
            this.status = "completed";
        }catch(SQLException ex){
            
        }
    }
    
    public String getDateTimeNow(){
        ZonedDateTime zonedDateTimeNow = ZonedDateTime.now(ZoneId.of("Asia/Singapore"));
        String year = String.format("%04d", zonedDateTimeNow.getYear());
        String month = String.format("%02d", zonedDateTimeNow.getMonthValue());
        String day = String.format("%02d", zonedDateTimeNow.getDayOfMonth());
        String hour = String.format("%02d", zonedDateTimeNow.getHour());
        String minute = String.format("%02d", zonedDateTimeNow.getMinute());
        String second = String.format("%02d", zonedDateTimeNow.getSecond());
        String dateTime = year + "-" + month + "-" + day + " " + hour + ":" + minute + ":" + second;
        return dateTime;
    }
    
    public void addItem(OrderItem item){
        items.add(item);
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public List<OrderItem> getItems() {
        return items;
    }

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public int getCustomerID() {
        return customerID;
    }

    public void setCustomerID(int customerID) {
        this.customerID = customerID;
    }

    public String getPlaced_at() {
        return placed_at;
    }

    public void setPlaced_at(String placed_at) {
        this.placed_at = placed_at;
    }

    public String getStreet() {
        return street;
    }

    public void setStreet(String street) {
        this.street = street;
    }

    public String getBarangay() {
        return barangay;
    }

    public void setBarangay(String barangay) {
        this.barangay = barangay;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getRegion() {
        return region;
    }

    public void setRegion(String region) {
        this.region = region;
    }
}
