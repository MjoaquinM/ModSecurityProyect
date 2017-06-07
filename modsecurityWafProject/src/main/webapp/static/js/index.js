/*------------------------------------*\
    SIMPLE LOGIN FORM
\*------------------------------------*/

$(document).ready(function(){
    console.log('Alto: ' + screen.height + ' - Ancho: ' + screen.width);
    
    /************************LOGIN PAGE****************************/
    
    //Center login form
    $('#div-container-login').css('height','300');
    var margin_top_bottom = (screen.height-242)/2-50;
    $('#div-container-login').css('margin-top',margin_top_bottom);
    
    //Disapear logout message
    $('.notice-login-page').fadeOut(4000);
    
    /************************LOGIN PAGE END****************************/
    
    /************************ADMIN FILE CONFIGURATION PAGE****************************/
    
    //Cancel form button
       
    $('#fileConfigurationModal').on('click','#configurationFileModalCancel',function(){
        $('#fileConfigurationModal').modal('hide');
    })
    
    //Show form to edit a new configuration file
    $('#add-file-configuration-button,#edit-file-configuration-button,#remove-file-configuration-button').on('click',function(){
        var action = $(this).data('action');
        var data = {};
        var url = '';
        var id = $(this).data('id');
        if (!id){
            id = -1;
        }
        var modalFooter = "";
        switch(action){
            case 'remove':
                url = 'removeFileConfiguration';
                modalFooter = '<button type="button" class="btn btn-primary" id="removeFileConfiguration" data-id="'+id+'">Delete</button>';
            break;
            default:
                modalFooter = '<button type="button" class="btn btn-primary" id="addFileConfiguration">Add</button>';
                data = {id: id};
                url = 'addFileConfigurationForm';
        }
        modalFooter += '<button type="button" class="btn btn-secondary" data-dismiss="modal" id="configurationFileModalCancel">Cancel</button>';
        $('#fileConfigurationModalFooter').empty().html(modalFooter);
        $('#fileConfigurationModal').modal('show');
        if(url=='removeFileConfiguration'){
            $('#loading-image-modal').hide();
            $('#fileConfigurationModalBody').empty().html('<p> Confirm remove selected configuration file? </p>');
        }else{
            console.log(url);
            $.ajax({
                url: url,
                method: 'GET',
                dataType: 'html',
                data: data
                }).done(function(response){
                    $('#loading-image-modal').hide();
                    $('#fileConfigurationModalBody').empty().html(response);
                }).fail(function(){
                    $('#fileConfigurationModalBody').empty().html('<p>There was an error </p>');
                   $('#loading-image-modal').hide();
                });
            }
        });
        
        $('#configurationFileModalCancel').on('click',function(){
            $('#fileConfigurationModalBody').empty();
            $('#fileConfigurationModal').modal('close');
        });

        $('#fileConfigurationModal').on('click','#addFileConfiguration',function(){
            $('#fileConfigurationModal').find('form').validate({
                rules: {
                    name: "required",
                    path:"required"
                },
                messages: {
                    name: "Please enter a name",
                    path: "Please enter a valid file path"
                }
            });
            $('#fileConfigurationModal').find('form').submit();
        })

        $('body').on('click','#removeFileConfiguration',function(){
            $('#deleteFileconfiguration').append('<input type="text" name="id" value="'+$(this).data("id")+'" />');
            $('#deleteFileconfiguration').submit();
        });
    
    /************************ADMIN FILE CONFIGURATION PAGE END****************************/
        
    
    /************************MANAGE USERS****************************/
    
    /**
     * Show add user modal - Get add user form
     **/
        
    $('#add-user-button,#edit-user-button,#remove-user-button').on('click',function(){
        var action = $(this).data('action');
        var data = {};
        var url = '';
        var id = $(this).data('id');
        if (!id){
            id = -1;
        }
        var modalFooter = "";
        switch(action){
            case 'remove':
                url = 'removeUser';
                modalFooter = '<button type="button" class="btn btn-primary" id="removeUser" data-id="'+id+'">Delete</button>';
            break;
            default:
                modalFooter = '<button type="button" class="btn btn-primary" id="addUser">Add</button>';
                data = {id: id};
                url = 'addUserForm';
        }
        modalFooter += '<button type="button" class="btn btn-secondary" data-dismiss="modal" id="userModalCancel">Cancel</button>';
        $('#addUserModalFooter').html(modalFooter);
        $('#userModal').modal('show');
        if(url=='removeUser'){
            $('#loading-image-modal').hide();
            $('#userModalBody').html('<p> Confirm remove selected user? </p>');
        }else{
            $.ajax({
                url: url,
                method: 'GET',
                dataType: 'html',
                data: data
            }).done(function(response){
                $('#loading-image-modal').hide();
                $('#userModalBody').html(response);
            }).fail(function(){
               $('#loading-image-modal').hide();
            });
        }
    });
    
    $('#cancel-add-user-modal-button').on('click',function(){
        $('#add-user-modal-body-content').empty();
        $('#addUserModal').modal('close');
    });
    
    $('body').on('click','#addUser',function(){
        $('#userModal').find('form').validate({
            rules: {
                ssoId: "required",
                firstName:"required",
                lastName:"required",
                password: {
                        required: true,
                        minlength: 5
                }
            },
            messages: {
                ssoId: "Please enter a user name",
                firstName: "Please enter your first name",
                lastName: "Please enter your last name",
                password: {
                        required: "Please enter a password",
                        minlength: "Your password must be at least 5 characters long"
                }
            }
        });
        
        $('#userModal').find('form').submit();
        
    })
    
    $('body').on('click','#removeUser',function(){
        $('#delete-user-form').append('<input type="text" name="id" value="'+$(this).data("id")+'" />');
        $('#delete-user-form').submit();
    });
    
    /************************MANAGE USERS END****************************/
    
//    $.validator.setDefaults({
//            submitHandler: function() {
//                    alert("submitted!");
//            }
//    });
    
})