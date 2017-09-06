<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page isELIgnored="false" %>

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
            <h1 class="page-header">Users Historial</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <!-- /.row -->
    
    <div class="panel panel-default">
        <div class="panel-heading">
            <div class="row">
                <h3 class="filter-title">
                    Filters
                </h3>
                <button id="show-filter-user-history" data-toggle="collapse" data-target="#filters-containers"><i class="fa fa-angle-double-down" aria-hidden="true"></i></button>
                <a href="<c:url value="/historyUsers/1" />" class="btn btn-primary">Reset</a>
            </div>
        </div>
        <div class="panel-body collapse" id="filters-containers">
            <form method="GET">
                <input type="hidden" name="filterFlag"  value="true" />

                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th colspan="2">Date</th>
                                <th colspan="2">User</th>
                                <th colspan="2">Description</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>From:</td>
                                <td>
                                    <input type="hidden" name="filter-parameters-targets" value="dateEvent" />
                                    <input type="text" id="datepicker-from" name="filter-parameters-values" />
                                </td>
                                <td>Name:</td>
                                <td>
                                    <input type="hidden" name="filter-parameters-targets" value="user.userName" />
                                    <input type="text" name="filter-parameters-values" />
                                </td>
                                <td>Keyword:</td>
                                <td>
                                    <input type="hidden" name="filter-parameters-targets" value="description" />
                                    <input type="text" name="filter-parameters-values" />
                                </td>
                            </tr>
                            <tr>
                                <td>To:</td>
                                <td>
                                    <input type="hidden" name="filter-parameters-targets" value="dateEvent" />
                                    <input type="text" id="datepicker-to" name="filter-parameters-values" />
                                </td>
                                <td>Mail:</td>
                                <td>
                                    <input type="hidden" name="filter-parameters-targets" value="user.email" />
                                    <input type="text" name="filter-parameters-values" />
                                </td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>
                                    <button type="submit" class="btn btn-sm btn-success filter-submit">Apply</button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <input type="hidden" name="filter-parameters-names" value="user" />
                <input type="hidden" name="pageNumber" value="${pageNumber}" />
                <input type="hidden" name="flagFilter" id="flagFilter" value="${flagFilter}" />
            </form>
        </div>
    </div>
    
    <div class="panel panel-default">
        <div class="panel-heading">
            <div class="row">
                <div class="col-md-6">
                    <h3>Actions</h3>
                </div>
            </div>
        </div>
        <div class="panel-body">
            
            <c:choose>
                <c:when test="${flagFilter=='true'}">
                    <div class="table-responsive table-filtered">
                </c:when>
                <c:otherwise>
                    <div class="table-responsive">
                </c:otherwise>
            </c:choose>
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>n</th>
                            <th>id</th>
                            <th>User</th>
                            <th>Email</th>
                            <th>Description</th>
                            <th>Date/Time</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${usersActions}" var="action" varStatus="index">
                        <tr>
                            <td> ${index.index+1} </td>
                            <td> ${action.id} </td>
                            <td> ${action.user.userName} </td>
                            <td> ${action.user.email} </td>
                            <td> <div class="user-history-description"> ${action.description} </div> </td>
                            <td> ${action.dateEvent} </td>
                            <td>
                                <a href="#" class="btn btn-success"  data-action="edit" data-id="">
                                    <i class="fa fa-pencil" aria-hidden="true"></i>
                                </a>
                                <a class="btn btn-danger" data-action="remove" data-id="">
                                    <i class="fa fa-times" aria-hidden="true"></i>
                                </a>
                            </td>
                        </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            <c:choose>
                <c:when test="${flagFilter!='true'}">
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
                </c:when>
            </c:choose>
        </div>
    </div>
</div>

<form:form method="POST" action="deleteUser" id="delete-user-form">
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
</form:form>