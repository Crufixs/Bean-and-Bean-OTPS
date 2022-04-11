
<%@page import="model.User"%>
<%@page import="model.Cart"%>
        <header>
            <!-- <style>
              .banner-image {
                background-image: url('img/banner-img.jpg');
                background-size: cover;
              }
            </style> -->
            <!-- Navbar  -->
            <nav class="navbar fixed-top navbar-expand-lg navbar-dark p-md-3" style="background-color: #6f4e37">
                <div class="container">
                    <!-- <a class="navbar-brand" href="home.jsp">
                    <img src="Images/logo-plain.png" alt="logo" width="30" height="24" class="d-inline-block align-text-top"><span class="fs-4 text-white">Bean&Bean</span></a> -->
                    <a href="home.jsp" class="d-flex align-items-center mb-3 mb-md-0 me-md-auto text-dark text-decoration-none">
                        <img src="Images/logo-plain.png" width="50" height="50">
                        &nbsp;<span class="fs-4 text-white">Bean & Bean</span></a>
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
            <!-- <script src="js/bootstrap.bundle.min.js"></script>
            <script type="text/javascript">
                var nav = document.querySelector('nav');

                window.addEventListener('scroll', function () {
                    if (window.pageYOffset > 100) {
                        nav.classList.add('bg-dark', 'shadow');
                    } else {
                        nav.classList.remove('bg-dark', 'shadow');
                    }
                });
            </script> -->
        </header>
