class HomesController < ApplicationController

  def index
    @categories = GImageCategory.includes(:g_images).reverse_order.limit(6)

    gon.pusher_config = Webs.pusher_config
  end

end
