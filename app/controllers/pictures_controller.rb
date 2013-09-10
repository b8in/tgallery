class PicturesController < ApplicationController
  def show
    @image = GImage.find(params[:id])
  end
end
