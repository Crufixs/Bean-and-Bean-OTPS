<%-- 
    Document   : index
    Created on : May 11, 2021, 2:19:03 PM
    Author     : Carlo
--%>

<%@page import="java.util.List"%>
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
        <title>Home | Bean&Bean</title>
        <%
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
            response.setHeader("Pragma", "no-cache");
            response.setDateHeader("Expires", 0);

            List<Product> products = (List) getServletContext().getAttribute("products");

            User u = (User) session.getAttribute("user");
//            out.print("TESTING LANG");
//            if (u == null) {
////                System.out.print("HUYYYUYUYUYUYUYUYU");
////                u = new User();
////                Cart c = new Cart();
////                session.setAttribute("user", u);
////                session.setAttribute("cart", c);
////                response.sendRedirect("Login");
////                return;
//            }
        %>
    </head> 
    <body style="background-color: #F0E7DE;">
        <!-- HEADER -->
        <%@include file="header.jsp" %>
        <main>
            <!-- CAROUSEL -->
            <div id="myCarousel" class="carousel slide" data-bs-ride="carousel">
                <div class="carousel-indicators">
                    <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
                    <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="1" aria-label="Slide 2"></button>
                </div>
                <div class="carousel-inner">
                    <div class="carousel-item active" style="background: url(Images/s3.jpg);min-height:500px;background-repeat: no-repeat;background-size: cover;background-position: center;">
                        <div class="container">
                            <div class="carousel-caption text-start">
                                <img src="Images/Bean.png" style="height:100px;width:100px;">
                                <h1>Bean&Bean</h1>
                                <p>Locally sourced coffee. PH</p>
                                <p><a class="btn btn-lg btn-outline-light" href="aboutus.jsp">Read More</a></p>
                            </div>
                        </div>
                    </div>
                    <div class="carousel-item" style="background: url(Images/o1.jpg);min-height:500px;background-repeat: no-repeat;background-size: cover;background-position: center;">
                        <div class="container">
                            <div class="carousel-caption">
                                <h1>DELIVERY</h1>
                                <p>Get it delivered straight through your doorstep.</p>
                                <p><i>within Metro Manila only</i></p>
                                <p><a class="btn btn-lg btn-outline-light" href="shop.jsp">Shop Now</a></p>
                            </div>
                        </div>
                    </div>
                </div>
                <button class="carousel-control-prev" type="button" data-bs-target="#myCarousel" data-bs-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Previous</span>
                </button>
                <button class="carousel-control-next" type="button" data-bs-target="#myCarousel" data-bs-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Next</span>
                </button>
            </div>
            <br><br>

        <!-- </div> -->
        <div class="container marketing">
            <!-- Three columns of text below the carousel -->
            <div class="row" style="text-align: center">
                <div class="col-lg-4">
                    <img class="rounded-circle" width="140" height="140" src="Images/arab.jpg">
                    <div style="border-color:white;border-top-width:1px;margin-left: auto;margin-right: auto;margin-top:10px;margin-bottom:10px;width:100%;max-width:170px;"><hr style="height: 3px;"></div>
                    <h2>Premium Coffee</h2>
                    <p>Made from uniquely flavored beans.</p>
                    <p><a class="btn btn-secondary" href="shop.jsp#pc">See More &raquo;</a></p>
                </div><!-- /.col-lg-4 -->
                <div class="col-lg-4">
                    <img class="rounded-circle" width="140" height="140" src="Images/brew2.jpg">
                    <div style="border-color:white;border-top-width:1px;margin-left: auto;margin-right: auto;margin-top:10px;margin-bottom:10px;width:100%;max-width:170px;"><hr style="height: 3px;"></div>
                    <h2>Cold Series</h2>
                    <p>Made from ground coffee with cold water.</p>
                    <p><a class="btn btn-secondary" href="shop.jsp#cb">See More &raquo;</a></p>
                </div><!-- /.col-lg-4 -->
                <div class="col-lg-4">
                    <img class="rounded-circle" width="140" height="140" src="Images/g3.jpg">
                    <div style="border-color:white;border-top-width:1px;margin-left: auto;margin-right: auto;margin-top:10px;margin-bottom:10px;width:100%;max-width:170px;"><hr style="height: 3px;"></div>
                    <h2>Coffee Syrups</h2>
                    <p>Flavoring that can be added to hot or cold coffee.</p>
                    <p><a class="btn btn-secondary" href="shop.jsp#ic">See More &raquo;</a></p>
                </div><!-- /.col-lg-4 -->
            </div><!-- /.row -->
            <hr>

            <div class="container px-4 py-5">
                <!-- <div class="py-3">
                    <h1 class="display-5 fw-bold">About us</h1>
                    <hr class="divider-color">
                </div>  -->
                <div class="row row-cols-1 row-cols-lg-2">             
                    <div class="col text-center">
                        <img src="Images/f11.jpg" class="img-fluid rounded mx-auto">
                    </div>
                    <div class="col p-5 cn my-3">
                        <div class="inner">
                            <h2 style="text-align:center;">Keep beans airtight and cool</h2>
                            <p class="lead" style="text-align:center;">Your beans' greatest enemies are air, moisture, heat, and light.<br><br>
                                <% 
                                    //if (u.getCustomerID() == -1)
                                    System.out.print("HAAAAAAAAY");
                                    if(u == null){
                                        System.out.print("HELOOOOOOO");
                                %>
                                <a class="btn btn-secondary btn-md" style="text-align:center;" href="register.jsp">Sign Up Now</a>
                                <% } else {%>
                                <a class="btn btn-secondary btn-md" style="text-align:center;" href="success.jsp">My Account</a>
                                <% }%>
                            </p>
                        </div>
                    </div>                
                </div>
                <div class="row row-cols-1 row-cols-lg-2"> 
                    <div class="col order-lg-2 text-center">    
                        <img src="Images/f22.jpg" class="img-fluid rounded" >
                    </div>
                    <div class="col order-lg-1 p-5 cn my-3">
                        <div class="inner">
                            <h2 style="text-align:center;">Buy the right amount</h2>
                            <p class="lead" style="text-align:center;">Coffee begins to lose freshness almost immediately after roasting.<br><br>
                                <a class="btn btn-secondary btn-md" style="text-align:center;" href="aboutus.jsp#gallery">See Gallery</a></p>
                        </div> 
                    </div>
                </div>
            </div>
        </div>
    </main>
        <!-- Footer -->
        <%@include file="footer.jsp" %>
        <!-- Footer -->
    </body>
    <!-- SOURCE: https://www.darwinbiler.com/jquery-ph-locations/ -->
    <!-- <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.0/jquery.js"></script> -->
    <!--    <script type="text/javascript">
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
</html>
