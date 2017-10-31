<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="panel panel-default">
    <div class="panel-heading">
        <h3>New File Configuration</h3>
    </div>
    <!-- /.panel-heading -->
    <form:form method="POST" modelAttribute="configurationFile" >
        <div class="panel-body">
            <div class="table-responsive">
                <table class="table table-hover">
                    <tbody>
                        <tr>
                            <td>
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
                            <td>
                                <div class="form-group col-md-12">
                                    <label class="col-md-3 control-lable" for="path">File Path</label>
                                    <div class="col-md-7">
                                        <form:input type="text" path="path" id="path" class="form-control input-sm"/>
                                        <div class="has-error">
                                            <form:errors path="path" class="help-inline"/>
                                        </div>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="form-group col-md-12">
                                    <label class="col-md-3 control-lable" for="description">Description</label>
                                    <div class="col-md-7">
                                        <form:input type="text" path="description" id="description" class="form-control input-sm"/>
                                        <div class="has-error">
                                            <form:errors path="description" class="help-inline"/>
                                        </div>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="form-group col-md-12">
                                    <label class="col-md-3 control-lable" for="state">State</label>
                                    <div class="col-md-7">
                                        <form:select path="state" multiple="false" class="form-control input-sm">
                                            <form:option value="1" >Active</form:option>
                                            <form:option value="0" >Disable</form:option>
                                        </form:select>
                                        <div class="has-error">
                                            <form:errors path="state" class="help-inline"/>
                                        </div>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <!-- /.panel-body -->
                        <tr>
                            <td>
                                <button type="submit" class="btn btn-default">Add File</button>
                            </td>
                            <td>
                                <a href="#" class="btn btn-default" id="cancel-new-file-configuration-button">Cancel</a>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <!-- /.table-responsive -->
        </div>
        <!-- /.panel-body -->
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
</form:form>
</div>
<!-- /.panel -->