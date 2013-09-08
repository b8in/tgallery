class HomesController < ApplicationController

  def index
    @painting = Painting.new
    @categories = GImageCategory.includes(:paintings).all

    cat = GImageCategory.all
    @ch = {}
    cat.each do |c|
      @ch[c.name] = c.paintings.sample.image.url(:thumb)
    end

  end

end
