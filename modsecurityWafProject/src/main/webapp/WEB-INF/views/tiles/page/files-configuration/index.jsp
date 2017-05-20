<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        <div class="col-lg-4">
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
                            <tbody>
                                <c:forEach items="${configFiles}" var="configFile">
                                    <tr id="show-file-configuration-attributes-button" data-id="<c:out value="${configFile.id}"/>">
                                        <td>
                                            <c:out value="${configFile.name}"/>
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