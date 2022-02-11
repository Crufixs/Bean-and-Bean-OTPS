<%-- 
    Document   : index
    Created on : May 11, 2021, 2:19:03 PM
    Author     : Carlo
--%>

<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.*" %>
<!DOCTYPE html>
<html>
    <head>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-wEmeIV1mKuiNpC+IOBjI7aAzPcEZeedi5yW5f2yOq55WWLwNGmvvx4Um1vskeMj0" crossorigin="anonymous">
        <link rel="stylesheet" type="text/css" href = "CSS/webcss.css"/>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
        <title>Login | Bean&Bean</title>
        <%
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
            response.setHeader("Pragma", "no-cache");
            response.setDateHeader("Expires", 0);

            User u = (User) session.getAttribute("user");
            if (u == null || u.getCustomerID() != -1) {
                response.sendRedirect("home.jsp");
                return;
            }

        %>
    </head> 
    <body style="background-color: #F0E7DE;">
        <!-- HEADER -->
        <%@include file="header.jsp" %>

        <div class="container">     
            <div class="modal-dialog">

                <div class="modal-content">
                    <form method="POST" action="Login" class="divider-color">
                        <div class="container softEdge">
                            <div class="modal-header text-center">
                                <h1 class="modal-title primary-text fw-bold ">Login</h1>
                            </div>
                            <div class="modal-body">
                                <label class="fs-5 form-label primary-text">Username</label>
                                <input type="text" name="uname" value="${input.username}" class="form-control primary-text" required>
                                <span style="color:red;"><i>${errors.username}</i></span>
                                <br>
                                <label class="fs-5 form-label primary-text">Password</label>
                                <input type="password" name="psw" value="${input.password}" class="form-control primary-text" required>
                                <span style="color:red;"><i>${errors.password}</i></span>
                                <br>

                            </div>  
                            <div class="modal-body text-center">
                                <div>
                                    <button type="submit" class="btn btn-secondary w-100">Login</button>
                                </div>
                                <br>
                                <div>
                                    Need an account? <a href="register.jsp" style="text-decoration: underline;">Sign up</a>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>

        </div>

        <!-- Footer -->
        <%@include file="footer.jsp" %>
        <!-- Footer -->
        <!--        <script type="text/javascript">
                    var my_handlers = {
        
                        fill_provinces: function () {
        
                            var region_code = $(this).val();
                            $('#province').ph_locations('fetch_list', [{"region_code": region_code}]);
        
                        },
        
                        fill_cities: function () {
        
                            var province_code = $(this).val();
                            $('#city').ph_locations('fetch_list', [{"province_code": province_code}]);
                        },
        
                        fill_barangays: function () {
        
                            var city_code = $(this).val();
                            $('#barangay').ph_locations('fetch_list', [{"city_code": city_code}]);
                        }
                    };
        
                    $(function () {
                        $('#region').on('change', my_handlers.fill_provinces);
                        $('#province').on('change', my_handlers.fill_cities);
                        $('#city').on('change', my_handlers.fill_barangays);
                        $('#region').ph_locations({'location_type': 'regions'});
                        $('#province').ph_locations({'location_type': 'provinces'});
                        $('#city').ph_locations({'location_type': 'cities'});
                        $('#barangay').ph_locations({'location_type': 'barangays'});
                        $('#region').ph_locations('fetch_list');
                    });
                </script>-->
    </body>
</html>
