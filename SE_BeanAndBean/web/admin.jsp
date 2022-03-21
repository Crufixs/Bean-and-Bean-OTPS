<%-- 
    Document   : success
    Created on : 02 24, 22, 7:01:10 PM
    Author     : Marylaine Lumacad
--%>

<%@page import="model.Order"%>
<%@page import="java.util.List"%>
<%@page import="model.Cart"%>
<%@page import="model.User"%>
<!DOCTYPE html>
<html lang="en">
    <title>My Account | Bean&Bean</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-wEmeIV1mKuiNpC+IOBjI7aAzPcEZeedi5yW5f2yOq55WWLwNGmvvx4Um1vskeMj0" crossorigin="anonymous">
    <link rel="stylesheet" href="CSS/admin.css">

    <%
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);

        User u = (User) session.getAttribute("user");
        List<Order> orderList  = (List) session.getAttribute("orderList");
        if (u == null) {
            response.sendRedirect("login.jsp");
            return;

        } else if (!u.getRole().equals("admin")) {
            response.sendRedirect("success.jsp");
            return;
        }
        

    %>  

</head>
<body class="d-flex flex-column min-vh-100" style="background-color: #F0E7DE;">
    <link rel="stylesheet" type="text/css" href = "CSS/webcss.css"/>
    <!-- HEADER -->
    <%--<%@include file="header.jsp" %>--%>
