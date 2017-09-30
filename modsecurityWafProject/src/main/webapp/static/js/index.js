/*------------------------------------*\
 SIMPLE LOGIN FORM
 \*------------------------------------*/

$(document).ready(function () {
    //POPOVER ATTRIBUTE DESCRIPTION
    $('[data-toggle="popover"]').popover({ container: 'body'});
    $('.attribute-description').click(function(e) {
        e.preventDefault();
    });
    
    $('.message-status-container > div').fadeOut(7000);
    
    /************************LOGIN PAGE****************************/

    //Center login form
    $('#div-container-login').css('height', '300');
    var margin_top_bottom = (screen.height - 242) / 2 - 50;
    $('#div-container-login').css('margin-top', margin_top_bottom);

    //Disapear logout message
    $('.notice-login-page').fadeOut(4000);

    /************************LOGIN PAGE END****************************/

    /************************ADMIN FILE CONFIGURATION PAGE****************************/

    //Cancel form button

    $('#fileConfigurationModal').on('click', '#configurationFileModalCancel', function () {
        $('#fileConfigurationModal').modal('hide');
    })

    //Show form to edit a new configuration file
    $('#add-file-configuration-button,#edit-file-configuration-button,#remove-file-configuration-button').on('click', function () {
        /*<VARIABLES>*/
        var modalTitle = '';
        var action = $(this).data('action');
        var data = {};
        var url = '';
        var id = $(this).data('id');
        if (!id) {
            id = -1;
        }
        /*<PREPARE MODAL>*/
        var modalFooter = "";
        switch (action) {
            case 'remove':
                modalTitle = 'Remove File Configuration';
                url = 'removeFileConfiguration';
                modalFooter = '<button type="button" class="btn btn-primary" id="removeFileConfiguration" data-id="' + id + '">Delete</button>';
                break;
            case 'edit':
                modalTitle = 'Edit File Configuration';
                modalFooter = '<button type="button" class="btn btn-primary" id="addFileConfiguration">Save</button>';
                data = {id: id};
                url = 'addFileConfigurationForm';
                break;
            default:
                modalTitle = 'Add File Configuration <buton>Choose File</buton>';
                modalFooter = '<button type="button" class="btn btn-primary" id="addFileConfiguration">Add</button>';
                data = {id: id};
                url = 'addFileConfigurationForm';
        }
        modalFooter += '<button type="button" class="btn btn-secondary" data-dismiss="modal" id="configurationFileModalCancel">Cancel</button>';
        $('#generic-modal-container').find('.modal-footer').html(modalFooter);
        $('#generic-modal-container').find('.modal-title').html(modalTitle);
        if (url == 'removeFileConfiguration') {
            $('#generic-modal-container').find('.modal-body').html('<p> Confirm remove selected configuration file?</p>');
        } else {
            $.ajax({
                url: url,
                method: 'GET',
                dataType: 'html',
                data: data
            }).done(function (response) {
                $('#generic-modal-container').find('.modal-body').html(response);
                $('#search-file-configuration-button').on('click',function(){
                    validateFileConfiguration($('#generic-modal-container').find('#pathName').val());
                });
            }).fail(function () {
                $('#generic-modal-container').find('.modal-body').html('<p>An error has occurred. </p>');
            });
        }
        /*<SHOW MODAL>*/
        if($('#generic-modal-container').find('#fileConfigurationTemplateModal').length==1){
            $('#fileConfigurationTemplateModal').modal('show');
        }else{
            $('#fileConfigurationModal').modal('show');
        }
    });
    
    //Validate FILE
    function validateFileConfiguration(path){
        $.ajax({
            method : "POST",
            url : "checkFile",
            timeout : 100000,
            data: {path: path},
            beforeSend: function(xhr){
                xhr.setRequestHeader('X-CSRF-Token', $('#token-form').val());
            },
        }).done(function(response){
            var messageStatus = '';
            var typeAlert = 'danger';
            if(response.length==2){
                $('#name').val(response[1].substring(response[1].lastIndexOf('/')+1));
                messageStatus = 'The path is correct';
                typeAlert = 'success';
            }else{
                messageStatus = 'Can\'t find file';
            }
            var html = '<div class="alert alert-'+typeAlert+' notice-login-page" ><p style="margin-left: auto; margin-right: auto">'+messageStatus+'</p></div>';
            html += (typeAlert == 'success') ? '<input type="hidden" id="file-path-status" value="true" />' : '<input type="hidden" id="file-path-status" value="false" />';
            
            $('.path-file-state').html(html);
        }).fail(function(e){
            console.log('Error',e);
        });
    };

    $('#configurationFileModalCancel').on('click', function () {
        $('#fileConfigurationModal').modal('close');
    });

    $('#fileConfigurationModal').on('click', '#addFileConfiguration', function () {
        editConfigFile('configFileList');
    });
    
    $('#fileConfigurationTemplateModal').on('click','#addFileConfiguration',function(){
        editConfigFile('configFileTemplate');
    });
    
    function editConfigFile(redirectTo){
        $('#fileConfigurationModal,#fileConfigurationTemplateModal').find('form').validate({
            rules: {
                pathName: "required"
            },
            messages: {
                pathName: "Please enter a valid file path"
            }
        });
        if($('#name').val()!='' && $('#file-path-status').val()=='true'){
            var form = $('#fileConfigurationModal,#fileConfigurationTemplateModal').find('form');
            form.append('<input type="hidden" value="'+redirectTo+'" name=redirectTo />')
            form.submit();
        }else{
            if($('#file-path-status').length==0 || $('#file-path-status').val()=='false'){
                $('.path-file-state').html('<div class="alert alert-danger notice-login-page" ><p style="margin-left: auto; margin-right: auto">Please, verify the path file.</p></div><input type="hidden" id="file-path-status" value="false" />');
            }
        }
    };

    $('body').on('click', '#removeFileConfiguration', function () {
        $('#deleteFileconfiguration').append('<input type="text" name="id" value="' + $(this).data("id") + '" />');
        $('#deleteFileconfiguration').submit();
    });


    /**
     * SPECIFIC CONFIGURATION FILE TEMPLATE - EDIT ATTRIBUTES
     */
    //Show form to edit a new configuration file attribute group
    $('.attribute-group').on('click', function () {
        /*<VARIABLES>*/
        var modalTitle = '';
        var action = $(this).data('action');
        var url = '';
        var configFileId = $(this).data('config-file-id');
        var configFileAttrGroupId = $(this).data('config-file-group-id');
        if (!configFileId) {
            configFileId = -1;
        }
        if (!configFileAttrGroupId) {
            configFileAttrGroupId = -1;
        }
        var data = {'cfag-id': configFileAttrGroupId,
                    'cfa-id' : configFileId};
        /*<PREPARE MODAL>*/
        var modalFooter = "";
        switch (action) {
            case 'remove':
                modalTitle = 'Remove File Configuration Group';
                url = 'removeFileConfiguration';
                modalFooter = '<button type="button" class="btn btn-primary" id="removeFileConfigurationAttGroup" data-cfId="'+configFileId+'" data-cfagId="'+configFileAttrGroupId+'" data-action="'+action+'">Delete</button>';
                break;
            case 'edit':
                modalTitle = 'Edit File Configuration Group';
                modalFooter = '<button type="button" class="btn btn-primary" id="addFileConfigurationAttrGroup" data-cfId="'+configFileId+'" data-cfagId="'+configFileAttrGroupId+'" data-action="'+action+'">Save</button>';
                url = 'addFileConfigurationAttrGroupForm';
                break;
            default:
                modalTitle = 'Add File Configuration Attribute Group';
                modalFooter = '<button type="button" class="btn btn-primary" id="addFileConfigurationAttrGroup" data-cfId="'+configFileId+'" data-cfagId="'+configFileAttrGroupId+'" data-action="'+action+'">Add</button>';
                url = 'addFileConfigurationAttrGroupForm';
        }
        modalFooter += '<button type="button" class="btn btn-secondary" data-dismiss="modal" id="configurationFileAttrGroupModalCancel">Cancel</button>';
        $('#generic-modal-container').find('.modal-footer').html(modalFooter);
        $('#generic-modal-container').find('.modal-title').html(modalTitle);
        if (action == 'remove') {
            $('#generic-modal-container').find('.modal-body').html('<p> Confirm remove selected configuration file attribute group? All attributes in this group will be deleted. </p>');
        } else {
            $.ajax({
                url: url,
                method: 'GET',
                dataType: 'html',
                data: data
            }).done(function (response) {
                $('#generic-modal-container').find('.modal-body').html(response);
            }).fail(function () {
                $('#generic-modal-container').find('.modal-body').html('<p>An error has occurred. </p>');
            });
        }
        /*<SHOW MODAL>*/
        $('#fileConfigurationTemplateModal').modal('show');
    });
    
    //Confirm Add Attribute 
    $('#fileConfigurationTemplateModal').on('click', '#addFileConfigurationAttrGroup', function () {
        $('#fileConfigurationTemplateModal').find('form').validate({
            rules: {
                name: "required",
                description: "required"
            },
            messages: {
                name: "Please enter a name",
                description: "Please enter a description"
            }
        });
        $('#fileConfigurationTemplateModal').find('form').append('<input type="hidden" name="action" value="'+$(this).data('action')+'" />');
        $('#fileConfigurationTemplateModal').find('form').append('<input type="hidden" name="cf-id" value="'+$(this).data('cfid')+'" />');
        $('#fileConfigurationTemplateModal').find('form').append('<input type="hidden" name="cfag-id" value="'+$(this).data('cfagid')+'" />');
        $('#fileConfigurationTemplateModal').find('form').submit();
    });
    //Confirm Remove Attribute Group
    $('#fileConfigurationTemplateModal').on('click', '#removeFileConfigurationAttGroup', function () {
        $('#deleteAttrGroupForm').append('<input type="hidden" name="cfag-id" value="'+$(this).data('cfagid')+'" />');
        $('#deleteAttrGroupForm').submit();
    });
    
    //Show form to edit a new configuration file attribute
    $('.file-attribute-button').on('click', function () {
        /*<VARIABLES>*/
        var modalTitle = '';
        var action = $(this).data('action');
        
        var url = '';
        var configFileAttrGroupId = $(this).data('config-file-attr-group-id');
        var configFileAttrId = $(this).data('config-file-attr-id');
        var configFileId = $(this).data('config-file-id');
        if (!configFileAttrId) {
            configFileAttrId = -1;
        }
        if (!configFileAttrGroupId) {
            configFileAttrGroupId = -1;
        }
        var data = {'cfag-id': configFileAttrGroupId,
                    'cfa-id' : configFileAttrId};
        /*<PREPARE MODAL>*/
        var modalFooter = "";
        switch (action) {
            case 'remove':
                modalTitle = 'Remove File Configuration Attr '+$(this).data('config-file-attr-name')+'?';
                modalFooter = '<button type="button" class="btn btn-primary" id="removeFileConfigurationAttr" data-id="'+configFileAttrId+'">Delete</button>';
                break;
            case 'edit':
                modalTitle = 'Edit File Configuration';
                modalFooter = '<button type="button" class="btn btn-primary" id="addFileConfigurationAttr">Save</button>';
                url = 'addFileConfigurationAttrForm';
                break;
            default:
                modalTitle = 'Add File Configuration Attribute';
                modalFooter = '<button type="button" class="btn btn-primary" id="addFileConfigurationAttr">Add</button>';
                url = 'addFileConfigurationAttrForm';
        }
        modalFooter += '<button type="button" class="btn btn-secondary" data-dismiss="modal" id="configurationFileAttrModalCancel">Cancel</button>';
        $('#generic-modal-container').find('.modal-footer').html(modalFooter);
        $('#generic-modal-container').find('.modal-title').html(modalTitle);
        if (action == 'remove') {
            $('#generic-modal-container').find('.modal-body').html('<p> Confirm remove selected configuration file attribute? </p>');
        } else {
            $.ajax({
                url: url,
                method: 'GET',
                dataType: 'html',
                data: data
            }).done(function (response) {
                $('#generic-modal-container').find('.modal-body').html(response);
                $('#generic-modal-container').find('form').append('<input type="hidden" name="cfid" value="'+configFileId+'" />');
                $('#generic-modal-container').find('.type-row').find('select').on('change',function(){
                    var currentValue = $(this).val();
                    var text = $(this).find('[value='+currentValue+']').text();
                    if(text.toString().indexOf('group')>=0){
                        $('#generic-modal-container').find('.options-row-header').addClass('hidden');
                        $('#value').attr('readonly',false);
                        $('#value').attr('disabled',false);
                        $('.option-groups-row-header').removeClass('hidden');
                        $('#generic-modal-container').find('.options-row').remove();
                    }else{
                        if(text.toString().indexOf('select')>=0){
                            $('#value').attr('disabled',true);
                            $('#generic-modal-container').find('.options-row-header').removeClass('hidden');
                            var nOptions = $('#generic-modal-container').find('.options-row').length;
                            var htmlBlock = '<tr class="options-row added"><td><input id="configurationFileAttributeOptions'+(nOptions)+'.name" name="configurationFileAttributeOptions['+(nOptions)+'].name" class="form-control input-sm attr-opt" value="" type="text"><div class="has-error"></div></td><td><a class="btn btn-primary" id="remove-config-file-attr-opt" data-action="remove"><i class="fa fa-times" aria-hidden="true"></i></a><a class="btn btn-primary" id="remove-config-file-attr-opt" data-action="remove"><i class="fa fa-times" aria-hidden="true"></i></a><input type="radio" name="radio-options" class="radio-options"></td></tr>\n\
                                             <tr><td>Description</td><td><textarea id="configurationFileAttributeOptions'+(nOptions)+'.description" name="configurationFileAttributeOptions['+(nOptions)+'].description" type="text" class="form-control input-sm" rows="2" cols="30"></textarea></td></tr>';
                            $(this).closest('tbody').append(htmlBlock);
                            $('.radio-options').trigger('click');
                        }else{
                            $('#generic-modal-container').find('.options-row-header').addClass('hidden');
                            $('#value').attr('readonly',false);
                            $('#value').attr('disabled',false);
                            $('#generic-modal-container').find('.options-row').remove();
                        }
                    }
                });
            }).fail(function () {
                $('#generic-modal-container').find('.modal-body').html('<p>An error has occurred. </p>');
            });
        }
        /*<SHOW MODAL>*/
        $('#fileConfigurationTemplateModal').modal('show');
    });
    
    $('#fileConfigurationTemplateModal').on('click', '#addFileConfigurationAttr', function () {
        $('#fileConfigurationTemplateModal').find('form').validate({
            rules: {
                name: "required",
//                description: "required",
                value: "required",
            },
            messages: {
                name: "Please enter a name",
//                description: "Please enter a description",
                value: "Plese set a value",
            }
        });
        var flagSubmit = true;
        $('.attr-opt').each(function(){
           if($(this).val()==""){
               flagSubmit = false;
               $(this).parent().find('.error').remove();
               $(this).parent().append('<label class="error" for="name">Please enter a option value</label>');
           }else{
               $(this).parent().find('.error').remove();
           }
        });
        if(flagSubmit){
            $('#value').attr('disabled',false);
            $('#fileConfigurationTemplateModal').find('form').submit();
        }
    });
    
    //Attributes options
    $('#fileConfigurationTemplateModal').on('click','#add-file-attribute-option-button',function(){
        var nOptions = $('#generic-modal-container').find('.options-row').length;
        var isChecked = (nOptions==0) ? 'checked' : '';
        var htmlBlock = '<tr class="options-row added"><td><input id="configurationFileAttributeOptions'+(nOptions)+'.name" name="configurationFileAttributeOptions['+(nOptions)+'].name" class="form-control input-sm attr-opt" value="" type="text"><div class="has-error"></div></td><td><a class="btn btn-primary" id="remove-config-file-attr-opt" data-action="remove"><i class="fa fa-times" aria-hidden="true"></i></a><a class="btn btn-primary" id="remove-config-file-attr-opt" data-action="remove"><i class="fa fa-times" aria-hidden="true"></i></a><input type="radio" name="radio-options" class="radio-options"></td></tr>\n\
                                             <tr><td>Description</td><td><textarea id="configurationFileAttributeOptions'+(nOptions)+'.description" name="configurationFileAttributeOptions['+(nOptions)+'].description" type="text" class="form-control input-sm" rows="2" cols="30"></textarea></td></tr>';
        $(this).closest('tbody').append(htmlBlock);
        if (nOptions==0){
            $('.radio-options').trigger('click');
        }
    });
    
    //Select current option
    $('#fileConfigurationTemplateModal').on('click','.radio-options',function(){
        $('#value').val($(this).closest('.options-row.added').find('.attr-opt').val());
        $(this).closest('.options-row.added').find('.attr-opt').keyup(function(){
            $('#value').val($(this).val());
        });
    });
    
    $('#fileConfigurationTemplateModal').on('click','#remove-config-file-attr-opt',function(){
        $(this).closest('tr').next().remove();
        $(this).closest('tr').remove();
    });
    
    //Remove file configuration on file configuration template
    $('#remove-config-file-button').on('click',function(){
        
    });
    
    //Remove file configuration attribute on file configuration template    
    $('#fileConfigurationTemplateModal').on('click','#removeFileConfigurationAttr',function(){
        $('#deleteAttrForm').append('<input type="text" name="id" value="' + $(this).data("id") + '" />');
        $('#deleteAttrForm').submit();
    });
    
    //This is to set current options on select attributes in configuration file template page
    $('.file-config-page-select-attr').find('option').attr('selected',false);
    $('.file-config-page-current-value-attr-label').each(function(){
        var text = $(this).text();
        $(this).parent().parent().find('.file-config-page-select-attr').find('option').each(function(){
            if($(this).text()==text){
                $(this).parent().val($(this).val());
                return false;
            }
        });
    });
    
    //When select option change -> update the hidden value attr input
    $('.file-config-page-select-attr').on('change',function(){
        var values = '';
        $(this).find('option:selected').each(function(){
            values += $(this).text()+',';
        });
        values = values.slice(0,-1);
        $(this).parent().parent('tr').find('.file-config-page-current-value-attr').val(values);
    });
    
    $('.file-config-page-text-number-attr').on('keyup click',function(){
       $(this).parent().parent('tr').find('.file-config-page-current-value-attr').val($(this).val());
    });
    
    //Apply configuration
    $('#apply-configuration').on('click',function(){
        
        $('#configurationFrom').submit();
    });
    
    /**
     * SPECIFIC CONFIGURATION FILE TEMPLATE - EDIT ATTRIBUTES END
     */

    /************************ADMIN FILE CONFIGURATION PAGE END****************************/
    
    /************************MANAGE USERS****************************/

    /**
     * Show add user modal - Get add user form
     **/

    $('#add-user-button,#edit-user-button,#remove-user-button').on('click', function () {
        /*<VARIABLES>*/
        var modalTitle = '';
        var action = $(this).data('action');
        var data = {};
        var url = '';
        var id = $(this).data('id');
        if (!id) {
            id = -1;
        }
        /*<PREPARE MODAL>*/
        var modalFooter = "";
        switch (action) {
            case 'remove':
                modalTitle = 'Remove User';
                url = 'removeUser';
                modalFooter = '<button type="button" class="btn btn-primary" id="removeUser" data-id="' + id + '">Delete</button>';
                break;
            case 'edit':
                modalTitle = 'Edit User';
                modalFooter = '<button type="button" class="btn btn-primary" id="addUser">Save</button>';
                data = {id: id};
                url = 'addUser';
                break;
            default:
                modalTitle = 'Add User';
                modalFooter = '<button type="button" class="btn btn-primary" id="addUser">Add</button>';
                data = {id: id};
                url = 'addUser';
        }
        modalFooter += '<button type="button" class="btn btn-secondary" data-dismiss="modal" id="userModalCancel">Cancel</button>';
        $('#generic-modal-container').find('.modal-title').html(modalTitle);
        $('#generic-modal-container').find('.modal-footer').html(modalFooter);
        if (url == 'removeUser') {
            $('#generic-modal-container').find('.modal-body').html('<p> Confirm remove selected user? </p>');
        } else {
            $.ajax({
                url: url,
                method: 'GET',
                dataType: 'html',
                data: data
            }).done(function (response) {
                $('#generic-modal-container').find('.modal-body').html(response);
            }).fail(function (e) {
                console.log(e);
                $('#generic-modal-container').find('.modal-body').html('An error has occurred.');
            });
        }
        /*<SHOW MODAL>*/
        $('#userModal').modal('show');
    });

    $('#generic-modal-container').on('click', '#addUser', function () {

        $('#userModal').find('form').validate({
            rules: {
                userName: "required",
                firstName: "required",
                lastName: "required",
                password: {
                    required: true,
                    minlength: 5
                }
            },
            messages: {
                userName: "Please enter a user name",
                firstName: "Please enter your first name",
                lastName: "Please enter your last name",
                password: {
                    required: "Please enter a password",
                    minlength: "Your password must be at least 5 characters long"
                }
            }
        });

        $('#userModal').find('form').submit();

    });

    $('#generic-modal-container').on('click', '#removeUser', function () {
        $('#delete-user-form').append('<input type="text" name="id" value="' + $(this).data("id") + '" />');
        $('#delete-user-form').submit();
    });
    
    //USERS HISTORY
    $('#show-filter-user-history').on('click',function(){
        if($(this).find('i').hasClass('fa-angle-double-down')){
            $(this).find('i').removeClass('fa-angle-double-down');
            $(this).find('i').addClass('fa-angle-double-up');
        }else{
            $(this).find('i').removeClass('fa-angle-double-up');
            $(this).find('i').addClass('fa-angle-double-down');
        }
    });
    
    //User filter
//    $( "#datepicker-from" ).datepicker({ dateFormat: 'yy-mm-dd' });
    $( "#datepicker-from" ).datepicker({ dateFormat: 'yy-mm-dd' });
    $( "#datepicker-to" ).datepicker({ dateFormat: 'yy-mm-dd' });
    $( "#datepicker-to" ).on("change",function(){
        if($(this).val()<$( "#datepicker-from" ).val()){
            $(this).val($( "#datepicker-from" ).val());
        }
    });
    
    //Users History Pagination
    $('.user-history-filter-btn').on('click',function(){
        
        $('#user-history-filter-form').find('#pageNumber').val($(this).val());
        $('#user-history-filter-form').submit();
    });

    /************************MANAGE USERS END****************************/
    
    /************************MANAGE RULES ****************************/
    $('.parameter-item').on('click',function(){
        var name = $(this).text().replace('REQUEST-','').trim();
        name = name.replace('RESPONSE-','').trim();
        name = name.substring(0,name.indexOf('-'));
        name = name+"000-"+name+"999";
        if ($(this).hasClass('alert-warning')){
            $('#'+name).remove();
            $(this).removeClass('alert-warning');
            var finalValue = $('.final-value').val();
            finalValue = finalValue.replace(name,'');
            if(finalValue[0]==','){
                finalValue = finalValue.substring(1,finalValue.length);
            }
            if(finalValue[finalValue.length-1]==','){
                finalValue = finalValue.substring(0,finalValue.length-1);
            }
            $('.final-value').val(finalValue);
            
        }else{
            $(this).addClass('alert-warning');
            if($('.final-value').val()!=''){
                $('.final-value').val($('.final-value').val()+","+name);
            }else{
                $('.final-value').val(name);
            }
            $('.blocked-container').append('<div id="'+name +'" class="blocked-item">'+name+'</div>');
        }
    });
    
    $('.id-parameter-item').on('click',function(){
        var finalValue = $('.final-value').val();
        
        if ($(this).hasClass('alert-warning')){
            $('#id-blocked-container').find('#'+$(this).html().trim(' ')).remove();
            $(this).removeClass('alert-warning');
//            $('.final-value').val($('.final-value').val().replace($(this).html().trim(' '),'').trim(','));
            finalValue = finalValue.replace($(this).html().trim(),'');
        }else{
            $(this).addClass('alert-warning');
            $('#id-blocked-container').append('<div id="'+$(this).html().trim()+'" class="blocked-item">'+$(this).html().trim()+'</div>');
//            $('.final-value').val(($('.final-value').val()+','+$(this).html().trim(' ')).trim(','));
            finalValue = finalValue+','+$(this).html().trim();
        }
        
        if(finalValue[0]==','){
            finalValue = finalValue.substring(1,finalValue.length);
        }
        if(finalValue[finalValue.length-1]==','){
            finalValue = finalValue.substring(0,finalValue.length-1);
        }
        
        finalValue = finalValue.replace(',,',',');
        
        $('.final-value').val(finalValue);
    
    });
    
    $('.block-rules-button').on('click',function(){
        $('#blockRules').submit();
    });
    
    /************************MANAGE RULES END****************************/
    
    /************************MANAGE EVENTS****************************/
    $('.event-filter-btn').on('click',function(){
        $('#event-filter-form').find('#pageNumber').val($(this).val());
        $('#event-filter-form').submit();
    });

$('.show-event-details').on('click', function () {
        /*<VARIABLES>*/
        var modalTitle = 'Event Details';
        var data = {};
        var url = '';
        var txid = $(this).data('id');
        if (!txid) {
            txid = "";
        }
        data = {transactionId: txid};
        /*<PREPARE MODAL>*/
        var modalFooter = '<button type="button" class="btn btn-secondary" data-dismiss="modal" id="eventDetailsCancel">Close</button>';
        $('#generic-modal-container').find('.modal-title').html(modalTitle);
        $('#generic-modal-container').find('.modal-footer').html(modalFooter);
        $.ajax({
            url: 'eventDetailsForm',
            method: 'GET',
            dataType: 'html',
            data: data
        }).done(function (response) {
            $('#generic-modal-container').find('.modal-body').html(response);
        }).fail(function (e) {
            console.log(e.responseText);
            $('#generic-modal-container').find('.modal-body').html('An error has occurred.');
        });
        /*<SHOW MODAL>*/
        $('#eventModal').modal('show');
    });

/************************MANAGE EVENTS END****************************/

/************************ALERT ATTACK****************************/
////    $(function () {
//        "use strict";
//
//        var content = $('#content');
//        var input = $('#input');
//        var status = $('#status');
//        var myName = false;
//        var author = null;
//        var logged = false;
//        var socket = atmosphere;
//        
////        console.log("HOLA");
////        console.log( document.location.toString() + 'put');
//        
//        var request = { url: "http://localhost:8080/modsecurityWafProject/nada",// document.location.toString() + 'put',
//            contentType: "application/json",
//            logLevel: 'debug',
//            transport: 'sse',
//            reconnectInterval: 5000,
//
//            fallbackTransport: 'long-polling'};
//
//        request.onOpen = function (response) {
//            console.log("CONECCION ABIERTA");
//            console.log(response);
////            content.html($('<p>', { text: 'Atmosphere connected using ' + response.transport }));
////            input.removeAttr('disabled').focus();
////            status.text('Choose name:');
//        };
//
//        request.onReconnect = function (request, response) {
//            console.log("CONEXION PERDIDA, INTENTANDO RECONECTAR");
//            console.log(request);
//            console.log(response);
////            content.html($('<p>', { text: 'Connection lost, trying to reconnect. Trying to reconnect ' + request.reconnectInterval}));
////            input.attr('disabled', 'disabled');
//        };
//
//        request.onReopen = function (response) {
//            console.log("CONEXION REABIERTA");
//            console.log(response);
////            input.removeAttr('disabled').focus();
////            content.html($('<p>', { text: 'Atmosphere re-connected using ' + response.transport }));
//        };
//
//        request.onMessage = function (response) {
//            console.log("ESCRIBOOOOOOOOOOOOOOOOOOOOOOOOO");
//            console.log(response);
//            var message = response.responseBody;
//            try {
//                var json = atmosphere.util.parseJSON(message);
//            } catch (e) {
//                console.log('This doesn\'t look like a valid JSON: ', message);
//                return;
//            }
//
////            input.removeAttr('disabled').focus();
////            if (!logged) {
////                logged = true;
////                status.text(myName + ': ').css('color', 'blue');
////            } else {
////                var me = json.author == author;
////                var date = typeof(json.time) == 'string' ? parseInt(json.time) : json.time;
////                addMessage(json.author, json.text, me ? 'blue' : 'black', new Date(date));
////            }
//        };
//
//        request.onClose = function (response) {
//            console.log("CONEXION CERRADA");
//            console.log(response);
////            content.html($('<p>', { text: 'Server closed the connection after a timeout' }));
////            input.attr('disabled', 'disabled');
//        };
//
//        request.onError = function (response) {
//            console.log("HUBO PROBLEMAS CON EL SOCKET O EL SERVIDOR");
//            console.log(response);
////            content.html($('<p>', { text: 'Sorry, but there\'s some problem with your '
////                + 'socket or the server is down' }));
//        };
//
//        /*
//         * ACA CONECTO CON EL PUSH
//         */
//        var subSocket = socket.subscribe(request);
//
//    //    var msg = $(this).val();
//        var msg = 'ESTO ES AL PEDO';
//
//        // First message is always the author's name
//        if (author == null) {
//            author = msg;
//        }
//
//        alert("NADA");
//        subSocket.push(atmosphere.util.stringifyJSON({ author: "author", message: "msg" }));
//        alert("TODO");
//        input.attr('disabled', 'disabled');
//        if (myName === false) {
//            myName = msg;
//        }

    //    input.keydown(function (e) {
    //        if (e.keyCode === 13) {
    //            var msg = $(this).val();
    //
    //            // First message is always the author's name
    //            if (author == null) {
    //                author = msg;
    //            }
    //
    //            subSocket.push(atmosphere.util.stringifyJSON({ author: author, message: msg }));
    //            $(this).val('');
    //
    //            input.attr('disabled', 'disabled');
    //            if (myName === false) {
    //                myName = msg;
    //            }
    //        }
    //    });

//        function addMessage(author, message, color, datetime) {
//            content.append('<p><span style="color:' + color + '">' + author + '</span> @ ' + +(datetime.getHours() < 10 ? '0' + datetime.getHours() : datetime.getHours()) + ':'
//                + (datetime.getMinutes() < 10 ? '0' + datetime.getMinutes() : datetime.getMinutes())
//                + ': ' + message + '</p>');
//        }
//    });



    var stompClient = null;
             
    function setConnected(connected) {
        document.getElementById('connect').disabled = connected;
        document.getElementById('disconnect').disabled = !connected;
        document.getElementById('conversationDiv').style.visibility 
          = connected ? 'visible' : 'hidden';
        document.getElementById('response').innerHTML = '';
    }

    function connect() {
//        var socket = new SockJS('/spring-mvc-java/chat');
        var socket = new SockJS('/modsecurityWafProject/put');
        
        stompClient = Stomp.over(socket);  
        stompClient.connect({}, function(frame) {
            setConnected(true);
            console.log('Connected: ' + frame);
            stompClient.subscribe('/topic/messages', function(messageOutput) {
                showMessageOutput(messageOutput.body);
//                showMessageOutput(messageOutput);
//                showMessageOutput(JSON.parse(messageOutput.body));
            });
        });
    }

    function disconnect() {
        if(stompClient != null) {
            stompClient.disconnect();
        }
        setConnected(false);
        console.log("Disconnected");
    }

    function sendMessage() {
        var from = document.getElementById('from').value;
        var text = document.getElementById('text').value;
        stompClient.send("/app/put", {}, 
          "hola");
//        stompClient.send("/app/chat", {}, 
//          JSON.stringify({'from':from, 'text':text}));
    }

    function showMessageOutput(messageOutput) {
        console.log(messageOutput);
        alert(messageOutput.time);
        $('#contenedor-auxiliar').append("<p>ATTACARON VIEJA! TENE CUIDADO</p>")
//        var response = document.getElementById('response');
//        var p = document.createElement('p');
//        p.style.wordWrap = 'break-word';
//        p.appendChild(document.createTextNode(messageOutput.from + ": " 
//          + messageOutput.text + " (" + messageOutput.time + ")"));
//        response.appendChild(p);
    }
    
    $('#connect').on('click',function(){
        connect();
    });
    
    $('#sendMessage').on('click',function(){
//        sendMessage();
        sendRequest();
    });

    
    function sendRequest(){
        console.log("APRETASTE");
        var date = '';
        var datedate = new Date();
        console.log (datedate.getFullYear() + " " + datedate.getHours());
        if(typeof(EventSource) !== "undefined") {
            console.log("DISPONIBLE");
            var source = new EventSource("/modsecurityWafProject/pasame?date="+date);
            source.onmessage = function(event) {
                console.log("mensaje recibido: "+event.data)
//                document.getElementById("sseDiv").innerHTML += event.data + " - ";
            };
        } else {
            console.log("NO DISPONIBLE");
            alert("Your browser does not support server-sent events.");                             
        }
    }
    
//    if(typeof(EventSource) !== "undefined") {
//        console.log("DISPONIBLE");
//        var source = new EventSource("/modsecurityWafProject/pasame");
//        source.onmessage = function(event) {
//            console.log("mensaje recibido: "+event.data)
////                document.getElementById("sseDiv").innerHTML += event.data + " - ";
//        };
//    } else {
//        console.log("NO DISPONIBLE");
//        alert("Your browser does not support server-sent events.");                             
//    }
    

/************************ALERT ATTACK END****************************/
      
});