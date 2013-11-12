class LikesController < ApplicationController
  def create
    if !!current_user
      if current_user.likes.where(g_image_id: params[:image_id]).blank?
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
                        message: t('likes.create.already_voted')
        }
      end
    else
      render json: {  image_likes_count: -1,
                      stat: 'error',
                      message: t('likes.create.should_been_authorized')
      }
    end
  end
end
