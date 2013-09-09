class HomesController < ApplicationController

  def index
    @categories = GImageCategory.includes(:g_images).page(params[:page]).per(2)
  end

end
