class PicturesController < ApplicationController
  def show
    @image = GImage.find(params[:id])
    @comment = UserComment.new
  end
end
