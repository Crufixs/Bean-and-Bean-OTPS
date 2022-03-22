<html>
    <head>
        <title>Error 404</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-wEmeIV1mKuiNpC+IOBjI7aAzPcEZeedi5yW5f2yOq55WWLwNGmvvx4Um1vskeMj0" crossorigin="anonymous">
        <link rel="shortcut icon" type="image/png" href="Images/logo-black.png"/>
        <link rel="stylesheet" type="text/css" href = "CSS/webcss.css"/>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
        <style>
            .vertical-center {
                min-height: 100%;  /* Fallback for browsers do NOT support vh unit */
                min-height: 100vh;
                display: flex;
                align-items: center;
            }
        </style>
    </head>
    <body class="jumbotron vertical-center" style="background-color: #F0E7DE">
        <div class="container align-middle" style="margin:auto;">
            <div class="col text-center flex-row-reverse">
                <img src="Images/404img.png">
            </div>
            <div class="col text-center">
                <div class="d-flex flex-column">
                    <div class="p-2" style="margin-top: 10px;">
                        <h1 class="fw-bold">Oops, I think you went the wrong way.</h1> 
                    </div>
                    <div>
                        <p>Click here to go back home</p>
                    </div>
                    <div class="p-2">
                        <a href ="
                           <%= request.getContextPath()%>\home.jsp"
                           <button class="btn btn-dark">Go Home</button>
                        </a>
                    </div>
                </div>
            </div> 
        </div> 
    </body>
    <footer>
        <script type="text/javascript" src="imported/bootstrap.min.js"></script>
        <script type="text/javascript" src="imported/popper.min.js"></script>
        <script type="text/javascript" src="imported/jquery.js"></script>
    </footer>
</html>
