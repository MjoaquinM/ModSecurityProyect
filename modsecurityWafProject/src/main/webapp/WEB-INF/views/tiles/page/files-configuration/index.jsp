<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@page import="java.util.List"%>
<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">Manage Configuration Files</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <div class="row">
        <!-- List of files configuration --->
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <div class="row">
                        <div class="col-lg-8">
                            <h4>Files</h4>
                        </div>
                        <div class="col-lg-4">
                            <h5><a href="#" id="add-file-configuration-button" ><i class="fa fa-plus" aria-hidden="true"></i>
Add file</a></h5>
                        </div>
                    </div>
                </div>
                <!-- /.panel-heading -->
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
                                <c:forEach items="${configFiles}" var="configFile">
                                    <tr id="show-file-configuration-attributes-button" data-id="<c:out value="${configFile.id}"/>">
                                        <td>
                                            <c:out value="${configFile.name}"/>
                                        </td>
                                        <td>
                                            <c:out value="${configFile.description}"/>
                                        </td>
                                        <td>
                                            <c:out value="${configFile.path}"/>
                                        </td>
                                        <td>
                                            <c:out value="${configFile.state}"/>
                                        </td>
                                        <td>
                                            <a href="#" class="btn btn-success" id="edit-file-configuration-button" data-action="edit" data-id="${configFile.id}">
                                                <i class="fa fa-pencil" aria-hidden="true"></i>
                                            </a>
                                            <a class="btn btn-primary" id="remove-file-configuration-button" data-action="remove" data-id="${configFile.id}">
                                                <i class="fa fa-times" aria-hidden="true"></i>
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <!-- /.table-responsive -->
                </div>
                <!-- /.panel-body -->
            </div>
            <!-- /.panel -->
        </div>
        
        <!-- Right view -->
        <div class="col-lg-8" id="right-column-configuration-file-page"></div>
    </div>
</div>

<form:form method="POST" action="deleteFileconfiguration" id="deleteFileconfiguration">
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
</form:form>

<div class="modal fade" id="fileConfigurationModal">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="fileConfigurationModalTitel"></h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body" id="modalBodyFileConfiguration">
          <img id="loading-image-modal" src="<c:url value='/static/img/loading.png'/>"></img>
          <div id="fileConfigurationModalBody"></div>
      </div>
      <div class="modal-footer" id="fileConfigurationModalFooter">
      </div>
    </div>
  </div>
</div>