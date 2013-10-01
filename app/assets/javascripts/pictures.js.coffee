# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script
#= require pusher
#= require lib/webs
#= require new_comment_notifier/new_comment_notifier

$(document).ready ->
  $('.comment-textarea').width($('.image-box').width()-400)

  $(document).ajaxSuccess (event, response, settings) ->

    if (response) && (response.responseJSON)
      if (response.responseJSON.stat) && (response.responseJSON.stat is "error")
        if response.responseJSON.image_likes_count
          $('.navbar').after("<div class='alert fade in alert-error'><button class='close' data-dismiss='alert'>×</button>"+response.responseJSON.message+"</div>")

      if (response.responseJSON.stat) && (response.responseJSON.stat is "success")
        if response.responseJSON.image_likes_count
          $('#span_likes_count').text(response.responseJSON.image_likes_count)

        if response.responseJSON.comment && response.responseJSON.author
          # Init variables and add new comment
          comment = response.responseJSON.comment
          nickname = response.responseJSON.author
          i = +response.responseJSON.image_comments_count - 1
          $(".comments").append "<blockquote style =\"display:none;\" id = " + i + ">" + "<b><span class =\"comment_nickname text-primary\">" + nickname + "</span></b><br>" + "<span class = \"comment_description\">" + comment + "</span><br>" + "<small class = \"comment_time\">fresh</small>" + "<hr></blockquote>"
          $(".comments blockquote").slideDown "slow"

          id = 'blockquote#'+i
          console.log $(id).height()
          $('#page-container').height($('#page-container').height() + $(id).height())
          $('.comment-textarea').val('')

  channel = 'new-comment-channel'
  notifier = new NewCommentNotifier(channel)