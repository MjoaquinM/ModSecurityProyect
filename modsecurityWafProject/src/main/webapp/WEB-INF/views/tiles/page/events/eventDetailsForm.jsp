<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<div id="${idPageWrapper}">
    
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">${title}</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    
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
                    <c:forEach items="${event.rules}" var="r">
                        <div class="form-group col-md-12">
                            <div class="col-md-2 control-lable">
                                ${r.ruleId}
                            </div>
                            <div class="col-md-5">
                                ${r.message}
                            </div>
                            <div class="col-md-2">
                                ${r.severity}
                            </div>
                            <div class="col-md-3">
                                ${r.fileId.fileName}
                            </div>
                        </div>
                    </c:forEach>

                    <div class="col-md-7">
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <table>
                        <thead>
                            <tr>
                                <td>
                                    <h4><strong>Transaction Parts Details</strong></h4>
                                </td>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>
                                    <strong>Part A</strong>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <p>${event.partA}</p>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <strong>Part B</strong>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <p>${event.partB}</p>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <strong>Part C</strong>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <p>${event.partC}</p>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <strong>Part D</strong>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <p>${event.partD}</p>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <strong>Part E</strong>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <p>${event.partE}</p>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <strong>Part F</strong>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <p>${event.partF}</p>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <strong>Part G</strong>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <p>${event.partG}</p>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <strong>Part H</strong>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <p>${event.partH}</p>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <strong>Part I</strong>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <p>${event.partI}</p>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <strong>Part J</strong>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <p>${event.partJ}</p>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <strong>Part K</strong>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <p>${event.partK}</p>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <strong>Part Z</strong>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <p>${event.partZ}</p>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </td>
            </tr>      
        </tbody>
    </table>
</div>
