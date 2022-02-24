<%-- 
    Document   : aboutus
    Created on : 05 21, 21, 9:33:54 PM
    Author     : Marylaine Lumacad
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <title>About Us | Bean&Bean</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-wEmeIV1mKuiNpC+IOBjI7aAzPcEZeedi5yW5f2yOq55WWLwNGmvvx4Um1vskeMj0" crossorigin="anonymous">
    <link rel="stylesheet" href="CSS/aboutus.css">
    <%
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);
        int totalComments = 25;
    %>
</head>
<body style="background-color: #F0E7DE;">
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
                <p style="color:white;">COFFEE BEANS</p>
            </div>
        </div>
        <!-- Jumbotron -->
        <div>
            <h2>About Us</h2>
            <hr>
        </div>
        <!-- paragraphs -->
        <div>
            <p style="text-align: justify;">Bean&Bean is your homebased and homegrown brew. It was founded on the love for coffee and it is fueled by the passion for quality coffee beans and drinks. Every cup of our coffee celebrates and supports Philippine brew by using local beans from Kalinga, Batangas, and Benguet. Each flavor profile has a distinct taste that truly incorporates the rich diversity of their geographies.</p>
            <p style="text-align: justify;">Our flawless supply chain system assures consistent product supply and quality. We maintain strong bonds with local farmers to make sure that we get first pick of the best crops they have in each batch. Our facility uses reliable and efficient time table during the roasting and fermentation process. The beans and leaves are then checked, weighed and packed fresh before delivering to our store.</p>
            <p>With drink prepared right in-store and made from quality-sourced ingredients, Bean&Bean brings people a whole new coffee experience.</p>
        </div>
        <!-- paragraphs -->
        <!-- icon -->
        <div style="text-align: center;">
            <img src="Images/cb.png" style="height: 50px;">
        </div>
        <br>
        <!-- icon -->
        <!-- faqs -->
        <div>
            <h2 id="faqs">FAQs</h2>
            <hr>
            <div class="accordion accordion-flush" id="accordionFlushExample">
                <div class="accordion-item">
                    <h2 class="accordion-header" id="flush-headingOne">
                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseOne" aria-expanded="false" aria-controls="flush-collapseOne">
                            How can I store these cold brewed coffee?
                        </button>
                    </h2>
                    <div id="flush-collapseOne" class="accordion-collapse collapse" aria-labelledby="flush-headingOne" data-bs-parent="#accordionFlushExample">
                        <div class="accordion-body">
                            <ul>
                                <li>Two weeks for original cold brew and original cold brew concentrate.</li>
                                <li>Four days for flavored cold brew coffee because it contains milk.</li>
                            </ul>
                        </div>
                    </div>
                </div>

                <div class="accordion-item">
                    <h2 class="accordion-header" id="flush-headingTwo">
                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseTwo" aria-expanded="false" aria-controls="flush-collapseTwo">
                            What coffee beans do you use?
                        </button>
                    </h2>
                    <div id="flush-collapseTwo" class="accordion-collapse collapse" aria-labelledby="flush-headingTwo" data-bs-parent="#accordionFlushExample">
                        <div class="accordion-body">
                            <ul>
                                <li>We use Robusta from Kalinga, Arabica Benguet from Buguiasm, Bakun, Mankayan, and parts of Kabayan same as flavored coffees.</li>
                            </ul>
                        </div>
                    </div>
                </div>

                <div class="accordion-item">
                    <h2 class="accordion-header" id="flush-headingThree">
                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseThree" aria-expanded="false" aria-controls="flush-collapseThree">
                            What type of bottle do you use?
                        </button>
                    </h2>
                    <div id="flush-collapseThree" class="accordion-collapse collapse" aria-labelledby="flush-headingThree" data-bs-parent="#accordionFlushExample">
                        <div class="accordion-body"><ul>
                                <li>We use 350mL GLASS BOTTLES so it is reusable and eco-friendly.</li>
                            </ul></div>
                    </div>
                </div>

                <div class="accordion-item">
                    <h2 class="accordion-header" id="flush-headingFour">
                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseFour" aria-expanded="false" aria-controls="flush-collapseFour">
                            Where are you located?
                        </button>
                    </h2>
                    <div id="flush-collapseFour" class="accordion-collapse collapse" aria-labelledby="flush-headingFour" data-bs-parent="#accordionFlushExample">
                        <div class="accordion-body">
                            <ul>
                                <li>We are homebased, DTI-registered business and located in Comembo, Makati City.</li>
                            </ul>
                        </div>
                    </div>
                </div>

                <div class="accordion-item">
                    <h2 class="accordion-header" id="flush-headingFive">
                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseFive" aria-expanded="false" aria-controls="flush-collapseFive">
                            What is the difference between cold brew and iced coffee?
                        </button>
                    </h2>
                    <div id="flush-collapseFive" class="accordion-collapse collapse" aria-labelledby="flush-headingFive" data-bs-parent="#accordionFlushExample">
                        <div class="accordion-body">
                            <ul>
                                <li>Cold brew is brewed by soaking coffee beans cold or room temperature water at 12 hours minimum to extract its sugars, oils and caffeine.</li>
                                <li>Iced coffee uses hot water to extract flavor (resulting in a hot cup of coffee) which is then poured over ice.</li>
                            </ul>
                        </div>
                    </div>
                </div>

                <div class="accordion-item">
                    <h2 class="accordion-header" id="flush-headingSix">
                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseSix" aria-expanded="false" aria-controls="flush-collapseSix">
                            What is your cold brew brewing time?
                        </button>
                    </h2>
                    <div id="flush-collapseSix" class="accordion-collapse collapse" aria-labelledby="flush-headingSix" data-bs-parent="#accordionFlushExample">
                        <div class="accordion-body">
                            <ul>
                                <li>16-18 hours.</li>
                            </ul>
                        </div>
                    </div>
                </div>

                <div class="accordion-item">
                    <h2 class="accordion-header" id="flush-headingSeven">
                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseSeven" aria-expanded="false" aria-controls="flush-collapseSeven">
                            Can I request level of sugar?
                        </button>
                    </h2>
                    <div id="flush-collapseSeven" class="accordion-collapse collapse" aria-labelledby="flush-headingSeven" data-bs-parent="#accordionFlushExample">
                        <div class="accordion-body">
                            <ul>
                                <li>Yes, it is up to you. You can have it with no sugar (0%), 25%, 50%, 75%, 100%.</li>
                            </ul>
                        </div>
                    </div>
                </div>

                <div class="accordion-item">
                    <h2 class="accordion-header" id="flush-headingEight">
                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseEight" aria-expanded="false" aria-controls="flush-collapseEight">
                            How much is shipping fee?
                        </button>
                    </h2>
                    <div id="flush-collapseEight" class="accordion-collapse collapse" aria-labelledby="flush-headingEight" data-bs-parent="#accordionFlushExample">
                        <div class="accordion-body">
                            <ul>
                                <li>For cold brewed coffee, we ship via Lalamove, Angkas, GrabExpress or Mr. Speedy.</li>
                                <li>For the coffee essentials, premium coffee, we also offer same delivery couriers stated above and for cheaper rates but 1-3 days within Metro Manila, we can ship via J&T Express.<br><br>Note: shipping fee will be shouldered by the buyer.</li>
                            </ul>
                        </div>
                    </div>
                </div>

            </div>
        </div>
        <!-- Gallery -->
        <br>
        <div>
            <h2 id="gallery">Gallery</h2>
            <hr>
            <div class="album py-3 bg-light">
                <div class="container">

                    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
                        <div class="col">
                            <div class="card shadow-sm">
                                <img src="Images/bg.jpg">
                            </div>
                        </div>
                        <div class="col">
                            <div class="card shadow-sm">
                                <img src="Images/g2.jpg">
                            </div>
                        </div>

                        <div class="col">
                            <div class="card shadow-sm">
                                <img src="Images/g3.jpg">
                            </div>
                        </div>

                        <div class="col">
                            <div class="card shadow-sm">
                                <img src="Images/g4.jpg">
                            </div>
                        </div>

                        <div class="col">
                            <div class="card shadow-sm">
                                <img src="Images/g5.jpg">
                            </div>
                        </div>

                        <div class="col">
                            <div class="card shadow-sm">
                                <img src="Images/g6.jpg">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <br>
        <div>
            <h2 id="reviews">Reviews</h2>
            <hr>
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
            <br>
            <ul class="" style="align-content: center; padding: 0; margin: 0">
                <%for (int y = 1; y <= 5; y++) {%>
                <li class="row w-100 justify-content-between" style="background-color: white; margin: 0; margin-bottom: 2vh; padding: 2vh;">
                    <div class="col-lg-3 col-md-3 col-sm-4" style="align-items: center; align-content: center; padding: 2vh;">
                        <img src="Images/f22.jpg" alt="username" style="border-radius: 50%; width: 80%;">
                    </div>
                    <div class="col-lg-9 col-md-9 col-sm-8 lh-md">
                        <br>
                        <H4>User<%=y%></H4>
                            <% for (int x = 0; x < y; x++) {%>
                        <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="gold" class="bi bi-star-fill" viewBox="0 0 16 16">
                        <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
                        </svg>
                        <%}%>
                        <% for (int x = 0; x < (5 - y); x++) {%>
                        <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="gold" class="bi bi-star" viewBox="0 0 16 16">
                        <path d="M2.866 14.85c-.078.444.36.791.746.593l4.39-2.256 4.389 2.256c.386.198.824-.149.746-.592l-.83-4.73 3.522-3.356c.33-.314.16-.888-.282-.95l-4.898-.696L8.465.792a.513.513 0 0 0-.927 0L5.354 5.12l-4.898.696c-.441.062-.612.636-.283.95l3.523 3.356-.83 4.73zm4.905-2.767-3.686 1.894.694-3.957a.565.565 0 0 0-.163-.505L1.71 6.745l4.052-.576a.525.525 0 0 0 .393-.288L8 2.223l1.847 3.658a.525.525 0 0 0 .393.288l4.052.575-2.906 2.77a.565.565 0 0 0-.163.506l.694 3.957-3.686-1.894a.503.503 0 0 0-.461 0z"/>
                        </svg>
                        <%}%>
                        <br><br>
                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore 
                            magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo 
                            consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. 
                            Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
                    </div>
                </li>
                <%}%>
            </ul>
        </div>
    </div>
    <!-- Footer -->
    <%@include file="footer.jsp" %>
    <!-- Footer -->
</body>
</html>
