<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">Users List</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <!-- /.row -->
    <div class="row">
        <h1>ACA VAN LOS EVENTOS/ALERTAS</h1>
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
                            <a href="get">${e.transactionId}</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <nav aria-label="Page navigation example">
            <ul class="pagination justify-content-center">
                <li class="page-item">
                    <a class="page-link" href="${pageNumber-1}">Previus</a>
                </li>
                <li class="page-item"><a class="page-link" href="#">${pageNumber}</a></li>
                <li class="page-item">
                    <a class="page-link" href="${pageNumber+1}">Next</a>
                </li>
            </ul>
        </nav>
    </div>
</div>