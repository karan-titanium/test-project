$(document).ready(function() {

    // $(document).on("click", ".add_exam", function() {
        // params = $("form").serializeJSON();
        // $.ajax({
            // async : true,
            // type : 'POST',
            // url : "/exams/create/",
            // data : params,
            // success : function(data) {
                // $('.avgrund-close').click();
                // // disablePopup(add_qualifications);
                // $('#examContent').html(data);
            // },
            // error : function(data) {
// 
            // }
        // });
        // return false;
    // });
    
    $(document).on("click", ".update_exam", function() {
        params = $("form").serializeJSON();
         path = $(this).attr('path');
        $.ajax({
            async : true,
            type : 'PUT',
            url : path,
            data : params,
            success : function(data) {
                // disablePopup(add_qualifications);
                $('#examContent').html(data);
            },
            error : function(data) {

            }
        });
        return false;
    });

    $(document).delegate('.edit_exam', 'click', function() {
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

        $.ajax({
            async : true,
            type : 'GET',
            url : path,
            success : function(data) {
                $('.avgrund-close').click();
                // disablePopup(add_qualifications);
                $('#examContent').html(data);
            },
            error : function(data) {

            }
        });
        return false;
    });

    $(document).delegate('.remove_test', 'click', function() {
        /* Delegates click events on the links having class next_links
         which will usually be contained in a partials as next or back links
         fetches value in its path attribute which is the name of the action
         On which the AJAX call will be made on clicking this link.
         fetches form object serialize it in JSON format and stores in params variable,
         pass these path and  params to loadContent method to trigger AJAX call.
         */
        path = $(this).attr('path');
        exam_id = $(this).attr('data-exam_id');
        // alert(path)
        // params = $("form").serializeJSON();

        $.ajax({
            async : true,
            type : 'POST',
            url : path,
            data : {
                "exam_id" : exam_id
            },
            success : function(data) {
                $('#add_remove_tests').html(data);
            },
            error : function(data) {

            }
        });
        return false;
    });

    $(document).delegate('.add_test', 'click', function() {
        /* Delegates click events on the links having class next_links
         which will usually be contained in a partials as next or back links
         fetches value in its path attribute which is the name of the action
         On which the AJAX call will be made on clicking this link.
         fetches form object serialize it in JSON format and stores in params variable,
         pass these path and  params to loadContent method to trigger AJAX call.
         */
        path = $(this).attr('path');
        exam_id = $(this).attr('data-exam_id');
        // params = $("form").serializeJSON();
        $.ajax({
            async : true,
            type : 'POST',
            url : path,
            data : {
                "exam_id" : exam_id
            },
            success : function(data) {
                $('#add_remove_tests').html(data);
            },
            error : function(data) {

            }
        });
        return false;
    });

});
