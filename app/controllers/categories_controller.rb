class CategoriesController < ApplicationController
  def index
    @categories = GImageCategory.includes(:g_images).order(:updated_at).reverse_order.page params[:page]
    @category_comments_count_hash = {}
    @category_likes_count_hash = {}
    @categories.each do |cat|
      @category_comments_count_hash[cat.name] = 0
      @category_likes_count_hash[cat.name] = 0
      cat.g_images.each do |img|
        @category_comments_count_hash[cat.name] += img.user_comments.count
        @category_likes_count_hash[cat.name] += img.likes_count
      end
    end
  end

  def show_by_name
    @category = GImageCategory.find_by_name(params[:category_name])
    @images = @category.g_images.page params[:page]
    if user_signed_in?                                                                           #fixme: not ID, should be boolean
      arr = WatchingCategory.where(user_id: current_user.id, g_image_category_id: @category.id).pluck(:id)
      if arr.blank?
        @user_watch_this_category_id = nil
      else
        @user_watch_this_category_id = arr[0]
      end
    end
  end
end
