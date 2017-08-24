<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@page import="java.util.List"%>
<div id="page-wrapper">
    <c:choose>
        <c:when test="${not empty message!=''}">
            <div class="alert alert-${messageClass}">
                ${message}
            </div>
        </c:when>
    </c:choose>
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">Manage Configuration Files</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    
    <div class="panel panel-default">
        <div class="panel-heading">
            <div class="row">
                <div class="col-lg-6">
                    <h3>Files</h3>
                </div>
                <div class="col-lg-2">
                    <h5>
                        <a class="btn btn-primary" href="#" id="add-file-configuration-button" >
                            <i class="fa fa-plus" aria-hidden="true"></i>
                            Add file
                        </a>
                    </h5>
                </div>
            </div>
        </div>
        <!-- /.panel-heading -->
        <div class="panel-body">
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>Name</th>
                            <th>Description</th>
                            <th>Path</th>
                            <th>State</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${configFiles}" var="configFile">
                            <tr id="show-file-configuration-attributes-button" data-id="<c:out value="${configFile.id}"/>">
                                <td>
                                    <c:out value="${configFile.name}"/>
                                </td>
                                <td>
                                    <c:out value="${configFile.description}"/>
                                </td>
                                <td>
                                    <c:out value="${configFile.pathName}"/>
                                </td>
                                <td>
                                    <c:out value="${configFile.configurationFileStates.name}"/>
                                </td>
                                <td>
                                    <a href="#" class="btn btn-success" id="edit-file-configuration-button" data-action="edit" data-id="${configFile.id}">
                                        <i class="fa fa-pencil" aria-hidden="true"></i>
                                    </a>
                                    <a class="btn btn-danger" id="remove-file-configuration-button" data-action="remove" data-id="${configFile.id}">
                                        <i class="fa fa-times" aria-hidden="true"></i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            <!-- /.table-responsive -->
        </div>
        <!-- /.panel-body -->
    </div>
</div>

<form:form method="POST" action="deleteFileconfiguration" id="deleteFileconfiguration">
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
</form:form>