class LikesController < ApplicationController
  def create
    event = Event.find_by_name("likes")
    hist = current_user.e_histories.create(date: Time.now, event_id: event.id)

    image = GImage.find(params[:image_id])
    image.likes.create(e_history_id: hist.id)
    redirect_to :back
  end
end
