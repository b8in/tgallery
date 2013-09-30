(->
  class Webs
    pusher: null

    constructor: (options={}) ->
     @initPusher()

    initPusher: ()->
      settings = TGallery.pusherConfig
#      Pusher.host = settings.host
#      Pusher.ws_port = settings.port
#      Pusher.wss_port = settings.port
#      # SockJS fallback parameters. We don't have such feature, so force all params to undefined
#      Pusher.sockjs_host = undefined
#      Pusher.sockjs_http_port = undefined
#      Pusher.sockjs_https_port = undefined
#      Pusher.sockjs_path = undefined
#      # Stats. We don't have such feature, so force all params to undefined
#      Pusher.stats_host = undefined
#      Pusher.cdn_http = undefined
#      Pusher.cdn_https = undefined

      @pusher = new Pusher(settings.key)  # , {encrypted: settings.ssl, disableStats: settings.disable_statistics, disableFlash: settings.disable_flash}
      @disposed = false

    dispose: ->
      throw "NotImplementedError"
  window.Webs = Webs
)()