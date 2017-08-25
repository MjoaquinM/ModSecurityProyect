<%-- 
    Document   : modal
    Created on : 28-jul-2017, 14:33:04
    Author     : joaquin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="modal" id="${idModal}">
    <div class="modal-dialog modal-lg center-elements">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title"></h4>
            </div>
            <div class="modal-body"></div>
            <div class="modal-footer">
                <a href="#" data-dismiss="modal" class="btn modal-close">Close</a>
                <a href="#" class="btn btn-primary modal-success">Save</a>
            </div>
        </div>
    </div>
</div>