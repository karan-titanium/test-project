$(document).ready(function() {

    $(document).on("click", ".add_question", function() {
        params = $("form").serializeJSON();
        $.ajax({
            async : true,
            type : 'POST',
            url : "/questions/create/",
            data : params,
            success : function(data) {
                $('.avgrund-close').click();
                // disablePopup(add_qualifications);
                $('#questionContent').html(data);
            },
            error : function(data) {

            }
        });
        return false;
    });

    $(document).delegate('#example_question', 'change', function() {
        if (this.checked) {
            $('#explanation').show(500);
        } else {
            $('#explanation').hide(300);
        }

    });

    // $('#new_question_link').bind("click", function() {
    // $(document).delegate('#new_question_link', 'click', function() {
    /* Reads click events on the links having class side_links
    fetches value in its path attribute which is the name of the action
    On which the AJAX call will be made on clicking this link.
    pass this path variable to loadContent method along with 0 as temp data.
    So it mets two requested args to trigger AJAX call.
    */
    // alert("Hiiiii");
    // });
    //
    $(document).delegate('.edit_link', 'click', function() {
        /* Delegates click events on the links having class next_links
         which will usually be contained in a partials as next or back links
         fetches value in its path attribute which is the name of the action
         On which the AJAX call will be made on clicking this link.
         fetches form object serialize it in JSON format and stores in params variable,
         pass these path and  params to loadContent method to trigger AJAX call.
         */
        path = $(this).attr('path');
        // alert(path)
        // params = $("form").serializeJSON();
        loadContent(path, 0, "GET")
    });
// 
    // $(document).delegate('.edit_question', 'submit', function(e) {
        // alert("Brrrrr");
        // e.preventDefault();
        // // params = $(".edit_question").serializeJSON();
        // path = $(this).attr('action');
        // // $("form").submit();
//         
        // // alert(path);
//         
        // loadContent(path, this, "POST");
//         
        // return false;
    // });

    function loadContent(path, params, type) {
        /* this method is responsible for making AJAX calls it accepts path(action name of particular controller)
         and params containing the data to be sent to that action as parameters.
         the
         */
        // alert(path);
        // alert("in ajax");
        // alert(type);
        $.ajax({
            async : true,
            type : type, // whether http verb should be GET or POST
            url : path, // URL of controller/action where request should be sent
            data : params, //data to be sent as parameters
            success : function(data) {
                // What should be done if response is sent successfully.
                // alert("renderd");
                $('#questionContent').html(data);
            },
            error : function(data) {
                // What should be done in case of unsuccessful AJAX call.
                $('#questionContent').html('<h1 style="color:red">Unable to load this page.Unexpect error ouccred</h1>');
            }
        });
    }

});
