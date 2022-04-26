<%@page import="model.User"%>
<%@page import="model.Cart"%>

<li id="login-dropdown" class="nav-item dropdown">
    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" style="color: white;">
        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-person" viewBox="0 0 16 16">
            <path d="M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0zm4 8c0 1-1 1-1 1H3s-1 0-1-1 1-4 6-4 6 3 6 4zm-1-.004c-.001-.246-.154-.986-.832-1.664C11.516 10.68 10.289 10 8 10c-2.29 0-3.516.68-4.168 1.332-.678.678-.83 1.418-.832 1.664h10z"/>
        </svg>
    </a>
    <ul id="login-dropdown-menu" class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
        <%
            if ((User) session.getAttribute("user") != null) {
        %>
        <li><a class="dropdown-item text-white" href="success.jsp">My Account</a></li>
        <li>
            <form id="logout-form" method="POST" action="Logout"><!-- 
                <a class="dropdown-item text-white" href="javascript:;" onclick="document.getElementById('logout-form').submit();">Logout</a> -->
                <button type="submit" class="dropdown-item text-white">Logout</button>
                <input type="hidden" name="access" value="valid">
            </form>
        </li>
        <%
        } else {
        %>
        <li><a class="dropdown-item text-white" href="success.jsp">Login/Register</a></li>                        
            <%
                }
            %>
    </ul>
</li>