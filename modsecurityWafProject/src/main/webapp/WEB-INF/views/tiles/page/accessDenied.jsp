<%-- 
    Document   : accessDenied
    Created on : Apr 30, 2017, 3:15:39 PM
    Author     : r3ng0
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
<body>
    <div class="center-elements">
        <h2><span class="label label-warning">
            Dear <strong>${user}</strong>, You are not authorized to access this page.
            </span></h2>
        <h2><span class="label label-warning">
            <a href="<c:url value="/home" />">Go to home</a> OR <a href="<c:url value="/logout" />">Logout</a>
            </span>
        </h2>
    </div>
</body>
</html>