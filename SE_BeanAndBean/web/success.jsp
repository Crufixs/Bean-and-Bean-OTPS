<%-- 
    Document   : success
    Created on : 02 24, 22, 7:01:10 PM
    Author     : Marylaine Lumacad
--%>

<%@page import="model.User"%>
<!DOCTYPE html>
<html lang="en">
    <title>My Account | Bean&Bean</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-wEmeIV1mKuiNpC+IOBjI7aAzPcEZeedi5yW5f2yOq55WWLwNGmvvx4Um1vskeMj0" crossorigin="anonymous">
    <link rel="stylesheet" href="CSS/success.css">

    <%
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);

        User u = (User) session.getAttribute("user");
        if (u == null) {
            response.sendRedirect("home.jsp");
            return;

        } else if (u.getCustomerID() == -1) {
            response.sendRedirect("login.jsp");
            return;
        }

    %>  

</head>
<body style="background-color: #F0E7DE;">
    <!-- HEADER -->
    <%@include file="header.jsp" %>

    <div class="container">
        <main>
            <!-- account details -->
            <div class="row g-5">
                <div class="col-md-7 col-lg-7 order-md-last">
                    <h2 style="text-align: center;">Orders</h2>
                    <hr>
                    <div class="row align-items-center" style="font-weight: bold; text-align: center; margin-bottom: 12px;">
                        <div class="col">
                            PENDING
                            <span class="badge rounded-pill bg-danger">0</span>
                        </div>
                        <div class="col">
                            PROCESSING
                            <span class="badge rounded-pill bg-warning">0</span>
                        </div>
                        <div class="col">
                            COMPLETED
                            <span class="badge rounded-pill bg-success">0</span>
                        </div>
                    </div>  
                    <div class="row" style="text-align: center; margin-bottom: 12px;">
                        <div class="col overflow-auto" id="list-group-border">
                            <!-- <i>No pending orders.</i> -->
                            <ul class="list-group">
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    <b>Order 234</b>
                                    <div>
                                        <button type="button" class="btn btn-warning btn-sm rounded-pill" data-bs-toggle="tooltip" data-bs-placement="right" title="Processing"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-right" viewBox="0 0 16 16">
                                            <path fill-rule="evenodd" d="M1 8a.5.5 0 0 1 .5-.5h11.793l-3.147-3.146a.5.5 0 0 1 .708-.708l4 4a.5.5 0 0 1 0 .708l-4 4a.5.5 0 0 1-.708-.708L13.293 8.5H1.5A.5.5 0 0 1 1 8z"/>
                                            </svg></button>
                                    </div>
                                </li>
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    <b>Order 234</b>
                                    <div>
                                        <button type="button" class="btn btn-warning btn-sm rounded-pill" data-bs-toggle="tooltip" data-bs-placement="right" title="Processing"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-right" viewBox="0 0 16 16">
                                            <path fill-rule="evenodd" d="M1 8a.5.5 0 0 1 .5-.5h11.793l-3.147-3.146a.5.5 0 0 1 .708-.708l4 4a.5.5 0 0 1 0 .708l-4 4a.5.5 0 0 1-.708-.708L13.293 8.5H1.5A.5.5 0 0 1 1 8z"/>
                                            </svg></button>
                                    </div>
                                </li>
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    <b>Order 234</b>
                                    <div>
                                        <button type="button" class="btn btn-warning btn-sm rounded-pill" data-bs-toggle="tooltip" data-bs-placement="right" title="Processing"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-right" viewBox="0 0 16 16">
                                            <path fill-rule="evenodd" d="M1 8a.5.5 0 0 1 .5-.5h11.793l-3.147-3.146a.5.5 0 0 1 .708-.708l4 4a.5.5 0 0 1 0 .708l-4 4a.5.5 0 0 1-.708-.708L13.293 8.5H1.5A.5.5 0 0 1 1 8z"/>
                                            </svg></button>
                                    </div>
                                </li>
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    <b>Order 234</b>
                                    <div>
                                        <button type="button" class="btn btn-warning btn-sm rounded-pill" data-bs-toggle="tooltip" data-bs-placement="right" title="Processing"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-right" viewBox="0 0 16 16">
                                            <path fill-rule="evenodd" d="M1 8a.5.5 0 0 1 .5-.5h11.793l-3.147-3.146a.5.5 0 0 1 .708-.708l4 4a.5.5 0 0 1 0 .708l-4 4a.5.5 0 0 1-.708-.708L13.293 8.5H1.5A.5.5 0 0 1 1 8z"/>
                                            </svg></button>
                                    </div>
                                </li>
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    <b>Order 234</b>
                                    <div>
                                        <button type="button" class="btn btn-warning btn-sm rounded-pill" data-bs-toggle="tooltip" data-bs-placement="right" title="Processing"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-right" viewBox="0 0 16 16">
                                            <path fill-rule="evenodd" d="M1 8a.5.5 0 0 1 .5-.5h11.793l-3.147-3.146a.5.5 0 0 1 .708-.708l4 4a.5.5 0 0 1 0 .708l-4 4a.5.5 0 0 1-.708-.708L13.293 8.5H1.5A.5.5 0 0 1 1 8z"/>
                                            </svg></button>
                                    </div>
                                </li>
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    <b>Order 234</b>
                                    <div>
                                        <button type="button" class="btn btn-warning btn-sm rounded-pill" data-bs-toggle="tooltip" data-bs-placement="right" title="Processing"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-right" viewBox="0 0 16 16">
                                            <path fill-rule="evenodd" d="M1 8a.5.5 0 0 1 .5-.5h11.793l-3.147-3.146a.5.5 0 0 1 .708-.708l4 4a.5.5 0 0 1 0 .708l-4 4a.5.5 0 0 1-.708-.708L13.293 8.5H1.5A.5.5 0 0 1 1 8z"/>
                                            </svg></button>
                                    </div>
                                </li>
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    <b>Order 234</b>
                                    <div>
                                        <button type="button" class="btn btn-warning btn-sm rounded-pill" data-bs-toggle="tooltip" data-bs-placement="right" title="Processing"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-right" viewBox="0 0 16 16">
                                            <path fill-rule="evenodd" d="M1 8a.5.5 0 0 1 .5-.5h11.793l-3.147-3.146a.5.5 0 0 1 .708-.708l4 4a.5.5 0 0 1 0 .708l-4 4a.5.5 0 0 1-.708-.708L13.293 8.5H1.5A.5.5 0 0 1 1 8z"/>
                                            </svg></button>
                                    </div>
                                </li>
                            </ul>
                        </div>
                        <div class="col overflow-auto" id="list-group-border">
                            <i>No processing orders.</i>
                            <!-- <ul class="list-group">
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    <b>Order 234</b>
                                    <div>
                                        <button type="button" class="btn btn-success btn-sm rounded-pill" data-bs-toggle="tooltip" data-bs-placement="right" title="Completed">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-check2" viewBox="0 0 16 16">
                                            <path d="M13.854 3.646a.5.5 0 0 1 0 .708l-7 7a.5.5 0 0 1-.708 0l-3.5-3.5a.5.5 0 1 1 .708-.708L6.5 10.293l6.646-6.647a.5.5 0 0 1 .708 0z"/>
                                        </svg></button>
                                    </div>
                                 </li>
                            </ul> -->
                        </div>
                        <div class="col overflow-auto" id="list-group-border">
                            <!-- <i>No completed orders.</i> -->
                            <ul class="list-group">
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    <b>Order 512</b>
                                    <span class="badge bg-secondary rounded-pill">14 hrs ago</span>
                                </li>
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    <b>Order 512</b>
                                    <span class="badge bg-secondary rounded-pill">2 days ago</span>
                                </li>
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    <b>Order 512</b>
                                    <span class="badge bg-secondary rounded-pill">1 day ago</span>
                                </li>
                            </ul>
                        </div>
                    </div>  
                    <!-- <hr>-->                    
