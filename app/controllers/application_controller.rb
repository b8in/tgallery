class ApplicationController < ActionController::Base
  include SimpleCaptcha::ControllerHelpers

  protect_from_forgery
  before_filter :load_categories
  after_filter :save_navigation

  private
  def load_categories
    @categories_menu = GImageCategory.select(:name).all
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
      event = Event.find_by_name("navigation")   #find_or_create_by_name
      nav = Navigation.create(target_url: request.original_url.truncate(100))
      current_user.e_histories.create(date: Time.now, event_id: event.id, eventable: nav)
    end
  end

end
