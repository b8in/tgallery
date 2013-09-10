class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :load_categories

  private
  def load_categories
    @categories = GImageCategory.all   #FIXME вместо объектов хеш: (имя категории => url)
  end

  # Overwriting the sign_in redirect path method
  def after_sign_in_path_for(resource_or_scope)
    categories_path
  end
end
