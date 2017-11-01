<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="panel panel-default">
    <!-- /.panel-heading -->
    <form:form method="POST" modelAttribute="configFiles" action="${action}">
        <div class="panel-body">
            <div class="table-responsive">
                <table class="table table-hover">
                    <tbody>
                        <tr>
                            <td>
                                <div class="form-group col-md-12">
                                    <label class="col-md-3 control-lable" for="pathName">File Path</label>
                                    <div class="col-md-7">
                                        <form:input type="text" path="pathName" id="pathName" class="form-control input-sm" />
                                        <div class="has-error">
                                            <form:errors path="pathName" class="help-inline"/>
                                        </div>
                                    </div>
                                        <div class="col-md-1">
                                        <a class="btn btn-primary" id="search-file-configuration-button">Check Path</a>
                                    </div>
                                </div>
                                <div class="form-group col-md-12 path-file-state">
                                </div>
                            </td>
                            <td></td>
                        </tr>
                        <tr id="nameRow">
                            <td colspan="2">
                                <div class="form-group col-md-12">
                                    <label class="col-md-3 control-lable" for="name">Name</label>
                                    <div class="col-md-7">
                                        <form:input type="text" path="name" id="name" class="form-control input-sm"/>
                                        <div class="has-error">
                                            <form:errors path="name" class="help-inline"/>
                                        </div>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <div class="form-group col-md-12">
                                    <label class="col-md-3 control-lable" for="description">Description</label>
                                    <div class="col-md-7">
                                        <form:textarea path="description" id="description" class="form-control input-sm" rows="5" cols="30"/>
                                        <div class="has-error">
                                            <form:errors path="description" class="help-inline"/>
                                        </div>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <div class="form-group col-md-12">
                                    <label class="col-md-3 control-lable" for="configurationFileStates">State</label>
                                    <div class="col-md-7">
                                        <form:select path="configurationFileStates.id" multiple="false" class="form-control input-sm">
                                            <c:forEach items="${configFilesStates}" var="cfs">
                                                <form:option value="${cfs.id}" >${cfs.name}</form:option>
                                            </c:forEach>
                                        </form:select>
                                        <div class="has-error">
                                            <form:errors path="configurationFileStates.id" class="help-inline"/>
                                        </div>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr class="alert-path-status">
                        </tr>
                        <form:hidden path="id"></form:hidden>
                        <!-- /.panel-body -->
                    </tbody>
                </table>
            </div>
            <!-- /.table-responsive -->
        </div>
        <!-- /.panel-body -->
        
        <input id="token-form" type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        
</form:form>
</div>
<!-- /.panel -->