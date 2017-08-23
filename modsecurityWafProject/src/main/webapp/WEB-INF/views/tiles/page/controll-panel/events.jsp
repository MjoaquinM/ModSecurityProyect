<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>                         
<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">Events List</h1>
        </div>
    </div>
    <div class="row">
        <div class="table-responsive">
            <table class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Date</th>
                        <th>SourceIP</th>
                        <th>SourcePort</th>
                        <th>DestinationIP</th>
                        <th>DestinationPort</th>
                        <th>ClassAtack</th>
                        <th>Details</th>
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
                            <td>${e.eventRuleList[0].ruleId.fileId.fileName}</td>
                            <td>
                                <a id="show-event-details" data-action="showEvent" data-id="${e.transactionId}">
                                    ${e.transactionId}
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        <nav aria-label="Page navigation example">
            <ul class="pagination justify-content-center">
                <li class="page-item">
                    <a class="page-link" href="${pageNumber-1}">Previous</a>
                </li>
                <li class="page-item"><a class="page-link" href="#">${pageNumber}</a></li>
                <li class="page-item">
                    <a class="page-link" href="${pageNumber+1}">Next</a>
                </li>
            </ul>
        </nav>
    </div>
</div>