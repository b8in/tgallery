# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script

#= require pusher
#= require lib/webs
#= require new_comment_notifier/new_comment_notifier

HtmlEncode = (val) ->
  $("<div/>").text(val).html()

$(document).ready ->

#  if ($.cookie 'nickname')
#    $("#comment_nickname").val($.cookie 'nickname')

  # LOAD COMMENTS
  $("#close_comments").hide()
  $("#all_comments").on "click", ->
    id = $(".image-box .number").attr("id")
    offset = $("blockquote").length
    $.ajax
      url: "/load_all_comments"
      data:
        id: id
        offset: offset
      type: "post"
      dataType: "json"
      success: (response) ->
        $("#all_comments").hide()
        $("#close_comments").show()
        comments = response.comments
        str = undefined
        i = comments.length - 1
        $(".comments").slideDown 500, ->
          $.each comments, (key) ->
            str = HtmlEncode(comments[key].text)
            $(".comments").prepend "<blockquote style =\"display:none;\" id = " + i + ">" + "<b><span class =\"comment_nickname text-primary\">" + comments[key].author + "</span></b><br>" + "<span class = \"comment_description\">" + str + "</span><br><small class=\"comment_time\">"+comments[key].date+"</small><hr></blockquote>"
            id = 'blockquote#'+i
            $('#page-container').height($('#page-container').height() + $(id).outerHeight(true))
            $(".comments blockquote").slideDown "slow"
            i--
          $('html,body').animate({scrollTop: $(".comments_block").offset().top - $('.navbar .container').height()},'slow');

  $("#close_comments").on "click", ->
    count = $("blockquote").length - 3
    i = 1

    while i < count
      $("#" + i + "").slideToggle 500, ->
        id = 'blockquote#'+i
        size = $(id).height()
        $(this).remove()
        $('#page-container').height($('#page-container').height() - size - 1)
      i++
    if count > 0
      $("#0").slideToggle 500, ->
        id = 'blockquote#0'
        size = $(id).outerHeight(true)
        $(this).remove()
        $('#page-container').height($('#page-container').height() - size)

    $("#all_comments").show()
    $("#close_comments").hide()

  $('.comment-textarea').width($('.image-box').width()-400)

  $(document).ajaxSuccess (event, response, settings) ->

    if (response) && (response.responseJSON)
      if (response.responseJSON.stat) && (response.responseJSON.stat is "error")
        if response.responseJSON.image_likes_count
          $('.navbar').after("<div class='alert fade in alert-error'><button class='close' data-dismiss='alert'>×</button>"+response.responseJSON.message+"</div>")

        if response.responseJSON.image_comments_count
          $('.navbar').after("<div class='alert fade in alert-error'><button class='close' data-dismiss='alert'>×</button>"+response.responseJSON.message+"</div>")
          #refresh captcha image
          $(".refresh_image").click()

      if (response.responseJSON.stat) && (response.responseJSON.stat is "success")
        if response.responseJSON.image_likes_count
          $('#span_likes_count').text(response.responseJSON.image_likes_count)

        if response.responseJSON.comment && response.responseJSON.author
          #refresh captcha image
          $(".refresh_image").click()
          # Init variables and add new comment
          comment = response.responseJSON.comment
          nickname = response.responseJSON.author
          i = +response.responseJSON.image_comments_count - 1
          $(".comments").append "<blockquote style =\"display:none;\" id = " + i + "><b><span class =\"comment_nickname text-primary\">" +
            nickname + "</span></b><br><span class = \"comment_description\">" + comment +
            "</span><br><small class = \"comment_time\">fresh</small><hr></blockquote>"

          id = 'blockquote#'+i
          $('#page-container').height($('#page-container').height() + $(id).outerHeight(true))
          $(".comments blockquote").slideDown "slow"

          $('.comment-textarea').val('')

  channel = 'new-comment-channel'
  notifier = new NewCommentNotifier(channel)