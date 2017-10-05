<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div id="page-wrapper">
    <c:choose>
        <c:when test="${not empty message!=''}">
            <div class="alert alert-${messageClass}">
                ${message}
            </div>
        </c:when>
    </c:choose>
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">Events List</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <!-- /.row -->
    
    <div class="panel-heading">
        <div class="row">
            <h3 class="filter-title">
                Filters
            </h3>
            <button id="show-filter-user-history" data-toggle="collapse" data-target="#filters-containers"><i class="fa fa-angle-double-down" aria-hidden="true"></i></button>
            <a href="<c:url value="/eventList" />" class="btn btn-primary">Reset</a>
            <a href="<c:url value="/deleteAllEvents" />" class="btn btn-danger">Delete All</a>
        </div>
    </div>
    <div class="panel-body collapse" id="filters-containers">
        <form method="GET" id="event-filter-form">
            <input type="hidden" name="filterFlag"  value="true" />
            <div class="table-responsive">
                <table class="table">
                    <thead>
                        <tr>
                            <th colspan="2">Date</th>
                            <th colspan="2">Ip</th>
                            <th colspan="2">Port</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>From:</td>
                            <td>
                                <input type="hidden" name="filter-parameters-targets" value="dateEvent" />
                                <input type="hidden" name="filter-parameters-labels" value="dateEventFrom" />
                                <input type="text" id="datepicker-from"  name="filter-parameters-values" value="${hm.dateEventFrom}"/>
                            </td>
                            <td>Source:</td>
                            <td>
                                <input type="hidden" name="filter-parameters-targets" value="clientIp" />
                                <input type="hidden" name="filter-parameters-labels" value="clientIpSource" />
                                <input type="text" id="clientIp" name="filter-parameters-values" value="${hm.clientIpSource}" />
                            </td>
                            <td>Source:</td>
                            <td>
                                <input type="hidden" name="filter-parameters-targets" value="clientPort" />
                                <input type="hidden" name="filter-parameters-labels" value="clientPortSource" />
                                <input type="text" id="clientPort" name="filter-parameters-values" value="${hm.clientPortSource}" />
                            </td>
                        </tr>
                        <tr>
                            <td>To:</td>
                            <td>
                                <input type="hidden" name="filter-parameters-targets" value="dateEvent" />
                                <input type="hidden" name="filter-parameters-labels" value="dateEventTo" />
                                <input type="text" id="datepicker-to" name="filter-parameters-values" value="${hm.dateEventTo}" />
                            </td>
                            <td>Destination:</td>
                            <td>
                                <input type="hidden" name="filter-parameters-targets" value="serverIp" />
                                <input type="hidden" name="filter-parameters-labels" value="serverIpSource" />
                                <input type="text" name="filter-parameters-values" value="${hm.serverIpSource}"/>
                            </td>
                            <td>Destination:</td>
                            <td>
                                <input type="hidden" name="filter-parameters-targets" value="serverPort" />
                                <input type="hidden" name="filter-parameters-labels" value="serverIpDestination" />
                                <input type="text" name="filter-parameters-values" value="${hm.serverIpDestination}" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <button type="submit" class="btn btn-sm btn-success filter-submit">Apply</button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <!--<input type="hidden" name="filter-parameters-names" value="user" />-->
            <input type="hidden" id="pageNumber" name="pageNumber" value="1" />
        </form>
    </div>
    <div class="row">
        <table class="table table-bordered table-striped table-hover">
            <thead>
                <tr>
                    <td><strong>ID</strong></td>
                    <td><strong>Date</strong></td>
                    <td><strong>SourceIP</strong></td>
                    <td><strong>SourcePort</strong></td>
                    <td><strong>DestinationIP</strong></td>
                    <td><strong>DestinationPort</strong></td>
                    <td><strong>ClassAtack</strong></td>
                    <td><strong>Details</strong></td>
                    <td><strong>Action</strong></td>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${lst}" var="e">
                    <tr>
                        <td>${e.id}</td>
                        <td>${e.dateEvent}</td>
                        <td>${e.clientIp}</td>
                        <td>${e.clientPort}</td>
                        <td>${e.serverIp}</td>
                        <td>${e.serverPort}</td>
                        <td>${e.rules[0].fileId.fileName}</td>
                        <td>
                            <a href="get">${e.transactionId}</a>
                        </td>
                        <td>
                            <strong> 
                                <a class="btn btn-danger" href="<c:url value="/deleteAllEvents?event=${e.id}" />">
                                    <i class="fa fa-times" aria-hidden="true"></i>
                                </a> 
                            </strong>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <div class="btn-group">
            <button type="button" class="btn btn-primary event-filter-btn" value="${pageNumber-1}">Previus</button>
            <button type="button" class="btn btn-primary event-filter-btn" value="${pageNumber}">${pageNumber}</button>
            <button type="button" class="btn btn-primary event-filter-btn" value="${pageNumber+1}">Next</button>
        </div>
    </div>
</div>