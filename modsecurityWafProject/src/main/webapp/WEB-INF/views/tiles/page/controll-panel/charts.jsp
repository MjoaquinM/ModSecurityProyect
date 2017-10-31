<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">Reports</h1>
        </div>
    </div>
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
            <form method="GET" id="event-filter-jasper-form" action="<c:url value="/control/jrreport" />">
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
                                <td colspan="5"></td>
                                <td>
                                    <a href="<c:url value="/charts" />" class="btn btn-md btn-primary">Reset</a>
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
                                
    <div class="row" style="text-align: center">
        <a class="btn btn-lg btn-primary" href="<c:url value="/control/jrreport" />">Generate Report</a>
    </div>
    
</div>