<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<div class="panel panel-default">
    <!-- /.panel-heading -->
    <form:form method="POST" modelAttribute="configFileAttrGroup" action="${action}">
        <div class="panel-body">
            <div class="table-responsive">
                <table class="table table-hover">
                    <tbody>
                        <tr>
                            <td>
                                <div class="form-group col-md-12">
                                    <label class="col-md-5 control-lable" for="name">Name</label>
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
                                    <label class="col-md-5 control-lable" for="description">Description</label>
                                    <div class="col-md-7">
                                        <form:textarea type="text" path="description" id="description" class="form-control input-sm" rows="5" cols="30"/>
                                        <div class="has-error">
                                            <form:errors path="description" class="help-inline"/>
                                        </div>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <!-- /.panel-body -->
                    </tbody>
                </table>
            </div>
            <!-- /.table-responsive -->
        </div>
        <!-- /.panel-body -->
        
        <form:hidden path="id"></form:hidden>
        <form:hidden path="configurationFiles.id" value="${currentConfigFile}"></form:hidden>
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
</form:form>
</div>
<!-- /.panel -->