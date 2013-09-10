class CategoriesController < ApplicationController
  def index
    @categories = GImageCategory.page params[:page]
  end

  def show_by_name
    @category = GImageCategory.find_by_name(params[:category_name])
    @images = @category.g_images.page params[:page]
  end
end
