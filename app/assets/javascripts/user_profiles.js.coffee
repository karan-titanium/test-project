# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
    $('.next_button').click ->
         path = $(this).attr('path'); 
         # alert path
         # alert $('#create_item').serialize()
          #  selectedValue = $('.messageCheckbox:checked').val()
         $.ajax ->
           async : true
           type : 'POST'
           dataType : 'text'
           url : path
           data : 
             testdata : 100
           success : (data) ->
             $('#abc').html(data)
           error : (data) ->
             $('#abc').html(data)
      return false;  
              
