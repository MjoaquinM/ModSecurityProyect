<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">Manage Users</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <!-- /.row -->
    <div class="row">
        <div class="col-lg-12">
            <h2>Users</h2>
            <a type="button" class="btn btn-primary" id="add-user-button" data-action="addUser">Add User</a>
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>Alias/Nik</th>
                            <th>Name</th>
                            <th>Last Name</th>
                            <th>Email</th>
                            <th>State</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${users}" var="user">
                        <tr>
                            <td> ${user.ssoId}</td>
                            <td> ${user.firstName}</td>
                            <td> ${user.lastName}</td>
                            <td> ${user.email}</td>
                            <td> ${user.state}</td>
                            <td> 
                                <a href="#" class="btn btn-success" id="edit-user-button" data-action="edit" data-id="${user.id}">
                                    <i class="fa fa-pencil" aria-hidden="true"></i>
                                </a>
                                <a class="btn btn-primary" id="remove-user-button" data-action="remove" data-id="${user.id}">
                                    <i class="fa fa-times" aria-hidden="true"></i>
                                </a>
                            </td>
                        </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<form:form method="POST" action="deleteUser" id="delete-user-form">
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
</form:form>

<div class="modal fade" id="userModal">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="userModalTitel"></h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body" id="modal-body-add-user">
          <img id="loading-image-modal" src="<c:url value='/static/img/loading.png'/>"></img>
          <div id="userModalBody"></div>
      </div>
      <div class="modal-footer" id="addUserModalFooter">
          
      </div>
    </div>
  </div>
</div>