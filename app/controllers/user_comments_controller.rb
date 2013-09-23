class UserCommentsController < ApplicationController

  def index
    @comments = UserComment.joins(:e_history).includes(:e_history).order('e_histories.date').page params[:page]
  end

  def create
    if !!current_user
    event = Event.find_by_name("comments")
    image = GImage.find(params[:image_id])
    comment = image.user_comments.create(text: params[:user_comment][:text])

    current_user.e_histories.create(date: Time.now, event_id: event.id, eventable: comment)

    render json: { comment: comment.text,
                   author: current_user.name,
                   image_comments_count: image.user_comments_count,
                   stat: 'success'
    }
    end
  end

end
