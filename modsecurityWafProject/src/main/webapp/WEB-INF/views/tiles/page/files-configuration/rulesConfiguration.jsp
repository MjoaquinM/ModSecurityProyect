<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@page import="java.util.List"%>


<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">Rules configuration</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <!-- /.row -->    
        <div class="row">
        <!-- List of files configuration --->
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <div class="row">
                        <div class="col-lg-4">
                            <h3>Block Rules by</h3>
                        </div>
                    </div>
                </div>
                <!-- /.panel-heading -->
                <div class="panel-body">
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th colspan="3">Attack</th>
<!--                                    <th>Description</th>
                                    <th>Path</th>
                                    <th>State</th>
                                    <th>Action</th>-->
                                </tr>
                            </thead>
                            <tbody>
                                
                                <tr>
                                    <td>
                                        Rules Files
                                    </td>
                                    <td>
                                        Blocked
                                    </td>
                                    <td>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div class="parameter-container">
                                        <c:forEach items="${list}" var="item" varStatus="loop">
                                            <c:choose>
                                                <c:when test="${states[loop.index]==true}">
                                                    <div class="parameter-item alert-warning">
                                                        ${item}
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="parameter-item">
                                                        ${item}
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="blocked-container">
                                        <c:forEach items="${values}" var="item" varStatus="loop">
                                            <div id="${item}" class="blocked-item">
                                                ${item}
                                            </div>
                                        </c:forEach>
                                        </div>
                                    </td>
                                    <td class="action-container">
                                        <div class="col-md-4">
                                            <h5>
                                                <button type="button" class="btn btn-success block-rules-button">
                                                    Apply Configuration
                                                </button>
                                            </h5>
                                        </div>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th colspan="3">Rule Id's</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>
                                        Id
                                    </td>
                                    <td>
                                        Blocked
                                    </td>
                                    <td>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div class="parameter-container">
                                        <c:forEach items="${rules}" var="item" varStatus="loop">
                                            <c:choose>
                                                <c:when test="${statesIds[loop.index]==true}">
                                                    <div class="id-parameter-item alert-warning">
                                                        ${item.ruleId}
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="id-parameter-item">
                                                        ${item.ruleId}
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
<!--                                            <div class="parameter-item">CHANGE
                                            </div>-->
                                        </c:forEach>
                                        </div>
                                    </td>
                                    <td>
                                        <div id="id-blocked-container">
                                        <c:forEach items="${rules}" var="item" varStatus="loop">
                                            <c:choose>
                                                <c:when test="${statesIds[loop.index]==true}">
                                                    <div id="${item.ruleId}" class="id-blocked-item">
                                                        ${item.ruleId}
                                                    </div>
                                                </c:when>
                                            </c:choose>
                                        </c:forEach>
                                        </div>
                                    </td>
                                    <td class="action-container">
                                        <div class="col-md-4">
                                            <h5>
                                                <button type="button" class="btn btn-success block-rules-button">
                                                    Apply Configuration
                                                </button>
                                            </h5>
                                        </div>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                </div>
            </div>
        </div>
    </div>
    
    <form:form id="blockRules" method="POST" modelAttribute="fileAttribute" action="blockRules">
        <form:hidden path="value" cssClass="final-value" readonly="true" />
        <form:hidden path="id"></form:hidden>
    </form:form>
</div>