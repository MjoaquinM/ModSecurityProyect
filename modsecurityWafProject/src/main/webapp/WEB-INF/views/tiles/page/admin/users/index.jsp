<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
            <h1 class="page-header">Manage Users</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <!-- /.row -->
    
    <!-- FILTROS -->
    <div class="panel panel-default">
        <div class="panel-heading">
            <div class="row">
                <h3 class="filter-title">
                    Filters
                </h3>
                <button id="show-filter-user-history" data-toggle="collapse" data-target="#filters-containers"><i class="fa fa-angle-double-down" aria-hidden="true"></i></button>
            </div>
        </div>
        <div class="panel-body collapse" id="filters-containers">
            <form method="GET" id="user-filter-form">
                <!--<input type="hidden" name="filterFlag"  value="true" />-->
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
                                <td>User Name:</td>
                                <td>
                                    <input type="hidden" name="filter-parameters-targets" value="userName" />
                                    <input type="hidden" name="filter-parameters-labels" value="userName" />
                                    <input type="text" name="filter-parameters-values" value="${hm.userName}" />
                                </td>
                                <td>First Name:</td>
                                <td>
                                    <input type="hidden" name="filter-parameters-targets" value="firstName" />
                                    <input type="hidden" name="filter-parameters-labels" value="firstName" />
                                    <input type="text" name="filter-parameters-values" value="${hm.firstName}" />
                                </td>
                                
                                <td>Last Name:</td>
                                <td>
                                    <input type="hidden" name="filter-parameters-targets" value="lastName" />
                                    <input type="hidden" name="filter-parameters-labels" value="lastName" />
                                    <input type="text" name="filter-parameters-values" value="${hm.lastName}" />
                                </td>
                            </tr>
                            <tr>
                                <td>Email:</td>
                                <td>
                                    <input type="hidden" name="filter-parameters-targets" value="email" />
                                    <input type="hidden" name="filter-parameters-labels" value="email" />
                                    <input type="text" name="filter-parameters-values" value="${hm.email}" />
                                </td>
                                <td colspan="4"></td>
                            </tr>
                            <tr>
                                <td colspan="5"></td>
                                <td>
                                    <a href="<c:url value="/users/list" />" class="btn btn-primary">Reset</a>
                                    <button type="submit" class="btn btn-md btn-success filter-submit">Apply Filter</button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <!--<input type="hidden" name="filter-parameters-names" value="user" />-->
                <input type="hidden" id="pageNumber" name="pageNumber" value="1" />
            </form>
        </div>
    </div>
    
    <div class="panel panel-default">
        <div class="panel-heading">
            <div class="row">
                <div class="col-md-6">
                    <h3>Users</h3>
                </div>
            </div>
        </div>
        <div class="panel-body">
            <div class="table-responsive">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>User Name</th>
                            <th>Name</th>
                            <th>Last Name</th>
                            <th>Email</th>
                            <th>State</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${users}" var="user">
                        <tr>
                            <td> ${user.userName}</td>
                            <td> ${user.firstName}</td>
                            <td> ${user.lastName}</td>
                            <td> ${user.email}</td>
                            <td> ${user.userStates.name}</td>
                            <td>
                                <a href="#" class="btn btn-success" id="edit-user-button" data-action="edit" data-id="${user.id}">
                                    <i class="fa fa-pencil" aria-hidden="true"></i>
                                </a>
                                <a class="btn btn-danger" id="remove-user-button" data-action="remove" data-id="${user.id}">
                                    <i class="fa fa-times" aria-hidden="true"></i>
                                </a>
                            </td>
                        </tr>
                        </c:forEach>
                        <tr>
                            <td colspan="5">
                                <div class="btn-group">
                                    <button ${fn:length(users)==0 || pageNumber==1 ? "disabled='true'" : ""} type="button" class="btn btn-primary user-filter-btn" value="${pageNumber-1}">Previus</button>
                                    <button type="button" class="btn btn-primary user-filter-btn" value="${pageNumber}">${pageNumber}</button>
                                    <button type="button" class="btn btn-primary user-filter-btn" value="${pageNumber+1}">Next</button>
                                </div>
                            </td>
                            <td>
                                <h5>
                                    <a type="button" class="btn btn-primary" id="add-user-button" data-action="addUser"><i class="fa fa-plus" aria-hidden="true"></i>Add User</a>
                                </h5>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<form:form method="POST" action="deleteUser" id="delete-user-form">
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
</form:form>