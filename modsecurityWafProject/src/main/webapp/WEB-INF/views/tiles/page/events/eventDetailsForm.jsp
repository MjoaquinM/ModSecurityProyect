<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    

<table class="table table-hover">
    <tbody>
        <tr>
            <td>
                <div class="form-group col-md-12">
                    <label class="col-md-5 control-lable">
                        <p>Transaction ID:</p>
                        <p>Date Event:</p>
                        <p>SourceIp:</p>
                        <p>SourcePort:</p>
                        <p>DestinationIp:</p>
                        <p>DestinationPort:</p>
                        <p>Method:</p>
                        <p>Destination Page</p>
                    </label>
                    <div class="col-md-7">
                        <p>${event.transactionId}</p>
                        <p>${event.dateEvent}</p>
                        <p>${event.clientIp}</p>
                        <p>${event.clientPort}</p>
                        <p>${event.serverIp}</p>
                        <p>${event.serverPort}</p>
                        <p>${event.method}</p>
                        <p>${event.destinationPage}</p>
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <h4>Rules activated</h4>
                <c:forEach items="${event.eventRuleList}" var="er">
                    <div class="form-group col-md-12">
                        <div class="col-md-2 control-lable">
                            ${er.ruleId.ruleId}
                        </div>
                        <div class="col-md-5">
                            ${er.ruleId.message}
                        </div>
                        <div class="col-md-2">
                            ${er.ruleId.severity}
                        </div>
                        <div class="col-md-3">
                            ${er.ruleId.fileId.fileName}
                        </div>
                    </div>
                </c:forEach>
                
                <div class="col-md-7">
                </div>
            </td>
        </tr>
    </tbody>
</table>



