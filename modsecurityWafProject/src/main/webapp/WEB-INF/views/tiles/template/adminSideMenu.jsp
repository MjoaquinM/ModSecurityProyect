<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <div class="navbar-default sidebar" role="navigation">
        <div class="sidebar-nav navbar-collapse">
            <ul class="nav" id="side-menu">
                <li>
                    <a href="<c:url value="/admin" />"><i class="fa fa-dashboard fa-fw" aria-hidden="true"></i> Dashboard</a>
                </li>
                
                <li class="active">
                    <i class="fa fa-bar-chart-o fa-fw"></i>Users Administration<span class="fa arrow"></span>
                    <ul class="nav nav-second-level">
                        <li> 
                            <a href="<c:url value="/listUsers" />">User List</a>
                        </li>
                        <li>
                            <a href="<c:url value="/historyUsers" />">User History</a>
                        </li>
                        <li>
                            <a href="<c:url value="/chronHistoryUsers" />">Chronological History (que sería esto?)</a>
                        </li>
                    </ul>
                    <!-- /.nav-second-level -->
                </li>
                <li class="active">
                    <i class="fa fa-bar-chart-o fa-fw"></i>Manage Files Configuration<span class="fa arrow"></span>
                    <ul class="nav nav-third-level collapse in" aria-expanded="true" style="">
                        <li>
                            <a href="<c:url value="/modSecConf" />">ModSecurity</a>
                        </li>
                        <li>
                            <a href="<c:url value="/modSecLogCollectorConf" />">ModSecurity Log Collector</a>
                        </li>
                        <li>
                            <a href="<c:url value="/coreRuleSetConf" />">Core Rule Set</a>
                        </li>
                        <li>
                            <a href="<c:url value="/rulesConf" />">Rules</a>
                        </li>
                    </ul>
                    <!-- /.nav-third-level -->
                </li>
                <li class="active">
                    <i class="fa fa-bar-chart-o fa-fw"></i>Monitoring<span class="fa arrow"></span>
                    <ul class="nav nav-third-level collapse in" aria-expanded="true" style="">
                        <li>
                            <a href="<c:url value="/charts" />">Statistical Charts</a>
                        </li>
                        <li>
                            <a href="<c:url value="/reports" />">Generate Report</a>
                        </li>
                        <li>
                            <a href="<c:url value="/events" />">List Events</a>
                        </li>
                    </ul>
                    <!-- /.nav-third-level -->
                </li>
            </ul>
        </div>
    </div>
</nav>