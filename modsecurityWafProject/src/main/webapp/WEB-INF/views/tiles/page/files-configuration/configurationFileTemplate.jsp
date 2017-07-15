<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">${currentFile.getName()}</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <div class="panel panel-default">
        <div class="panel-heading">
            Configuration Parameters
        </div>
        
        <div class="panel-body">
            <div class="table-responsive">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>Name</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${currentFileAttributes}" var="cf">
                            <tr>
                                <td>${cf.name}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
        
    </div>    
</div>
