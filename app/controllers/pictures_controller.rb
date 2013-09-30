class PicturesController < ApplicationController

  def index
    @images = GImage.only_with_category.order(:likes_count).reverse_order.page params[:page]
  end

  def show
    @image = GImage.find(params[:id])
    @comment = UserComment.new
    @comments = UserComment.where(g_image_id: @image.id).includes(:e_history).reverse_order.limit(3)

    gon.pusher_config = Webs.pusher_config
  end
end
