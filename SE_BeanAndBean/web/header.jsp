
<%@page import="model.User"%>
<%@page import="model.Cart"%>
<header class="flex-wrap align-items-center justify-content-center justify-content-md-between py-2 mb-3 accent-color">
    <link rel="stylesheet" type="text/css" href = "CSS/webcss.css"/>
    <nav class="navbar navbar-expand-lg navbar-light">
        <div class="container-fluid">
            <a href="home.jsp" class="d-flex align-items-center col-md-5 mb-2 mb-md-0 text-dark text-decoration-none">
                <img src="Images/Bean.png" alt="logo" width="50" height="50" class="d-inline-block align-text-top">
                    <b style="padding: 10px;">Bean&Bean</b></a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarTogglerDemo02" aria-controls="navbarTogglerDemo02" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <!-- NAV LINKS -->
            <div class="collapse navbar-collapse" id="navbarTogglerDemo02">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link" aria-current="page" href="home.jsp">Home</a>
                    </li>
                    <li id="shop-dropdown" class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="shop.jsp" id="navbarDropdownMenuLink" role="button" aria-expanded="false">
                            Shop
                        </a>
                        <ul id="shop-dropdown-menu" class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                            <li><a class="dropdown-item" href="shop.jsp#premiumc">Premium Coffee</a></li>
                            <li><a class="dropdown-item" href="shop.jsp#hots">Hot Series</a></li>
                            <li><a class="dropdown-item" href="shop.jsp#colds">Cold Series</a></li>
                            <li><a class="dropdown-item" href="shop.jsp#csyrup">Coffee Syrups</a></li>
                            <li><a class="dropdown-item" href="shop.jsp#csauces">Coffee Sauces</a></li>
                        </ul>
                    </li>
                    <!-- <li class="nav-item">
                        <a class="nav-link" href="shop.jsp">Shop</a>
                    </li> -->
                    <li id="about-us-dropdown" class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="aboutus.jsp" id="navbarDropdownMenuLink" role="button" aria-expanded="false">
                            About Us
                        </a>
                        <ul id="about-us-dropdown-menu" class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                            <li><a class="dropdown-item" href="aboutus.jsp#faqs">FAQs</a></li>
                            <li><a class="dropdown-item" href="aboutus.jsp#gallery">Gallery</a></li>
                            <li><a class="dropdown-item" href="aboutus.jsp#reviews">Reviews</a></li>
                        </ul>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="contactus.jsp">Contact Us</a>
                    </li>
                </ul>
                <!-- ICONS -->
                <div class="text-end">
                    <a class="btn" href="success.jsp" style="color: black;">
                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-person" viewBox="0 0 16 16">
                            <path d="M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0zm4 8c0 1-1 1-1 1H3s-1 0-1-1 1-4 6-4 6 3 6 4zm-1-.004c-.001-.246-.154-.986-.832-1.664C11.516 10.68 10.289 10 8 10c-2.29 0-3.516.68-4.168 1.332-.678.678-.83 1.418-.832 1.664h10z"/>
                        </svg>
                    </a>
                    <% 
                        if((User)session.getAttribute("user") != null)
                        {
                    %>
                    <a class="btn" href="cart.jsp" style="color: black;">
                        <div id="cartItemIndicatorContainer">
                            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-cart3" viewBox="0 0 16 16">
                                <path d="M0 1.5A.5.5 0 0 1 .5 1H2a.5.5 0 0 1 .485.379L2.89 3H14.5a.5.5 0 0 1 .49.598l-1 5a.5.5 0 0 1-.465.401l-9.397.472L4.415 11H13a.5.5 0 0 1 0 1H4a.5.5 0 0 1-.491-.408L2.01 3.607 1.61 2H.5a.5.5 0 0 1-.5-.5zM3.102 4l.84 4.479 9.144-.459L13.89 4H3.102zM5 12a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm7 0a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm-7 1a1 1 0 1 1 0 2 1 1 0 0 1 0-2zm7 0a1 1 0 1 1 0 2 1 1 0 0 1 0-2z"/>
                            </svg>
                            <%
                                Cart userCart = (Cart)session.getAttribute("cart");
                                int amountInCart = 0;
                                if(userCart != null)
                                    amountInCart = userCart.getQuantityInCart();
                               
                                if(amountInCart>0) {
                            %>
                            <span id="cartItemIndicator">
                                <%
                                    out.print(amountInCart);
                                %>
                            </span>
                            <%}%>
                        </div>
                    </a>
                    <% 
                        }
                    %>
                </div>
            </div>
        </div>
    </nav>
</header>