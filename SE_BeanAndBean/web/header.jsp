
<%@page import="model.User"%>
<%@page import="model.Cart"%>
<header>
    <nav class="navbar fixed-top navbar-expand-lg accent-color p-md-3">
        <div class="container">
            <!-- <a class="navbar-brand" href="home.jsp">
            <img src="Images/Bean.png" alt="logo" width="30" height="24" class="d-inline-block align-text-top"><span class="fs-4 text-white">Bean&Bean</span></a> -->
            <a href="home.jsp" class="d-flex align-items-center mb-3 mb-md-0 me-md-auto text-dark text-decoration-none">
                <img src="Images/Bean.png" width="50" height="50">
                &nbsp;<span class="fs-4 text-white">Bean&Bean</span></a>
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
                            <li><a class="dropdown-item" href="shop.jsp#pc">Premium Coffee</a></li>
                            <li><a class="dropdown-item" href="shop.jsp#hs">Hot Series</a></li>
                            <li><a class="dropdown-item" href="shop.jsp#cs">Cold Series</a></li>
                            <li><a class="dropdown-item" href="shop.jsp#sy">Coffee Syrups</a></li>
                            <li><a class="dropdown-item" href="shop.jsp#sa">Coffee Sauces</a></li></ul>
                    </li>
                    <li id="about-us-dropdown" class="nav-item dropdown">
                        <a class="nav-link text-white dropdown-toggle" href="aboutus.jsp" id="navbarDropdownMenuLink" role="button">About Us
                        </a>
                        <ul id="about-us-dropdown-menu" class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                            <li><a class="dropdown-item" href="aboutus.jsp#faqs">FAQs</a></li>
                            <li><a class="dropdown-item" href="aboutus.jsp#gallery">Gallery</a></li>
                            <li><a class="dropdown-item" href="aboutus.jsp#reviews">Reviews</a></li>
                        </ul>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-white" href="contactus.jsp">Contact Us</a>
                    </li>
                    <!-- <li class="nav-item">
                        <a class="nav-link text-white" href="#">Contact</a>
                    </li> -->
                    <div class="text-end">
                        <a class="btn" href="success.jsp" style="color: white;">
                            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-person" viewBox="0 0 16 16">
                            <path d="M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0zm4 8c0 1-1 1-1 1H3s-1 0-1-1 1-4 6-4 6 3 6 4zm-1-.004c-.001-.246-.154-.986-.832-1.664C11.516 10.68 10.289 10 8 10c-2.29 0-3.516.68-4.168 1.332-.678.678-.83 1.418-.832 1.664h10z"/>
                            </svg>
                        </a>
                        <%
                            if ((User) session.getAttribute("user") != null) {
                        %>
                        <a class="btn" href="cart.jsp" style="color: white;">
                            <div id="cartItemIndicatorContainer">
                                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-cart3" viewBox="0 0 16 16">
                                <path d="M0 1.5A.5.5 0 0 1 .5 1H2a.5.5 0 0 1 .485.379L2.89 3H14.5a.5.5 0 0 1 .49.598l-1 5a.5.5 0 0 1-.465.401l-9.397.472L4.415 11H13a.5.5 0 0 1 0 1H4a.5.5 0 0 1-.491-.408L2.01 3.607 1.61 2H.5a.5.5 0 0 1-.5-.5zM3.102 4l.84 4.479 9.144-.459L13.89 4H3.102zM5 12a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm7 0a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm-7 1a1 1 0 1 1 0 2 1 1 0 0 1 0-2zm7 0a1 1 0 1 1 0 2 1 1 0 0 1 0-2z"/>
                                </svg>
                                <%
                                    Cart userCart = (Cart) session.getAttribute("cart");
                                    int amountInCart = 0;
                                    if (userCart != null) {
                                        amountInCart = userCart.getQuantityInCart();
                                    }

                                    if (amountInCart > 0) {
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
                </ul>
            </div>
        </div>
    </nav>
</header>