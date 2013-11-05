$(document).on("click", ".side_links", function(){
	varConfirmed = true;
	if($('form').hasClass('dirty')) {
        if (confirm('You have unsaved changes!', "asdasd", "asdsd","asd")) {
    		varConfirmed = true;    	
        }else{
        	varConfirmed = false;
        }
    }
    if(varConfirmed){
		path = $(this).attr('path');
		$(document).trigger( "myCustomEvent", [ path ] );    	
    }
    return false;
});
$(document).ready(function(){
	$(document).on( "myCustomEvent", function( event, path ) {
		$.ajax({
            async : true, 
            type : 'GET', // whether http verb should be GET or POST
            url : path, // URL of controller/action where request should be sent 
            data : 0, //data to be sent as parameters
            success : function(data) {
                // What should be done if response is sent successfully.
                $('#user_profile_content').html(data);
            },
            error : function(data) {
                // What should be done in case of unsuccessful AJAX call.
                $('#user_profile_content').html('<h1 style="color:red">Unable to load this page.Unexpect error ouccred</h1>');
            }
        });
	});
});



$(document).ready(function() {
    $(document).delegate('.next_link', 'click', function() {    
        /* Delegates click events on the links having class next_links
          which will usually be contained in a partials as next or back links
         fetches value in its path attribute which is the name of the action 
         On which the AJAX call will be made on clicking this link.
         fetches form object serialize it in JSON format and stores in params variable,
         pass these path and  params to loadContent method to trigger AJAX call.
         */
        
        path = $(this).attr('path');
        params = $("form").serialize();
        loadContent(path, params)
    });
    
    function loadContent(path, params) {
        /* this method is responsible for making AJAX calls it accepts path(action name of particular controller)
           and params containing the data to be sent to that action as parameters. 
           the  
         */
        
        $.ajax({
            async : true, 
            type : 'GET', // whether http verb should be GET or POST
            url : path, // URL of controller/action where request should be sent 
            data : params, //data to be sent as parameters
            success : function(data) {
                // What should be done if response is sent successfully.
                $('#user_profile_content').html(data);
            },
            error : function(data) {
                // What should be done in case of unsuccessful AJAX call.
                $('#user_profile_content').html('<h1 style="color:red">Unable to load this page.Unexpect error ouccred</h1>');
            }
        });
    }

});
