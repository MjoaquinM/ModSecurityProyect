<%-- 
    Document   : login
    Created on : Apr 30, 2017, 3:14:06 PM
    Author     : r3ng0
--%>

<div id="div-container-login" class="container-login">
    <h1 class="div-login-heading">
        <strong>Welcome.</strong> Please login.
    </h1>
    <div class="row row-notice-login-status">
        <div class="col-lg-10 center-elements">
        <c:if test="${param.error != null}">
            <div class="alert alert-danger notice-login-page">
                <p>Invalid username and password.</p>
            </div>
        </c:if>
        <c:if test="${param.logout != null}">                       
            <div class="alert alert-success notice-login-page">
                <p style="margin-left: auto; margin-right: auto">You have been logged out successfully.</p>
            </div>
        </c:if>
        </div>
    </div>
    <c:url var="loginUrl" value="/login" />
    <form action="${loginUrl}" method="post">
        <input type="text" id="username" name="user_name" placeholder="Enter Username" required class="input-txt">
        <input type="password" id="password" name="password" placeholder="Enter Password" required class="input-txt">

        <input type="hidden" name="${_csrf.parameterName}"  value="${_csrf.token}" />

        <div class="login-footer">
            <div class="row">
                <div class="col-lg-10">
                </div>
                <div class="col-lg-2 login-form-submit">
                    <button type="submit" class="btn btn--right" value="Log in">Sign in  </button>
                </div>
            </div>
        </div>                    
    </form>
</div>