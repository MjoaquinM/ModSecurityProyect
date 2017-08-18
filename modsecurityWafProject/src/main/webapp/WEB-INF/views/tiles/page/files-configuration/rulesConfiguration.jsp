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
                        <h1>${file.name}</h1>
                    </div>
                    <div class="row">
                        <div class="col-lg-4">
                            <h4>Block Rules by</h4>
                        </div>
                        <div class="col-lg-4">
                            <select>
                                <option>Attack</option>
                                <option>Id</option>
                                <option>Tags</option>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <h5>
                                <button type="button" class="btn btn-success" id="block-rules-button">
                                    <i class="fa fa-plus" aria-hidden="true"></i>
                                    Apply Configuration
                                </button>
                            </h5>
                        </div>
                    </div>
                </div>
                <!-- /.panel-heading -->
                <div class="panel-body">
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Name</th>
<!--                                    <th>Description</th>
                                    <th>Path</th>
                                    <th>State</th>
                                    <th>Action</th>-->
                                </tr>
                            </thead>
                            <tbody>
                                <form:form id="blockRules" method="POST" modelAttribute="fileAttribute" action="blockRules">
                                <tr>
                                    <td>
                                        value:
                                    </td>
                                    <td class="final-value">
                                        <form:input path="value" cssClass="final-value" readonly="true" ></form:input>
                                    </td>
                                    <td>
                                        <div class="parameter-container">
                                        <c:forEach items="${list}" var="item" varStatus="loop">
                                            <div class="parameter-item">
                                                ${item}
                                            </div>
                                        </c:forEach>    
                                        </div>
                                    </td>
                                </tr>
                                <form:hidden path="id"></form:hidden>
                                </form:form>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>