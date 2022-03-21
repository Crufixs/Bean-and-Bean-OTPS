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
//            response.sendRedirect("home.jsp");
//            return;
            response.sendRedirect("login.jsp");
            return;

        }
//        else if (u.getCustomerID() == -1) {
//            response.sendRedirect("login.jsp");
//            return;
//        }

    %>  
    <script>
        function toggleEditAccount() {
            document.getElementById("firstName").disabled = !document.getElementById("firstName").disabled;
            document.getElementById("lastName").disabled = !document.getElementById("lastName").disabled;
            document.getElementById("uname").disabled = !document.getElementById("uname").disabled;
            document.getElementById("psw").disabled = !document.getElementById("psw").disabled;
            document.getElementById("email").disabled = !document.getElementById("email").disabled;
            document.getElementById("phoneNumber").disabled = !document.getElementById("phoneNumber").disabled;
            document.getElementById("city").disabled = !document.getElementById("city").disabled;
            document.getElementById("barangay").disabled = !document.getElementById("barangay").disabled;
            document.getElementById("street").disabled = !document.getElementById("street").disabled;
         
        }
    </script>
   
</head>
<body class="d-flex flex-column min-vh-100" style="background-color: #F0E7DE;">
    <!-- HEADER -->
    <%@include file="header.jsp" %>

    <div class="container">
        <main>
            <!-- account details -->
            <div class="row g-5" style="margin-top: 100px; margin-bottom: 50px;">
                <div class="col-md-7 col-lg-7 order-md-last">
                    
                    <h4 class="justify-content-between align-items-center" style="float: right;">Account Details 
                        <button style="all:unset;cursor:pointer;" onclick="toggleEditAccount()"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil-square" viewBox="0 0 16 16">
                        <path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z"/>
                        <path fill-rule="evenodd" d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5v11z"/>
                        </svg>
                    </button>
                    </h4><br><hr>
                    <forms>
                        <div class="row gy-3">
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
                            <div class="col-3 text-end">
                                <p><b>Username</b></p>
                            </div>
                            <div class="col-9">
                                <input type="text" name="uname" value="<%= u.getUsername()%>" class="form-control form-control-sm primary-text" id="uname" placeholder="Username" data-bs-toggle="tooltip" disabled required>
                            </div>
                            <div class="col-3 text-end">
                                <p><b>Password</b></p>
                            </div>
                            <div class="col-9 ">
                                <input type="password" name="psw" value="<%= u.getPassword()%>" class="form-control form-control-sm primary-text" id="psw" placeholder="Password" data-bs-toggle="tooltip" disabled required>
                            </div>
                            <div class="col-3 text-end">
                                <p><b>Email</b></p>
                            </div>
                            <div class="col-9">
                                <input type="text" name="email" value="<%= u.getEmail()%>" class="form-control form-control-sm primary-text" id="email" placeholder="Email Address" data-bs-toggle="tooltip" title="e.g. usermail@gmail.com" disabled required>
                            </div>
                            <div class="col-3 text-end">
                                <p><b>Phone</b></p>
                            </div>
                            <div class="col-9">
                                <input type="tel" name="phoneNumber" value="<%= u.getPhoneNumber()%>" class="form-control form-control-sm primary-text" id="phoneNumber"  placeholder="Phone Number" data-bs-toggle="tooltip" pattern="^(09)\d{9}$" disabled required>
                            </div>
                            <div class="col-3 text-end">
                                <p><b>Address</b></p>
                            </div>
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
                            <div class="col-3 text-end">
                                <p><b>Landmark</b></p>
                            </div>
                            <div class="col-9">
                                <input type="text" name="street" value="<%= u.getStreet()%>" class="form-control form-control-sm primary-text" id="street" placeholder="Street/Landmark" data-bs-toggle="tooltip" data-bs-placement="bottom" title="e.g. 67 Anonas St., near St. Joseph Church" disabled required>
                            </div>
                        </div>
                    </forms>
                </div>
                <!-- end of account details -->
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
