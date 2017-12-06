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
                modalTitle = 'Add Configuration File ';
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
                modalTitle = 'Remove Attribute Group';
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
            $('#generic-modal-container').find('.modal-body').html('<p> Confirm remove selected attribute group? All attributes in this group will be deleted. </p>');
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
                modalTitle = 'Remove Attribute '+$(this).data('config-file-attr-name')+'?';
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
            $('#generic-modal-container').find('.modal-body').html('<p> Confirm remove selected attribute? </p>');
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
                            var htmlBlock = '<tr class="options-row added">\n\
                                                <td>\n\
                                                Name: \n\
                                                </td>\n\
                                                <td>\n\
                                                    <input id="configurationFileAttributeOptions'+(nOptions)+'.name" name="configurationFileAttributeOptions['+(nOptions)+'].name" class="form-control input-sm attr-opt" value="" type="text">\n\
                                                    <div class="has-error"></div>\n\
                                                </td>\n\
                                                <td>\n\
                                                    <a class="btn btn-primary" id="remove-config-file-attr-opt" data-action="remove">\n\
                                                        <i class="fa fa-times" aria-hidden="true"></i>\n\
                                                    </a>\n\
                                                    <input type="radio" name="radio-options" class="radio-options">\n\
                                                </td>\n\
                                             </tr>\n\
                                             <tr class="options-row added">\n\
                                                <td>Description</td>\n\
                                                <td>\n\
                                                    <textarea id="configurationFileAttributeOptions'+(nOptions)+'.description" name="configurationFileAttributeOptions['+(nOptions)+'].description" type="text" class="form-control input-sm" rows="2" cols="30"></textarea>\n\
                                                </td>\n\
                                             </tr>';
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
        //var htmlBlock = '<tr class="options-row added"><td><input id="configurationFileAttributeOptions'+(nOptions)+'.name" name="configurationFileAttributeOptions['+(nOptions)+'].name" class="form-control input-sm attr-opt" value="" type="text"><div class="has-error"></div></td><td><a class="btn btn-primary" id="remove-config-file-attr-opt" data-action="remove"><i class="fa fa-times" aria-hidden="true"></i></a><a class="btn btn-primary" id="remove-config-file-attr-opt" data-action="remove"><i class="fa fa-times" aria-hidden="true"></i></a><input type="radio" name="radio-options" class="radio-options"></td></tr>\n\
        //                                    <tr><td>Description</td><td><textarea id="configurationFileAttributeOptions'+(nOptions)+'.description" name="configurationFileAttributeOptions['+(nOptions)+'].description" type="text" class="form-control input-sm" rows="2" cols="30"></textarea></td></tr>';
        var htmlBlock = '<tr class="options-row added">\n\
                                                <td>\n\
                                                Name: \n\
                                                </td>\n\
                                                <td>\n\
                                                    <input id="configurationFileAttributeOptions'+(nOptions)+'.name" name="configurationFileAttributeOptions['+(nOptions)+'].name" class="form-control input-sm attr-opt" value="" type="text">\n\
                                                    <div class="has-error"></div>\n\
                                                </td>\n\
                                                <td>\n\
                                                    <a class="btn btn-primary" id="remove-config-file-attr-opt" data-action="remove">\n\
                                                        <i class="fa fa-times" aria-hidden="true"></i>\n\
                                                    </a>\n\
                                                    <input type="radio" name="radio-options" class="radio-options">\n\
                                                </td>\n\
                                             </tr>\n\
                                             <tr>\n\
                                                <td>Description</td>\n\
                                                <td>\n\
                                                    <textarea id="configurationFileAttributeOptions'+(nOptions)+'.description" name="configurationFileAttributeOptions['+(nOptions)+'].description" type="text" class="form-control input-sm" rows="2" cols="30"></textarea>\n\
                                                </td>\n\
                                             </tr>';
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
    
    $('.user-filter-btn').on('click',function(){
        $('#user-filter-form').find('#pageNumber').val($(this).val());
        $('#user-filter-form').submit();
    });

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
            $('#generic-modal-container').find('.modal-body').html('<p> remove selected user? </p>');
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
                email: "required",
                password: {
                    required: true,
                    minlength: 5
                }
            },
            messages: {
                userName: "Please enter a user name",
                firstName: "Please enter your first name",
                lastName: "Please enter your last name",
                email: "Please enter an email",
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
    
    
    /* PARSE RULES AND FILES */
    $('#parse-rule-button').on('click',function(){
        alert('apretaste');
        $.ajax({
            url: 'parseRules',
            method: 'POST',
        }).done(function (response) {
            alert('La actualizaci&oacuten de reglas fu&eacute existosa. Por favor actualice la p&aacutegina.');
            
        }).fail(function (e) {
            alert('Hubo un error al actualizar las reglas.');
        });
    });
    
    /************************MANAGE RULES END****************************/
    
    /************************EVENTS****************************/
    $('.deleteEvent').on('click',function(){
        /*<VARIABLES>*/
        var modalTitle = '';
        var action = $(this).data('action');
        var url = 'deleteAllEvents';
        var eventId = $(this).data('event-id');
        console.log(action + " -- " + eventId);
        if (!eventId) {
            eventId = -1;
        }
        var modalMessage = '';
        /*<PREPARE MODAL>*/
        var modalFooter = "";
        switch (action) {
            case 'individual':
                modalTitle = 'Delete Event';
                modalFooter = '<a href="deleteAllEvents?event='+eventId+'" class="btn btn-sm btn-danger">Delete</a>';//<button type="button" class="btn btn-primary" id="deleteEvent" data-cfId="'+configFileId+'" data-cfagId="'+configFileAttrGroupId+'" data-action="'+action+'">Delete</button>';
                modalMessage = '<p> Confirm delete selected event (id: '+eventId+')?</p>';
                break;
            default:
                alert("ELIMINAR TODOS");
                modalTitle = 'Delete Events';
                modalFooter = '<a href="deleteAllEvents" class="btn btn-sm btn-danger">Delete</a>';//<button type="button" class="btn btn-primary" id="deleteEvent" data-cfId="'+configFileId+'" data-cfagId="'+configFileAttrGroupId+'" data-action="'+action+'">Delete</button>';
                modalMessage = '<p> Confirm delete all events? </p>';
        }
        modalFooter += '<button type="button" class="btn btn-secondary" data-dismiss="modal" id="configurationFileAttrGroupModalCancel">Cancel</button>';
        $('#generic-modal-container').find('.modal-footer').html(modalFooter);
        $('#generic-modal-container').find('.modal-title').html(modalTitle);
        $('#generic-modal-container').find('.modal-body').html(modalMessage);

        /*<SHOW MODAL>*/
        $('#eventModal').modal('show');
    });
    
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
        data = {transactionId: txid, view: false};
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
    
    
    $('#delete-all-events').on('click',function(){
        $('#event-filter-form').append('<input type="hidden" name="deleteAll" value="true" />');
        $('#event-filter-form').submit();
    });

/************************MANAGE EVENTS END****************************/

/************************ALERT ATTACK****************************/
    var flagLog = true;
    var stompClient = null;
    
    function connect() {
        var socket = new SockJS('/modsecurityWafProject/alertMessages');
        stompClient = Stomp.over(socket);  
        stompClient.connect({}, function(frame) {
            console.log('Connected: ' + frame);
            stompClient.subscribe('/topic/messages', function(messageOutput) {
                showMessageOutput(JSON.parse(messageOutput.body));
            });
        });
        setInterval(function(){ sendMessage();}, 5000);
    }

    function disconnect() {
        if(stompClient != null) {
            stompClient.disconnect();
        }
        setConnected(false);
        console.log("Disconnected");
    }

    function sendMessage() {
        stompClient.send("/app/alertMessages", {}, {});
    }

    function showMessageOutput(messageOutput) {
        console.log("ESTA EN EL SHOW MESSAGE OUTPUT");
        if(messageOutput.length > 0){
            (flagLog == true) ? console.log("RECEIVED") : console.log("");
            (flagLog == true) ? console.log(messageOutput) : console.log("");
            for(var obj in messageOutput){
                console.log(messageOutput[obj].transactionId);
                console.log('REGLAS: '+messageOutput[obj].rules);
            }
            var message =
                    '<br><strong>Transaction Id: </strong>'+messageOutput[obj].transactionId+'<br>'+
                    '<strong>Client IP: </strong>'+messageOutput[obj].clientIp+
                    '<br><strong>Target: </strong>'+messageOutput[obj].destinationPage;
            
            for(var obj in messageOutput){
                if (messageOutput[obj].rules.length>0){
                    message += '<br><strong>Rules: </strong><br>';
                    for(var file in messageOutput[obj].rules){
                        message += messageOutput[obj].rules[file]+'<br>';
                    }
                }
            }

            showMessageAlert(
                    message,
                    'eventDetailsForm?view=true&transactionId='+messageOutput[obj].transactionId
                    );
        }
    }
    
    /*Conect to websocket on load page*/
    connect();
    
    /* Disconnect websocket before leave the page */
    $(window).bind('beforeunload', function(){
        disconnect();
    });
    
    /*Notify plugin - to show alerts*/
    function showMessageAlert(message,url){
        $.notify({
            // options
//            icon: 'glyphicon glyphicon-warning-sign',
            title: 'Alert: ',
            message: message,
            url: url,
            target: '_blank'
        },{
            // settings
            element: 'body',
            position: null,
            type: "danger",
            allow_dismiss: true,
            newest_on_top: false,
            showProgressbar: false,
            placement: {
                    from: "top",
                    align: "right"
            },
            offset: 20,
            spacing: 10,
            z_index: 1031,
            delay: 3000,
            timer: 1000,
            url_target: '_blank',
            mouse_over: null,
            animate: {
                    enter: 'animated fadeInDown',
                    exit: 'animated fadeOutUp'
            },
            onShow: null,
            onShown: null,
            onClose: null,
            onClosed: null,
            icon_type: 'class',
//            template: '<div data-notify="container" class="col-xs-11 col-sm-3 alert alert-{0}" role="alert">' +
//                    '<button type="button" aria-hidden="true" class="close" data-notify="dismiss">×</button>' +
//                    '<span data-notify="icon"></span> ' +
//                    '<span data-notify="title">{1}</span> ' +
//                    '<span data-notify="message">{2}</span>' +
//                    '<div class="progress" data-notify="progressbar">' +
//                            '<div class="progress-bar progress-bar-{0}" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 0%;"></div>' +
//                    '</div>' +
//                    '<a href="{3}" target="{4}" data-notify="url"></a>' +
//            '</div>' 
        });
    }

/************************ALERT ATTACK END****************************/

/************************ GENERAL ****************************/
//    $('.title-on-mouse-over').mouseover(function(){
//        console.log($(this).find('.text-container').text());
//    });
/************************ GENERAL END ****************************/

});