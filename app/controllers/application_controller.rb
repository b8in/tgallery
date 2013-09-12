class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :load_categories
  after_filter :save_navigation

  private
  def load_categories
    @categories = GImageCategory.all   #FIXME вместо объектов хеш: (имя категории => url)
  end

  # Overwriting the sign_in redirect path method
  def after_sign_in_path_for(resource_or_scope)
    categories_path
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

  def save_navigation
    if user_signed_in?
      event = Event.find_by_name("navigation")
      nav = Navigation.create(target_url: request.original_url)
      current_user.e_histories.create(date: Time.now, event_id: event.id, eventable: nav)    end
  end

end
