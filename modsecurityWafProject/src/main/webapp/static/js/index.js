/*------------------------------------*\
 SIMPLE LOGIN FORM
 \*------------------------------------*/

$(document).ready(function () {
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
            $('#generic-modal-container').find('.modal-body').html('<p> Confirm remove selected configuration file? </p>');
        } else {
            $.ajax({
                url: url,
                method: 'GET',
                dataType: 'html',
                data: data
            }).done(function (response) {
                $('#generic-modal-container').find('.modal-body').html(response);
                $('#file-selector').on('change',function(){
                    
                });
                $('#search-file-configuration-button').on('click',function(){
                    validateFileConfiguration($('#pathName').val());
                });
            }).fail(function () {
                $('#generic-modal-container').find('.modal-body').html('<p>An error has occurred. </p>');
            });
        }
        /*<SHOW MODAL>*/
        if($(this).data('redirect-to')){
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
            $('.pone-aca-el-estado').html(html);
        }).fail(function(e){
            console.log('Error',e);
        });
    };

    $('#configurationFileModalCancel').on('click', function () {
        $('#fileConfigurationModal').modal('close');
    });

    $('#fileConfigurationModal').on('click', '#addFileConfiguration', function () {
        $('#fileConfigurationModal').find('form').validate({
            rules: {
//                name: "required",
                pathName: "required"
            },
            messages: {
//                name: "Please enter a name",
                pathName: "Please enter a valid file path"
            }
        });
        if($('#name').val()!=''){
            $('#fileConfigurationModal').find('form').submit();
        }
    })

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
                            var htmlBlock = '<tr class="options-row added"><td><input id="configurationFileAttributeOptions'+(nOptions)+'.name" name="configurationFileAttributeOptions['+(nOptions)+'].name" class="form-control input-sm attr-opt" value="" type="text"><div class="has-error"></div></td><td><a class="btn btn-primary" id="remove-config-file-attr-opt" data-action="remove"><i class="fa fa-times" aria-hidden="true"></i></a><a class="btn btn-primary" id="remove-config-file-attr-opt" data-action="remove"><i class="fa fa-times" aria-hidden="true"></i></a><input type="radio" name="radio-options" class="radio-options"></td></tr>';
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
        var htmlBlock = '<tr class="options-row added"><td><input id="configurationFileAttributeOptions'+(nOptions)+'.name" name="configurationFileAttributeOptions['+(nOptions)+'].name" class="form-control input-sm attr-opt" value="" type="text"><div class="has-error"></div></td><td><a class="btn btn-primary" id="remove-config-file-attr-opt" data-action="remove"><i class="fa fa-times" aria-hidden="true"></i></a><a class="btn btn-primary" id="remove-config-file-attr-opt" data-action="remove"><i class="fa fa-times" aria-hidden="true"></i></a><input type="radio" name="radio-options" class="radio-options" '+isChecked+'></td></tr>';
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

    /************************MANAGE USERS END****************************/
    
    /************************MANAGE RULES ****************************/
    $('.parameter-item').on('click',function(){
        var name = $(this).text().replace('REQUEST-','').trim();
        name = name.substring(0,name.indexOf('-'));
        name = name+"000-"+name+"999";
        if ($(this).hasClass('alert-warning')){
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
//            alert($('.final-value').val());
        }else{
            $(this).addClass('alert-warning');
            if($('.final-value').val()!=''){
                $('.final-value').val($('.final-value').val()+","+name);
            }else{
                $('.final-value').val(name);
            }    
//            alert($(this).text().substring(2,$(this).text().indexOf('-')));
        }
    });
    
    $('#block-rules-button').on('click',function(){
        
        $('#blockRules').submit();
    });
    
    /************************MANAGE RULES END****************************/
    
    
})