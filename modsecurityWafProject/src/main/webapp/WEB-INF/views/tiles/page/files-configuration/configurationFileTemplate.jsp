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
        <div class="panel-heading">
            <div class="row">
                <div class="col-lg-8">
                    <h4>Configuration Parameters</h4>
                </div>
                <div class="col-lg-4">
                    <h5>
                        <button class="btn btn-primary attribute-group" data-config-file-id="${currentFile.id}" data-action="add">
                            <i class="fa fa-plus" aria-hidden="true"></i>
                            Add Attribute Group
                        </button>
                    </h5>
                </div>
            </div>
        </div>

        <div class="panel-body">
            <div class="table-responsive">
                <table class="table table-striped">
                    <tbody>
                        <c:forEach items="${currentFile.configurationFileAttributeGroups}" var="configFileAttrGroup" varStatus="loop">
                        <thead>
                            <tr>
                                <div class="col-lg-8">
                                    <th><c:out value="${configFileAttrGroup.name}"/></th>
                                </div>
                                <div class="col-lg-4">
                                    <th>
                                        <a href="#" class="file-attribute-button"  data-config-file-id="${currentFile.id}" data-config-file-attr-group-id="${configFileAttrGroup.id}" data-action="add">
                                            <i class="fa fa-plus" aria-hidden="true"></i>
                                            Add Attribute
                                        </a>
                                    </th>
                                    <td>
                                        <button class="btn btn-success attribute-group" data-action="edit" data-config-file-group-id="${configFileAttrGroup.id}" data-config-file-id="${currentFile.id}" >
                                            <i class="fa fa-pencil" aria-hidden="true"></i>
                                        </button>
                                        <button class="btn btn-danger attribute-group" data-action="remove" data-config-file-group-id="${configFileAttrGroup.id}" data-config-file-id="${currentFile.id}" >
                                            <i class="fa fa-times" aria-hidden="true"></i>
                                        </button>
                                    </td>
                                </div>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${allFileAttributes[loop.index]}" var="configFileAttr">
                                
                                <tr>
                                    <td>
                                        <c:out value="${configFileAttr.name}"/>
                                    </td>
                                    <td>
                                        <c:out value="${configFileAttr.value}"/>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${configFileAttr.configurationFileAttributeType.name == 'multiple-select' || configFileAttr.configurationFileAttributeType.name == 'single-select'}">
                                                <select>
                                                    <c:forEach items="${configFileAttr.configurationFileAttributeOptions}" var="opts">
                                                        <option value="${opts.name}">${opts.name}</option>
                                                    </c:forEach>
                                                </select>
                                            </c:when>
                                            <c:when test="${configFileAttr.configurationFileAttributeType.name == 'numeric-input'}">
                                                <input type="number" value="${configFileAttr.value}">
                                            </c:when>
                                            <c:when test="${configFileAttr.configurationFileAttributeType.name == 'input-text'}">
                                                <input type="text" value="${configFileAttr.value}">
                                            </c:when>
                                            <c:otherwise>
                                                    Option Undefined
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <button class="btn btn-success file-attribute-button" data-action="edit" data-config-file-id="${currentFile.id}" data-config-file-attr-group-id="${configFileAttrGroup.id}" data-config-file-attr-id="${configFileAttr.id}" data-config-file-attr-name="${configFileAttr.name}" >
                                            <i class="fa fa-pencil" aria-hidden="true"></i>
                                        </button>
                                        <button class="btn btn-danger file-attribute-button" data-action="remove" data-config-file-attr-id="${configFileAttr.id}" data-config-file-attr-name="${configFileAttr.name}" >
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
        </div>    
    </div>
    
    <form:form id="deleteAttrForm" method="POST" action="deleteFileconfigurationAttr"></form:form>
    <form:form id="deleteAttrGroupForm" method="POST" action="deleteFileConfigurationAttrGroup"></form:form>
</div>
