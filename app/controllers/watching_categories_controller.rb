class WatchingCategoriesController < ApplicationController
  before_filter :authenticate_user!

  def create
    current_user.watching_categories.create(g_image_category_id: params[:category_id])
    render json: { new_btn_title: 'Unsubscribe this category',
                   new_btn_action: 'unsubscribe',
                   new_url: watching_categories_path(id: 0, category_id: params[:category_id]),
                   new_method: 'delete',
                   stat: 'success'
    }
    #redirect_to :back
  end

  def destroy
    cat = current_user.watching_categories.where(g_image_category_id: params[:category_id]).first
    if cat.destroy
      render json: { new_btn_title: 'Subscribe this category',
                     new_btn_action: 'subscribe',
                     new_url: watching_categories_path(category_id: params[:category_id]),
                     new_method: 'post',
                     stat: 'success'
      }
    else
      redirect_to :back
    end
  end

end