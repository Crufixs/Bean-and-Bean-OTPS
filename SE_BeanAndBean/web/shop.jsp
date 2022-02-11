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

            User u = (User) session.getAttribute("user");
            if (u == null) {
                response.sendRedirect("home.jsp");
                return;
            }
        %>
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