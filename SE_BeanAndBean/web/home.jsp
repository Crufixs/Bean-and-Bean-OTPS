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
        <link rel="shortcut icon" type="image/png" href="Images/logo-black.png"/>
        <link rel="stylesheet" type="text/css" href = "CSS/webcss.css?<?php echo time(); ?>"/>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Playfair+Display">
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
        <title>Home | Bean & Bean</title>
        <%
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
            response.setHeader("Pragma", "no-cache");
            response.setDateHeader("Expires", 0);

            List<Product> products = (List) getServletContext().getAttribute("products");

            User u = (User) session.getAttribute("user");
            System.out.print(u == null ? "ksjdflsdfsdfsdfsdfsdfkjdfgdfgsfsadasdasdlk" : "mmdfkjdksdsdfsdfsdfsdfsdfsdfsffdfsfm");
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
    <body class="d-flex flex-column min-vh-100" style="background-image: url('Images/newBG.png');">
        <!-- HEADER -->
        <header>
            <!-- <style>
              .banner-image {
                background-image: url('img/banner-img.jpg');
                background-size: cover;
              }
            </style> -->
            <!-- Navbar  -->
            <nav class="navbar fixed-top navbar-expand-lg navbar-dark p-md-3" style="background-color: #00000020; box-shadow: 5px 5px 8px 5px #00000020;">
                <div class="container">
                    <!-- <a class="navbar-brand" href="home.jsp">
                    <img src="Images/logo-plain.png" alt="logo" width="30" height="24" class="d-inline-block align-text-top"><span class="fs-4 text-white">Bean&Bean</span></a> -->
                    <a href="home.jsp" class="d-flex align-items-center mb-3 mb-md-0 me-md-auto text-dark text-decoration-none">
                        <img src="Images/logo-plain.png" width="50" height="50">
                        &nbsp;<span class="fs-4 text-white mt-3" style="font-family: Playfair Display">Bean & Bean</span></a>
                    <button
                        class="navbar-toggler"
                        type="button"
                        data-bs-toggle="collapse"
                        data-bs-target="#navbarNav"
                        aria-controls="navbarNav"
                        aria-expanded="false"
                        aria-label="Toggle navigation"
                        >
                        <span class="navbar-toggler-icon"></span>
                    </button>

                    <div class="collapse navbar-collapse" id="navbarNav">
                        <div class="mx-auto"></div>
                        <ul class="navbar-nav">
                            <li class="nav-item">
                                <a class="nav-link text-white" href="home.jsp">Home</a>
                            </li>
                            <li class="nav-item dropdown" id="shop-dropdown">
                                <a class="nav-link text-white dropdown-toggle" href="shop.jsp" id="navbarDropdownMenuLink" role="button">Shop</a>
                                <ul id="shop-dropdown-menu" class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                                    <li><a class="dropdown-item text-white" href="shop.jsp#pc">Premium Coffee</a></li>
                                    <li><a class="dropdown-item text-white" href="shop.jsp#hs">Hot Series</a></li>
                                    <li><a class="dropdown-item text-white" href="shop.jsp#cs">Cold Series</a></li>
                                    <li><a class="dropdown-item text-white" href="shop.jsp#sy">Coffee Syrups</a></li>
                                    <li><a class="dropdown-item text-white" href="shop.jsp#sa">Coffee Sauces</a></li></ul>
                            </li>
                            <li id="about-us-dropdown" class="nav-item dropdown">
                                <a class="nav-link text-white dropdown-toggle" href="aboutus.jsp" id="navbarDropdownMenuLink" role="button">About Us
                                </a>
                                <ul id="about-us-dropdown-menu" class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                                    <li><a class="dropdown-item text-white" href="aboutus.jsp#faqs">FAQs</a></li>
                                    <li><a class="dropdown-item text-white" href="aboutus.jsp#gallery">Gallery</a></li>
                                    <li><a class="dropdown-item text-white" href="aboutus.jsp#reviews">Reviews</a></li>
                                </ul>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link text-white" href="contactus.jsp">Contact Us</a>
                            </li>
                            <!-- <li class="nav-item">
                                <a class="nav-link text-white" href="#">Contact</a>
                            </li> -->
                            <!-- <div class="text-end"> -->
                            <%@include file="loginMenu.jsp" %>
                            <%@include file="cartMenu.jsp" %>
                            <!-- </div> -->
                        </ul>
                    </div>
                </div>
            </nav>
            <!-- Banner Image  -->
            <!--     <div
                  class="banner-image w-100 vh-100 d-flex justify-content-center align-items-center"
                >
                  <div class="content text-center">
                    <h1 class="text-white">WEB ZONE</h1>
                  </div>
                </div> -->
            <script src="js/bootstrap.bundle.min.js"></script>
            <script type="text/javascript">
                var nav = document.querySelector('nav');

                window.addEventListener('scroll', function () {
                    if (window.pageYOffset > 100) {
                        nav.classList.add('bg-dark', 'shadow');
                    } else {
                        nav.classList.remove('bg-dark', 'shadow');
                    }
                });
            </script>
        </header>
        <main>
            <!-- CAROUSEL -->
            <div id="myCarousel" class="carousel slide" data-bs-ride="carousel">
                <div class="carousel-indicators">
                    <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
                    <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="1" aria-label="Slide 2"></button>
                </div>
                <div class="carousel-inner">
                    <div class="carousel-item active" style="background: url(Images/s33.jpg);min-height:65vh;background-repeat: no-repeat;background-size: cover;background-position: center;">
                        <div class="container">
                            <div class="carousel-caption text-start" style="margin-bottom: 6.7vh;">
                                <!-- <img src="Images/logo-plain.png" style="height: 150px; width:150px"> -->
                                <h1 style="font-family: Playfair Display; font-size: ">Bean & Bean</h1>
                                <p>Locally sourced coffee. PH</p>
                                <p><a class="btn btn-lg btn-outline-light" href="aboutus.jsp">Read More</a></p>
                            </div>
                        </div>
                    </div>
                    <div class="carousel-item" style="background: url(Images/o11.jpg);min-height:65vh;background-repeat: no-repeat;background-size: cover;background-position: center;">
                        <div class="container">
                            <div class="carousel-caption">
                                <h1>DELIVERY</h1>
                                <p style="margin-bottom: 1px;">Get it delivered straight through your doorstep.</p>
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
                        <img class="rounded-circle" width="140" height="140" src="Images/12.jpg">
                        <div style="border-color:white;border-top-width:1px;margin-left: auto;margin-right: auto;margin-top:10px;margin-bottom:10px;width:100%;max-width:170px;"><hr style="height: 3px;"></div>
                        <h2 >Premium Coffee</h2>
                        <p>Made from uniquely flavored beans.</p>
                        <p><a class="btn btn-outline-dark" href="shop.jsp#pc">See More &raquo;</a></p>
                    </div><!-- /.col-lg-4 -->
                    <div class="col-lg-4">
                        <img class="rounded-circle" width="140" height="140" src="Images/21.jpg">
                        <div style="border-color:white;border-top-width:1px;margin-left: auto;margin-right: auto;margin-top:10px;margin-bottom:10px;width:100%;max-width:170px;"><hr style="height: 3px;"></div>
                        <h2>Cold Series</h2>
                        <p>Made from ground coffee with cold water.</p>
                        <p><a class="btn btn-outline-dark" href="shop.jsp#cb">See More &raquo;</a></p>
                    </div><!-- /.col-lg-4 -->
                    <div class="col-lg-4">
                        <img class="rounded-circle" width="140" height="140" src="Images/31.jpg">
                        <div style="border-color:white;border-top-width:1px;margin-left: auto;margin-right: auto;margin-top:10px;margin-bottom:10px;width:100%;max-width:170px;"><hr style="height: 3px;"></div>
                        <h2>Coffee Syrups</h2>
                        <p>Flavoring that can be added to hot or cold coffee.</p>
                        <p><a class="btn btn-outline-dark" href="shop.jsp#ic">See More &raquo;</a></p>
                    </div><!-- /.col-lg-4 -->
                </div><!-- /.row -->
                <hr>

                <div class="container px-4 py-5">
                    <!-- <div class="py-3">
                        <h1 class="display-5 fw-bold">About us</h1>
                        <hr class="divider-color">
                    </div>  -->
                    <div class="row row-cols-1 row-cols-lg-2 mb-3">             
                        <div class="col text-center">
                            <img src="Images/h1.jpg" class="img-fluid rounded mx-auto">
                        </div>
                        <div class="col p-5 cn my-3">
                            <div class="inner">
                                <h2 style="text-align:center;">Keep beans airtight and cool</h2>
                                <p class="lead" style="text-align:center;">Your beans' greatest enemies are air, moisture, heat, and light.<br><br>
                                    <%                                        //if (u.getCustomerID() == -1)
                                        System.out.print("HAAAAAAAAY");
                                        if (u == null) {
                                            System.out.print("HELOOOOOOO");
                                    %>
                                    <a class="btn btn-outline-dark btn-md" style="text-align:center;" href="register.jsp">Sign Up Now</a>
                                    <% } else {%>
                                    <a class="btn btn-outline-dark btn-md" style="text-align:center;" href="success.jsp">My Account</a>
                                    <% }%>
                                </p>
                            </div>
                        </div>                
                    </div>
                    <div class="row row-cols-1 row-cols-lg-2 mb-3"> 
                        <div class="col order-lg-2 text-center">    
                            <img src="Images/f3.jpg" class="img-fluid rounded" >
                        </div>
                        <div class="col order-lg-1 p-5 cn my-3">
                            <div class="inner">
                                <h2 style="text-align:center;">Buy the right amount</h2>
                                <p class="lead" style="text-align:center;">Coffee begins to lose freshness almost immediately after roasting.<br><br>
                                    <a class="btn btn-outline-dark btn-md" style="text-align:center;" href="aboutus.jsp#gallery">See Reviews</a></p>
                            </div> 
                        </div>
                    </div>
                    <!-- <div class="row row-cols-1 row-cols-lg-2 mb-3">             
                        <div class="col text-center">
                            <img src="Images/f3.jpg" class="img-fluid rounded mx-auto">
                        </div>
                        <div class="col p-5 cn my-3">
                            <div class="inner">
                                <h2 style="text-align:center;">idk</h2>
                                <p class="lead" style="text-align:center;">blah blah blah<br><br>
                                 <a class="btn btn-outline-dark btn-md" style="text-align:center;" href="aboutus.jsp#reviews">See Reviews</a></p>
                            </div>
                        </div>                
                    </div> -->
                    <hr class="my-5">
                    <div class="row" data-masonry='{"percentPosition": true }'>
                        <div class="col-sm-6 col-lg-4 mb-4">
                            <div class="card">
                                <img src="Images/c1.jpg">
                            </div>
                        </div>
                        <div class="col-sm-6 col-lg-4 mb-4">
                            <div class="card">
                                <img src="Images/c5.jpg">
                            </div>
                        </div>
                        <div class="col-sm-6 col-lg-4 mb-4">
                            <div class="card">
                                <img src="Images/c2.jpg">
                            </div>
                        </div>
                        <div class="col-sm-6 col-lg-4 mb-4">
                            <div class="card p-3">
                                <figure class="p-3 mb-0">
                                    <blockquote class="blockquote">
                                        <p>"But even a bad cup of coffee is better than no coffee at all."</p>
                                    </blockquote>
                                    <figcaption class="blockquote-footer mb-0 text-muted">
                                        <i>David Lynch</i>
                                    </figcaption>
                                </figure>
                            </div>
                        </div>
                        <div class="col-sm-6 col-lg-4 mb-4">
                            <div class="card p-3 text-center">
                                <figure class="p-3 mb-0">
                                    <blockquote class="blockquote">
                                        <p>"The powers of a man's mind are directly proportional to the quantity of coffee he drinks."</p>
                                    </blockquote>
                                    <figcaption class="blockquote-footer mb-0 text-muted">
                                        <i>Sir James MacKintosh</i>
                                    </figcaption>
                                </figure>
                            </div>
                        </div>
                        <div class="col-sm-6 col-lg-4 mb-4">
                            <div class="card">
                                <img src="Images/c3.jpg">
                            </div>
                        </div>
                        <div class="col-sm-6 col-lg-4 mb-4">
                            <div class="card p-3 text-end">
                                <figure class="p-3 mb-0">
                                    <blockquote class="blockquote">
                                        <p>"It does not matter where you are from or how you feel, there is always peace in a strong cup of coffee."</p>
                                    </blockquote>
                                    <figcaption class="blockquote-footer mb-0 text-muted">
                                        <i>Gabriel Ba</i>
                                    </figcaption>
                                </figure>
                            </div>
                        </div>
                        <div class="col-sm-6 col-lg-4 mb-4">
                            <div class="card p-3">
                                <figure class="p-3 mb-0">
                                    <blockquote class="blockquote">
                                        <p>"Coffee is a language in itself."</p>
                                    </blockquote>
                                    <figcaption class="blockquote-footer mb-0 text-muted">
                                        <i>Jackie Chan</i>
                                    </figcaption>
                                </figure>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
        <!-- Footer -->
        <%@include file="footer.jsp" %>
        <script src="https://cdn.jsdelivr.net/npm/masonry-layout@4.2.2/dist/masonry.pkgd.min.js" integrity="sha384-GNFwBvfVxBkLMJpYMOABq3c+d3KnQxudP/mGPkzpZSTYykLBNsZEnG2D9G/X/+7D" crossorigin="anonymous" async></script>
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
