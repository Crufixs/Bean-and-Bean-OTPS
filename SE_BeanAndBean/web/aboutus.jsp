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
    </div>
    <!-- Footer -->
    <%@include file="footer.jsp" %>
    <!-- Footer -->
</body>
</html>
