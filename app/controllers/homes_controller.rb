class HomesController < ApplicationController

  def index
    @categories = GImageCategory.includes(:g_images).reverse_order.limit(6)
    @comments = UserComment.includes(e_history: [:user], g_image: [:g_image_category]).order.reverse_order.limit(5)

    gon.pusher_config = Webs.pusher_config
  end

end
