class PicturesController < ApplicationController
  def show
    @image = GImage.find(params[:id])
    @comment = UserComment.new
    @comments = UserComment.where(g_image_id: @image.id).includes(:e_history).reverse_order.limit(3)
  end
end