<!-- 
    <header class="flex-wrap align-items-center justify-content-center justify-content-md-between py-2 mb-3 accent-color"> -->
    <header>
        <nav class="navbar fixed-top navbar-expand-lg accent-color p-md-3">
            <div class="container">
                <a class="d-flex align-items-center mb-3 mb-md-0 me-md-auto text-white text-decoration-none">
                <img src="Images/Bean.png" width="50" height="50">
                &nbsp;<span class="fs-4">Bean&Bean</span></a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarTogglerDemo02" aria-controls="navbarTogglerDemo02" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <!-- ICONS -->
                <div id="login-dropdown" class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" id="navbarDropdownMenuLink" role="button" style="color: white;">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-box-arrow-right" viewBox="0 0 16 16">
                        <path fill-rule="evenodd" d="M10 12.5a.5.5 0 0 1-.5.5h-8a.5.5 0 0 1-.5-.5v-9a.5.5 0 0 1 .5-.5h8a.5.5 0 0 1 .5.5v2a.5.5 0 0 0 1 0v-2A1.5 1.5 0 0 0 9.5 2h-8A1.5 1.5 0 0 0 0 3.5v9A1.5 1.5 0 0 0 1.5 14h8a1.5 1.5 0 0 0 1.5-1.5v-2a.5.5 0 0 0-1 0v2z"/>
                        <path fill-rule="evenodd" d="M15.854 8.354a.5.5 0 0 0 0-.708l-3-3a.5.5 0 0 0-.708.708L14.293 7.5H5.5a.5.5 0 0 0 0 1h8.793l-2.147 2.146a.5.5 0 0 0 .708.708l3-3z"/>
                        </svg>
                    </a>
                    <ul id="login-dropdown-menu" class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                        <li>
                            <form id="logout-form" method="POST" action="Logout"><!-- 
                <a class="dropdown-item text-white" href="javascript:;" onclick="document.getElementById('logout-form').submit();">Logout</a> -->
                                <button type="submit" class="dropdown-item text-white">Logout</button>
                                <input type="hidden" name="access" value="valid">
                            </form>
                        </li>
                    </ul>
                </div>
            </div>
            </div>
        </nav>
    </header>

    <div class="container">
        <main style="margin-top: 100px;">
            <!-- account details -->
            <div class="row g-5" style="margin-bottom: 20px;">
                <div class="col-md-7 col-lg-7 order-md-last">
                    <h2 style="text-align: center;">Orders</h2>
                    <hr>
                    <div class="row align-items-center" style="font-weight: bold; text-align: center; margin-bottom: 12px;">
                        <%
                            int pending = 0;
                            int processing = 0;
                            int completed = 0;
                            for(int i=0; i<orderList.size(); i++){
                                
                                if(orderList.get(i).getStatus() == null){
                                    break;
                                } else if(orderList.get(i).getStatus().equals("pending")){
                                    pending++;
                                } else if(orderList.get(i).getStatus().equals("processing")){
                                    processing++;
                                } else if(orderList.get(i).getStatus().equals("completed")){
                                    completed++;
                                } 
                            }
                        %>
                        <div class="col">
                            PENDING
                            <span class="badge rounded-pill bg-danger"><%out.print(pending);%></span>
                        </div>
                        <div class="col">
                            PROCESSING
                            <span class="badge rounded-pill bg-warning"><%out.print(processing);%></span>
                        </div>
                        <div class="col">
                            COMPLETED
                            <span class="badge rounded-pill bg-success"><%out.print(completed);%></span>
                        </div>
                    </div>  
                    <div class="row" style="text-align: center; margin-bottom: 12px;">
                        <div class="col overflow-auto" id="list-group-border">
                            <!-- <i>No pending orders.</i> -->
                            <ul class="list-group" style="width: 200px;">
                                <%
                                for(int i=0; i<orderList.size(); i++){
                                    String status = orderList.get(i).getStatus();
                                    if(status != null && status.equals("pending")){
                                %>
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    <form method="POST" action="PDFServlet" target="_blank">
                                        <button class="btn btn-sm fw-bold" type="submit" name="view" value="<%out.print(i);%>">
                                            Order <%out.print(orderList.get(i).getOrderID()); %>
                                        </button>
                                    </form>
                                    <div>
                                        <form method="POST" action="ManageOrder">
                                            <button name="cancel" value="<%out.print(i);%>" type="submit" class="btn btn-danger btn-sm rounded-pill" data-bs-toggle="tooltip" data-bs-placement="right" title="Pending"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-x" viewBox="0 0 16 16">
                                            <path d="M4.646 4.646a.5.5 0 0 1 .708 0L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 0 1 0-.708z"/>
                                            </svg></button>
                                            <button name="process" value="<%out.print(i);%>" type="submit" class="btn btn-warning btn-sm rounded-pill" data-bs-toggle="tooltip" data-bs-placement="right" title="Pending"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-right" viewBox="0 0 16 16">
                                            <path fill-rule="evenodd" d="M1 8a.5.5 0 0 1 .5-.5h11.793l-3.147-3.146a.5.5 0 0 1 .708-.708l4 4a.5.5 0 0 1 0 .708l-4 4a.5.5 0 0 1-.708-.708L13.293 8.5H1.5A.5.5 0 0 1 1 8z"/>
                                            </svg></button>
                                        </form>
                                    </div>
                                </li>
                                <%
                                    }
                                }
                                %>
                            </ul>
                        </div>
                        <div class="col overflow-auto" id="list-group-border">
                            <!--<i>No processing orders.</i>-->
                             <ul class="list-group">
                                 <%
                                for(int i=0; i<orderList.size(); i++){
                                    String status = orderList.get(i).getStatus();
                                    if(status != null && status.equals("processing")){
                                %>
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    <!--  <input class="btn btn-sm fw-bold" type="submit" value="Order 234"> -->
                                    <form method="POST" action="PDFServlet" target="_blank">
                                        <button class="btn btn-sm fw-bold" type="submit" name="view" value="<%out.print(i);%>">
                                            Order <%out.print(orderList.get(i).getOrderID()); %>
                                        </button>
                                    </form>
                                    <div>
                                        <form method="POST" action="ManageOrder">
                                            <button name="complete" value="<%out.print(i);%>" type="submit" class="btn btn-success btn-sm rounded-pill" data-bs-toggle="tooltip" data-bs-placement="right" title="Processing">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-check2" viewBox="0 0 16 16">
                                                <path d="M13.854 3.646a.5.5 0 0 1 0 .708l-7 7a.5.5 0 0 1-.708 0l-3.5-3.5a.5.5 0 1 1 .708-.708L6.5 10.293l6.646-6.647a.5.5 0 0 1 .708 0z"/>
                                            </svg></button>
                                            
                                        </form>
                                    </div>
                                 </li>
                                 <%
                                    }
                                }
                                %>
                            </ul> 
                        </div>
                        <div class="col overflow-auto" id="list-group-border">
                            <!-- <i>No completed orders.</i> -->
                            <ul class="list-group">
                                <%
                                for(int i=0; i<orderList.size(); i++){
                                    String status = orderList.get(i).getStatus();
                                    if(status != null && status.equals("completed")){
                                %>
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    <input class="btn btn-sm fw-bold" type="submit" value="Order 512">
                                    <!--<span class="badge bg-secondary rounded-pill">14 hrs ago</span>-->
                                </li>
                                <%
                                    }
                                }
                                %>
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
                        <!-- <div class="col">
                            <form method="POST" action="Logout" style="float: right;">
                                <button class="btn btn-outline-secondary btn-md" type="submit">LOGOUT</button>
                                <input type="hidden" name="access" value="valid">
                            </form>
                        </div> -->
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
                    <!--                    <br>
                                        <div class="mb-3">
                                            <h5>Order History</h5>
                                            <hr>
                                            <form method="POST" action="PDFServlet" target="_blank">
                                                <button class="btn btn-outline-secondary btn-md" type="submit">Get Records</button>
                                                <input type="hidden" name="type" value="guest">
                                            </form>
                                        </div>-->
                </div>
                <!-- end of pdf -->
            </div>
        </main>
    </div>
    <!-- Footer -->
    <%--<%@include file="footer.jsp" %>--%>
    <!-- Footer -->
</body>
</html>
