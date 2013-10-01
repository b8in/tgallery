class PusherController < ApplicationController

  protect_from_forgery except: :auth # stop rails CSRF protection for this action

  def auth
    channel = Webs.pusher[params[:channel_name]]

    # We're allowing anonymous users
    response = channel.authenticate(params[:socket_id])
    render json: response
  end

end
