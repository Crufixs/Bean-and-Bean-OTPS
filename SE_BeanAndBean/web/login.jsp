<%-- 
    Document   : login2
    Created on : 03 21, 22, 10:02:39 PM
    Author     : Marylaine Lumacad
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
            if (u != null) {
                response.sendRedirect("success.jsp");
                return;
            }

        %>
    </head> 
    <body class="d-flex flex-column min-vh-100" style="background-image: url('Images/img-bg.jpg');">
        <!-- HEADER -->
        <%@include file="header.jsp" %>
        <!--        <div class="container">     
                    <div class="modal-dialog">
        
                        <div class="modal-content">-->
        <div style="margin-top: 100px;">
            <!-- <section class="vh-100" style="background-color: #9A616D;"> -->
  <div class="container py-5 h-100">
    <div class="row d-flex justify-content-center align-items-center h-100">
      <div class="col col-xl-10">
        <div class="card" style="border-radius: 1rem;">
          <div class="row g-0">
            <div class="col-md-6 col-lg-5 d-none d-md-block">
              <img
                src="Images/login-bg.jpg"
                alt="login form"
                class="img-fluid" style="border-radius: 1rem 0 0 1rem;"
              />
            </div>
            <div class="col-md-6 col-lg-7 d-flex align-items-center" style="height: 385px;">
              <div class="card-body p-4 p-lg-5 text-black">

                <form method="POST" action="Login">

                  <!-- <div class="d-flex align-items-center mb-3 pb-1">
                    <i class="fas fa-cubes fa-2x me-3" style="color: #ff6219;"></i>
                    <span class="h1 fw-bold mb-0"><img src="Images/logo-black.png" width="100" height="100"></span>
                  </div>
 -->
                  <h5 class="fw-normal mt-4 pb-3" style="letter-spacing: 1px;">Sign into your account</h5>

                  <div class="form-outline mb-3">
                    <label class="form-label" for="form2Example17">Username</label>
                    <input type="text" name="uname" value="${input.username}" id="form2Example17" class="form-control form-control-lg" required/>
                    <p style="color:red;"><small><i>${errors.password}</small></i></p>
                  </div>


                  <div class="form-outline mb-3">
                    <label class="form-label" for="form2Example27">Password</label>
                    <input type="password" id="form2Example27" name="psw" value="${input.password}" class="form-control form-control-lg" required/>
                    <p style="color:red;"><small><i>${errors.password}</small></i></p>
                  </div>

                  <div class="pt-1 mb-3">
                    <button class="btn btn-dark btn-md btn-block" type="submit">Login</button>
                  </div>

                  <!-- <a class="small text-muted" href="#!">Forgot password?</a> -->
                  <p class="pb-lg-2" style="color: #000000;">Don't have an account? <a href="register.jsp" style="color: #6f4e37;">Register here</a></p>
                  <!-- <a href="#!" class="small text-muted">Terms of use.</a>
                  <a href="#!" class="small text-muted">Privacy policy</a> -->
                </form>

              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
<!-- </section> -->
        </div>
        <!--                </div>
                    </div>
        
                </div>-->

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
