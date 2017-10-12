<%-- 
    Document   : accessDenied
    Created on : Apr 30, 2017, 3:15:39 PM
    Author     : joaquin
--%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>AccessDenied page</title>
        <link href="<c:url value='/static/css/bootstrap.css' />" rel="stylesheet"></link>
        <link href="<c:url value='/static/css/app.css' />" rel="stylesheet"></link>
    </head>
    <body style="background-image: url(http://wallpapercave.com/wp/wp1848383.jpg);">
        <div class="center-elements">
            <h2 style="margin-top: 0px; padding-top: 100px;"><span class="label label-danger">
                    Sory, You are not authorized to access this page.
                </span></h2>
            <h2><span class="label label-danger">
                    <a href="<c:url value="/admin" />">Go to home</a> OR <a href="<c:url value="/logout" />">Logout</a>
                </span>
            </h2>
        </div>
    </body>
</html>