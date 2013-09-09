class HomesController < ApplicationController

  def index
    @categories = GImageCategory.includes(:g_images).all
  end

end
