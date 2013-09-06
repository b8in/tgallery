class PaintingsController < ApplicationController

  def new

  end

  def create
    @paintings = Painting.create(params[:painting])
#    @paintings.save

    redirect_to root_path
  end
end
