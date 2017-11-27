<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div id="page-wrapper">
    <c:choose>
        <c:when test="${not empty message!=''}">
            <div class="message-status-container">
                <div class="alert alert-${messageClass}">
                    ${message}
                </div>
            </div>
        </c:when>
    </c:choose>
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">${currentFile.name}</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <div class="row" style="text-align:center;">
        <button type="button" class="btn btn-lg btn-success" id="apply-configuration">
            <i class="fa fa-plus" aria-hidden="true"></i>
            Apply Configuration
        </button>
    </div>
        
    <div class="panel-body">
        <div class="table-responsive">
            <table class="table">
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
                    <tr id="show-file-configuration-attributes-button" data-id="<c:out value="${currentFile.id}"/>">
                        <td>
                            <c:out value="${currentFile.name}"/>
                        </td>
                        <td class="description-file-column">
                            <c:out value="${currentFile.description}"/>
                        </td>
                        <td>
                            <c:out value="${currentFile.pathName}"/>
                        </td>
                        <td>
                            <c:out value="${currentFile.configurationFileStates.name}"/>
                        </td>
                        <td style="min-width:100px;">
                            <a href="#" class="btn btn-success" id="edit-file-configuration-button" data-action="edit" data-id="${currentFile.id}" data-redirect-to="confFileTemp">
                                <i class="fa fa-pencil" aria-hidden="true"></i>
                            </a>    
                            <a href="#" class="btn btn-danger" id="remove-file-configuration-button" data-action="remove" data-id="${currentFile.id}">
                                <i class="fa fa-times" aria-hidden="true"></i>
                            </a>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
        <!-- /.table-responsive -->
    </div>

    <div class="panel panel-default">
        <form:form id="configurationFrom" method="POST" modelAttribute="currentFile" action="applyRequestBodyHandlingChanges">
            <div class="panel-heading">
                <div class="row">
                    <div class="col-md-6">
                        <h3>Configuration Parameters</h3>
                    </div>
                </div>
                <div class="row" style="text-align:right;padding-right: 15px;">
                    <button type="button" class="btn btn-md btn-primary attribute-group" data-config-file-id="${currentFile.id}" data-action="add">
                        <i class="fa fa-plus" aria-hidden="true"></i>
                        Add Attribute Group
                    </button>
                </div>
            </div>
            <div class="panel-body">                                
            <c:forEach items="${currentFile.configurationFileAttributeGroups}" var="group" varStatus="loopGroup">
                <div class="table-responsive">
                    <table class="table table-striped">
                    <form:hidden path="configurationFileAttributeGroups[${loopGroup.index}].id" />
                    <form:hidden path="configurationFileAttributeGroups[${loopGroup.index}].description" />
                    <form:hidden path="configurationFileAttributeGroups[${loopGroup.index}].name" />
                    <form:hidden path="configurationFileAttributeGroups[${loopGroup.index}].configurationFiles.id" />
                    <thead>
                        <tr class="label-default tmpl-page-group-header">
                            <th colspan="5">
                                <div class="row">
                                    <div class="col-md-4">
                                        <h4>
                                            ${group.name}
                                            <span href="" class="attribute-description" data-toggle="popover" title="Description" data-content="${group.description}"><i class="fa fa-question-circle" aria-hidden="true"></i></span>
                                        </h4>
                                    </div>
                                    <div class="col-md-2">
                                    </div>
                                    <div class="col-md-6 tmpl-page-delete-edit-group-buttons">
                                        <button type="button" class="btn btn-success attribute-group" data-action="edit" data-config-file-group-id="${group.id}" data-config-file-id="${currentFile.id}" >
                                            <i class="fa fa-pencil" aria-hidden="true"></i>
                                        </button>
                                        <button type="button" class="btn btn-danger attribute-group" data-action="remove" data-config-file-group-id="${group.id}" data-config-file-id="${currentFile.id}" >
                                            <i class="fa fa-times" aria-hidden="true"></i>
                                        </button>
                                    </div>
                                </div>
                            </th>
                        </tr>
                        <tr>
                            <th>Name</th>
                            <th>Current Value</th>
                            <th>New Value</th>
                            <th>Actions</th>
                            <th>State</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${group.configurationFilesAttributes}" var="attr" varStatus="loopAttr">
                            <form:hidden path="configurationFileAttributeGroups[${loopGroup.index}].configurationFilesAttributes[${loopAttr.index}].id" />
                            <form:hidden path="configurationFileAttributeGroups[${loopGroup.index}].configurationFilesAttributes[${loopAttr.index}].name" />
                            <form:hidden path="configurationFileAttributeGroups[${loopGroup.index}].configurationFilesAttributes[${loopAttr.index}].configurationFileAttributeType.id" />
                            <form:hidden path="configurationFileAttributeGroups[${loopGroup.index}].configurationFilesAttributes[${loopAttr.index}].configurationFileAttributeStates.id" />
                            <form:hidden path="configurationFileAttributeGroups[${loopGroup.index}].configurationFilesAttributes[${loopAttr.index}].configurationFileAttributeGroups.id" />
                            <tr>
                                <td>
                                    <c:out value="${attr.name}"/>
                                    <a href="" class="attribute-description" data-toggle="popover" title="Description" data-content="${attr.description}"><i class="fa fa-question-circle" aria-hidden="true"></i></a>
                                </td>
                                <td>
                                    <label class="file-config-page-current-value-attr-label">${attr.value}</label>
                                    <form:hidden path="configurationFileAttributeGroups[${loopGroup.index}].configurationFilesAttributes[${loopAttr.index}].value" cssClass="file-config-page-current-value-attr" />
                                    <form:hidden path="configurationFileAttributeGroups[${loopGroup.index}].configurationFilesAttributes[${loopAttr.index}].description" cssClass="file-config-page-current-value-attr" />
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${attr.configurationFileAttributeType.name == 'single-select'}">
                                            <c:choose>
                                                <c:when test="${attr.configurationFileAttributeStates.name == 'LOCKED'}">
                                                    <form:select path="configurationFileAttributeGroups[${loopGroup.index}].configurationFilesAttributes[${loopAttr.index}].configurationFileAttributeOptions"  multiple="false" itemValue="id" itemLabel="name" cssClass="file-config-page-select-attr"  disabled="true">
                                                        <c:forEach items="${attr.configurationFileAttributeOptions}" var="opt" varStatus="loopOpt" >
                                                            <form:option value="${opt.name}" title="${opt.description}" ></form:option>
                                                        </c:forEach>
                                                    </form:select>
                                                </c:when>
                                                <c:otherwise>
                                                    <form:select path="configurationFileAttributeGroups[${loopGroup.index}].configurationFilesAttributes[${loopAttr.index}].configurationFileAttributeOptions"  multiple="false" itemValue="id" itemLabel="name" cssClass="file-config-page-select-attr"  disabled="false" >
                                                        <c:forEach items="${attr.configurationFileAttributeOptions}" var="opt" varStatus="loopOpt" >
                                                            <form:option value="${opt.name}" title="${opt.description}" ></form:option>
                                                        </c:forEach>
                                                    </form:select>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:when>
                                        <c:when test="${attr.configurationFileAttributeType.name == 'multiple-select'}">
                                            <c:choose>
                                                <c:when test="${attr.configurationFileAttributeStates.name == 'LOCKED'}">
                                                    <form:select path="configurationFileAttributeGroups[${loopGroup.index}].configurationFilesAttributes[${loopAttr.index}].configurationFileAttributeOptions" items="${attr.configurationFileAttributeOptions}" multiple="true" itemValue="id" itemLabel="name" cssClass="file-config-page-select-attr" disabled="true" />
                                                </c:when>
                                                <c:otherwise>
                                                    <form:select path="configurationFileAttributeGroups[${loopGroup.index}].configurationFilesAttributes[${loopAttr.index}].configurationFileAttributeOptions" items="${attr.configurationFileAttributeOptions}" multiple="true" itemValue="id" itemLabel="name" cssClass="file-config-page-select-attr" disabled="false"/>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:when>
                                        <c:when test="${attr.configurationFileAttributeType.name == 'numeric-input'}">
                                            <c:choose>
                                                <c:when test="${attr.configurationFileAttributeStates.name == 'LOCKED'}">
                                                    <input type="number" value="${attr.value}" class="file-config-page-text-number-attr" disabled>
                                                </c:when>
                                                <c:otherwise>
                                                    <input type="number" value="${attr.value}" class="file-config-page-text-number-attr">
                                                </c:otherwise>
                                            </c:choose>
                                        </c:when>
                                        <c:when test="${attr.configurationFileAttributeType.name == 'input-text'}">
                                            <c:choose>
                                                <c:when test="${attr.configurationFileAttributeStates.name == 'LOCKED'}">
                                                    <input type="text" value="${fn:replace(attr.value, "\"", "'")}" class="file-config-page-text-number-attr" disabled >
                                                </c:when>
                                                <c:otherwise>
                                                    <input type="text" value="${fn:replace(attr.value, "\"", "'")}" class="file-config-page-text-number-attr" >
                                                </c:otherwise>
                                            </c:choose>
                                        </c:when>
                                        <c:otherwise>
                                            Option Undefined    
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="config-file-temp-action-column">
                                    <button type="button" class="btn btn-success file-attribute-button" data-action="edit" data-config-file-id="${currentFile.id}" data-config-file-attr-group-id="${group.id}" data-config-file-attr-id="${attr.id}" data-config-file-attr-name="${attr.name}" >
                                        <i class="fa fa-pencil" aria-hidden="true"></i>
                                    </button>
                                    <button type="button" class="btn btn-danger file-attribute-button" data-action="remove" data-config-file-attr-id="${attr.id}" data-config-file-attr-name="${attr.name}" >
                                        <i class="fa fa-times" aria-hidden="true"></i>
                                    </button>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${attr.configurationFileAttributeStates.name == 'LOCKED'}">
                                            <div class="alert alert-danger cfa-state">LOCKED</div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="alert alert-success cfa-state">CONFIGURABLE</div>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                            <tr>
                                <td colspan="5">
                                    <a  style="float:right;" href="#" class="file-attribute-button btn btn-primary"  data-config-file-id="${currentFile.id}" data-config-file-attr-group-id="${group.id}" data-action="add">
                                        <i class="fa fa-plus" aria-hidden="true"></i>
                                        Add Attribute
                                    </a>
                                </td>
                            </tr>
                    </tbody>
                </table>
            </div>
            </c:forEach>
        </div>
        <form:hidden path="id"></form:hidden>
        <form:hidden path="name"></form:hidden>
        <form:hidden path="pathName"></form:hidden>
        <form:hidden path="description"></form:hidden>
        <form:hidden path="configurationFileStates.id"></form:hidden>
    </div>
    </form:form>
    <form:form id="deleteFileconfiguration" method="POST" action="deleteFileconfiguration"></form:form>
    <form:form id="deleteAttrForm" method="POST" action="deleteFileconfigurationAttr"></form:form>
    <form:form id="deleteAttrGroupForm" method="POST" action="deleteFileConfigurationAttrGroup"></form:form>
</div>
