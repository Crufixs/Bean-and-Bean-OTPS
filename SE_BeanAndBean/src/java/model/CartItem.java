package model;
public class CartItem {
    private int cartItemID;
    private Product product;
    private int quantity;
    private double cartItemPrice;

    public CartItem(int cartItemID, Product product, int quantity) {
        this.cartItemID = cartItemID;
        this.product = product;
        this.quantity = quantity;
        this.cartItemPrice = product.getPrice() * quantity;
    }

    public double getCartItemPrice() {
        return cartItemPrice;
    }

    public void setCartItemPrice(double cartItemPrice) {
        this.cartItemPrice += cartItemPrice;
    }

    public int getCartItemID() {
        return cartItemID;
    }

    public void setCartItemID(int cartItemID) {
        this.cartItemID = cartItemID;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    
    public void addQuantity(int quantity){
        this.quantity+=quantity;
        this.cartItemPrice = this.quantity*this.product.getPrice();
    }
    
    public void subtractQuantity(int quantity){
        this.quantity-=quantity;
        this.cartItemPrice = this.quantity*this.product.getPrice();
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }
}
