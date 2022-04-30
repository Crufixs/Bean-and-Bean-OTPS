<%-- 
    Document   : success
    Created on : 02 24, 22, 7:01:10 PM
    Author     : Marylaine Lumacad
--%>

<%@page import="model.Security"%>
<%@page import="java.util.Map"%>
<%@page import="model.User"%>
<!DOCTYPE html>
<html lang="en">
    <title>My Account | Bean & Bean</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-wEmeIV1mKuiNpC+IOBjI7aAzPcEZeedi5yW5f2yOq55WWLwNGmvvx4Um1vskeMj0" crossorigin="anonymous">
    <link rel="shortcut icon" type="image/png" href="Images/logo-black.png"/>
    <link rel="stylesheet" href="CSS/success.css?<?php echo time(); ?>">

    <%
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);

        User u = (User) session.getAttribute("user");
        if (u == null) {
//            response.sendRedirect("home.jsp");
//            return;
            response.sendRedirect("login.jsp");
            return;

        } else if(u.getRole().equalsIgnoreCase("admin")){
                response.sendRedirect("admin.jsp");
            return;
        }
//        else if (u.getCustomerID() == -1) {
//            response.sendRedirect("login.jsp");
//            return;
//        }
        Map<String, String> e = (Map) request.getAttribute("errors");

    %>  
    <script>
        function toggleEditAccount() {
            document.getElementById("firstName").disabled = !document.getElementById("firstName").disabled;
            document.getElementById("lastName").disabled = !document.getElementById("lastName").disabled;
            document.getElementById("psw").disabled = !document.getElementById("psw").disabled;
            document.getElementById("phoneNumber").disabled = !document.getElementById("phoneNumber").disabled;
            document.getElementById("city").disabled = !document.getElementById("city").disabled;
            document.getElementById("barangay").disabled = !document.getElementById("barangay").disabled;
            document.getElementById("street").disabled = !document.getElementById("street").disabled;
            document.getElementById("editAccountButton").disabled = !document.getElementById("editAccountButton").disabled;
        }
        
        function enableAll() {
            document.getElementById("email").disabled = false;
            document.getElementById("uname").disabled = false;
            document.getElementById("firstName").disabled = false;
            document.getElementById("lastName").disabled = false;
            document.getElementById("psw").disabled = false;
            document.getElementById("phoneNumber").disabled = false;
            document.getElementById("city").disabled = false;
            document.getElementById("barangay").disabled = false;
            document.getElementById("street").disabled = false;
            document.getElementById("editAccountButton").disabled = false;
        }
    </script>

</head>
<body class="d-flex flex-column min-vh-100" style="background-image: url('Images/newBG.png');">
    <!-- HEADER -->
    <%@include file="header.jsp" %>

    <div class="container">
        <main>
            <!-- account details -->
            <div class="row g-5" style="margin-top: 100px; margin-bottom: 50px;">
                <div class="col-md-5 col-lg-5">
                    <div class="row align-items-center">
                        <div class="col">
                            <h2>My Account</h2>
                            <p>Welcome, <%= u.getUsername()%>!</p>
                        </div>
