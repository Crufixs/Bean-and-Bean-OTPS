<%-- 
    Document   : aboutus
    Created on : 05 21, 21, 9:33:54 PM
    Author     : Marylaine Lumacad
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <title>About Us | Bean & Bean</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-wEmeIV1mKuiNpC+IOBjI7aAzPcEZeedi5yW5f2yOq55WWLwNGmvvx4Um1vskeMj0" crossorigin="anonymous">
    <link rel="shortcut icon" type="image/png" href="Images/logo-black.png"/>
    <link rel="stylesheet" href="CSS/aboutus.css">
    <%
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);

        int totalComments = 25;
    %>
</head>
<body class="d-flex flex-column min-vh-100" style="background-image: url('Images/newBG.png');"
    <!-- HEADER -->
    <%@include file="header.jsp" %>

    <div class="container">
        <!-- Jumbotron -->
        <div
            class="bg-image p-5 text-center shadow-1-strong rounded mb-4 text-white mt-4"
            style="background-image: url('Images/d1.jpg'); height: 200px;">
            <div style="margin-top: 10px;">
                <h1 class="mb-3 h2" style="color:white;">BEAN & BEAN</h1>
                <div style="border-color:white;border-top-width:1px;margin-left: auto;margin-right: auto;margin-top:10px;margin-bottom:10px;width:100%;max-width:170px;"><hr style="height: 3px;"></div>
                <p style="color:white;">CUSTOMERS' REVIEW</p>
            </div>
        </div>
        <!-- Jumbotron -->
        <div class="row justify-content-between align-middle align-items-center">
            <div class="col-6">
                <h4>Comments : <%=totalComments%></h4>
            </div>
            <div style="white-space: nowrap;" class="col-6 text-end">
                <h4 style="display: inline-block;">Sort by:&nbsp;</h4>
                <select style="display: inline-block;" id="ddlModel">
                    <option value="AllComments">Most Relevant</option>
                    <option value="Iphone">Ratings</option>
                    <option value="Samsung">Date</option>
                </select>
            </div>
        </div>
        <hr>
        <div>
            
        </div>
       

    </div>
    <!-- Footer -->
    <%@include file="footer.jsp" %>
    <!-- Footer -->
</body>
</html>
