<%-- 
    Document   : cvError
    Created on : 20 Oct 2026, 5:25:26 pm
    Author     : admin
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String ctx = request.getContextPath();

    String message = (String) request.getAttribute("errorMessage");
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <title>CV Builder | Error</title>

    <link rel="stylesheet"
      type="text/css"
      href="<%=request.getContextPath()%>/css/style.css?v=2">
</head>


<body class="app-body">


    <main class="error-card">


        <div class="error-icon">
            !
        </div>


        <h1>Unable to Generate CV</h1>


        <p>

            <%= message == null
                    ? "Something went wrong. Please try again."
                    : message %>

        </p>


        <a class="button button-primary"
           href="<%=ctx%>/cvForm.jsp">

            Back to CV Form

        </a>


    </main>


</body>
</html>