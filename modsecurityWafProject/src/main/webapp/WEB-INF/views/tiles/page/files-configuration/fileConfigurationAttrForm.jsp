<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<div class="panel panel-default">
    <!-- /.panel-heading -->
    <form:form method="POST" modelAttribute="configFileAttr" action="${action}">
        <div class="panel-body">
            <div class="table-responsive">
                <table class="table table-hover">
                    <tbody>
                        <tr>
                            <td colspan="3">
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
                        <tr id="value-row">
                            <td colspan="3">
                                <div class="form-group col-md-12">
                                    <label class="col-md-5 control-lable" for="value">Value</label>
                                    <div class="col-md-7">
                                        <c:choose>
                                            <c:when test="${configFileAttr.configurationFileAttributeType.name == 'multiple-select' || configFileAttr.configurationFileAttributeType.name == 'single-select'}">
                                                <form:input type="text" path="value" id="value" class="form-control input-sm" readonly="true"/>
                                            </c:when>
                                            <c:otherwise>
                                                <form:input type="text" path="value" id="value" class="form-control input-sm" />
                                            </c:otherwise>
                                        </c:choose>
                                        <div class="has-error">
                                            <form:errors path="value" class="help-inline"/>
                                        </div>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">
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
                        <tr>
                            <td colspan="3">
                                <div class="form-group col-md-12">
                                    <label class="col-md-5 control-lable" for="state">State</label>
                                    <div class="col-md-7">
                                        <form:select path="configurationFileAttributeStates.id" items="${cfaStates}" multiple="false" itemValue="id" itemLabel="name" class="form-control input-sm"/>
                                        <div class="has-error">
                                            <form:errors path="configurationFileAttributeStates.id" class="help-inline"/>
                                        </div>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr class="type-row">
                            <td colspan="3">
                                <div class="form-group col-md-12">
                                    <label class="col-md-5 control-lable" for="type">Type</label>
                                    <div class="col-md-7">
                                        <form:select path="configurationFileAttributeType.id" items="${cfaTypes}" multiple="false" itemValue="id" itemLabel="name" class="form-control input-sm"/>
                                        <div class="has-error">
                                            <form:errors path="configurationFileAttributeType.id" class="help-inline"/>
                                        </div>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr class="options-row-header <c:out default="" escapeXml="true" value="${(configFileAttr.configurationFileAttributeType.name=='multiple-select' || configFileAttr.configurationFileAttributeType.name=='single-select')? value:'hidden'}"/>">
                            <td colspan="3">
                                <label class="col-md-5 control-lable" for="option">Options</label>
                                <a href="#" id="add-file-attribute-option-button" class="col-md-5">
                                    <i class="fa fa-plus" aria-hidden="true"></i>
                                    Add Attribute option
                                </a>
                            </td>
                        </tr>
                        <c:forEach items="${options}" var="opt" varStatus="loop">
                            <tr class="options-row added">
                                <td>
                                    <input id="configurationFileAttributeOptions${loop.index}.name" name="configurationFileAttributeOptions[${loop.index}].name" class="form-control input-sm attr-opt" value="${opt.name}" type="text">
                                    <div class="has-error"></div>
                                </td>
                                <td>
                                    <a class="btn btn-primary" id="remove-config-file-attr-opt" data-action="remove">
                                        <i class="fa fa-times" aria-hidden="true"></i>
                                    </a>
                                    <a class="btn btn-primary" id="remove-config-file-attr-opt" data-action="remove">
                                            <i class="fa fa-times" aria-hidden="true"></i>
                                    </a>
                                    
                                    <c:choose>
                                        <c:when test="${configFileAttr.value == opt.name}">
                                            <input type="radio" name="radio-options" class="radio-options" checked>
                                        </c:when>    
                                        <c:otherwise>
                                            <input type="radio" name="radio-options" class="radio-options">
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>                            
                        </c:forEach>
                        
                        <!-- /.panel-body -->
                    </tbody>
                </table>
            </div>
            <!-- /.table-responsive -->
        </div>
        <!-- /.panel-body -->
        
        <form:hidden path="id"></form:hidden>
        <input type="hidden" name="currentConfigFile" value="${currentConfigFile}"/>
        <form:hidden path="configurationFileAttributeGroups.id" value="${currentConfigFileAttrGroupId}"></form:hidden>
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
</form:form>
</div>
<!-- /.panel -->