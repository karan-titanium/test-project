$(document).on("click", function(){
	
			/*---  To accept only numbers [0-9]  ---*/
	$(".only_numerics").keypress(function (e) {
    if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
      //$(".errmsg").html("Digits Only").show().fadeOut("slow");
      return false;
    }
  });
  
			/*---  To accept only float numbers  ---*/
  $('.only_float').keypress(function(event) {
    if ((event.which != 46 || $(this).val().indexOf('.') != -1) &&(event.which != 8)&& (event.which < 48 || event.which > 57)) {
      event.preventDefault();
    }
  });
  
  
  		/*---  To accept only alphabets with max length of 50  ---*/
  $(".only_50_alphabets").keypress(function myfunction(event) {
    var regex = new RegExp("^[a-zA-Z]+$");
    var textLength = $(this).val().length + 1;
    var key = String.fromCharCode(event.charCode ? event.which : event.charCode);

    if (textLength <= 50) {                
      if (!regex.test(key)) {
        event.preventDefault();
        return false;
      }
    }
    else {
      return false;
    }
  });


  		/*---  To accept only alphabets  ---*/
  $(".only_alphabets").keypress(function myfunction(event) {
    var regex = new RegExp("^[a-zA-Z]+$");
    var key = String.fromCharCode(event.charCode ? event.which : event.charCode);

    if (!regex.test(key)) {
      event.preventDefault();
      return false;
    }
  });

  
});
