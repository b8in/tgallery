class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :load_categories

  private
  def load_categories
    @categories = GImageCategory.all
  end
end
