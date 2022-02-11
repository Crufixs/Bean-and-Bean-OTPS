package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ProductList {

    private List<Product> products = new ArrayList<>();
    private Connection con;

    public ProductList(Connection con) {
        this.con = con;
        generateProducts();
    }

    public List<Product> getProducts() {
        return products;
    }
    
    //pag create mo ng ProductList object;
    private void generateProducts(){
        String id;
        String name;
        double price;
        String type;
        try {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM product");
            ResultSet rs = ps.executeQuery();
            
            while(rs.next()){
                id = rs.getString("product_id");
                name = rs.getString("product_name");
                price = rs.getDouble("product_price");
                type = rs.getString("product_type");
                Product p = new Product(id, name, price, type);
                products.add(p);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductList.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    //finds the product
    public Product findProduct(String id){
        for(Product p : products){
            if(id.equals(p.getId()))
                return p;
        }
        return null;
    }
}
