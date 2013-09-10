class UserCommentsController < ApplicationController

  def create
    event = Event.find_by_name("comments")
    hist = current_user.e_histories.create(date: Time.now, event_id: event.id)
    image = GImage.find(params[:image_id])
    image.user_comments.create(e_history_id: hist.id, text: params[:user_comment][:text])

    redirect_to :back
  end

end
