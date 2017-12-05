<%-- 
    Document   : borrame
    Created on : 04/12/2017, 08:31:09
    Author     : usuario
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        
        <c:forEach items="${valores}" var="val">
            <h3>${val}</h3>
        </c:forEach>
        
    </body>
</html>
