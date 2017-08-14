<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset=UTF-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
        <title>Listado de Empresas</title>
    </head>
    <body>
        <div class="row">
            <div class="col-lg-12">
                <h3 class="page-header">Listado de Provincias
                    <a href="<c:url value="provinciaCreate.htm" />" class="btn btn-success"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span> Agregar</a>
                    <button type="button" id="add-prov-button" class="btn btn-primary" data-action="addUser" data-toggle="modal">Add</button>
                </h3>
            </div>

        </div>
        <table class="table table-bordered table-striped table-hover">
            <thead>
                <tr>
                    <td><strong>ID</strong></td>
                    <td><strong>Date</strong></td>
                    <td><strong>SourceIP</strong></td>
                    <td><strong>SourcePort</strong></td>
                    <td><strong>DestinationIP</strong></td>
                    <td><strong>DestinationPort</strong></td>
                    <td><strong>ClassAtack</strong></td>
                    <td><strong>Details</strong></td>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${lst}" var="e">
                    <tr>
                        <td>${e.id}</td>
                        <td>${e.dateEvent}</td>
                        <td>${e.clientIp}</td>
                        <td>${e.clientPort}</td>
                        <td>${e.serverIp}</td>
                        <td>${e.serverPort}</td>
                        <td>VER Q ONDA</td>
                        <td>
                            <a href="get">${e.transactionId}</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <nav aria-label="Page navigation example">
            <ul class="pagination justify-content-center">
                <li class="page-item">
                    <a class="page-link" href="${pageNumber-1}">Previus</a>
                </li>
                <li class="page-item"><a class="page-link" href="#">${pageNumber}</a></li>
                <li class="page-item">
                    <a class="page-link" href="${pageNumber+1}">Next</a>
                </li>
            </ul>
        </nav>
        <a href="index.htm">Volver a index</a>

        <div class="modal" id="modal-event">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div id="modal-event-header" class="modal-header">
                    </div>
                    <div id="modal-event-body" class="modal-body">
                    </div>
                    <div id="modal-event-footer" class="modal-footer">                
                    </div>
                </div>
            </div>
        </div>

    </body>
</html>