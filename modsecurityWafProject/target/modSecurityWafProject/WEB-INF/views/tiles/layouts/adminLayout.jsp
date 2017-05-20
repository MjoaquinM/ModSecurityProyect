<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<html style="background: white;">
 
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="">
        
        <title><tiles:getAsString name="title" /></title>
        
        <link href="<c:url value='/static/css/app.css' />" rel="stylesheet"></link>
        
        <!-- Bootstrap Core CSS -->
        <link href="<c:url value='/static/css/bootstrap.min.css' />"  rel="stylesheet"></link>

        <!-- MetisMenu CSS -->
        <link href="<c:url value='/static/css/SBAdmin2/metisMenu.min.css' />" rel="stylesheet"></link>

        <!-- Custom CSS -->
        <link href="<c:url value='/static/css/SBAdmin2/sb-admin-2.css' />" rel="stylesheet"></link>

        <!-- Morris Charts CSS -->
        <link href="<c:url value='/static/css/SBAdmin2/morris.css' />" rel="stylesheet"></link>

        <!-- Custom Fonts -->
        <link href="<c:url value='/static/css/font-awesome.min.css' />" rel="stylesheet"></link>
        
    </head>
  
    <body style="background: #f8f8f8;">
        <div id="wrapper">
            <!--<header id="header">-->
                <tiles:insertAttribute name="header" />
            <!--</header>-->

            <!--<section id="sidemenu">-->
                <tiles:insertAttribute name="menu" />
            <!--</section>-->

            <!--<section id="site-content">-->
                <tiles:insertAttribute name="body" />
            <!--</section>-->

            <!--<footer id="footer">-->
                <tiles:insertAttribute name="footer" />
            <!--</footer>-->
        </div>
        <!-- jQuery -->
        <script src="<c:url value='/static/js/jquery-3.2.1.min.js' />"></script>
        
        <!-- custom -->
        <script src="<c:url value='/static/js/index.js' />"></script>

        <!-- Bootstrap Core JavaScript -->
        <script src="<c:url value='/static/js/bootstrap.min.js' />"></script>

        <!-- Metis Menu Plugin JavaScript -->
        <script src="<c:url value='/static/js/SBAdmin2/metisMenu.min.js' />"></script>

        <!-- Morris Charts JavaScript -->
        <script src="<c:url value='/static/js/SBAdmin2/raphael.min.js' />"></script>
        <script src="<c:url value='/static/js/SBAdmin2/morris.min.js' />"></script>
        <script src="<c:url value='/static/js/SBAdmin2/morris-data.js' />"></script>

        <!-- Custom Theme JavaScript -->
        <script src="<c:url value='/static/js/SBAdmin2/sb-admin-2.js' />"></script>
        
    </body>
</html>