<!--                         <div class="col">
                            <form method="POST" action="Logout" style="float: right;">
                                <button class="btn btn-outline-secondary btn-md" type="submit">LOGOUT</button>
                                <input type="hidden" name="access" value="valid">
                            </form>
                        </div> -->
                    </div> 
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
                    <%if(u.getIsVerified()) { %>
                    <div class="mb-3">
                        <hr>
                        <h5>Order History</h5>
                        <p>Shows all the products you've bought in the past</p>
                        <form method="POST" action="PDFServlet" target="_blank">
                            <button class="btn btn-outline-secondary btn-md" type="submit">Get Records</button>
                            <input type="hidden" name="type" value="guest">
                        </form>
                    </div>
                    <%} else {%>
                    
                    <div class="mb-3">
                        <hr>
                        <h5>You haven't verified your account</h5>
                        <p>In order to order and comment a review, you must first verify your email</p>
                        <form method="POST" action="SendVerificationServlet">
                            <button class="btn btn-outline-secondary btn-md" type="submit">Send Email Verification</button>
                        </form>
                    </div>
                    <%} 
                    %>
                    <br>
                    
                </div>
                <!-- end of pdf -->
                <div class="col-md-7 col-lg-7 order-md-last">
                    <h4 class="justify-content-between align-items-center" style="float: right;">Account Details 
                        <button style="all:unset;cursor:pointer;" onclick="toggleEditAccount()"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil-square" viewBox="0 0 16 16">
                            <path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z"/>
                            <path fill-rule="evenodd" d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5v11z"/>
                            </svg>
                        </button>
                    </h4><br><hr>
                    <form method="post" action="Signup">
                        <div class="row gy-1">
                            <p class="col-3 text-end"><b>Username</b></p>
                            <div class="col-9">
                                <input type="text" name="uname" value="<%= u.getUsername()%>" class="form-control form-control-sm primary-text" id="uname" placeholder="Username" data-bs-toggle="tooltip" disabled required>
                            </div>

                            <div style="display:<%=e != null && (e.get("usernameWrongFormat") != null || e.get("usernameTaken") != null) ? "block" : "none"%>" class="col-3"></div>
                            <p style="color: red; display:<%=e != null && (e.get("usernameWrongFormat") != null || e.get("usernameTaken") != null) ? "block" : "none"%>;" class="col-9"><i><%
                                if (e != null) {
                                    if (e.get("usernameWrongFormat") != null) {
                                        out.println(e.get("usernameWrongFormat"));
                                    } else if (e.get("usernameTaken") != null) {
                                        out.println(e.get("usernameTaken"));
                                    }
                                }
                                    %></i></p>
                            <p class="col-3 text-end"><b>Email</b></p>
                            <div class="col-9">
                                <input type="text" name="email" value="<%= u.getEmail()%>" class="form-control form-control-sm primary-text" id="email" placeholder="Email Address" data-bs-toggle="tooltip" title="e.g. usermail@gmail.com" disabled required>
                            </div>
                            <div style="display:<%=e != null && (e.get("emailWrongFormat") != null || e.get("emailTaken") != null) ? "block" : "none"%>"class="col-3"></div>
                            <p style="color: red; display:<%=e != null && (e.get("emailWrongFormat") != null || e.get("emailTaken") != null) ? "block" : "none"%>;" class="col-9">a<i><%
                                if (e != null) {
                                    if (e.get("emailWrongFormat") != null) {
                                        out.println(e.get("emailWrongFormat"));
                                    } else if (e.get("emailTaken") != null) {
                                        out.println(e.get("emailTaken"));
                                    }
                                }
                                    %></i></p>
                            
                            <div class="col-3 text-end">
                                <p><b>Name</b></p>
                            </div>
                            <div class="col-9">
                                <div class="row">
                                    <div class="col">
                                        <input type="text" name="firstName" value="<%= u.getFirstName()%>" class="form-control form-control-sm primary-text" id="firstName" placeholder="First Name" disabled required>
                                    </div>
                                    <div class="col">
                                        <input type="text" name="lastName" value="<%=u.getLastName()%>" class="form-control form-control-sm primary-text" id="lastName" placeholder="Last Name" disabled required>
                                    </div>
                                </div>
                            </div>
                            <p class="col-3 text-end"><b>Password</b></p>
                            <div class="col-9 ">
                                <input type="password" name="psw" value="<% 
                                    Security s = new Security();
                                    out.println(s.decrypt(u.getPassword()));
                                %>" class="form-control form-control-sm primary-text" id="psw" placeholder="Password" data-bs-toggle="tooltip" disabled required>
                            </div>
                            <div style="display:<%=e != null && (e.get("passwordWrongFormat") != null || e.get("pwMismatch") != null) ? "block" : "none"%>"class="col-3"></div>
                            <p style="color: red; display:<%=e != null && (e.get("passwordWrongFormat") != null || e.get("pwMismatch") != null) ? "block" : "none"%>;" class="col-9">a<i><%
                                if (e != null) {
                                    if (e.get("passwordWrongFormat") != null) {
                                        out.println(e.get("passwordWrongFormat"));
                                    } else if (e.get("pwMismatch") != null) {
                                        out.println(e.get("pwMismatch"));
                                    }
                                }
                                    %></i></p>
                            <p class="col-3 text-end"><b>Phone</b></p>
                            <div class="col-9">
                                <input type="tel" name="phoneNumber" value="<%= u.getPhoneNumber()%>" class="form-control form-control-sm primary-text" id="phoneNumber"  placeholder="Phone Number" data-bs-toggle="tooltip" pattern="^(09)\d{9}$" disabled required>
                            </div>
                            <div style="display:<%=e != null && (e.get("phoneNumberWrongFormat") != null) ? "block" : "none"%>"class="col-3"></div>
                            <p style="color: red; display:<%=e != null && (e.get("phoneNumberWrongFormat") != null) ? "block" : "none"%>;" class="col-9"><i><%
                                if (e != null) {
                                    if (e.get("phoneNumberWrongFormat") != null) {
                                        out.println(e.get("phoneNumberWrongFormat"));
                                    }
                                }
                                    %></i></p>
                            <p class="col-3 text-end"><b>Address</b></p>
                            <div class="col-9">
                                <div class="row">
                                    <div class="col">
                                        <input type="text" name="city" value="<%= u.getCity()%>" class="form-control form-control-sm primary-text" id="city" placeholder="City"
                                               data-bs-toggle="tooltip" data-bs-placement="bottom" title="e.g. Quezon City" required disabled>                                    
                                    </div>
                                    <div class="col">
                                        <input type="text" name="barangay" value="<%= u.getBarangay()%>" class="form-control form-control-sm primary-text" id="barangay" placeholder="Barangay" data-bs-toggle="tooltip" data-bs-placement="bottom" title="e.g. Barangay Quirino 2-A" disabled required>
                                    </div>
                                </div>
                            </div>

                            <p class="col-3 text-end"><b>Landmark</b></p>
                            <div class="col-9">
                                <input type="text" name="street" value="<%= u.getStreet()%>" class="form-control form-control-sm primary-text col-9" id="street" placeholder="Street/Landmark" data-bs-toggle="tooltip" data-bs-placement="bottom" title="e.g. 67 Anonas St., near St. Joseph Church" disabled required>
                            </div>
                            <input type="hidden" name="state" value="edit">
                            <div class="col-3"></div>
                            <div class="col-9">
                            <button id="editAccountButton"class="btn btn-outline-secondary btn-md" onclick="enableAll()"type="submit" style="margin-top: 10px; float: right;" disabled>Save Changes</button></div>
                        </div>
                    </form>
                </div>
                <!-- end of account details -->
            </div>
            <br><br>
        </main>
    </div>
    <!-- Footer -->
    <%@include file="footer.jsp" %>
    <!-- Footer -->
</body>
</html>
