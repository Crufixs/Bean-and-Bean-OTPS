<%-- 
    Document   : index
    Created on : May 11, 2021, 2:19:03 PM
    Author     : Carlo
--%>

<%@page import="java.util.Map"%>
<%@page import="model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-wEmeIV1mKuiNpC+IOBjI7aAzPcEZeedi5yW5f2yOq55WWLwNGmvvx4Um1vskeMj0" crossorigin="anonymous">
        <link rel="shortcut icon" type="image/png" href="Images/logo-black.png"/>
        <link rel="stylesheet" type="text/css" href = "CSS/webcss.css?<?php echo time(); ?>"/>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
        <title>Sign Up | Bean & Bean</title>
        <%
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
            response.setHeader("Pragma", "no-cache");
            response.setDateHeader("Expires", 0);
            User u = (User) session.getAttribute("user");
            
            if (u != null) {
                if(u.getRole().equalsIgnoreCase("admin"))
                    response.sendRedirect("admin.jsp");
                else if(u.getRole().equalsIgnoreCase("guest"))
                    response.sendRedirect("home.jsp");
                return;
            }
            
            Map<String, String> e = (Map) request.getAttribute("errors");

        %>
    </head>
    <body class="d-flex flex-column min-vh-100" style="background-image: url('Images/newBG.png');">
        <!-- HEADER -->
        <%@include file="header.jsp" %>
        <div class="container">
            <div class="py-4" style="margin-top: 100px; text-align: center;">
                <h1 class="fs-3 fw-bold form-label primary-text"><%= u == null ? "CREATE ACCOUNT" : "EDIT ACCOUNT"%></h1>
                <hr>
            </div>
            <div class="row rounded py-3 px-4 mx-lg-5 mb-5" style="padding:0!important; background-color: white">
                <div class="col-lg-6" style="padding:25px;">
                    <form method="post" action="Signup" >
                        <label class="fs-4 fw-bold form-label primary-text">Credentials</label>
                        <div class="form-floating mb-3">
                            <input type="text" name="uname" value="${input.uname}" class="form-control primary-text" id="floatingInput" placeholder="Username" data-bs-toggle="tooltip" data-bs-placement="bottom" required>
                            <label for="floatingInput">Username</label>
                            <p style="color: red"><small><i>
                                    <%
                                        if (e != null) {
                                            if (e.get("usernameWrongFormat") != null) {
                                                out.println(e.get("usernameWrongFormat"));
                                            } else if (e.get("usernameTaken") != null) {
                                                out.println(e.get("usernameTaken"));
                                            }
                                        }
                                    %>
                                </i></small>
                            </p>
                        </div>

                        <div class="form-floating mb-3">
                            <input type="text" name="email" value="${input.email}" class="form-control primary-text" id="floatingInput" placeholder="Email Address" data-bs-toggle="tooltip" data-bs-placement="bottom" title="e.g. usermail@gmail.com" required>
                            <label for="floatingInput">Email Address</label>
                            <p style="color: red"><small><i><%
                                if (e != null) {
                                    if (e.get("emailWrongFormat") != null) {
                                        out.println(e.get("emailWrongFormat"));
                                    } else if (e.get("emailTaken") != null) {
                                        out.println(e.get("emailTaken"));
                                    }
                                }
                                    %>
                                </i></small></p>
                        </div>
                        <div class="row row-cols-1 g-4 row-cols-sm-2">
                            <div class="col">
                                <div class="form-floating mb-3">
                                    <input type="password" name="psw" value="${input.psw}" class="form-control primary-text" id="floatingInput" placeholder="Password" data-bs-toggle="tooltip" data-bs-placement="bottom" required>
                                    <label for="floatingInput">Password</label>
                                    <p style="color: red"><small><i><%
                                        if (e != null) {
                                            if (e.get("passwordWrongFormat") != null) {
                                                out.println(e.get("passwordWrongFormat"));
                                            } else if (e.get("pwMismatch") != null) {
                                                out.println(e.get("pwMismatch"));
                                            }
                                        }
                                            %></i></small></p>
                                </div>
                            </div>
                            <div class="col">
                                <div class="form-floating mb-3">
                                    <input type="password" name="confirmPsw" value="${input.confirmPsw}" class="form-control primary-text" id="floatingInput" placeholder="Confirm Password" required>
                                    <label for="floatingInput">Confirm Password</label>
                                </div>
                            </div>
                        </div>

                        <label class="fs-4 fw-bold form-label primary-text">Full Name</label>
                        <div class="row row-cols-1 g-4 row-cols-sm-2">
                            <div class="col">
                                <div class="form-floating mb-3">
                                    <input type="text" name="firstName" value="${input.firstName}" class="form-control primary-text" id="floatingInput" placeholder="First Name" required>
                                    <label for="floatingInput">First Name</label>
                                </div>
                            </div>
                            <div class="col">
                                <div class="form-floating mb-3">
                                    <input type="text" name="lastName" value="${input.lastName}" class="form-control primary-text" id="floatingInput" placeholder="Last Name" required>
                                    <label for="floatingInput">Last Name</label>
                                </div>
                            </div>
                        </div>

                        <label class="fs-4 fw-bold form-label primary-text">Contact No.</label>
                        <div class="form-floating mb-3">
                            <input type="text" name="phoneNumber" value="${input.phoneNumber}" class="form-control primary-text" id="phone" name="phone" placeholder="Phone Number" data-bs-toggle="tooltip" data-bs-placement="bottom" required>
                            <label for="floatingInput">Phone Number</label>
                            <p style="color: red"><small><i><%
                                if (e != null) {
                                    if (e.get("phoneNumberWrongFormat") != null) {
                                        out.println(e.get("phoneNumberWrongFormat"));
                                    }
                                }
                                    %>
                                </i></small></p>
                        </div>
                        <div>  
                            <label class="fs-4 fw-bold form-label primary-text">Permanent Address</label>
                            <div class="row row-cols-1 row-cols-sm-2">
                                <div class="col">
                                    <div class="form-floating mb-3">
                                        <input type="text" name="region" value="National Capital Region" class="form-control primary-text" disabled="disabled" required>
                                        <!--                        <select id="region" name="region"  class="form-select form-select-md mb-3 primary-text" aria-label=".form-select-lg example" required>
                                                                    <option value="" disabled selected>Region</option>
                                                                </select>-->
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="form-floating mb-3">
                                        <input type="text" name="city" value="${input.city}" class="form-control primary-text" id="floatingInput" placeholder="City"
                                               data-bs-toggle="tooltip" data-bs-placement="bottom" title="e.g. Quezon City" required>
                                        <label for="floatingInput">City</label>
                                    </div>
                                    <!--                        <select id="province" name="province" class="form-select form-select-md mb-3 primary-text" aria-label=".form-select-lg example" required>
                                                                <option value="" disabled selected>Province</option>
                                                            </select>-->
                                </div>
                                <div class="col">
                                    <div class="form-floating mb-3">
                                        <input type="text" name="barangay" value="${input.barangay}" class="form-control primary-text" id="floatingInput" placeholder="Barangay" data-bs-toggle="tooltip" data-bs-placement="bottom" title="e.g. Barangay Quirino 2-A" required>
                                        <label for="floatingInput">Barangay</label>
                                    </div>
                                    <!--                        <select id="city" name="city" class="form-select form-select-md mb-3 primary-text" aria-label=".form-select-lg example" required>
                                                                <option value="" disabled selected>City</option>
                                                            </select>-->
                                </div>
                                <div class="col">
                                    <div class="form-floating mb-3">
                                        <input type="text" name="street" value="${input.street}" class="form-control primary-text" id="floatingInput" placeholder="Street/Landmark" data-bs-toggle="tooltip" data-bs-placement="bottom" title="e.g. 67 Anonas St., near St. Joseph Church" required>
                                        <label for="floatingInput">Street/Landmark</label>
                                    </div>
                                    <!--                        <select id="barangay" name="barangay" class="form-select form-select-md mb-3 primary-text" aria-label=".form-select-lg example" required>
                                                                <option value="" disabled selected>Barangay</option>
                                                            </select>-->
                                </div>
                            </div>
                        </div>
                        <!--<input type="text" name="street" class="form-control primary-text" placeholder="Street/Landmark" aria-describedby="emailHelp" required>-->
                        <!--<br>-->
                        <!-- <label class="fs-4 fw-bold form-label primary-text">Mobile Number</label> -->
                        <div class="text-center">     
                            <div class="col">
                                <label class="fs-4 fw-bold form-label primary-text">What can you see?</label>
                                <br>
                                <img src="CaptchaGenerator" alt="None">
                                <br><br>
                                <input type="text" name="captcha" class="form-control primary-text" id="captcha" name="captcha" placeholder="Captcha" required>
                                <p style="color: red"><small><i>${errors.captcha}</i></small></p>
                            </div>
                            <input type="hidden" name="state" value="signup">
                            <div class="col-6" style="margin-left: 25%;">
                                <div>
                                    <button type="submit" class="w-100 btn btn-secondary">Sign Up</button>
                                </div>
                            </div>
                        </div>
                        <br>

                    </form>
                </div><!--first column-->
                <div class="col-lg-6 rounded" id="secondCol" style=" transition: 2s; background: url('Images/bg.jpg')  no-repeat center center; background-size: cover;">
                    <span></span>
                </div><!--second column-->
            </div><!--row-->
        </div>
        <!-- Footer -->
        <%@include file="footer.jsp" %>
        <!-- Footer -->
        <script>
           window.onload = function () {
     // Array of Images
      var backgroundImg=["Images/r1.png", "Images/r2.png", "Images/r3.png", "Images/r4.png"];

        setInterval(changeImage, 5000);
       function changeImage() {   
        var i = Math.floor((Math.random() * 4));

        document.getElementById("secondCol").style.background = "url('"+backgroundImg[i]+"') no-repeat center center";
        document.getElementById("secondCol").style.backgroundSize = "cover";

      }
    }
        </script>
    </body>
</html>
