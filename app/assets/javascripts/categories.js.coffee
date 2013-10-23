# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


$(document).ready ->

  $(document).ajaxSuccess (event, response, settings) ->

    if (response) && (response.responseJSON)
      if (response.responseJSON.stat) && (response.responseJSON.stat is "success")
        if response.responseJSON.new_btn_action
          $('.user-subscribe-category-btn').remove()
          $('.box-for-user-subscribe-category-btn').prepend(
            '<a href='+response.responseJSON.new_url+' class="user-subscribe-category-btn" data-method='+
              response.responseJSON.new_method+' data-remote="true" rel="nofollow">'+response.responseJSON.new_btn_title+
            '</a>'
          )
