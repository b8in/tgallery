class HomesController < ApplicationController

  def index
    @categories = GImageCategory.includes(:g_images).page(params[:page]).per(5)
  end

end
