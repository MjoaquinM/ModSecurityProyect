<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
    <div class="row" style="text-align:center; padding-bottom: 10px;">
        <button type="button" class="btn btn-lg btn-danger" id="delete-all-events">
            Delete All
        </button>
    </div>
    <!-- /.row -->
    <div class="panel panel-default">
        <div class="panel-heading">
            <div class="row">
                <h3 class="filter-title">
                    Filters
                </h3>
                <button id="show-filter-user-history" data-toggle="collapse" data-target="#filters-containers"><i class="fa fa-angle-double-down" aria-hidden="true"></i></button>
            </div>
        </div>
        <div class="panel-body collapse" id="filters-containers">
            <form method="GET" id="event-filter-form">
                <input type="hidden" name="filterFlag"  value="true" />
                <div class="table-responsive">
                    <table class="table table-responsive">
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
                                <td colspan="2"></td>
                                <td>Transaction ID</td>
                                <td>
                                    <input type="hidden" name="filter-parameters-targets" value="transactionId" />
                                    <input type="hidden" name="filter-parameters-labels" value="transactionId" />
                                    <input type="text" name="filter-parameters-values" value="${hm.transactionId}" />
                                </td>
                                <td colspan="2"></td>
                            </tr>
                            <tr>
                                <td colspan="5"></td>
                                <td>
                                    <a href="<c:url value="/control/eventList" />" class="btn btn-primary">Reset</a>
                                    <button type="submit" class="btn btn-md btn-success filter-submit">Apply</button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <!--<input type="hidden" name="filter-parameters-names" value="user" />-->
                <input type="hidden" id="pageNumber" name="pageNumber" value="1" />
            </form>
        </div>
    </div>
    
    <div class="row">
        <table class="table table-striped vertical-middle-table">
                <thead>
                    <tr>
                        <th>Date</th>
                        <th>SourceIP</th>
                        <th>SourcePort</th>
                        <th>DestinationIP</th>
                        <th>DestinationPort</th>
                        <th>Method</th>
                        <th>Service</th>
                        <th>Protocol</th>
                        <th>Details</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${lst}" var="e" varStatus="i">
                        <tr>
                            <td><p title="${e.dateEvent}">${e.dateEvent}</p></td>
                            <td><p title="${e.clientIp}">${e.clientIp}</p></td>
                            <td><p title="${e.clientPort}">${e.clientPort}</p></td>
                            <td><p title="${e.serverIp}">${e.serverIp}</p></td>
                            <td><p title="${e.serverPort}">${e.serverPort}</p></td>
                            <td><p title="${e.method}">${e.method}</p></td>
                            <td><p title="${e.destinationPage}">${e.destinationPage}</p></td>
                            <td><p title="${e.protocol}">${e.protocol}</p></td>
                            <td class="title-on-mouse-over">
                                <a class="show-event-details text-container" data-action="showEvent" data-id="${e.transactionId}" title="${e.transactionId}">
                                    ${e.transactionId}
                                </a>
                            </td>
                            <td>
                                <strong>
                                    <a class="btn btn-danger deleteEvent" data-event-id="${e.id}" data-action="individual">
                                        <i class="fa fa-times" aria-hidden="true"></i>
                                    </a> 
                                </strong>
                            </td>
                        </tr>
                    </c:forEach>
                        <tr>
                            <td colspan="9">
                                <div class="btn-group">
                                    <button ${fn:length(lst)==0 || pageNumber==1 ? "disabled='true'" : ""} type="button" class="btn btn-primary event-filter-btn" value="${pageNumber-1}">Previous</button>
                                    <button ${fn:length(lst)==0 ? "disabled='true'" : ""} type="button" class="btn btn-primary event-filter-btn" value="${pageNumber}">${pageNumber}</button>
                                    <button ${fn:toUpperCase(lastPage)=="TRUE" ? "disabled='true'" : ""} type="button" class="btn btn-primary event-filter-btn" value="${pageNumber+1}">Next</button>
                                </div>
                            </td>
                            <td>
                                <!--<a ${fn:length(lst)==0 ? "disabled='true'" : ""} class="btn btn-danger deleteEvent" data-action="all">Delete All</a>-->
                            </td>
                        </tr>
                </tbody>
            </table>
    </div>
</div>