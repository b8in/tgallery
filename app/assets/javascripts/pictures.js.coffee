# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script

$(document).ready ->
  $('.comment-textarea').width($('.image-box').width()-400)

  $(document).ajaxSuccess (event, response, settings) ->
    $('.comment-textarea').val('')
    if (response) && (response.responseJSON)
      if (response.responseJSON.stat) && (response.responseJSON.stat is "success")

        if response.responseJSON.comment && response.responseJSON.author
          # Init variables and add new comment
          comment = response.responseJSON.comment
          nickname = response.responseJSON.author
          i = +response.responseJSON.image_comments_count - 1
          $(".comments").append "<blockquote style =\"display:none;\" id = " + i + ">" + "<b><span class =\"comment_nickname text-primary\">" + nickname + "</span></b><br>" + "<span class = \"comment_description\">" + comment + "</span><br>" + "<small class = \"comment_time\">fresh</small>" + "<hr></blockquote>"
          $(".comments blockquote").slideDown "slow"