class CategoriesController < ApplicationController
  def index
    @categories = GImageCategory.includes(:g_images).page params[:page]
    @category_comments_count_hash = {}
    @category_likes_count_hash = {}
    @category_popular_image = {}
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
  end
end
