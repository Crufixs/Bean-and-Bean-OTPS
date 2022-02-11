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


//@WebServlet(name = "ReportServlet", urlPatterns = {"/Report"})
public class PDFServlet extends HttpServlet {
    Connection con = null;
    String txtHeader;
    String txtFooter;
    int pageCount = 1;
    String dateTime = "";
    User u;
    
    @Override
    public void init(ServletConfig config) throws ServletException{
        super.init(config);
        
        con = (Connection) getServletContext().getAttribute("connection");
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        
        //Current user in the session
        HttpSession session = request.getSession();
        u = (User) session.getAttribute("user");
        
        String choice = request.getParameter("type");
        
        //invalid access
        if(session.getAttribute("user") == null){
            response.sendRedirect("");
            return;
        } else if(choice == null){
            response.sendRedirect("error404.jsp");
            return;
        }
        
        //valid
        if(choice.equalsIgnoreCase("guest")){
            getCustomerOrders(request, response);
        } else if(choice.equalsIgnoreCase("admin") && u.getRole().equalsIgnoreCase("admin")){
            getAllOrders(request, response);
        } else if(choice.equalsIgnoreCase("receipt")){
            getReceipt(request, response);
        }
    }
    
    protected void getReceipt(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException{
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyyMMddHHmmss"); 
        DateTimeFormatter dtf2 = DateTimeFormatter.ofPattern("MM/dd/yyyy HH:mm:ss"); 
        LocalDateTime now = LocalDateTime.now();  
        dateTime = dtf2.format(now);
        String txtFileName = "receipt"+dtf.format(now) + ".pdf";
        
        Order o = (Order) request.getSession().getAttribute("order");
        if(o==null){
            System.out.println("NO ORDER");
            response.sendRedirect("shop.jsp");
            return;
        }
        
        
        PreparedStatement ps;
        boolean valid = true;
        int orderID = o.getOrderID();
        
         //header & footer
        txtHeader = "     BEAN & BEAN: Receipt for Order ID: " + orderID;
        txtFooter = txtFileName;
        
        Font bfBold12 = new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.BOLD, new BaseColor(0,0,0));
        Font bf12 = new Font(Font.FontFamily.TIMES_ROMAN, 12);
        Paragraph p = new Paragraph("Customer ID: " + u.getCustomerID() + "\n\n", bfBold12);
        
        
            
        try {
            ByteArrayOutputStream bout = new ByteArrayOutputStream();
            
            Document document = new Document(PageSize.A4.rotate(),20, 20, 50, 25);
            PdfWriter writer = PdfWriter.getInstance(document, bout);
            HeaderFooterPageEvent event = new HeaderFooterPageEvent();
            writer.setPageEvent(event);
            
            document.open();
            
            document.addTitle("Records");
            document.addSubject("Using iText");
            document.addKeywords("Java, PDF, iText");
            document.addAuthor("Gaite, Lumacad, Minano, Reodica");
            document.addCreator("Gaite, Lumacad, Minano, Reodica");
            
            document.add(p);
            
            //preparing the table for the records
            PdfPTable table = new PdfPTable(3);
            table.setWidthPercentage(90);
            table.setWidths(new int[]{3, 3, 3});
            

            PdfPCell hcell = new PdfPCell();
            hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(hcell);

            hcell = new PdfPCell();
            hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(hcell);
            
            hcell = new PdfPCell();
            hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(hcell);
            
            
            int recordCount = 0;
            
            if(valid){
                PreparedStatement getDetails = con.prepareStatement("SELECT * FROM orders WHERE order_id=?");
                getDetails.setString(1, orderID+"");
                ResultSet order = getDetails.executeQuery();
                order.next();
                double totalPrice = order.getDouble("total_price");
                String datePlaced = order.getString("placed_at");
                String name = order.getString("first_name") + " " + order.getString("last_name");
                String address = order.getString("street") + ", " + order.getString("barangay") + ", " + order.getString("city") + ", " + order.getString("region");
                String phoneNumber = order.getString("phone_number");
                String email = order.getString("email");

                document.add(new Paragraph(("Name: " + name), bfBold12));
                document.add(new Paragraph(("Address: " + address), bfBold12));
                document.add(new Paragraph(("Phone Number: " + phoneNumber), bfBold12));
                document.add(new Paragraph(("Email: " + email), bfBold12));
                document.add(new Paragraph(("Placed At: " + datePlaced), bfBold12));
                document.add(new Paragraph(("Total Price: " + totalPrice + " PESOS" + "\n\n"), bfBold12));
            }

            PreparedStatement total = con.prepareStatement("SELECT COUNT(*) AS TOTAL FROM order_item WHERE order_id=?");
            total.setString(1, orderID+"");
            ResultSet res = total.executeQuery();
            res.next();
            pageCount = res.getInt("TOTAL");
            
            if(pageCount == 0)
                pageCount = 1;

            PreparedStatement statement = con.prepareStatement("SELECT * FROM order_item WHERE order_id=?");
            statement.setString(1, orderID+"");
            ResultSet rs = statement.executeQuery();
            
            PdfPCell cell;
            
            cell = new PdfPCell(new Phrase("ORDER_ITEM_ID"));
            cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(cell);
            
            cell = new PdfPCell(new Phrase("PRODUCT_ID"));
            cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(cell);

            cell = new PdfPCell(new Phrase("QUANTITY"));
            cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
            cell.setHorizontalAlignment(Element.ALIGN_LEFT);
            table.addCell(cell);
            
            
            while(rs.next()){


                //Retrieve by column name
                String orderItemID = rs.getString("ORDER_ITEM_ID");
                String productID  = rs.getString("product_id");
                String quantity = rs.getString("quantity");
                
                cell = new PdfPCell(new Phrase(orderItemID));
                cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(cell);

                cell = new PdfPCell(new Phrase(productID));
                cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(cell);

                cell = new PdfPCell(new Phrase(quantity));
                cell.setPaddingLeft(5);
                cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
                cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                table.addCell(cell);
                
                recordCount++;
                if(recordCount == 20){
                   document.add(table);
                   document.newPage();
                   table.deleteBodyRows();
                   recordCount = 0;
//                   pageCount++;
                }
             }
            rs.close();
            
            document.add(table);
            document.close();
            
            response.setContentType("application/pdf");
             response.setHeader("Content-Type", "application/pdf");
             response.setHeader("Content-disposition", "inline; filename="+txtFileName);
            
            OutputStream sos = response.getOutputStream();

            bout.writeTo(sos);
            sos.flush();
            sos.close();
            bout.close();
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    protected void getAllOrders(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyyMMddHHmmss"); 
        DateTimeFormatter dtf2 = DateTimeFormatter.ofPattern("MM/dd/yyyy HH:mm:ss"); 
        LocalDateTime now = LocalDateTime.now();  
        dateTime = dtf2.format(now);
        String txtFileName = "allOrders"+dtf.format(now) + ".pdf";
        
        //header & footer
        txtHeader = "BEAN & BEAN ORDER HISTORY";
        txtFooter = txtFileName;
        
        
            
        try {
            ByteArrayOutputStream bout = new ByteArrayOutputStream();
            
            Document document = new Document(PageSize.A4.rotate(),20, 20, 50, 25);
            PdfWriter writer = PdfWriter.getInstance(document, bout);
            HeaderFooterPageEvent event = new HeaderFooterPageEvent();
            writer.setPageEvent(event);
            
            document.open();
            
            document.addTitle("Records");
            document.addSubject("Using iText");
            document.addKeywords("Java, PDF, iText");
            document.addAuthor("Gaite, Lumacad, Minano, Reodica");
            document.addCreator("Gaite, Lumacad, Minano, Reodica");
            
            //preparing the table for the records
            PdfPTable table = new PdfPTable(4);
            table.setWidthPercentage(90);
            table.setWidths(new int[]{3, 3, 3, 3});
            

            PdfPCell hcell = new PdfPCell();
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
            
            if(pageCount == 0)
                pageCount = 1;

            PreparedStatement statement = con.prepareStatement("SELECT * FROM orders");
            ResultSet rs = statement.executeQuery();
            
            PdfPCell cell;
            
            cell = new PdfPCell(new Phrase("CUSTOMER_ID"));
            cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(cell);
            
            cell = new PdfPCell(new Phrase("ORDER_ID"));
            cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(cell);

            cell = new PdfPCell(new Phrase("TOTAL PRICE"));
            cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
            cell.setHorizontalAlignment(Element.ALIGN_LEFT);
            table.addCell(cell);

            cell = new PdfPCell(new Phrase("DATE PLACED"));
            cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
            cell.setHorizontalAlignment(Element.ALIGN_LEFT);
            table.addCell(cell);
            
            
            while(rs.next()){
                //Retrieve by column name
                String customerID = rs.getString("customer_id");
                if(customerID == null)
                    customerID = "n/a";
                String orderID  = rs.getString("order_id");
                double totalPrice = Double.parseDouble(rs.getString("total_price"));
                String datePlaced = rs.getString("placed_at");
                
                cell = new PdfPCell(new Phrase(customerID));
                cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(cell);

                cell = new PdfPCell(new Phrase(orderID));
                cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(cell);

                cell = new PdfPCell(new Phrase(totalPrice+""));
                cell.setPaddingLeft(5);
                cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
                cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                table.addCell(cell);
                
                cell = new PdfPCell(new Phrase(datePlaced));
                cell.setPaddingLeft(5);
                cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
                cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                table.addCell(cell);
                
                recordCount++;
                if(recordCount == 20){
                   document.add(new Paragraph("\n\n\n"));
                   document.add(table);
                   document.newPage();
                   table.deleteBodyRows();
                   recordCount = 0;
//                   pageCount++;
                }
             }
            rs.close();
            
            document.add(table);
            document.close();
            
            response.setContentType("application/pdf");
             response.setHeader("Content-Type", "application/pdf");
             response.setHeader("Content-disposition", "inline; filename="+txtFileName);
            
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
        String txtFileName = "yourOrderHistory"+dtf.format(now) + ".pdf";
        
        //header & footer
        txtHeader = "ORDER HISTORY FOR " + u.getUsername();
        txtFooter = txtFileName;
        
 
        try {
            ByteArrayOutputStream bout = new ByteArrayOutputStream();
            
            Document document = new Document(PageSize.A4.rotate(),20, 20, 50, 25);
            PdfWriter writer = PdfWriter.getInstance(document, bout);
            HeaderFooterPageEvent event = new HeaderFooterPageEvent();
            writer.setPageEvent(event);
            
            document.open();
            
            document.addTitle("Records");
            document.addSubject("Using iText");
            document.addKeywords("Java, PDF, iText");
            document.addAuthor("Gaite, Lumacad, Minano, Reodica");
            document.addCreator("Gaite, Lumacad, Minano, Reodica");
            
            //preparing the table for the records
            PdfPTable table = new PdfPTable(3);
            table.setWidthPercentage(90);
            table.setWidths(new int[]{3, 3, 3});
            

            PdfPCell hcell = new PdfPCell();
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
            total.setString(1, u.getCustomerID()+"");
            ResultSet res = total.executeQuery();
            res.next();
            pageCount = res.getInt("TOTAL");
            
            if(pageCount == 0)
                pageCount = 1;

            PreparedStatement statement = con.prepareStatement("SELECT * FROM orders WHERE customer_id=?");
            statement.setString(1, u.getCustomerID()+"");

            ResultSet rs = statement.executeQuery();
            
            PdfPCell cell;
            
            cell = new PdfPCell(new Phrase("ORDER_ID"));
            cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(cell);

            cell = new PdfPCell(new Phrase("TOTAL PRICE"));
            cell.setPaddingLeft(5);
            cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
            cell.setHorizontalAlignment(Element.ALIGN_LEFT);
            table.addCell(cell);

            cell = new PdfPCell(new Phrase("DATE PLACED"));
            cell.setPaddingLeft(5);
            cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
            cell.setHorizontalAlignment(Element.ALIGN_LEFT);
            table.addCell(cell);
            
            
            while(rs.next()){
                //Retrieve by column name
                String orderID  = rs.getString("order_id");
                double totalPrice = Double.parseDouble(rs.getString("total_price"));
                String datePlaced = rs.getString("placed_at");

                cell = new PdfPCell(new Phrase(orderID));
                cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(cell);

                cell = new PdfPCell(new Phrase(totalPrice+""));
                cell.setPaddingLeft(5);
                cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
                cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                table.addCell(cell);
                
                cell = new PdfPCell(new Phrase(datePlaced));
                cell.setPaddingLeft(5);
                cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
                cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                table.addCell(cell);
                
                recordCount++;
                if(recordCount == 20){
                   document.add(table);
                   document.newPage();
                   table.deleteBodyRows();
                   recordCount = 0;
//                   pageCount++;
                }
             }
            rs.close();
            
            document.add(table);
            document.close();
            
            response.setContentType("application/pdf");
             response.setHeader("Content-Type", "application/pdf");
             response.setHeader("Content-disposition", "inline; filename="+txtFileName);
            
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
            ColumnText.showTextAligned(writer.getDirectContent(), Element.ALIGN_CENTER, new Phrase(txtHeader + " - " + dateTime), 160, 550, 0);
            //ColumnText.showTextAligned(writer.getDirectContent(), Element.ALIGN_CENTER, new Phrase("Top Right"), 800, 550, 0);
        }

        public void onEndPage(PdfWriter writer, Document document) {
            ColumnText.showTextAligned(writer.getDirectContent(), Element.ALIGN_CENTER, new Phrase(txtFooter), 110, 30, 0);
            ColumnText.showTextAligned(writer.getDirectContent(), Element.ALIGN_CENTER, new Phrase("Page " + document.getPageNumber() + " of " + (int) (Math.ceil(pageCount / 20.0))), 550, 30, 0);
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
