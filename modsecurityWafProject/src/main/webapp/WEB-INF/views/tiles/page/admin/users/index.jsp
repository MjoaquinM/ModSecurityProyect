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
            <h1 class="page-header">Manage Users</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <!-- /.row -->
    <div class="row">
        <div class="col-lg-12">
            <h2>Users</h2>
            <a type="button" class="btn btn-primary" id="add-user-button" data-action="addUser">Add User</a>
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>Alias/Nik</th>
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
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<form:form method="POST" action="deleteUser" id="delete-user-form">
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
</form:form>