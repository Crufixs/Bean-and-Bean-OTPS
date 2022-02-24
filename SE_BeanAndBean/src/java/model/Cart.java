package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Cart {

    private static Connection con;
    private List<CartItem> cart = new ArrayList<>();
    private static ProductList productList;
    private int customer_id;
    private int cart_id;
    private int quantityInCart;
    private double totalPrice;

    public Cart(int customer_id) { //registered
        this.customer_id = customer_id;
        generateCart();
    }

//    public Cart() { //no account
//        this.quantityInCart = 0;
//        this.totalPrice = 0;
//        createNewCart();
//    }

    public CartItem findCartItem(String product_id) {
        for (CartItem c : cart) {
            if (c.getProduct().getId().equalsIgnoreCase(product_id)) {
                return c;
            }
        }
        return null;
    }

    public CartItem findCartItem(int cart_item_id) {
        for (CartItem c : cart) {
            if (c.getCartItemID() == cart_item_id) {
                return c;
            }
        }
        return null;
    }

    //removes cart from DB
    public void removeCartFromDB() {
        try {

            emptyCart();
            PreparedStatement remove = con.prepareStatement("DELETE FROM cart WHERE cart_id=?");
            remove.setString(1, this.cart_id + "");
            int affectedRows = remove.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(Cart.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    //kapag nagcheckout
    public void emptyCart() {
        try {
            PreparedStatement select = con.prepareStatement("SELECT * FROM cart_item WHERE cart_id=?");
            select.setString(1, this.cart_id + "");
            ResultSet rsSelect = select.executeQuery();

            while (rsSelect.next()) {
                String cart_item_id = rsSelect.getString("cart_item_id");

                PreparedStatement delete = con.prepareStatement("DELETE FROM cart_item WHERE cart_item_id=?");
                delete.setString(1, cart_item_id + "");
                int affectedRows = delete.executeUpdate();
            }

            PreparedStatement update = con.prepareStatement("UPDATE cart SET total_price=?, quantity=? WHERE cart_id=?");
            update.setString(1, 0 + "");
            update.setString(2, 0 + "");
            update.setString(3, this.cart_id + "");
            int affectedRows = update.executeUpdate();

            this.quantityInCart = 0;
            this.totalPrice = 0;
            this.cart.clear();

        } catch (SQLException ex) {
            Logger.getLogger(Cart.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    //add to cart
    public void addToCart(String product_id, int cartItemQuantity) {

        Product p = productList.findProduct(product_id);
        String name = p.getName();
        double price = p.getPrice() * cartItemQuantity;
        String type = p.getType();

        CartItem c = findCartItem(product_id);

        if (c != null) { //the product is already in the cart
            c.addQuantity();
            cartItemQuantity += c.getQuantity();

            try {
                PreparedStatement select = con.prepareStatement("SELECT * FROM cart_item WHERE cart_id=? AND product_id=?");
                select.setString(1, this.cart_id + "");
                select.setString(2, product_id);
                ResultSet rsSelect = select.executeQuery();

                rsSelect.next();

                String cart_item_id = rsSelect.getString("cart_item_id");

                PreparedStatement update = con.prepareStatement("UPDATE cart_item SET quantity=? WHERE cart_item_id=?");
                update.setString(1, cartItemQuantity + "");
                update.setString(2, cart_item_id + "");
                int affectedRows = update.executeUpdate();

            } catch (SQLException ex) {
                Logger.getLogger(Cart.class.getName()).log(Level.SEVERE, null, ex);
            }

        } else { //product not yet in the cart

            try {
                PreparedStatement insert = con.prepareStatement("INSERT INTO cart_item(product_id, cart_id, quantity) VALUES(?,?,?)");

                insert.setString(1, product_id);
                insert.setString(2, this.cart_id + "");
                insert.setString(3, cartItemQuantity + "");

                int affectedRows = insert.executeUpdate();

                PreparedStatement select = con.prepareStatement("SELECT * FROM cart_item WHERE cart_id=? AND product_id=?");
                select.setString(1, this.cart_id + "");
                select.setString(2, product_id);
                ResultSet rsSelect = select.executeQuery();

                rsSelect.next();

                int cart_item_id = Integer.parseInt(rsSelect.getString("cart_item_id"));

                Product productToCart = new Product(product_id, name, price, type);
                c = new CartItem(cart_item_id, productToCart, cartItemQuantity);
                cart.add(c);

            } catch (SQLException ex) {
                Logger.getLogger(Cart.class.getName()).log(Level.SEVERE, null, ex);
            }

        }

        this.quantityInCart++; //another product is added
        this.totalPrice += price; //total price of the cart increases

        try { //updating the cart database after adding the cartItem
            PreparedStatement ps2 = con.prepareStatement("UPDATE cart SET total_price=?, quantity=? WHERE cart_id=?");
            ps2.setString(1, this.totalPrice + "");
            ps2.setString(2, this.quantityInCart + "");
            ps2.setString(3, this.cart_id + "");
            int affectedRows = ps2.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(Cart.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public void removeFromCart(int cart_item_id) {
        CartItem c = findCartItem(cart_item_id);
        if (c != null) { //this if is not needed actually, for verification lang na nahanap talaga yung cartItem
            c.subtractQuantity();
            this.quantityInCart--;
            this.totalPrice -= c.getProduct().getPrice();

            //ubos na yung cart item na yun sa cart
            cart.remove(c);

            try {
                PreparedStatement select = con.prepareStatement("SELECT * FROM cart_item WHERE cart_item_id=?");
                select.setString(1, cart_item_id + "");
                ResultSet rsSelect = select.executeQuery();
                rsSelect.next();

                int cartItemQuantity = Integer.parseInt(rsSelect.getString("quantity"));
                PreparedStatement update = con.prepareStatement("UPDATE cart_item SET quantity=? WHERE cart_item_id=?");
                update.setString(1, (cartItemQuantity - 1) + "");
                update.setString(2, cart_item_id + "");
                int affectedRows = update.executeUpdate();

                PreparedStatement ps2 = con.prepareStatement("UPDATE cart SET total_price=?, quantity=? WHERE cart_id=?");
                ps2.setString(1, this.totalPrice + "");
                ps2.setString(2, this.quantityInCart + "");
                ps2.setString(3, this.cart_id + "");
                affectedRows = ps2.executeUpdate();
            } catch (SQLException ex) {
                Logger.getLogger(Cart.class.getName()).log(Level.SEVERE, null, ex);
            }

        }
    }

    private void generateCart() {
        try {
            PreparedStatement psCart = con.prepareStatement("SELECT * FROM cart WHERE customer_id = ?");
            psCart.setString(1, customer_id + "");
            ResultSet rsCart = psCart.executeQuery();

            if (rsCart.next()) { //may cart na yung customer
                this.cart_id = Integer.parseInt(rsCart.getString("cart_id"));
                this.quantityInCart = Integer.parseInt(rsCart.getString("quantity"));
                this.totalPrice = Double.parseDouble(rsCart.getString("total_price"));

                PreparedStatement psCartItem = con.prepareStatement("SELECT * FROM cart_item WHERE cart_id=?");
                psCartItem.setString(1, cart_id + "");

                ResultSet rsCartItem = psCartItem.executeQuery();

                while (rsCartItem.next()) {
                    String product_id = rsCartItem.getString("product_id");
                    int quantity = Integer.parseInt(rsCartItem.getString("quantity"));
                    int cartItemID = Integer.parseInt(rsCartItem.getString("cart_item_id"));
                    Product p = productList.findProduct(product_id);
                    String name = p.getName();
                    double price = p.getPrice();
                    String type = p.getType();

                    Product productToCart = new Product(product_id, name, price, type);
                    cart.add(new CartItem(cartItemID, productToCart, quantity));
                }

            } else {//wala pang cart sa database -- gagawan palang
                PreparedStatement ps = con.prepareStatement("INSERT INTO cart(customer_id, total_price, quantity) VALUES(?,?,?)");
                ps.setString(1, this.customer_id + "");
                ps.setString(2, 0 + "");
                ps.setString(3, 0 + "");

                int affectedRows = ps.executeUpdate();
                this.quantityInCart = 0;
                this.totalPrice = 0;

                Statement s = con.createStatement();
                ResultSet rs = s.executeQuery("SELECT * FROM cart WHERE customer_id=" + this.customer_id);
                rs.next();
                this.cart_id = Integer.parseInt(rs.getString("cart_id"));
            }

        } catch (SQLException ex) {
            Logger.getLogger(ProductList.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

//    private void createNewCart() {
//        try {
//            PreparedStatement create = con.prepareStatement("INSERT INTO cart(total_price, quantity) VALUES (?,?)");
//            create.setString(1, this.totalPrice + "");
//            create.setString(2, this.quantityInCart + "0");
//            int affectedRows = create.executeUpdate();
//
//            PreparedStatement select = con.prepareStatement("SELECT * FROM cart WHERE cart_id=(SELECT max(cart_id) FROM cart)");
//            ResultSet rs = select.executeQuery();
//            rs.next();
//
//            int cart_id = Integer.parseInt(rs.getString("cart_id"));
//            this.cart_id = cart_id;
//            this.cart = new ArrayList<>();
//            this.customer_id = -1;
//
//        } catch (SQLException ex) {
//            Logger.getLogger(Cart.class.getName()).log(Level.SEVERE, null, ex);
//        }
//
//    }

    public List<CartItem> getCart() {
        return cart;
    }

    public ProductList getProductList() {
        return productList;
    }

    public int getCustomer_id() {
        return customer_id;
    }

    public int getCart_id() {
        return cart_id;
    }

    public int getQuantityInCart() {
        return quantityInCart;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public static Connection getCon() {
        return con;
    }

    public static void setCon(Connection con) {
        Cart.con = con;
    }

    public static void setProductList(ProductList productList) {
        Cart.productList = productList;
    }
}
