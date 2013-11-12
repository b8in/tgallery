# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

#=require pusher

newCommentCallback = (response) ->
  $('#comment_0').remove()
  i = 1
  while i<5
    id = '#comment_' + i
    $(id).prop('id', 'comment_'+(i-1))
    i++
  $('.comments').prepend('<blockquote id="comment_4"><div class="comment_nickname"><b class="text-primary">'+
    response.data.author_name+' [ <a href='+response.data.image_url+'>'+response.data.image_name+
    '</a> ]</b></div><div class="comment_description">'+response.data.message+'</div><br/><small class = \"comment_time\">'+I18n.t("javascript.fresh")+'</small><hr></blockquote>')

$(document).ready ->

  settings = TGallery.pusherConfig
  Pusher.host = settings.host
  Pusher.ws_port = settings.port
  Pusher.wss_port = settings.port
  # SockJS fallback parameters. We don't have such feature, so force all params to undefined
  Pusher.sockjs_host = undefined
  Pusher.sockjs_http_port = undefined
  Pusher.sockjs_https_port = undefined
  Pusher.sockjs_path = undefined
  # Stats. We don't have such feature, so force all params to undefined
  Pusher.stats_host = undefined
  Pusher.cdn_http = undefined
  Pusher.cdn_https = undefined

  pusher = new Pusher(settings.key, {encrypted: settings.ssl, disableStats: settings.disable_statistics, disableFlash: settings.disable_flash})
  channel = pusher.subscribe('new-comment-channel')
  channel.bind 'new-comment', newCommentCallback