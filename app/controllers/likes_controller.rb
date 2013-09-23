class LikesController < ApplicationController
  def create
    if !!current_user
      event = Event.find_by_name("likes")
      image = GImage.find(params[:image_id])
      like = image.likes.create

      current_user.e_histories.create(date: Time.now, event_id: event.id, eventable: like)

      render json: { image_likes_count: image.likes_count+1,
                     stat: 'success'
      }
    else
      render json: {  image_likes_count: -1,
                      stat: 'error',
                      message: "You should been authorized"
      }
    end
  end
end
