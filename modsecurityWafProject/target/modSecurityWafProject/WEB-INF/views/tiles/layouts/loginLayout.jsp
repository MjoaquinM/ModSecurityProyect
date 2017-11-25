<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<!DOCTYPE html>
<html class="login-page-html">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title><tiles:getAsString name="title" /></title>
        <link href="<c:url value='/static/css/style.css' />"  rel="stylesheet"></link>
        <link href="<c:url value='/static/css/bootstrap.css' />"  rel="stylesheet"></link>
        <link rel="stylesheet" type="text/css" href="//cdnjs.cloudflare.com/ajax/libs/font-awesome/4.2.0/css/font-awesome.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css">
    </head>
  
    <body class="login-page-background">
        <header id="header">
            <tiles:insertAttribute name="header" />
        </header>

        <section id="sidemenu">
            <tiles:insertAttribute name="menu" />
        </section>

        <section id="site-content">
            <tiles:insertAttribute name="body" />
        </section>

        <footer id="footer">
            <tiles:insertAttribute name="footer" />
        </footer>
        
        <!-- jQuery -->
        <script src="<c:url value='/static/js/jquery-3.2.1.min.js' />"></script>

        <!-- Bootstrap Core JavaScript -->
        <script src="<c:url value='/static/js/bootstrap.min.js' />"></script>
        
        <!-- Custom JavaScript -->
        <script src="<c:url value='/static/js/index.js' />"></script>
        
    </body>

</html>