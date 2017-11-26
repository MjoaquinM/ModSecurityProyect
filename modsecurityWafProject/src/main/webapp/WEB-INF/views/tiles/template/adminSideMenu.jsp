<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <div class="navbar-default sidebar" role="navigation">
        <div class="sidebar-nav navbar-collapse">
            <ul class="nav" id="side-menu">
<!--                <li>
                    <a href="<c:url value="/admin" />"><i class="fa fa-dashboard fa-fw" aria-hidden="true"></i>Dashboard</a>
                </li>-->
                <li>
                    <a href="#"><i class="fa fa-users fa-fw" aria-hidden="true"></i>Users Administration</a>
                </li>
                <li class="active">
                    <ul class="nav nav-second-level">
                        <li>
                            <a href="<c:url value="/users/list" />">User List</a>
                        </li>
                        <li>
                            <a href="<c:url value="/users/history" />">User History</a>
                        </li>
                    </ul>
                    <!-- /.nav-second-level -->
                </li>
                <li>
                    <a><i class="fa fa-file fa-fw" aria-hidden="true"></i>Manage Files Configuration</a>
                </li>
                <li class="active">
                    <ul class="nav nav-third-level collapse in" aria-expanded="true" style="">
                        <li>
                            <a href="<c:url value="/configurationFiles/list" />">Files Configuration List</a>
                        </li>
                        <c:forEach items="${configFiles}" var="configFile">
                            <c:choose>
                                <c:when test="${configFile.configurationFileStates.name!='NO-CONFIGURABLE'}">
                                    <li>
                                        <a href="<c:url value="/configurationFiles/confFileTemp?currentFile=${configFile.name}" />">${configFile.name}</a>
                                    </li>
                                </c:when>
                            </c:choose>
                        </c:forEach>
                        <li>
                            <a href="<c:url value="/configurationFiles/rulesManagement" />">Manage Rules</a>
                        </li>
                    </ul>
                    <!-- /.nav-third-level -->
                </li>
                <li>
                    <a href="#"><i class="fa fa-eye fa-fw" aria-hidden="true"></i>Monitoring</a>
                </li>
                <li class="active">
                    <ul class="nav nav-third-level collapse in" aria-expanded="true" style="">
                        <li>
                            <a href="<c:url value="/control/charts" />">Statistical Charts</a>
                        </li>
                        <li>
                            <a href="<c:url value="/control/eventList" />">List Events</a>
                        </li>
                    </ul>
                    <!-- /.nav-third-level -->
                </li>
            </ul>
        </div>
    </div>
</nav>