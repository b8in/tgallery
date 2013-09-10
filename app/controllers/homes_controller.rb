class HomesController < ApplicationController

  def index
    @categories = GImageCategory.includes(:g_images).reverse_order.limit(6)
  end

end
