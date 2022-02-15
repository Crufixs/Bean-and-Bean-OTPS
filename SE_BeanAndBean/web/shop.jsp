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
                response.sendRedirect("home.jsp");
                return;
            }
        %>
        <script>
            function incrementQuantity(id) {
                var quantityElement = document.getElementById('quantity' + id);
                if (quantityElement.value < 9) {
                    quantityElement.value++;
                    var priceElement = document.getElementById('price' + id);

                    console.log(priceElement.value + " " + quantityElement.value);
                    priceElement.value = (priceElement.value / (quantityElement.value - 1)) * quantityElement.value;
                }
            }
            function decrementQuantity(id) {
                var quantityElement = document.getElementById('quantity' + id);
                console.log('quantity' + id);
                if (quantityElement.value > 1) {
                    quantityElement.value--;
                    var priceElement = document.getElementById('price' + id);
                    priceElement.value = (priceElement.value / (quantityElement.value - (-1))) * quantityElement.value;
                }
            }
            function resetQuantity(id) {
                var quantityElement = document.getElementById('quantity' + id);
                var priceElement = document.getElementById('price' + id);
                priceElement.value = priceElement.value / quantityElement.value;
                quantityElement.value = 1;
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
                <h1 class="mb-3 h2">All Products</h1>
            </div>

            <!-- Premium Coffee Section -->
            <div>
                <h5 id="pc">Premium Coffee (125g)</h5>
                <hr>
                <%
                    for (int i = 0; i < products.size();) {
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
                                        if (c.findCartItem(p.getId())==null) {
                                            out.print("modal" + p.getId());
                                        } else {
                                            out.print("error" + p.getId());
                                        }
                                            %>">
                                        Add to Cart
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
                                                    <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
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
                <!-- end of premium coffee -->
                <!-- cold brew, 1st row cold brew -->
                <div>
                    <h5 style="margin-top: 20px;" id="cb">Cold Brew (350ml)</h5>
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
                                if (!p.getType().equals("cb")) {
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
                                        <button type="submit" name="action" value="add" class="w-100 btn btn-outline-secondary">Add to Cart</button>
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
                    <div>
                        <h5 style="margin-top: 20px;" id="ic">Iced Coffee (500ml)</h5>
                        <hr>
                        <!-- 1st row iced coffee -->
                        <%
                            for (int i = 0; i < products.size();) {
                        %>
                        <div class="row row-cols-1 row-cols-md-4 g-4" style="text-align: center;">
                            <!-- orig -->
                            <%
                                int counter = 0;
                                while (counter < 4) {
                                    if (i >= products.size()) {
                                        break;
                                    }
                                    Product p = products.get(i);
                                    i++;
                                    if (!p.getType().equals("ic")) {
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
                                            <button type="submit" name="action" value="add" class="w-100 btn btn-outline-secondary">Add to Cart</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                            <!-- end of mocha -->
                            <%
                                }
                            %>           
                        </div>
                        <%
                            }
                        %>
                    </div>
                    <br>
                    <!-- end of iced coffee -->
                    <!-- essentials -->
                    <div>
                        <h5 style="margin-top: 20px;" id="ce">Coffee Essentials</h5>
                        <hr>
                        <div class="container">
                            <!-- group -->
                            <%
                                for (int i = 0; i < products.size();) {
                            %>
                            <div class="row row-cols-1 row-cols-sm-2 row-cols-md-4">
                                <%
                                    int counter = 0;
                                    while (counter < 4) {
                                        if (i >= products.size()) {
                                            break;
                                        }
                                        Product p = products.get(i);
                                        i++;
                                        if (!p.getType().equals("ce")) {
                                            continue;
                                        }
                                        counter++;
                                %> 
                                <div class="col"><div class="card border-dark mb-3" style="max-width: 18rem; text-align: center;">
                                        <div class="card-header"><b><%=p.getName()%></b></div>
                                        <p class="card-text">&#8369;<%=p.getPrice()%></p>
                                        <form method="POST" action="cart" class="d-inline-block">
                                            <input type="hidden" name="id" value="<%=p.getId()%>"/>
                                            <button type="submit" name="action" value="add" class="w-100 btn btn-outline-secondary">Add to Cart</button>
                                        </form>
                                    </div></div>
                                    <%
                                        }
                                    %>           
                            </div>
                            <%
                                }
                            %>
                            <!-- end of group  -->
                        </div>
                    </div>
                    <!-- end of essentials -->
                    <br><br>
                </div>
            </div>
        </div>
        <!-- Footer -->
        <%@include file="footer.jsp" %>
        <!-- Footer -->
    </body>
</html>