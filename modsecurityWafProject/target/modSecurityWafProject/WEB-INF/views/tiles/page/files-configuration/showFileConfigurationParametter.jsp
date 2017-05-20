<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="panel panel-default">
    <div class="panel-heading">
        <h3>Set Configuration</h3>
    </div>
    <!-- /.panel-heading -->
    <form:form method="POST" modelAttribute="configFileAttr" >
        <div class="panel-body">
            <div class="table-responsive">
                <table class="table table-hover">
                    <tbody>        
                        <c:forEach items="${cfa}" var="configFile">
                            <tr>
                                <td> <c:out value="${cfa.name}"/></td>
                            </tr>
                        </c:forEach>
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