package model;

import java.util.regex.Pattern;

public class User 
{  
    private String username,password,role,firstName,lastName,email, phoneNumber, street, barangay, city, region; 
    private int customerID;
    private String fullAddress;

    public User() { //guest, no account
        this.username = "";
        this.password = "";
        this.role = "guest";
        this.firstName = "";
        this.lastName = "";
        this.email = "";
        this.phoneNumber = "";
        this.street = "";
        this.barangay = "";
        this.city = "";
        this.region = "NCR";
        this.customerID = -1;
        this.fullAddress = "";
    }
    
    public User(int customerID, String username, String password, String role, String firstName, String lastName, String email, String phoneNumber, 
            String street, String barangay, String city, String region) { //with account
        this.username = username;
        this.password = password;
        this.role = role;
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.street = street;
        this.barangay = barangay;
        this.city = city;
        this.region = region;
        this.customerID = customerID;
        this.fullAddress = street + ", " + barangay + ", " + city + ", " + region;
    }

    public String getFullAddress() {
        return fullAddress;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
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

    public int getCustomerID() {
        return customerID;
    }

    public void setCustomerID(int customerID) {
        this.customerID = customerID;
    }
     
    public void setRole(String role){
        this.role = role;
    }

    public String getUsername()
    {
        return this.username;
    }
    
    public String getRole()
    {
        return this.role;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
    
    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }
}  