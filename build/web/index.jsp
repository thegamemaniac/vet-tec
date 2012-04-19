<%@page import="Clases.Flight"%>
<%@page import="Clases.City"%>
<%
    City[] cities;
    cities = (City[]) request.getAttribute("cities");

    if (cities == null) {
%> <jsp:forward page="Ciudades" >
    <jsp:param name="referer" value="index.jsp" />
</jsp:forward><%

        RequestDispatcher rd = request.getRequestDispatcher("Ciudades");
        rd.forward(request, response);
    }
    Flight flights[];
    flights = (Flight[]) request.getAttribute("flights");
    Flight flights2[];
    flights2 = (Flight[]) request.getAttribute("flights2");

    boolean f1, f2 = false;

    f1 = (flights != null) && (flights.length > 0);
    f2 = (flights2 != null) && (flights2.length > 0);
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Home</title>
        <meta charset="utf-8">
        <link rel="stylesheet" href="css/reset.css" type="text/css" media="all">
        <link rel="stylesheet" href="css/layout.css" type="text/css" media="all">
        <link rel="stylesheet" href="css/style.css" type="text/css" media="all">
        <link rel="stylesheet" href="css/jquery.datepick.css" type="text/css" media="all">
        <script type="text/javascript" src="js/jquery-1.4.2.js" ></script>
        <script type="text/javascript" src="js/cufon-yui.js"></script>
        <script type="text/javascript" src="js/cufon-replace.js"></script>
        <script type="text/javascript" src="js/Myriad_Pro_600.font.js"></script>
        <script type="text/javascript" src="js/jquery.datepick.js"></script>
        <script type="text/javascript" src="js/vet.js"></script>
        <!--[if lt IE 9]>
                <script type="text/javascript" src="http://info.template-help.com/files/ie6_warning/ie6_script_other.js"></script>
                <script type="text/javascript" src="js/html5.js"></script>
        <![endif]-->        
    </head>
    <body id="page1">
        <div class="extra">
            <div class="main">
                <!-- header -->
                <header>
                    <div class="wrapper">
                        <h1><a href="index.html" id="logo">Around the World</a></h1>
                        <div class="right">
                            <div class="wrapper">
                                <form id="search" action="" method="post">
                                    <div class="bg">
                                        <input type="submit" class="submit" value="">
                                        <input type="text" class="input">
                                    </div>
                                </form>
                            </div>
                            <div class="wrapper">
                                <nav>
                                    <ul id="top_nav">
                                        <li><a href="#">Register</a></li>
                                        <li><a href="#">Log In</a></li>
                                        <li><a href="#">Help</a></li>
                                    </ul>
                                </nav>
                            </div>
                        </div>
                    </div>
                    <jsp:include page="includes/navbar.jsp" />
                    <article class="col1">
                        <ul class="tabs">
                            <li><a href="#" class="active">Flight</a></li>
                            <li><a href="#">Hotel</a></li>
                            <li><a href="#">Car</a></li>
                            <li class="end"><a href="#">Cruise</a></li>
                        </ul>
                        <div class="tabs_cont">
                            <form id="form_1" action="FlightServlet" method="post">
                                <input type="hidden" name="referer" value="vuelos.jsp"/>
                                <div class="bg">
                                    <div class="wrapper">
                                        <div class="radio">
                                            <input type="radio" name="isRoundTrip" value="true" checked onclick="mostrarRegreso()">Redondo
                                        </div>
                                        <div class="radio"><input type="radio" name="isRoundTrip" value="false" onclick="ocultarRegreso()">Simple</div>
                                    </div>
                                    <!-- div class="wrapper"><input name="source" type="text" class="input">Origen</div -->
                                    <div class="wrapper"><label for="source">Salida</label>
                                        <select name="source" id="source">
                                            <% if (cities != null)
                                                    for (City c : cities) {%>
                                            <option value="<%=c.getCityCode()%>"><%=c.getCityName()%></option>
                                            <% }%>
                                        </select></div>
                                    <!-- div class="wrapper"><input name="destiny" type="text" class="input">Destino</div -->
                                    <div class="wrapper"><label for="destination">Destino</label>
                                        <select name="destiny" id="destiny">
                                            <% if (cities != null)
                                                    for (City c : cities) {%>
                                            <option value="<%=c.getCityCode()%>"><%=c.getCityName()%></option>
                                            <% }%>
                                        </select></div>
                                    <!-- div class="wrapper"><input name="date1" type="text" class="input input2" value="04/11/2010"  onblur="if(this.value=='') this.value='04/11/2010'" onfocus="if(this.value =='04/11/2010' ) this.value=''">Salida (mm/dd/aa)</div -->
                                    <div class="wrapper"><label for="date1">Salida (dd/mm/aaaa)</label>
                                        <input type="text" name="date1" id="date1" /></div>
                                    <!-- div class="wrapper pad_bot1"><input name="date2"type="text" class="input input2" value="04/11/2010"  onblur="if(this.value=='') this.value='04/11/2010'" onfocus="if(this.value =='04/11/2010' ) this.value=''">Regreso  (mm/dd/aa)</div -->
                                    <div id="regreso" class="wrapper pad_bot1"><label for="date2">Regreso (dd/mm/aaaa)</label>
                                        <input type="text" name="date2" id="date2" /></div>                                    
                                    <div class="wrapper pad_bot1">
                                        <label for="timeFrom">Hora</label>
                                        <select name="timeFrom" id="timeFrom">
                                            <%
                                                for (int i = 6; i <= 22; i++) {
                                            %>
                                            <option value="<%=i%>"><%=i%></option>    
                                            <%
                                                }
                                            %>
                                        </select>
                                        <br />
                                        <label for="timeTo">a</label>
                                        <select name="timeTo" id="timeTo">
                                            <%
                                                for (int i = 7; i <= 23; i++) {
                                            %>
                                            <option value="<%=i%>"><%=i%></option>    
                                            <%
                                                }
                                            %>
                                        </select>
                                    </div>
                                    <div class="wrapper pad_bot1">
                                        <a href="#" class="button" onclick="document.getElementById('form_1').submit()">Buscar</a>
                                        Adultos<br />
                                        <select name="adults">
                                            <option>1</option>
                                            <option>2</option>
                                            <option>3</option>
                                            <option>4</option>
                                            <option value="35">35</option>
                                        </select>
                                        Ni�os<br />
                                        <select name="kids">
                                            <option>0</option>
                                            <option>1</option>
                                            <option>2</option>
                                            <option>3</option>
                                            <option>4</option>
                                            <option>5</option>
                                        </select>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </article>
                    <article class="col1 pad_left1">
                        <div class="text">
                            <img src="images/text1.jpg" alt="">
                            <h2>The Best Offers</h2>
                            <p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore.</p>
                            <a href="#" class="button">Read More</a>
                        </div>
                    </article>
                    <div class="img"><img src="images/img.jpg" alt=""></div>
                </header><div class="ic">More Website Templates at TemplateMonster.com!</div>
                <!-- / header -->
                <!-- content -->
                <section id="content">
                    <article class="col1">
                        <h3>Hot Travel</h3>
                        <div class="pad">
                            <div class="wrapper under">
                                <figure class="left marg_right1"><img src="images/page1_img1.jpg" alt=""></figure>
                                <p class="pad_bot2"><strong>Italy<br>Holidays</strong></p>
                                <p class="pad_bot2">Lorem ipsum dolor sit amet, consect etuer adipiscing.</p>
                                <a href="#" class="marker_1"></a>
                            </div>
                            <div class="wrapper under">
                                <figure class="left marg_right1"><img src="images/page1_img2.jpg" alt=""></figure>
                                <p class="pad_bot2"><strong>Philippines<br>Travel</strong></p>
                                <p class="pad_bot2">Lorem ipsum dolor sit amet, consect etuer adipiscing.</p>
                                <a href="#" class="marker_1"></a>
                            </div>
                            <div class="wrapper">
                                <figure class="left marg_right1"><img src="images/page1_img3.jpg" alt=""></figure>
                                <p class="pad_bot2"><strong>Cruise<br>Holidays</strong></p>
                                <p class="pad_bot2">Lorem ipsum dolor sit amet, consect etuer adipiscing.</p>
                                <a href="#" class="marker_1"></a>
                            </div>
                        </div>
                    </article>
                    <article class="col2 pad_left1">
                        <h2>Popular Places</h2>
                        <div class="wrapper under">
                            <figure class="left marg_right1"><img src="images/page1_img4.jpg" alt=""></figure>
                            <p class="pad_bot2"><strong>Hotel du Havre</strong></p>
                            <p class="pad_bot2">Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. </p>
                            <p class="pad_bot2"><strong>Nemo enim ipsam voluptatem</strong> quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur.</p>
                            <a href="#" class="marker_2"></a>
                        </div>
                        <div class="wrapper">
                            <figure class="left marg_right1"><img src="images/page1_img5.jpg" alt=""></figure>
                            <p class="pad_bot2"><strong>Hotel Vacance</strong></p>
                            <p class="pad_bot2">At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa.</p>
                            <p class="pad_bot2">Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda.</p>
                            <a href="#" class="marker_2"></a>
                        </div>
                    </article>
                </section>
                <!-- / content -->
            </div>
            <div class="block"></div>
        </div>
        <div class="body1">
            <div class="main">
                <!-- footer -->
                <footer>
                    <a rel="nofollow" href="http://www.templatemonster.com/" target="_blank">Website template</a> designed by TemplateMonster.com<br>
                    <a href="http://www.templates.com/product/3d-models/" target="_blank">3D Models</a> provided by Templates.com
                </footer>
                <!-- / footer -->
            </div>
        </div>
        <script type="text/javascript">
            Cufon.now();
            $("#date1").datepick({
                dateFormat: 'dd-mm-yyyy',
                minDate: new Date()
            });
            $("#date2").datepick({
                dateFormat: 'dd-mm-yyyy',
                minDate: new Date()
            });
        </script>
    </body>
</html>