package controller;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Document;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.ColumnText;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfPageEventHelper;
import com.itextpdf.text.pdf.PdfWriter;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Order;
import model.User;
import com.itextpdf.text.Image;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.PdfContentByte;
import java.io.FileOutputStream;

//@WebServlet(name = "ReportServlet", urlPatterns = {"/Report"})
public class PDFServlet extends HttpServlet {

    Connection con = null;
    String txtHeader;
    String txtFooter;
    int pageCount = 1;
    String dateTime = "";
    User u;

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);

        con = (Connection) getServletContext().getAttribute("connection");
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");

        //Current user in the session
        HttpSession session = request.getSession();
        u = (User) session.getAttribute("user");
        String userType = u.getRole();

        String accountRecord = request.getParameter("type");
        String admin = request.getParameter("view");

        //invalid access
        if (u == null) {
            System.out.println("User Null");
            response.sendRedirect("");
            return;
        } else if (accountRecord == null && admin == null) {
            response.sendRedirect("error404.jsp");
            return;
        }

        //valid
        if (accountRecord != null) { //from getting records
            if (accountRecord.equalsIgnoreCase("guest") && userType.equals("guest")) {
                getCustomerOrders(request, response);
                return;
            } else if (accountRecord.equalsIgnoreCase("admin") && u.getRole().equalsIgnoreCase("admin")) {
                getAllOrders(request, response);
                return;
            } else if (accountRecord.equalsIgnoreCase("receipt")) {
                Order o = (Order) request.getSession().getAttribute("order");
                getReceipt(o, request, response);
                return;
            }
        } else if (admin != null) { //viewing order
            try {

                List<Order> orderList = (List) request.getSession().getAttribute("orderList");
                System.out.println("+" + admin + "+");
                int orderID = Integer.parseInt(admin);
                Order order = orderList.get(orderID);
                getReceipt(order, request, response);
                return;
            } catch (NumberFormatException e) {
                System.out.println("NFE");
                response.sendRedirect("");
                return;
            }
        }
        response.sendRedirect("");
    }

    protected void getReceipt(Order order, HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");
        DateTimeFormatter dtf2 = DateTimeFormatter.ofPattern("MM/dd/yyyy HH:mm:ss");
        LocalDateTime now = LocalDateTime.now();
        dateTime = dtf2.format(now);
        String txtFileName = "receipt" + dtf.format(now) + ".pdf";

        Order o = order;

        if (o == null) {
            System.out.println("NO ORDER");
            response.sendRedirect("");
            return;
        }

        PreparedStatement ps;
        boolean valid = true;
        int orderID = o.getOrderID();

        //header & footer
        txtHeader = "     BEAN & BEAN: Receipt for Order ID: " + orderID;
        txtFooter = dateTime;

        try {

            ByteArrayOutputStream bout = new ByteArrayOutputStream();

            Document document = new Document(PageSize.A4.rotate(), 20, 20, 50, 25);
            PdfWriter writer = PdfWriter.getInstance(document, bout);
            HeaderFooterPageEvent event = new HeaderFooterPageEvent();
            writer.setPageEvent(event);

            document.open();

            
            document.addTitle("Records");
            document.addSubject("Using iText");
            document.addKeywords("Java, PDF, iText");
            
            String relativeWebPath = "/fonts/Hypermarket-Bold.ttf";
            String absoluteDiskPath = getServletContext().getRealPath(relativeWebPath);
            BaseFont baseFont = BaseFont.createFont(absoluteDiskPath, BaseFont.IDENTITY_H, true);
            Font receipt = new Font(baseFont, 12);
            Font receipt2 = new Font(baseFont,15);
            
            PreparedStatement getDetails = con.prepareStatement("SELECT * FROM orders WHERE order_id=?");
            getDetails.setString(1, orderID + "");
            ResultSet orders = getDetails.executeQuery();
            orders.next();
            String datePlaced = orders.getString("placed_at");
            String name = orders.getString("first_name") + " " + orders.getString("last_name");
            String address = orders.getString("street") + ", " + orders.getString("barangay") + ", " + orders.getString("city") + ", " + orders.getString("region");
            String phoneNumber = orders.getString("phone_number");
            String email = orders.getString("email");

            //preparing the table for the records
            PdfPTable table = new PdfPTable(3);
            table.setWidthPercentage(90);
            table.setWidths(new int[]{3, 3, 3});

            PdfPCell hcell = new PdfPCell(new Paragraph("Customer: " + name, receipt));
            hcell.setColspan(2);
            hcell.setBorder(0);
            table.addCell(hcell);

            hcell = new PdfPCell(new Paragraph("Ship To: " + address, receipt));
            hcell.setColspan(3); // colspan 
            hcell.setBorder(0);
            table.addCell(hcell);

            hcell = new PdfPCell(new Paragraph("Customer ID: " + u.getCustomerID(), receipt));
            hcell.setColspan(2); // colspan 
            hcell.setBorder(0);
            table.addCell(hcell);

            hcell = new PdfPCell(new Paragraph("Contact Number: " + phoneNumber, receipt));
            hcell.setColspan(3); // colspan 
            hcell.setBorder(0);
            table.addCell(hcell);

            hcell = new PdfPCell(new Paragraph("Email: " + email, receipt));
            hcell.setColspan(2); // colspan 
            hcell.setBorder(0);
            hcell.setPaddingBottom(20);
            table.addCell(hcell);

            hcell = new PdfPCell(new Paragraph("Date of Order: " + datePlaced, receipt));
            hcell.setColspan(3); // colspan 
            hcell.setPaddingBottom(20);
            hcell.setBorder(0);
            table.addCell(hcell);

            hcell = new PdfPCell(new Paragraph("Receipt for Order ID: " + o.getOrderID(), receipt2));
            hcell.setColspan(3); // colspan
            hcell.setPaddingBottom(10);
            hcell.setPaddingTop(5);
            hcell.setBorderWidthBottom(0);
            hcell.setBorderWidthRight(0);
            hcell.setBorderWidthLeft(0);
            hcell.setBorderWidthTop(1);
            hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(hcell);

            hcell = new PdfPCell();
            hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(hcell);

            hcell = new PdfPCell();
            hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(hcell);

            hcell = new PdfPCell();
            hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(hcell);

            int recordCount = 0;

            PreparedStatement total = con.prepareStatement("SELECT COUNT(*) AS TOTAL FROM order_item WHERE order_id=?");
            total.setString(1, orderID + "");
            ResultSet res = total.executeQuery();
            res.next();
            pageCount = res.getInt("TOTAL");

            if (pageCount == 0) {
                pageCount = 1;
            }

            //PreparedStatement statement = con.prepareStatement("SELECT * FROM order_item WHERE order_id=?");
            PreparedStatement statement = con.prepareStatement("SELECT order_item.ORDER_ID,product.PRODUCT_NAME, order_item.QUANTITY, product.PRODUCT_PRICE FROM order_item LEFT JOIN product ON order_item.PRODUCT_ID = product.PRODUCT_ID WHERE order_id=?");
            statement.setString(1, orderID + "");
            ResultSet rs = statement.executeQuery();

            PdfPCell cell;

            /*cell = new PdfPCell(new Phrase("ORDER_ITEM_ID:", receipt));
            cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
            cell.setBorder(0);
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(cell);*/

            /*cell = new PdfPCell(new Phrase("PRODUCT_ID:", receipt));
            cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
            cell.setBorder(0);
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(cell);*/
            
            cell = new PdfPCell(new Phrase("PRODUCT_NAME:", receipt));
            cell.setBorder(0);
            cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(cell);
            
            cell = new PdfPCell(new Phrase("QUANTITY:", receipt));
            cell.setBorder(0);
            cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(cell);
            
           
            
            cell = new PdfPCell(new Phrase("PRICE:", receipt));
            cell.setBorder(0);
            cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(cell);

            while (rs.next()) {

                //Retrieve by column name
                //String orderItemID = rs.getString("ORDER_ITEM_ID");
                //String productID = rs.getString("product_id");
                String quantity = rs.getString("quantity");
                String pname = rs.getString("product_name");
                String price = rs.getString("product_price");

                /*cell = new PdfPCell(new Phrase(orderItemID, receipt));
                cell.setBorder(0);
                cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(cell);*/

                /*cell = new PdfPCell(new Phrase(productID, receipt));
                cell.setBorder(0);
                cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(cell);*/
                
                cell = new PdfPCell(new Phrase(pname, receipt));
                cell.setPaddingLeft(5);
                cell.setBorder(0);
                cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(cell);

                cell = new PdfPCell(new Phrase(quantity, receipt));
                cell.setPaddingLeft(5);
                cell.setBorder(0);
                cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(cell);
                
                cell = new PdfPCell(new Phrase("P"+Double.toString(Double.parseDouble(price)*Double.parseDouble(quantity)), receipt));
                cell.setPaddingLeft(5);
                cell.setBorder(0);
                cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(cell);
                
                recordCount++;
                if (recordCount == 10) {
                    document.add(table);
                    document.newPage();
                    table.deleteBodyRows();
                    recordCount = 0;
//                   pageCount++;
                }
            }
            rs.close();

            double totalPrice = orders.getDouble("total_price");

            cell = new PdfPCell(new Phrase("Total Price: ", receipt));
            cell.setColspan(2); // colspan 
            cell.setBorderWidthBottom(0);
            cell.setBorderWidthRight(0);
            cell.setBorderWidthLeft(0);
            cell.setBorderWidthTop(1);
            table.addCell(cell);

            cell = new PdfPCell(new Phrase("P" + totalPrice, receipt));
            cell.setBorderWidthBottom(0);
            cell.setBorderWidthRight(0);
            cell.setBorderWidthLeft(0);
            cell.setBorderWidthTop(1);
            cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(cell);

            document.add(table);
            document.close();

            response.setContentType("application/pdf");
            response.setHeader("Content-Type", "application/pdf");
            response.setHeader("Content-disposition", "inline; filename=" + txtFileName);

            OutputStream sos = response.getOutputStream();

            bout.writeTo(sos);
            sos.flush();
            sos.close();
            bout.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void getAllOrders(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");
        DateTimeFormatter dtf2 = DateTimeFormatter.ofPattern("MM/dd/yyyy HH:mm:ss");
        LocalDateTime now = LocalDateTime.now();
        dateTime = dtf2.format(now);
        String txtFileName = "allOrders" + dtf.format(now) + ".pdf";

        //header & footer
        txtHeader = "BEAN & BEAN ORDER HISTORY";
        txtFooter = dateTime;

        try {
            ByteArrayOutputStream bout = new ByteArrayOutputStream();

            Document document = new Document(PageSize.A4.rotate(), 20, 20, 50, 25);
            PdfWriter writer = PdfWriter.getInstance(document, bout);
            HeaderFooterPageEvent event = new HeaderFooterPageEvent();
            writer.setPageEvent(event);

            document.open();

            document.addTitle("Records");
            document.addSubject("Using iText");
            document.addKeywords("Java, PDF, iText");

           
            
            String relativeWebPath = "/fonts/BebasNeue.ttf";
            String absoluteDiskPath = getServletContext().getRealPath(relativeWebPath);
            BaseFont baseFont = BaseFont.createFont(absoluteDiskPath, BaseFont.IDENTITY_H, true);
            Font font = new Font(baseFont, 12);
            
            String relativeWebPath2 = "/fonts/BebasNeue.ttf";
            String absoluteDiskPath2 = getServletContext().getRealPath(relativeWebPath2);
            BaseFont baseFont2 = BaseFont.createFont(absoluteDiskPath2, BaseFont.IDENTITY_H, true);
            Font tablehead = new Font(baseFont2, 15);
            
            //preparing the table for the records
            PdfPTable table = new PdfPTable(6);
            table.setWidthPercentage(90);
            table.setWidths(new int[]{3, 3, 3, 3, 3, 3});

            PdfPCell hcell = new PdfPCell(new Paragraph("Past Transactions of Bean & Bean Customers",tablehead));
            hcell.setColspan(6); // colspan 
            hcell.setPaddingBottom(5);
            hcell.setPaddingTop(5);
            hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
            hcell.setBackgroundColor(new BaseColor(155, 129, 109));
            table.addCell(hcell);

            hcell = new PdfPCell();
            hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(hcell);

            hcell = new PdfPCell();
            hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(hcell);

            hcell = new PdfPCell();
            hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(hcell);

            hcell = new PdfPCell();
            hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(hcell);
            
            hcell = new PdfPCell();
            hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(hcell);
            
            hcell = new PdfPCell();
            hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(hcell);

            int recordCount = 0;

            PreparedStatement total = con.prepareStatement("SELECT COUNT(*) AS TOTAL FROM orders");
            ResultSet res = total.executeQuery();
            res.next();
            pageCount = res.getInt("TOTAL");

            if (pageCount == 0) {
                pageCount = 1;
            }

            PreparedStatement statement = con.prepareStatement("SELECT orders.customer_id, customer.first_name, customer.last_name, orders.order_id, orders.total_price, orders.placed_at, orders.status FROM orders LEFT JOIN customer ON orders.customer_id = customer.customer_id");
            ResultSet rs = statement.executeQuery();

            PdfPCell cell;

            cell = new PdfPCell(new Phrase("CUSTOMER ID", font));
            cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(cell);
            
            cell = new PdfPCell(new Phrase("CUSTOMER NAME", font));
            cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(cell);
            
            cell = new PdfPCell(new Phrase("ORDER ID", font));
            cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(cell);

            cell = new PdfPCell(new Phrase("TOTAL PRICE", font));
            cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(cell);

            cell = new PdfPCell(new Phrase("ORDER PLACED", font));
            cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(cell);
            
             cell = new PdfPCell(new Phrase("STATUS", font));
            cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(cell);


            while (rs.next()) {
                //Retrieve by column name
                String customerID = rs.getString("customer_id");
                if (customerID == null) {
                    customerID = "n/a";
                }
                String orderID = rs.getString("order_id");
                double totalPrice = Double.parseDouble(rs.getString("total_price"));
                String datePlaced = rs.getString("placed_at");
                String fname = rs.getString("first_name");
                String lname = rs.getString("last_name");
                String status = rs.getString("status");

                cell = new PdfPCell(new Phrase(customerID, font));
                cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(cell);
                
                cell = new PdfPCell(new Phrase(fname + " " + lname, font));
                cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(cell);

                cell = new PdfPCell(new Phrase(orderID, font));
                cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(cell);

                cell = new PdfPCell(new Phrase(totalPrice + "", font));
                cell.setPaddingLeft(5);
                cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(cell);

                cell = new PdfPCell(new Phrase(datePlaced, font));
                cell.setPaddingLeft(5);
                cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(cell);
                
                cell = new PdfPCell(new Phrase(status, font));
                cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(cell);
                
                recordCount++;
                if (recordCount == 10) {
                    document.add(new Paragraph("\n\n\n"));
                    document.add(table);
                    document.newPage();
                    table.deleteBodyRows();
                    
                    cell = new PdfPCell(new Paragraph("Past Transactions of Bean & Bean Customers",tablehead));
                    cell.setColspan(6); // colspan 
                    cell.setPaddingBottom(5);
                    cell.setPaddingTop(5);
                    cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                    cell.setBackgroundColor(new BaseColor(155, 129, 109));
                    table.addCell(cell);
                    
                    recordCount = 0;
//                   pageCount++;
                }
            }
            rs.close();

            document.add(table);
            document.close();

            response.setContentType("application/pdf");
            response.setHeader("Content-Type", "application/pdf");
            response.setHeader("Content-disposition", "inline; filename=" + txtFileName);

            OutputStream sos = response.getOutputStream();

            bout.writeTo(sos);
            sos.flush();
            sos.close();
            bout.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void getCustomerOrders(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");
        DateTimeFormatter dtf2 = DateTimeFormatter.ofPattern("MM/dd/yyyy HH:mm:ss");
        LocalDateTime now = LocalDateTime.now();
        dateTime = dtf2.format(now);
        String txtFileName = "yourOrderHistory" + dtf.format(now) + ".pdf";

        //header & footer
        txtHeader = "ORDER HISTORY FOR " + u.getUsername();
        txtFooter = dateTime;

        try {
            ByteArrayOutputStream bout = new ByteArrayOutputStream();

            Document document = new Document(PageSize.A4.rotate(), 20, 20, 50, 25);
            PdfWriter writer = PdfWriter.getInstance(document, bout);
            HeaderFooterPageEvent event = new HeaderFooterPageEvent();
            writer.setPageEvent(event);

            document.open();
            
            
            
                
            document.addTitle("Records");
            document.addSubject("Using iText");
            document.addKeywords("Java, PDF, iText");
             
            
            
            String relativeWebPath = "/fonts/BebasNeue.ttf";
            String absoluteDiskPath = getServletContext().getRealPath(relativeWebPath);
            BaseFont baseFont = BaseFont.createFont(absoluteDiskPath, BaseFont.IDENTITY_H, true);
            Font font2 = new Font(baseFont, 12);
            
            String relativeWebPath2 = "/fonts/BebasNeue.ttf";
            String absoluteDiskPath2 = getServletContext().getRealPath(relativeWebPath2);
            BaseFont baseFont2 = BaseFont.createFont(absoluteDiskPath2, BaseFont.IDENTITY_H, true);
            Font tablehead = new Font(baseFont2, 15);
            
            //preparing the table for the records
            PdfPTable table = new PdfPTable(4);
            table.setWidthPercentage(90);
            table.setWidths(new int[]{3, 3, 3, 3});

            PdfPCell hcell = new PdfPCell(new Paragraph("Order History of " + u.getFirstName() + " " + u.getLastName(), tablehead));
            hcell.setColspan(4); // colspan
            hcell.setPaddingBottom(5);
            hcell.setPaddingTop(5);
            hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
            hcell.setBackgroundColor(new BaseColor(155, 129, 109));
            table.addCell(hcell);

            hcell = new PdfPCell();
            hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(hcell);

            hcell = new PdfPCell();
            hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(hcell);

            hcell = new PdfPCell();
            hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(hcell);
            
            hcell = new PdfPCell();
            hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(hcell);

            int recordCount = 0;

            PreparedStatement total = con.prepareStatement("SELECT COUNT(*) AS TOTAL FROM orders WHERE customer_id=?");
            total.setString(1, u.getCustomerID() + "");
            ResultSet res = total.executeQuery();
            res.next();
            pageCount = res.getInt("TOTAL");

            if (pageCount == 0) {
                pageCount = 1;
            }

            PreparedStatement statement = con.prepareStatement("SELECT orders.order_id, orders.total_price, orders.placed_at, orders.status FROM orders WHERE customer_id=?");
            statement.setString(1, u.getCustomerID() + "");

            ResultSet rs = statement.executeQuery();

            PdfPCell cell;

            cell = new PdfPCell(new Phrase("ORDER_ID", font2));
            cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(cell);

            cell = new PdfPCell(new Phrase("TOTAL PRICE", font2));
            cell.setPaddingLeft(5);
            cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(cell);

            cell = new PdfPCell(new Phrase("ORDER PLACED", font2));
            cell.setPaddingLeft(5);
            cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(cell);
             
            cell = new PdfPCell(new Phrase("STATUS", font2));
            cell.setPaddingLeft(5);
            cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(cell);
            
            while (rs.next()) {
                //Retrieve by column name
                String orderID = rs.getString("order_id");
                double totalPrice = Double.parseDouble(rs.getString("total_price"));
                String datePlaced = rs.getString("placed_at");
                String status = rs.getString ("status");
                
                cell = new PdfPCell(new Phrase(orderID, font2));
                cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(cell);

                cell = new PdfPCell(new Phrase("P" + totalPrice + "", font2));
                cell.setPaddingLeft(5);
                cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(cell);

                cell = new PdfPCell(new Phrase(datePlaced, font2));
                cell.setPaddingLeft(5);
                cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(cell);
                
                cell = new PdfPCell(new Phrase(status, font2));
                cell.setPaddingLeft(5);
                cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(cell);

                recordCount++;
                if (recordCount == 10) {
                    
                    document.add(table);
                    document.newPage();
                    table.deleteBodyRows();
                    
                    cell = new PdfPCell(new Paragraph("Order History of " + u.getFirstName() + " " + u.getLastName(), tablehead));
                    cell.setColspan(4); // colspan
                    cell.setPaddingBottom(5);
                    cell.setPaddingTop(5);
                    cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                    cell.setBackgroundColor(new BaseColor(155, 129, 109));
                    table.addCell(cell);
                    
                    recordCount = 0;
//                   pageCount++;
                }
            }
            rs.close();

            document.add(table);
            document.close();

            response.setContentType("application/pdf");
            response.setHeader("Content-Type", "application/pdf");
            response.setHeader("Content-disposition", "inline; filename=" + txtFileName);

            OutputStream sos = response.getOutputStream();

            bout.writeTo(sos);
            sos.flush();
            sos.close();
            bout.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //header and footer of the PDF
    public class HeaderFooterPageEvent extends PdfPageEventHelper {
        
        public void onStartPage(PdfWriter writer, Document document) {
                
               try {
                 
                //Image img = Image.getInstance("C:/Users/Redd Ignacio/Documents/NetBeansProjects/SE_BeanAndBean/SE_BeanAndBean/web/Images/logo-plainblack(1).png");
                String relativeWebPath = "/images/logo-plainblack.png";
                String absoluteDiskPath = getServletContext().getRealPath(relativeWebPath);
                Image img =  Image.getInstance(absoluteDiskPath);
                img.scaleToFit(250, 200); 
                document.add(img);
               
                
              
                
                String relativeWebPath2 = "/fonts/AltmannGrotesk-Bold.ttf";
                String absoluteDiskPath2 = getServletContext().getRealPath(relativeWebPath2);
                BaseFont baseFont = BaseFont.createFont(absoluteDiskPath2, BaseFont.IDENTITY_H, true);
                Font fontheader = new Font(baseFont, 12);
                
                //ColumnText.showTextAligned(writer.getDirectContent(), Element.ALIGN_CENTER, new Phrase("BEAN & BEAN COFFEE", fontheader), 710, 450, 0);
                
            } catch (Exception x) {
                x.printStackTrace();
            }
            
            //ColumnText.showTextAligned(writer.getDirectContent(), Element.ALIGN_CENTER, new Phrase("Top Right"), 800, 550, 0);
        }

        public void onEndPage(PdfWriter writer, Document document) {
                try{
                    String relativeWebPath = "/fonts/BebasNeue.ttf";
                    String absoluteDiskPath = getServletContext().getRealPath(relativeWebPath);
                    BaseFont baseFont = BaseFont.createFont(absoluteDiskPath, BaseFont.IDENTITY_H, true);
                    Font font2 = new Font(baseFont, 12);
                    ColumnText.showTextAligned(writer.getDirectContent(), Element.ALIGN_CENTER, new Phrase("Generated at: " + txtFooter, font2), 130, 10, 0);
                    ColumnText.showTextAligned(writer.getDirectContent(), Element.ALIGN_CENTER, new Phrase("Page " + document.getPageNumber() + " of " + (int) (Math.ceil(pageCount / 10.0)),font2), 760, 10, 0);

                }
                catch(Exception x){
                    x.printStackTrace();
                }
            
        }

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
