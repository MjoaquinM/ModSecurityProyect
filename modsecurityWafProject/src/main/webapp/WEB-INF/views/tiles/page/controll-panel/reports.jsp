<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">Users List</h1>
        </div>
    </div>

    <div class="row">
        <a class="btn btn-primary" href="<c:url value="/jasperDownloadPDF" />">Descargar PDF</a>
        <hr/>
        <a class="btn btn-primary" href="<c:url value="/jasperInlinePDF" />">Inline PDF</a>
    </div>
</div>