<!--                <p><b>Name:</b> <%= u.getFirstName() + " " + u.getLastName()%></p>
                    <p><b>Email:</b> <%= u.getEmail()%></p>
                    <p><b>Phone:</b> <%= u.getPhoneNumber()%></p>
                    <p><b>Address:</b> <%= u.getFullAddress()%></p>
                    -->
                </div>
                <div class="col-md-5 col-lg-5">
                    <div class="row align-items-center">
                        <div class="col">
                            <h2>My Account</h2>
                            <p>Welcome, <%= u.getUsername()%>!</p>
                        </div>
                        <div class="col">
                            <form method="POST" action="Logout" style="float: right;">
                                <button class="btn btn-outline-secondary btn-md" type="submit">LOGOUT</button>
                                <input type="hidden" name="access" value="valid">
                            </form>
                        </div>
                    </div> 
                    <br><br>
                    <% if (u.getRole().equalsIgnoreCase("admin")) {%>
                    <div class="mb-3">
                        <h5>Bean&Bean Transaction History</h5>
                        <hr>
                        <form method="POST" action="PDFServlet" target="_blank">
                            <button class="btn btn-outline-secondary btn-md" type="submit">Get Records</button>
                            <input type="hidden" name="type" value="admin">
                        </form>
                    </div>
                    <%}%>
                    <br>
                    <div class="mb-3">
                        <h5>Order History</h5>
                        <hr>
                        <form method="POST" action="PDFServlet" target="_blank">
                            <button class="btn btn-outline-secondary btn-md" type="submit">Get Records</button>
                            <input type="hidden" name="type" value="guest">
                        </form>
                    </div>
                </div>
                <!-- end of pdf -->
            </div>
            <br><br>
        </main>
    </div>
    <!-- Footer -->
    <%@include file="footer.jsp" %>
    <!-- Footer -->
</body>
</html>
