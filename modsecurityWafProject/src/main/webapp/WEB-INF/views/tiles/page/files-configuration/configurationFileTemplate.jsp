<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">${currentFile.name}</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>

    <div class="panel-body">
        <div class="table-responsive">
            <table class="table table-hover">
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
                        <td>
                            <c:out value="${currentFile.description}"/>
                        </td>
                        <td>
                            <c:out value="${currentFile.pathName}"/>
                        </td>
                        <td>
                            <c:out value="${currentFile.configurationFileStates.name}"/>
                        </td>
                        <td>
                            ${currentFile.configurationFileAttributeGroups[0].configurationFilesAttributes[1].configurationFileAttributeOptions[0].name}
                        </td>
                        <td>
                            <a href="#" class="btn btn-success" id="" data-action="edit" data-id="${currentFile.id}" data-redirect-to="">
                                <i class="fa fa-pencil" aria-hidden="true"></i>
                            </a>    
                            <a href="" class="btn btn-danger" id="" data-action="remove">
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
                    <h4>Configuration Parameters</h4>
                </div>
                <div class="col-md-2">
                    <h5>
                        <button type="button" class="btn btn-primary attribute-group" data-config-file-id="${currentFile.id}" data-action="add">
                            <i class="fa fa-plus" aria-hidden="true"></i>
                            Add Attribute Group
                        </button>
                    </h5>
                </div>
                <div class="col-md-1"></div>
                <div class="col-md-2">
                    <h5>
                        <button type="button" class="btn btn-success" id="apply-configuration">
                            <i class="fa fa-plus" aria-hidden="true"></i>
                            Apply Configuration
                        </button>
                    </h5>
                </div>
            </div>
        </div>
        <div class="panel-body">
            <div class="table-responsive">
                <table class="table table-striped">
                    <tbody>
                    <c:forEach items="${currentFile.configurationFileAttributeGroups}" var="group" varStatus="loopGroup">
                        <form:hidden path="configurationFileAttributeGroups[${loopGroup.index}].id" />
                        <form:hidden path="configurationFileAttributeGroups[${loopGroup.index}].description" />
                        <form:hidden path="configurationFileAttributeGroups[${loopGroup.index}].name" />
                        <form:hidden path="configurationFileAttributeGroups[${loopGroup.index}].configurationFiles.id" />
                        <thead>
                            <tr>
                                <div class="col-lg-8">
                                    <th>${group.name}</th>
                                </div>
                                <div class="col-lg-4">
                                    <th>
                                        <a href="#" class="file-attribute-button"  data-config-file-id="${currentFile.id}" data-config-file-attr-group-id="${group.id}" data-action="add">
                                            <i class="fa fa-plus" aria-hidden="true"></i>
                                            Add Attribute
                                        </a>
                                    </th>
                                    <td>
                                        <button type="button" class="btn btn-success attribute-group" data-action="edit" data-config-file-group-id="${group.id}" data-config-file-id="${currentFile.id}" >
                                            <i class="fa fa-pencil" aria-hidden="true"></i>
                                        </button>
                                        <button type="button" class="btn btn-danger attribute-group" data-action="remove" data-config-file-group-id="${group.id}" data-config-file-id="${currentFile.id}" >
                                            <i class="fa fa-times" aria-hidden="true"></i>
                                        </button>
                                    </td>
                                </div>
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
                                </td>
                                <td>
                                    <label class="file-config-page-current-value-attr-label">${attr.value}</label>
                                    <form:hidden path="configurationFileAttributeGroups[${loopGroup.index}].configurationFilesAttributes[${loopAttr.index}].value" cssClass="file-config-page-current-value-attr" />
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${attr.configurationFileAttributeType.name == 'multiple-select' || attr.configurationFileAttributeType.name == 'single-select'}">
                                            <form:select path="configurationFileAttributeGroups[${loopGroup.index}].configurationFilesAttributes[${loopAttr.index}].configurationFileAttributeOptions" items="${attr.configurationFileAttributeOptions}" multiple="false" itemValue="id" itemLabel="name" cssClass="file-config-page-select-attr" />
                                        </c:when>
                                        <c:when test="${attr.configurationFileAttributeType.name == 'numeric-input'}">
                                            <input type="number" value="${attr.value}" class="file-config-page-text-number-attr">
                                        </c:when>
                                        <c:when test="${attr.configurationFileAttributeType.name == 'input-text'}">
                                            <input type="text" value="${attr.value}" class="file-config-page-text-number-attr">
                                        </c:when>
                                        <c:otherwise>
                                            Option Undefined    
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <button type="button" class="btn btn-success file-attribute-button" data-action="edit" data-config-file-id="${currentFile.id}" data-config-file-attr-group-id="${group.id}" data-config-file-attr-id="${attr.id}" data-config-file-attr-name="${attr.name}" >
                                        <i class="fa fa-pencil" aria-hidden="true"></i>
                                    </button>
                                    <button type="button" class="btn btn-danger file-attribute-button" data-action="remove" data-config-file-attr-id="${attr.id}" data-config-file-attr-name="${attr.name}" >
                                        <i class="fa fa-times" aria-hidden="true"></i>
                                    </button>
                                </td>
                            </tr>
                            <tr>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
            
        <form:hidden path="id"></form:hidden>
        <form:hidden path="name"></form:hidden>
        <form:hidden path="pathName"></form:hidden>
        <form:hidden path="description"></form:hidden>
        <form:hidden path="configurationFileStates.id"></form:hidden>
        </div>
    </form:form>
    <form:form id="deleteAttrForm" method="POST" action="deleteFileconfigurationAttr"></form:form>
    <form:form id="deleteAttrGroupForm" method="POST" action="deleteFileConfigurationAttrGroup"></form:form>
</div>
