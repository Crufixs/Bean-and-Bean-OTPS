<%@page import="model.User"%>
<%@page import="model.Product"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Shop | Bean&Bean</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-wEmeIV1mKuiNpC+IOBjI7aAzPcEZeedi5yW5f2yOq55WWLwNGmvvx4Um1vskeMj0" crossorigin="anonymous">
        <link rel="stylesheet" href="CSS/shop.css">
        <%

            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
            response.setHeader("Pragma", "no-cache");
            response.setDateHeader("Expires", 0);

            List<Product> products = (List) getServletContext().getAttribute("products");
            Cart c = (Cart) session.getAttribute("cart");
            User u = (User) session.getAttribute("user");
            if (u == null) {
//                response.sendRedirect("home.jsp");
//                return;
            }
        %>
        <script>
            function incrementQuantity(id) {
                var quantityElement = document.getElementById('quantity' + id);
                var quantityElementAgain = document.getElementById('quantityAgain' + id);
                console.log("INCREMENT");
                if (quantityElement.value < 9) {
                    quantityElement.value++;
                    quantityElementAgain.value++;
                    var priceElement = document.getElementById('price' + id);
                    priceElement.value = (priceElement.value / (quantityElement.value - 1)) * quantityElement.value;
                    var priceElementAgain = document.getElementById('priceAgain' + id);
                    priceElementAgain.value = (priceElementAgain.value / (quantityElementAgain.value - 1)) * quantityElementAgain.value;
                }
            }
            function decrementQuantity(id) {
                var quantityElement = document.getElementById('quantity' + id);
                var quantityElementAgain = document.getElementById('quantityAgain' + id);

                console.log('DECREMENT');
                if (quantityElement.value > 1) {
                    quantityElement.value--;
                    quantityElementAgain.value--;
                    var priceElement = document.getElementById('price' + id);
                    priceElement.value = (priceElement.value / (quantityElement.value - (-1))) * quantityElement.value;
                    var priceElementAgain = document.getElementById('priceAgain' + id);
                    priceElementAgain.value = (priceElementAgain.value / (quantityElement.value - (-1))) * quantityElement.value;

                }
            }
            function resetQuantity(id) {
                console.log("RESET");
                var quantityElement = document.getElementById('quantity' + id);
                var quantityElementAgain = document.getElementById('quantityAgain' + id);
                var priceElement = document.getElementById('price' + id);
                var priceElementAgain = document.getElementById('priceAgain' + id);
                priceElement.value = priceElement.value / quantityElement.value;
                priceElementAgain.value = priceElementAgain.value / quantityElementAgain.value;
                quantityElement.value = 1;
                quantityElementAgain.value = 1;
            }
        </script>
    </head>
    <body style="background-color: #F0E7DE;">
        <!-- HEADER -->
        <%@include file="header.jsp" %>

        <div class="container">
            <!-- PhotoCover Codes -->
            <div
                class="bg-image p-5 text-center shadow-1-strong rounded mb-5 text-white mt-4"
                style="background-image: url('Images/bg.jpg'); height: 200px;"
                >
                <br>
                <h2 class="mb-3" style="color: white;">Bean&Bean Products</h2>
            </div>
            <div class="d-flex align-items-start">
                <div class="nav flex-column nav-pills me-3" id="v-pills-tab" role="tablist" aria-orientation="vertical">
                    <button class="nav-link active" id="v-pills-ap-tab" data-bs-toggle="pill" data-bs-target="#v-pills-ap" type="button" role="tab" aria-controls="v-pills-ap" aria-selected="true">All Products</button>
                    <button class="nav-link" id="v-pills-pc-tab" data-bs-toggle="pill" data-bs-target="#v-pills-pc" type="button" role="tab" aria-controls="v-pills-pc" aria-selected="false">Premium Coffee</button>
                    <button class="nav-link" id="v-pills-hs-tab" data-bs-toggle="pill" data-bs-target="#v-pills-hs" type="button" role="tab" aria-controls="v-pills-hs" aria-selected="false">Hot Series</button>
                    <button class="nav-link" id="v-pills-cs-tab" data-bs-toggle="pill" data-bs-target="#v-pills-cs" type="button" role="tab" aria-controls="v-pills-cs" aria-selected="false">Cold Series</button>
                    <button class="nav-link" id="v-pills-sy-tab" data-bs-toggle="pill" data-bs-target="#v-pills-sy" type="button" role="tab" aria-controls="v-pills-sy" aria-selected="false">Coffee Syrups</button>
                    <button class="nav-link" id="v-pills-sa-tab" data-bs-toggle="pill" data-bs-target="#v-pills-sa" type="button" role="tab" aria-controls="v-pills-sa" aria-selected="false">Coffee Sauces</button>
                </div>
                <div class="tab-content" id="v-pills-tabContent" style="margin-bottom: 50px;">
                    <div class="tab-pane fade show active" id="v-pills-ap" role="tabpanel" aria-labelledby="v-pills-ap-tab"><!-- Premium Coffee Section -->
                        <div>
                            <h6 id="pc">Premium Coffee (250g)</h6>
                            <hr>
                            <%                                    for (int i = 0; i < products.size();) {
                            %>
                            <div class="row row-cols-1 row-cols-md-3 g-4" style="text-align: center; margin-bottom: 10px;">
                                <%
                                    int counter = 0;
                                    while (counter < 3) {
                                        if (i >= products.size()) {
                                            break;
                                        }
                                        Product p = products.get(i);
                                        i++;
                                        if (!p.getType().equals("pc")) {
                                            continue;
                                        }
                                        counter++;
                                %>
                                <div class="col">
                                    <div class="card mb-3">
                                        <img src="Images/<%=p.getId()%>.jpg" class="card-img-top">
                                        <div class="card-body">
                                            <h6 class="card-title"><%=p.getName()%></h6>
                                            <p class="card-text">&#8369;<%=p.getPrice()%></p>
                                            <form method="POST" action="cart">
                                                <input type="hidden" name="id" value="<%=p.getId()%>"/>
                                                <button type="button" class="w-100 btn btn-outline-secondary" data-bs-toggle="modal" data-bs-target="#<%
                                                    //if (u.getCustomerID() == -1) {
                                                    if (u == null || c == null) {
                                                        out.print("loginError");
                                                    } else if (c.findCartItem(p.getId()) == null) {
                                                        out.print("modal" + p.getId());
                                                    } else {
                                                        out.print("error" + p.getId());
                                                    }
                                                        %>">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="15" height="20" fill="currentColor" class="bi bi-cart3" viewBox="0 0 16 16">
                                                    <path d="M0 1.5A.5.5 0 0 1 .5 1H2a.5.5 0 0 1 .485.379L2.89 3H14.5a.5.5 0 0 1 .49.598l-1 5a.5.5 0 0 1-.465.401l-9.397.472L4.415 11H13a.5.5 0 0 1 0 1H4a.5.5 0 0 1-.491-.408L2.01 3.607 1.61 2H.5a.5.5 0 0 1-.5-.5zM3.102 4l.84 4.479 9.144-.459L13.89 4H3.102zM5 12a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm7 0a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm-7 1a1 1 0 1 1 0 2 1 1 0 0 1 0-2zm7 0a1 1 0 1 1 0 2 1 1 0 0 1 0-2z"/>
                                                    </svg> Add to Cart
                                                </button>
                                                <div class="modal fade" id="modal<%=p.getId()%>" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                    <div class="modal-dialog modal-dialog-centered">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title" id="exampleModalLabel">Add <%=p.getName()%> to your Cart?</h5>
                                                                <button onclick="resetQuantity(<%=p.getId()%>)"type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                            </div>
                                                            <div class="modal-body">
                                                                <img src="Images/<%=p.getId()%>.jpg" class="card-img-top img-thumbnail">
                                                                <div class="btn-group" style="width:100%; position: relative">
                                                                    <button onclick="incrementQuantity(<%=p.getId()%>)" type="button" class="btn btn-outline-success"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-plus" viewBox="0 0 16 16">
                                                                        <path d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4z"/>
                                                                        </svg></button>
                                                                    <button onclick="decrementQuantity(<%=p.getId()%>)" type="button" class="btn btn-outline-danger"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-dash" viewBox="0 0 16 16">
                                                                        <path d="M4 8a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7A.5.5 0 0 1 4 8z"/>
                                                                        </svg></button>
                                                                </div>
                                                            </div>
                                                            <div class="modal-footer">
                                                                <div class="row" style="width:100%">
                                                                    <p class="col-sm align-middle me-auto">
                                                                        Quantity: <input type="text" align="middle" class="form-control-plaintext form-inline" id="quantity<%=p.getId()%>" 
                                                                                         name="quantity" value="1" style="text-align: center; pointer-events:none;"/>
                                                                    </p><p class=" col-sm align-middle me-auto" >
                                                                        Price: &#8369;<input type="text" align="middle" class="form-control-plaintext form-inline" id="price<%=p.getId()%>"
                                                                                             name="price" value="<%=p.getPrice()%>" style="text-align: center; pointer-events:none;"/>
                                                                    </p>
                                                                </div>
                                                                <button type="submit" name="action" value="add" class="btn btn-primary">Submit</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="modal fade" id="error<%=p.getId()%>" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                    <div class="modal-dialog">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title" id="exampleModalLabel">Error</h5>
                                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                            </div>
                                                            <div class="modal-body">
                                                                Product is already in Cart!
                                                            </div>
                                                            <div class="modal-footer">
                                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="modal fade" id="loginError" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                    <div class="modal-dialog">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title" id="exampleModalLabel">Error</h5>
                                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                            </div>
                                                            <div class="modal-body">
                                                                Please Log-in first before buying any of our products
                                                            </div>
                                                            <div class="modal-footer">
                                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                                <%
                                    }
                                %>           
                            </div>
                            <%
                                }
                            %>
                        </div>
                        <!-- end of premium coffee -->
                        <!-- Hot Series Section -->
                        <div>
                            <h5 style="margin-top: 20px;" id="hs">Hot Series (8 oz.)</h5>
                            <hr>
                            <!-- 1st row cold brew -->
                            <%
                                for (int i = 0; i < products.size();) {
                            %>
                            <div class="row row-cols-1 row-cols-md-3 g-4" style="text-align: center;">
                                <!-- original b -->
                                <%
                                    int counter = 0;
                                    while (counter < 3) {
                                        if (i >= products.size()) {
                                            break;
                                        }
                                        Product p = products.get(i);
                                        i++;
                                        if (!p.getType().equals("hs")) {
                                            continue;
                                        }
                                        counter++;
                                %>
                                <div class="col">
                                    <div class="card mb-3">
                                        <img src="Images/<%=p.getId()%>.jpg" class="card-img-top">
                                        <div class="card-body">
                                            <h6 class="card-title"><%=p.getName()%></h6>
                                            <p class="card-text">&#8369;<%=p.getPrice()%></p>
                                            <form method="POST" action="cart">
                                                <input type="hidden" name="id" value="<%=p.getId()%>"/>
                                                <button type="button" class="w-100 btn btn-outline-secondary" data-bs-toggle="modal" data-bs-target="#<%
                                                    //if (u.getCustomerID() == -1) {
                                                    if (u == null || c == null) {
                                                        out.print("loginError");
                                                    } else if (c.findCartItem(p.getId()) == null) {
                                                        out.print("modal" + p.getId());
                                                    } else {
                                                        out.print("error" + p.getId());
                                                    }
                                                        %>">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="15" height="20" fill="currentColor" class="bi bi-cart3" viewBox="0 0 16 16">
                                                    <path d="M0 1.5A.5.5 0 0 1 .5 1H2a.5.5 0 0 1 .485.379L2.89 3H14.5a.5.5 0 0 1 .49.598l-1 5a.5.5 0 0 1-.465.401l-9.397.472L4.415 11H13a.5.5 0 0 1 0 1H4a.5.5 0 0 1-.491-.408L2.01 3.607 1.61 2H.5a.5.5 0 0 1-.5-.5zM3.102 4l.84 4.479 9.144-.459L13.89 4H3.102zM5 12a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm7 0a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm-7 1a1 1 0 1 1 0 2 1 1 0 0 1 0-2zm7 0a1 1 0 1 1 0 2 1 1 0 0 1 0-2z"/>
                                                    </svg> Add to Cart
                                                </button>
                                                <div class="modal fade" id="modal<%=p.getId()%>" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                    <div class="modal-dialog modal-dialog-centered">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title" id="exampleModalLabel">Add <%=p.getName()%> to your Cart?</h5>
                                                                <button onclick="resetQuantity(<%=p.getId()%>)"type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                            </div>
                                                            <div class="modal-body">
                                                                <img src="Images/<%=p.getId()%>.jpg" class="card-img-top img-thumbnail">
                                                                <div class="btn-group" style="width:100%; position: relative">
                                                                    <button onclick="incrementQuantity(<%=p.getId()%>)" type="button" class="btn btn-outline-success"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-plus" viewBox="0 0 16 16">
                                                                        <path d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4z"/>
                                                                        </svg></button>
                                                                    <button onclick="decrementQuantity(<%=p.getId()%>)" type="button" class="btn btn-outline-danger"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-dash" viewBox="0 0 16 16">
                                                                        <path d="M4 8a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7A.5.5 0 0 1 4 8z"/>
                                                                        </svg></button>
                                                                </div>
                                                            </div>
                                                            <div class="modal-footer">
                                                                <div class="row" style="width:100%">
                                                                    <p class="col-sm align-middle me-auto">
                                                                        Quantity: <input type="text" align="middle" class="form-control-plaintext form-inline" id="quantity<%=p.getId()%>" 
                                                                                         name="quantity" value="1" style="text-align: center; pointer-events:none;"/>
                                                                    </p><p class=" col-sm align-middle me-auto" >
                                                                        Price: &#8369;<input type="text" align="middle" class="form-control-plaintext form-inline" id="price<%=p.getId()%>"
                                                                                             name="price" value="<%=p.getPrice()%>" style="text-align: center; pointer-events:none;"/>
                                                                    </p>
                                                                </div>
                                                                <button type="submit" name="action" value="add" class="btn btn-primary">Submit</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="modal fade" id="error<%=p.getId()%>" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                    <div class="modal-dialog">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title" id="exampleModalLabel">Error</h5>
                                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                            </div>
                                                            <div class="modal-body">
                                                                Product is already in Cart!
                                                            </div>
                                                            <div class="modal-footer">
                                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="modal fade" id="loginError" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                    <div class="modal-dialog">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title" id="exampleModalLabel">Error</h5>
                                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                            </div>
                                                            <div class="modal-body">
                                                                Please Log-in first before buying any of our products
                                                            </div>
                                                            <div class="modal-footer">
                                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                                <%
                                    }
                                %>           
                            </div>
                            <%
                                }
                            %>
                            <!-- end of cold brew section -->
                            <!-- iced coffee section -->
                            <br>
                        </div>
                        <!-- end of hot series -->
                        <br>
                        <!-- cold series section -->
                        <div>
                            <h5 style="margin-top: 20px;" id="cs">Cold Series (12 oz.)</h5>
                            <hr>
                            <!-- 1st row iced coffee -->
                            <%
                                for (int i = 0; i < products.size();) {
                            %>
                            <div class="row row-cols-1 row-cols-md-3 g-4" style="text-align: center;">
                                <!-- orig -->
                                <%
                                    int counter = 0;
                                    while (counter < 3) {
                                        if (i >= products.size()) {
                                            break;
                                        }
                                        Product p = products.get(i);
                                        i++;
                                        if (!p.getType().equals("cs")) {
                                            continue;
                                        }
                                        counter++;
                                %>    
                                <div class="col">
                                    <div class="card mb-3">
                                        <img src="Images/<%=p.getId()%>.jpg" class="card-img-top">
                                        <div class="card-body">
                                            <h6 class="card-title"><%=p.getName()%></h6>
                                            <p class="card-text">&#8369;<%=p.getPrice()%></p>
                                            <form method="POST" action="cart">
                                                <input type="hidden" name="id" value="<%=p.getId()%>"/>
                                                <button type="button" class="w-100 btn btn-outline-secondary" data-bs-toggle="modal" data-bs-target="#<%
                                                    //if (u.getCustomerID() == -1) {
                                                    if (u == null || c == null) {
                                                        out.print("loginError");
                                                    } else if (c.findCartItem(p.getId()) == null) {
                                                        out.print("modal" + p.getId());
                                                    } else {
                                                        out.print("error" + p.getId());
                                                    }
                                                        %>">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="15" height="20" fill="currentColor" class="bi bi-cart3" viewBox="0 0 16 16">
                                                    <path d="M0 1.5A.5.5 0 0 1 .5 1H2a.5.5 0 0 1 .485.379L2.89 3H14.5a.5.5 0 0 1 .49.598l-1 5a.5.5 0 0 1-.465.401l-9.397.472L4.415 11H13a.5.5 0 0 1 0 1H4a.5.5 0 0 1-.491-.408L2.01 3.607 1.61 2H.5a.5.5 0 0 1-.5-.5zM3.102 4l.84 4.479 9.144-.459L13.89 4H3.102zM5 12a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm7 0a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm-7 1a1 1 0 1 1 0 2 1 1 0 0 1 0-2zm7 0a1 1 0 1 1 0 2 1 1 0 0 1 0-2z"/>
                                                    </svg> Add to Cart
                                                </button>
                                                <div class="modal fade" id="modal<%=p.getId()%>" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                    <div class="modal-dialog modal-dialog-centered">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title" id="exampleModalLabel">Add <%=p.getName()%> to your Cart?</h5>
                                                                <button onclick="resetQuantity(<%=p.getId()%>)"type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                            </div>
                                                            <div class="modal-body">
                                                                <img src="Images/<%=p.getId()%>.jpg" class="card-img-top img-thumbnail">
                                                                <div class="btn-group" style="width:100%; position: relative">
                                                                    <button onclick="incrementQuantity(<%=p.getId()%>)" type="button" class="btn btn-outline-success"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-plus" viewBox="0 0 16 16">
                                                                        <path d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4z"/>
                                                                        </svg></button>
                                                                    <button onclick="decrementQuantity(<%=p.getId()%>)" type="button" class="btn btn-outline-danger"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-dash" viewBox="0 0 16 16">
                                                                        <path d="M4 8a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7A.5.5 0 0 1 4 8z"/>
                                                                        </svg></button>
                                                                </div>
                                                            </div>
                                                            <div class="modal-footer">
                                                                <div class="row" style="width:100%">
                                                                    <p class="col-sm align-middle me-auto">
                                                                        Quantity: <input type="text" align="middle" class="form-control-plaintext form-inline" id="quantity<%=p.getId()%>" 
                                                                                         name="quantity" value="1" style="text-align: center; pointer-events:none;"/>
                                                                    </p><p class=" col-sm align-middle me-auto" >
                                                                        Price: &#8369;<input type="text" align="middle" class="form-control-plaintext form-inline" id="price<%=p.getId()%>"
                                                                                             name="price" value="<%=p.getPrice()%>" style="text-align: center; pointer-events:none;"/>
                                                                    </p>
                                                                </div>
                                                                <button type="submit" name="action" value="add" class="btn btn-primary">Submit</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="modal fade" id="error<%=p.getId()%>" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                    <div class="modal-dialog">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title" id="exampleModalLabel">Error</h5>
                                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                            </div>
                                                            <div class="modal-body">
                                                                Product is already in Cart!
                                                            </div>
                                                            <div class="modal-footer">
                                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="modal fade" id="loginError" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                    <div class="modal-dialog">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title" id="exampleModalLabel">Error</h5>
                                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                            </div>
                                                            <div class="modal-body">
                                                                Please Log-in first before buying any of our products
                                                            </div>
                                                            <div class="modal-footer">
                                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                                <%
                                    }
                                %>           
                            </div>
                            <%
                                }
                            %>
                        </div>
                        <!-- end of cold series -->
                        <br>
                        <!-- end of cold coffee -->
                        <!-- coffee syrup section -->
                        <div>
                            <h5 style="margin-top: 20px;" id="sy">Coffee Syrups (100 ml)</h5>
                            <hr>
                            <!-- 1st row iced coffee -->
                            <%
                                for (int i = 0; i < products.size();) {
                            %>
                            <div class="row row-cols-1 row-cols-md-3 g-4" style="text-align: center;">
                                <!-- orig -->
                                <%
                                    int counter = 0;
                                    while (counter < 3) {
                                        if (i >= products.size()) {
                                            break;
                                        }
                                        Product p = products.get(i);
                                        i++;
                                        if (!p.getType().equals("sy")) {
                                            continue;
                                        }
                                        counter++;
                                %>    
                                <div class="col">
                                    <div class="card mb-3">
                                        <img src="Images/<%=p.getId()%>.jpg" class="card-img-top">
                                        <div class="card-body">
                                            <h6 class="card-title"><%=p.getName()%></h6>
                                            <p class="card-text">&#8369;<%=p.getPrice()%></p>
                                            <form method="POST" action="cart">
                                                <input type="hidden" name="id" value="<%=p.getId()%>"/>
                                                <button type="button" class="w-100 btn btn-outline-secondary" data-bs-toggle="modal" data-bs-target="#<%
                                                    //if (u.getCustomerID() == -1) {
                                                    if (u == null || c == null) {
                                                        out.print("loginError2");
                                                    } else if (c.findCartItem(p.getId()) == null) {
                                                        out.print("modal2" + p.getId());
                                                    } else {
                                                        out.print("error2" + p.getId());
                                                    }
                                                        %>">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="15" height="20" fill="currentColor" class="bi bi-cart3" viewBox="0 0 16 16">
                                                    <path d="M0 1.5A.5.5 0 0 1 .5 1H2a.5.5 0 0 1 .485.379L2.89 3H14.5a.5.5 0 0 1 .49.598l-1 5a.5.5 0 0 1-.465.401l-9.397.472L4.415 11H13a.5.5 0 0 1 0 1H4a.5.5 0 0 1-.491-.408L2.01 3.607 1.61 2H.5a.5.5 0 0 1-.5-.5zM3.102 4l.84 4.479 9.144-.459L13.89 4H3.102zM5 12a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm7 0a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm-7 1a1 1 0 1 1 0 2 1 1 0 0 1 0-2zm7 0a1 1 0 1 1 0 2 1 1 0 0 1 0-2z"/>
                                                    </svg> Add to Cart
                                                </button>
                                                <div class="modal fade" id="modal2<%=p.getId()%>" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                    <div class="modal-dialog modal-dialog-centered">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title" id="exampleModalLabel">Add <%=p.getName()%> to your Cart?</h5>
                                                                <button onclick="resetQuantity(<%=p.getId()%>)"type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                            </div>
                                                            <div class="modal-body">
                                                                <img src="Images/<%=p.getId()%>.jpg" class="card-img-top img-thumbnail">
                                                                <div class="btn-group" style="width:100%; position: relative">
                                                                    <button onclick="incrementQuantity(<%=p.getId()%>)" type="button" class="btn btn-outline-success"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-plus" viewBox="0 0 16 16">
                                                                        <path d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4z"/>
                                                                        </svg></button>
                                                                    <button onclick="decrementQuantity(<%=p.getId()%>)" type="button" class="btn btn-outline-danger"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-dash" viewBox="0 0 16 16">
                                                                        <path d="M4 8a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7A.5.5 0 0 1 4 8z"/>
                                                                        </svg></button>
                                                                </div>
                                                            </div>
                                                            <div class="modal-footer">
                                                                <div class="row" style="width:100%">
                                                                    <p class="col-sm align-middle me-auto">
                                                                        Quantity: <input type="text" align="middle" class="form-control-plaintext form-inline" id="quantity<%=p.getId()%>" 
                                                                                         name="quantity" value="1" style="text-align: center; pointer-events:none;"/>
                                                                    </p><p class=" col-sm align-middle me-auto" >
                                                                        Price: &#8369;<input type="text" align="middle" class="form-control-plaintext form-inline" id="price<%=p.getId()%>"
                                                                                             name="price" value="<%=p.getPrice()%>" style="text-align: center; pointer-events:none;"/>
                                                                    </p>
                                                                </div>
                                                                <button type="submit" name="action" value="add" class="btn btn-primary">Submit</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="modal fade" id="error2<%=p.getId()%>" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                    <div class="modal-dialog">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title" id="exampleModalLabel">Error</h5>
                                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                            </div>
                                                            <div class="modal-body">
                                                                Product is already in Cart!
                                                            </div>
                                                            <div class="modal-footer">
                                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="modal fade" id="loginError2" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                    <div class="modal-dialog">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title" id="exampleModalLabel">Error</h5>
                                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                            </div>
                                                            <div class="modal-body">
                                                                Please Log-in first before buying any of our products
                                                            </div>
                                                            <div class="modal-footer">
                                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                                <%
                                    }
                                %>           
                            </div>
                            <%
                                }
                            %>
                        </div>
                        <!-- end of coffee syrup -->
                        <br>
                        <!-- coffee sauces section-->
                        <div>
                            <h5 style="margin-top: 20px;" id="sa">Coffee Sauces (100 ml)</h5>
                            <hr>
                            <!-- 1st row iced coffee -->
                            <%
                                for (int i = 0; i < products.size();) {
                            %>
                            <div class="row row-cols-1 row-cols-md-3 g-4" style="text-align: center;">
                                <!-- orig -->
                                <%
                                    int counter = 0;
                                    while (counter < 3) {
                                        if (i >= products.size()) {
                                            break;
                                        }
                                        Product p = products.get(i);
                                        i++;
                                        if (!p.getType().equals("sa")) {
                                            continue;
                                        }
                                        counter++;
                                %>    
                                <div class="col">
                                    <div class="card mb-3">
                                        <img src="Images/<%=p.getId()%>.jpg" class="card-img-top">
                                        <div class="card-body">
                                            <h6 class="card-title"><%=p.getName()%></h6>
                                            <p class="card-text">&#8369;<%=p.getPrice()%></p>
                                            <form method="POST" action="cart">
                                                <input type="hidden" name="id" value="<%=p.getId()%>"/>
                                                <button type="button" class="w-100 btn btn-outline-secondary" data-bs-toggle="modal" data-bs-target="#<%
                                                    //if (u.getCustomerID() == -1) {
                                                    if (u == null || c == null) {
                                                        out.print("loginError");
                                                    } else if (c.findCartItem(p.getId()) == null) {
                                                        out.print("modal" + p.getId());
                                                    } else {
                                                        out.print("error" + p.getId());
                                                    }
                                                        %>">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="15" height="20" fill="currentColor" class="bi bi-cart3" viewBox="0 0 16 16">
                                                    <path d="M0 1.5A.5.5 0 0 1 .5 1H2a.5.5 0 0 1 .485.379L2.89 3H14.5a.5.5 0 0 1 .49.598l-1 5a.5.5 0 0 1-.465.401l-9.397.472L4.415 11H13a.5.5 0 0 1 0 1H4a.5.5 0 0 1-.491-.408L2.01 3.607 1.61 2H.5a.5.5 0 0 1-.5-.5zM3.102 4l.84 4.479 9.144-.459L13.89 4H3.102zM5 12a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm7 0a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm-7 1a1 1 0 1 1 0 2 1 1 0 0 1 0-2zm7 0a1 1 0 1 1 0 2 1 1 0 0 1 0-2z"/>
                                                    </svg> Add to Cart
                                                </button>
                                                <div class="modal fade" id="modal<%=p.getId()%>" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                    <div class="modal-dialog modal-dialog-centered">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title" id="exampleModalLabel">Add <%=p.getName()%> to your Cart?</h5>
                                                                <button onclick="resetQuantity(<%=p.getId()%>)"type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                            </div>
                                                            <div class="modal-body">
                                                                <img src="Images/<%=p.getId()%>.jpg" class="card-img-top img-thumbnail">
                                                                <div class="btn-group" style="width:100%; position: relative">
                                                                    <button onclick="incrementQuantity(<%=p.getId()%>)" type="button" class="btn btn-outline-success"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-plus" viewBox="0 0 16 16">
                                                                        <path d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4z"/>
                                                                        </svg></button>
                                                                    <button onclick="decrementQuantity(<%=p.getId()%>)" type="button" class="btn btn-outline-danger"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-dash" viewBox="0 0 16 16">
                                                                        <path d="M4 8a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7A.5.5 0 0 1 4 8z"/>
                                                                        </svg></button>
                                                                </div>
                                                            </div>
                                                            <div class="modal-footer">
                                                                <div class="row" style="width:100%">
                                                                    <p class="col-sm align-middle me-auto">
                                                                        Quantity: <input type="text" align="middle" class="form-control-plaintext form-inline" id="quantity<%=p.getId()%>" 
                                                                                         name="quantity" value="1" style="text-align: center; pointer-events:none;"/>
                                                                    </p><p class=" col-sm align-middle me-auto" >
                                                                        Price: &#8369;<input type="text" align="middle" class="form-control-plaintext form-inline" id="price<%=p.getId()%>"
                                                                                             name="price" value="<%=p.getPrice()%>" style="text-align: center; pointer-events:none;"/>
                                                                    </p>
                                                                </div>
                                                                <button type="submit" name="action" value="add" class="btn btn-primary">Submit</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="modal fade" id="error<%=p.getId()%>" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                    <div class="modal-dialog">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title" id="exampleModalLabel">Error</h5>
                                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                            </div>
                                                            <div class="modal-body">
                                                                Product is already in Cart!
                                                            </div>
                                                            <div class="modal-footer">
                                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="modal fade" id="loginError" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                    <div class="modal-dialog">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title" id="exampleModalLabel">Error</h5>
                                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                            </div>
                                                            <div class="modal-body">
                                                                Please Log-in first before buying any of our products
                                                            </div>
                                                            <div class="modal-footer">
                                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                                <%
                                    }
                                %>           
                            </div>
                            <%
                                }
                            %>
                        </div>
                        <!-- end of coffee sauces --></div>
                    <div class="tab-pane fade" id="v-pills-pc" role="tabpanel" aria-labelledby="v-pills-pc-tab"><h5 id="pc">Premium Coffee (250g)</h5>
                        <hr>
                        <%                    for (int i = 0; i < products.size();) {
                        %>
                        <div class="row row-cols-1 row-cols-md-3 g-4" style="text-align: center;">
                            <%
                                int counter = 0;
                                while (counter < 3) {
                                    if (i >= products.size()) {
                                        break;
                                    }
                                    Product p = products.get(i);
                                    i++;
                                    if (!p.getType().equals("pc")) {
                                        continue;
                                    }
                                    counter++;
                            %>
                            <div class="col">
                                <div class="card mb-3">
                                    <img src="Images/<%=p.getId()%>.jpg" class="card-img-top">
                                    <div class="card-body">
                                        <h5 class="card-title"><%=p.getName()%></h5>
                                        <p class="card-text">&#8369;<%=p.getPrice()%></p>
                                        <form method="POST" action="cart">
                                            <input type="hidden" name="id" value="<%=p.getId()%>"/>
                                            <button type="button" class="w-100 btn btn-outline-secondary" data-bs-toggle="modal" data-bs-target="#<%
                                                //if (u.getCustomerID() == -1) {
                                                if (u == null || c == null) {
                                                    out.print("loginErrorAgain");
                                                } else if (c.findCartItem(p.getId()) == null) {
                                                    out.print("modalAgain" + p.getId());
                                                } else {
                                                    out.print("errorAgain" + p.getId());
                                                }
                                                    %>">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="15" height="20" fill="currentColor" class="bi bi-cart3" viewBox="0 0 16 16">
                                                <path d="M0 1.5A.5.5 0 0 1 .5 1H2a.5.5 0 0 1 .485.379L2.89 3H14.5a.5.5 0 0 1 .49.598l-1 5a.5.5 0 0 1-.465.401l-9.397.472L4.415 11H13a.5.5 0 0 1 0 1H4a.5.5 0 0 1-.491-.408L2.01 3.607 1.61 2H.5a.5.5 0 0 1-.5-.5zM3.102 4l.84 4.479 9.144-.459L13.89 4H3.102zM5 12a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm7 0a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm-7 1a1 1 0 1 1 0 2 1 1 0 0 1 0-2zm7 0a1 1 0 1 1 0 2 1 1 0 0 1 0-2z"/>
                                                </svg> Add to Cart
                                            </button>
                                            <div class="modal fade" id="modalAgain<%=p.getId()%>" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                <div class="modal-dialog modal-dialog-centered">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title" id="exampleModalLabel">Add <%=p.getName()%> to your Cart?</h5>
                                                            <button onclick="resetQuantity(<%=p.getId()%>)"type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                        </div>
                                                        <div class="modal-body">
                                                            <img src="Images/<%=p.getId()%>.jpg" class="card-img-top img-thumbnail">
                                                            <div class="btn-group" style="width:100%; position: relative">
                                                                <button onclick="incrementQuantity(<%=p.getId()%>)" type="button" class="btn btn-outline-success"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-plus" viewBox="0 0 16 16">
                                                                    <path d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4z"/>
                                                                    </svg></button>
                                                                <button onclick="decrementQuantity(<%=p.getId()%>)" type="button" class="btn btn-outline-danger"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-dash" viewBox="0 0 16 16">
                                                                    <path d="M4 8a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7A.5.5 0 0 1 4 8z"/>
                                                                    </svg></button>
                                                            </div>
                                                        </div>
                                                        <div class="modal-footer">
                                                            <div class="row" style="width:100%">
                                                                <p class="col-sm align-middle me-auto">
                                                                    Quantity: <input type="text" align="middle" class="form-control-plaintext form-inline" id="quantityAgain<%=p.getId()%>" 
                                                                                     name="quantity" value="1" style="text-align: center; pointer-events:none;"/>
                                                                </p><p class=" col-sm align-middle me-auto" >
                                                                    Price: &#8369;<input type="text" align="middle" class="form-control-plaintext form-inline" id="priceAgain<%=p.getId()%>"
                                                                                         name="price" value="<%=p.getPrice()%>" style="text-align: center; pointer-events:none;"/>
                                                                </p>
                                                            </div>
                                                            <button type="submit" name="action" value="add" class="btn btn-primary">Submit</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="modal fade" id="errorAgain<%=p.getId()%>" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                <div class="modal-dialog">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title" id="exampleModalLabel">Error</h5>
                                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                        </div>
                                                        <div class="modal-body">
                                                            Product is already in Cart!
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="modal fade" id="loginErrorAgain" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                <div class="modal-dialog">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title" id="exampleModalLabel">Error</h5>
                                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                        </div>
                                                        <div class="modal-body">
                                                            Please Log-in first before buying any of our products
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                            <%
                                }
                            %>           
                        </div>
                        <%
                            }
                        %></div>
                    <div class="tab-pane fade" id="v-pills-hs" role="tabpanel" aria-labelledby="v-pills-hs-tab"><div>
                            <h5 id="hs">Hot Series (8 oz.)</h5>
                            <hr>
                            <!-- 1st row cold brew -->
                            <%
                                for (int i = 0; i < products.size();) {
                            %>
                            <div class="row row-cols-1 row-cols-md-3 g-4" style="text-align: center;">
                                <!-- original b -->
                                <%
                                    int counter = 0;
                                    while (counter < 3) {
                                        if (i >= products.size()) {
                                            break;
                                        }
                                        Product p = products.get(i);
                                        i++;
                                        if (!p.getType().equals("hs")) {
                                            continue;
                                        }
                                        counter++;
                                %>
                                <div class="col">
                                    <div class="card mb-3">
                                        <img src="Images/<%=p.getId()%>.jpg" class="card-img-top">
                                        <div class="card-body">
                                            <h6 class="card-title"><%=p.getName()%></h6>
                                            <p class="card-text">&#8369;<%=p.getPrice()%></p>
                                            <form method="POST" action="cart">
                                                <input type="hidden" name="id" value="<%=p.getId()%>"/>
                                                <button type="button" class="w-100 btn btn-outline-secondary" data-bs-toggle="modal" data-bs-target="#<%
                                                    //if (u.getCustomerID() == -1) {
                                                    if (u == null || c == null) {
                                                        out.print("loginErrorAgain");
                                                    } else if (c.findCartItem(p.getId()) == null) {
                                                        out.print("modalAgain" + p.getId());
                                                    } else {
                                                        out.print("errorAgain" + p.getId());
                                                    }
                                                        %>">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="15" height="20" fill="currentColor" class="bi bi-cart3" viewBox="0 0 16 16">
                                                    <path d="M0 1.5A.5.5 0 0 1 .5 1H2a.5.5 0 0 1 .485.379L2.89 3H14.5a.5.5 0 0 1 .49.598l-1 5a.5.5 0 0 1-.465.401l-9.397.472L4.415 11H13a.5.5 0 0 1 0 1H4a.5.5 0 0 1-.491-.408L2.01 3.607 1.61 2H.5a.5.5 0 0 1-.5-.5zM3.102 4l.84 4.479 9.144-.459L13.89 4H3.102zM5 12a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm7 0a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm-7 1a1 1 0 1 1 0 2 1 1 0 0 1 0-2zm7 0a1 1 0 1 1 0 2 1 1 0 0 1 0-2z"/>
                                                    </svg> Add to Cart
                                                </button>
                                                <div class="modal fade" id="modalAgain<%=p.getId()%>" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                    <div class="modal-dialog modal-dialog-centered">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title" id="exampleModalLabel">Add <%=p.getName()%> to your Cart?</h5>
                                                                <button onclick="resetQuantity(<%=p.getId()%>)"type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                            </div>
                                                            <div class="modal-body">
                                                                <img src="Images/<%=p.getId()%>.jpg" class="card-img-top img-thumbnail">
                                                                <div class="btn-group" style="width:100%; position: relative">
                                                                    <button onclick="incrementQuantity(<%=p.getId()%>)" type="button" class="btn btn-outline-success"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-plus" viewBox="0 0 16 16">
                                                                        <path d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4z"/>
                                                                        </svg></button>
                                                                    <button onclick="decrementQuantity(<%=p.getId()%>)" type="button" class="btn btn-outline-danger"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-dash" viewBox="0 0 16 16">
                                                                        <path d="M4 8a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7A.5.5 0 0 1 4 8z"/>
                                                                        </svg></button>
                                                                </div>
                                                            </div>
                                                            <div class="modal-footer">
                                                                <div class="row" style="width:100%">
                                                                    <p class="col-sm align-middle me-auto">
                                                                        Quantity: <input type="text" align="middle" class="form-control-plaintext form-inline" id="quantityAgain<%=p.getId()%>" 
                                                                                         name="quantity" value="1" style="text-align: center; pointer-events:none;"/>
                                                                    </p><p class=" col-sm align-middle me-auto" >
                                                                        Price: &#8369;<input type="text" align="middle" class="form-control-plaintext form-inline" id="priceAgain<%=p.getId()%>"
                                                                                             name="price" value="<%=p.getPrice()%>" style="text-align: center; pointer-events:none;"/>
                                                                    </p>
                                                                </div>
                                                                <button type="submit" name="action" value="add" class="btn btn-primary">Submit</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="modal fade" id="errorAgain<%=p.getId()%>" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                    <div class="modal-dialog">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title" id="exampleModalLabel">Error</h5>
                                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                            </div>
                                                            <div class="modal-body">
                                                                Product is already in Cart!
                                                            </div>
                                                            <div class="modal-footer">
                                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="modal fade" id="loginErrorAgain" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                    <div class="modal-dialog">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title" id="exampleModalLabel">Error</h5>
                                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                            </div>
                                                            <div class="modal-body">
                                                                Please Log-in first before buying any of our products
                                                            </div>
                                                            <div class="modal-footer">
                                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                                <%
                                    }
                                %>           
                            </div>
                            <%
                                }
                            %>
                        </div></div>
                    <div class="tab-pane fade" id="v-pills-cs" role="tabpanel" aria-labelledby="v-pills-cs-tab"><h5 id="cs">Cold Series (12 oz.)</h5>
                        <hr>
                        <!-- 1st row iced coffee -->
                        <%
                            for (int i = 0; i < products.size();) {
                        %>
                        <div class="row row-cols-1 row-cols-md-3 g-4" style="text-align: center;">
                            <!-- orig -->
                            <%
                                int counter = 0;
                                while (counter < 3) {
                                    if (i >= products.size()) {
                                        break;
                                    }
                                    Product p = products.get(i);
                                    i++;
                                    if (!p.getType().equals("cs")) {
                                        continue;
                                    }
                                    counter++;
                            %>    
                            <div class="col">
                                <div class="card mb-3">
                                    <img src="Images/<%=p.getId()%>.jpg" class="card-img-top">
                                    <div class="card-body">
                                        <h6 class="card-title"><%=p.getName()%></h6>
                                        <p class="card-text">&#8369;<%=p.getPrice()%></p>
                                        <form method="POST" action="cart">
                                            <input type="hidden" name="id" value="<%=p.getId()%>"/>
                                            <button type="button" class="w-100 btn btn-outline-secondary" data-bs-toggle="modal" data-bs-target="#<%
                                                //if (u.getCustomerID() == -1) {
                                                if (u == null || c == null) {
                                                    out.print("loginErrorAgain");
                                                } else if (c.findCartItem(p.getId()) == null) {
                                                    out.print("modalAgain" + p.getId());
                                                } else {
                                                    out.print("errorAgain" + p.getId());
                                                }
                                                    %>">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="15" height="20" fill="currentColor" class="bi bi-cart3" viewBox="0 0 16 16">
                                                <path d="M0 1.5A.5.5 0 0 1 .5 1H2a.5.5 0 0 1 .485.379L2.89 3H14.5a.5.5 0 0 1 .49.598l-1 5a.5.5 0 0 1-.465.401l-9.397.472L4.415 11H13a.5.5 0 0 1 0 1H4a.5.5 0 0 1-.491-.408L2.01 3.607 1.61 2H.5a.5.5 0 0 1-.5-.5zM3.102 4l.84 4.479 9.144-.459L13.89 4H3.102zM5 12a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm7 0a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm-7 1a1 1 0 1 1 0 2 1 1 0 0 1 0-2zm7 0a1 1 0 1 1 0 2 1 1 0 0 1 0-2z"/>
                                                </svg> Add to Cart
                                            </button>
                                            <div class="modal fade" id="modalAgain<%=p.getId()%>" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                <div class="modal-dialog modal-dialog-centered">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title" id="exampleModalLabel">Add <%=p.getName()%> to your Cart?</h5>
                                                            <button onclick="resetQuantity(<%=p.getId()%>)"type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                        </div>
                                                        <div class="modal-body">
                                                            <img src="Images/<%=p.getId()%>.jpg" class="card-img-top img-thumbnail">
                                                            <div class="btn-group" style="width:100%; position: relative">
                                                                <button onclick="incrementQuantity(<%=p.getId()%>)" type="button" class="btn btn-outline-success"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-plus" viewBox="0 0 16 16">
                                                                    <path d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4z"/>
                                                                    </svg></button>
                                                                <button onclick="decrementQuantity(<%=p.getId()%>)" type="button" class="btn btn-outline-danger"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-dash" viewBox="0 0 16 16">
                                                                    <path d="M4 8a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7A.5.5 0 0 1 4 8z"/>
                                                                    </svg></button>
                                                            </div>
                                                        </div>
                                                        <div class="modal-footer">
                                                            <div class="row" style="width:100%">
                                                                <p class="col-sm align-middle me-auto">
                                                                    Quantity: <input type="text" align="middle" class="form-control-plaintext form-inline" id="quantityAgain<%=p.getId()%>" 
                                                                                     name="quantity" value="1" style="text-align: center; pointer-events:none;"/>
                                                                </p><p class=" col-sm align-middle me-auto" >
                                                                    Price: &#8369;<input type="text" align="middle" class="form-control-plaintext form-inline" id="priceAgain<%=p.getId()%>"
                                                                                         name="price" value="<%=p.getPrice()%>" style="text-align: center; pointer-events:none;"/>
                                                                </p>
                                                            </div>
                                                            <button type="submit" name="action" value="add" class="btn btn-primary">Submit</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="modal fade" id="errorAgain<%=p.getId()%>" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                <div class="modal-dialog">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title" id="exampleModalLabel">Error</h5>
                                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                        </div>
                                                        <div class="modal-body">
                                                            Product is already in Cart!
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="modal fade" id="loginErrorAgain" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                <div class="modal-dialog">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title" id="exampleModalLabel">Error</h5>
                                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                        </div>
                                                        <div class="modal-body">
                                                            Please Log-in first before buying any of our products
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                            <%
                                }
                            %>           
                        </div>
                        <%
                            }
                        %></div>
                    <div class="tab-pane fade" id="v-pills-sy" role="tabpanel" aria-labelledby="v-pills-sy-tab"><h5 id="sy">Coffee Syrups (100 ml)</h5>
                        <hr>
                        <!-- 1st row iced coffee -->
                        <%
                            for (int i = 0; i < products.size();) {
                        %>
                        <div class="row row-cols-1 row-cols-md-3 g-4" style="text-align: center;">
                            <!-- orig -->
                            <%
                                int counter = 0;
                                while (counter < 3) {
                                    if (i >= products.size()) {
                                        break;
                                    }
                                    Product p = products.get(i);
                                    i++;
                                    if (!p.getType().equals("sy")) {
                                        continue;
                                    }
                                    counter++;
                            %>    
                            <div class="col">
                                <div class="card mb-3">
                                    <img src="Images/<%=p.getId()%>.jpg" class="card-img-top">
                                    <div class="card-body">
                                        <h6 class="card-title"><%=p.getName()%></h6>
                                        <p class="card-text">&#8369;<%=p.getPrice()%></p>
                                        <form method="POST" action="cart">
                                            <input type="hidden" name="id" value="<%=p.getId()%>"/>
                                            <button type="button" class="w-100 btn btn-outline-secondary" data-bs-toggle="modal" data-bs-target="#<%
                                                //if (u.getCustomerID() == -1) {
                                                if (u == null || c == null) {
                                                    out.print("loginErrorAgain");
                                                } else if (c.findCartItem(p.getId()) == null) {
                                                    out.print("modalAgain" + p.getId());
                                                } else {
                                                    out.print("errorAgain" + p.getId());
                                                }
                                                    %>">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="15" height="20" fill="currentColor" class="bi bi-cart3" viewBox="0 0 16 16">
                                                <path d="M0 1.5A.5.5 0 0 1 .5 1H2a.5.5 0 0 1 .485.379L2.89 3H14.5a.5.5 0 0 1 .49.598l-1 5a.5.5 0 0 1-.465.401l-9.397.472L4.415 11H13a.5.5 0 0 1 0 1H4a.5.5 0 0 1-.491-.408L2.01 3.607 1.61 2H.5a.5.5 0 0 1-.5-.5zM3.102 4l.84 4.479 9.144-.459L13.89 4H3.102zM5 12a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm7 0a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm-7 1a1 1 0 1 1 0 2 1 1 0 0 1 0-2zm7 0a1 1 0 1 1 0 2 1 1 0 0 1 0-2z"/>
                                                </svg> Add to Cart
                                            </button>
                                            <div class="modal fade" id="modalAgain<%=p.getId()%>" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                <div class="modal-dialog modal-dialog-centered">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title" id="exampleModalLabel">Add <%=p.getName()%> to your Cart?</h5>
                                                            <button onclick="resetQuantity(<%=p.getId()%>)"type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                        </div>
                                                        <div class="modal-body">
                                                            <img src="Images/<%=p.getId()%>.jpg" class="card-img-top img-thumbnail">
                                                            <div class="btn-group" style="width:100%; position: relative">
                                                                <button onclick="incrementQuantity(<%=p.getId()%>)" type="button" class="btn btn-outline-success"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-plus" viewBox="0 0 16 16">
                                                                    <path d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4z"/>
                                                                    </svg></button>
                                                                <button onclick="decrementQuantity(<%=p.getId()%>)" type="button" class="btn btn-outline-danger"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-dash" viewBox="0 0 16 16">
                                                                    <path d="M4 8a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7A.5.5 0 0 1 4 8z"/>
                                                                    </svg></button>
                                                            </div>
                                                        </div>
                                                        <div class="modal-footer">
                                                            <div class="row" style="width:100%">
                                                                <p class="col-sm align-middle me-auto">
                                                                    Quantity: <input type="text" align="middle" class="form-control-plaintext form-inline" id="quantityAgain<%=p.getId()%>" 
                                                                                     name="quantity" value="1" style="text-align: center; pointer-events:none;"/>
                                                                </p><p class=" col-sm align-middle me-auto" >
                                                                    Price: &#8369;<input type="text" align="middle" class="form-control-plaintext form-inline" id="priceAgain<%=p.getId()%>"
                                                                                         name="price" value="<%=p.getPrice()%>" style="text-align: center; pointer-events:none;"/>
                                                                </p>
                                                            </div>
                                                            <button type="submit" name="action" value="add" class="btn btn-primary">Submit</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="modal fade" id="errorAgain<%=p.getId()%>" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                <div class="modal-dialog">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title" id="exampleModalLabel">Error</h5>
                                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                        </div>
                                                        <div class="modal-body">
                                                            Product is already in Cart!
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="modal fade" id="loginErrorAgain" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                <div class="modal-dialog">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title" id="exampleModalLabel">Error</h5>
                                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                        </div>
                                                        <div class="modal-body">
                                                            Please Log-in first before buying any of our products
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                            <%
                                }
                            %>           
                        </div>
                        <%
                            }
                        %></div>
                    <div class="tab-pane fade" id="v-pills-sa" role="tabpanel" aria-labelledby="v-pills-sa-tab"><h5 id="sa">Coffee Sauces (100 ml)</h5>
                        <hr>
                        <!-- 1st row iced coffee -->
                        <%
                            for (int i = 0; i < products.size();) {
                        %>
                        <div class="row row-cols-1 row-cols-md-3 g-4" style="text-align: center;">
                            <!-- orig -->
                            <%
                                int counter = 0;
                                while (counter < 3) {
                                    if (i >= products.size()) {
                                        break;
                                    }
                                    Product p = products.get(i);
                                    i++;
                                    if (!p.getType().equals("sa")) {
                                        continue;
                                    }
                                    counter++;
                            %>    
                            <div class="col">
                                <div class="card mb-3">
                                    <img src="Images/<%=p.getId()%>.jpg" class="card-img-top">
                                    <div class="card-body">
                                        <h6 class="card-title"><%=p.getName()%></h6>
                                        <p class="card-text">&#8369;<%=p.getPrice()%></p>
                                        <form method="POST" action="cart">
                                            <input type="hidden" name="id" value="<%=p.getId()%>"/>
                                            <button type="button" class="w-100 btn btn-outline-secondary" data-bs-toggle="modal" data-bs-target="#<%
                                                //if (u.getCustomerID() == -1) {
                                                if (u == null || c == null) {
                                                    out.print("loginErrorAgain");
                                                } else if (c.findCartItem(p.getId()) == null) {
                                                    out.print("modalAgain" + p.getId());
                                                } else {
                                                    out.print("errorAgain" + p.getId());
                                                }
                                                    %>">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="15" height="20" fill="currentColor" class="bi bi-cart3" viewBox="0 0 16 16">
                                                <path d="M0 1.5A.5.5 0 0 1 .5 1H2a.5.5 0 0 1 .485.379L2.89 3H14.5a.5.5 0 0 1 .49.598l-1 5a.5.5 0 0 1-.465.401l-9.397.472L4.415 11H13a.5.5 0 0 1 0 1H4a.5.5 0 0 1-.491-.408L2.01 3.607 1.61 2H.5a.5.5 0 0 1-.5-.5zM3.102 4l.84 4.479 9.144-.459L13.89 4H3.102zM5 12a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm7 0a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm-7 1a1 1 0 1 1 0 2 1 1 0 0 1 0-2zm7 0a1 1 0 1 1 0 2 1 1 0 0 1 0-2z"/>
                                                </svg> Add to Cart
                                            </button>
                                            <div class="modal fade" id="modalAgain<%=p.getId()%>" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                <div class="modal-dialog modal-dialog-centered">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title" id="exampleModalLabel">Add <%=p.getName()%> to your Cart?</h5>
                                                            <button onclick="resetQuantity(<%=p.getId()%>)"type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                        </div>
                                                        <div class="modal-body">
                                                            <img src="Images/<%=p.getId()%>.jpg" class="card-img-top img-thumbnail">
                                                            <div class="btn-group" style="width:100%; position: relative">
                                                                <button onclick="incrementQuantity(<%=p.getId()%>)" type="button" class="btn btn-outline-success"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-plus" viewBox="0 0 16 16">
                                                                    <path d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4z"/>
                                                                    </svg></button>
                                                                <button onclick="decrementQuantity(<%=p.getId()%>)" type="button" class="btn btn-outline-danger"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-dash" viewBox="0 0 16 16">
                                                                    <path d="M4 8a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7A.5.5 0 0 1 4 8z"/>
                                                                    </svg></button>
                                                            </div>
                                                        </div>
                                                        <div class="modal-footer">
                                                            <div class="row" style="width:100%">
                                                                <p class="col-sm align-middle me-auto">
                                                                    Quantity: <input type="text" align="middle" class="form-control-plaintext form-inline" id="quantityAgain<%=p.getId()%>" 
                                                                                     name="quantity" value="1" style="text-align: center; pointer-events:none;"/>
                                                                </p><p class=" col-sm align-middle me-auto" >
                                                                    Price: &#8369;<input type="text" align="middle" class="form-control-plaintext form-inline" id="priceAgain<%=p.getId()%>"
                                                                                         name="price" value="<%=p.getPrice()%>" style="text-align: center; pointer-events:none;"/>
                                                                </p>
                                                            </div>
                                                            <button type="submit" name="action" value="add" class="btn btn-primary">Submit</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="modal fade" id="errorAgain<%=p.getId()%>" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                <div class="modal-dialog">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title" id="exampleModalLabel">Error</h5>
                                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                        </div>
                                                        <div class="modal-body">
                                                            Product is already in Cart!
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="modal fade" id="loginErrorAgain" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                <div class="modal-dialog">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title" id="exampleModalLabel">Error</h5>
                                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                        </div>
                                                        <div class="modal-body">
                                                            Please Log-in first before buying any of our products
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                            <%
                                }
                            %>           
                        </div>
                        <%
                            }
                        %></div>
                </div>
            </div>
        </div>
        <!-- Footer -->
        <%@include file="footer.jsp" %>
        <!-- Footer -->
        <script type="text/javascript"></script>
    </body>
</html>