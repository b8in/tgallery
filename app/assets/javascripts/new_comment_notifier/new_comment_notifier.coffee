(->
  class NewCommentNotifier
    constructor: (channel_name) ->
      @initialize channel_name

    initialize: (channel_name) ->
      @pusher = (new Webs()).pusher
      @channel = @pusher.subscribe channel_name
      @listenChannel()

    listenChannel: ->

      @newCommentCallback = ((responseData)->
        if responseData.data.author_id != TGallery.userId && window.location.pathname == responseData.data.image_url
          comment = responseData.data.message
          nickname = responseData.data.author_name
          i = +responseData.data.image_comments_count - 1
          $(".comments").append "<blockquote style =\"display:none;\" id = " + i + ">" + "<b><span class =\"comment_nickname text-primary\">" + nickname + "</span></b><br>" + "<span class = \"comment_description\">" + comment + "</span><br>" + "<small class = \"comment_time\">"+I18n.t("javascript.fresh")+"</small><hr></blockquote>"
          id = 'blockquote#'+i
          $('#page-container').height($('#page-container').height() + $(id).outerHeight(true))
          $(".comments blockquote").slideDown "slow"
      ).bind(@)

      @channel.bind "new-comment", @newCommentCallback
  window.NewCommentNotifier = NewCommentNotifier
)()