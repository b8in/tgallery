class UserCommentsController < ApplicationController

  def index
    @comments = UserComment.joins(:e_history).includes(:e_history).order('e_histories.date').page params[:page]
  end

  def create
    if !!current_user || simple_captcha_valid?
      event = Event.find_by_name("comments")
      image = GImage.find(params[:image_id])
      comment = image.user_comments.build(text: params[:user_comment][:text])
      if params[:user_comment][:author]
        comment.author = params[:user_comment][:author]
        comment.save
      else
        comment.save
        current_user.e_histories.create(date: Time.now, event_id: event.id, eventable: comment)
      end

      channel = 'new-comment-channel'
      event = 'new-comment'
      Webs.pusher
      Webs.notify('notify', channel, event, {message: comment.text, image_name: image.name,
                  author_name: comment.author || current_user.name, author_id: session[:user_id],
                  image_comments_count: image.user_comments_count})


      render json: { comment: comment.text,
                     author: comment.author || current_user.name,
                     image_comments_count: image.user_comments_count,
                     stat: 'success'
      }
    else
      redirect_to :back    # FIXME: json flash-error
    end
  end

end
