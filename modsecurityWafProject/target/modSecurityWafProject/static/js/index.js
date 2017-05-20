/*------------------------------------*\
    SIMPLE LOGIN FORM
\*------------------------------------*/

$(document).ready(function(){
    console.log('Alto: ' + screen.height + ' - Ancho: ' + screen.width);
    
    //LOGIN PAGE
    
    //Center login form
    $('#div-container-login').css('height','300');
    var margin_top_bottom = (screen.height-242)/2-50;
    $('#div-container-login').css('margin-top',margin_top_bottom);
    
    //Disapear logout message
    $('.notice-login-page').fadeOut(4000);
    
    //ADMIN FILE CONFIGURATION PAGE
    //
    //ADD FILE CONFIGURATION
    
    //Cancel form button
    $('body').on('click','#cancel-new-file-configuration-button',function(){
        $('#right-column-configuration-file-page').empty();  
    })
    
    //List configuration attributes of current file
    $('body').on('click','#show-file-configuration-attributes-button',function(){
       console.log('Apretaste');
       data = {'fileId': $(this).data('id')};
       replaceRightColumnPage('addFileConfigurationAttributes',data,'GET');
    });
    
    //Show form to add a new configuration file
    $('#add-file-configuration-button').on('click',function(){
        replaceRightColumnPage('addConfigurationFile',{},'GET');
    })
    
    //Right Panel Request
    function replaceRightColumnPage(url,dataPass,method){
        var data = Object.assign({}, {CSRF: $('#token-csrf').val()}, dataPass);
        $.ajax({
            url: url,
            method: method,
            dataType: 'html',
            data: data
        }).done(function(data){
            $('#right-column-configuration-file-page').html(data);
        })
    }
    
//    $('#add-file-configuration-button').on('click',function(){
//        console.log('APRETASTE');
//        $.ajax({
//            url: 'addConfigurationFile',
//            method: 'get',
//            dataType: 'html',
//            data: {CSRF: $('#token-csrf').val()}
//        }).done(function(data){
//            $('#right-column-configuration-file-page').html(data);
//        })
//    })
    
    
})