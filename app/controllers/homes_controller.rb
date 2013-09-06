class HomesController < ApplicationController

  def index
    @painting = Painting.new
  end

end
