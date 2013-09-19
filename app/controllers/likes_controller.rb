class LikesController < ApplicationController
  def create
    event = Event.find_by_name("likes")

    image = GImage.find(params[:image_id])
    like = image.likes.create

    current_user.e_histories.create(date: Time.now, event_id: event.id, eventable: like)

    redirect_to :back
  end
end
