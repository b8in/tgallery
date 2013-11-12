class ApplicationController < ActionController::Base
  include SimpleCaptcha::ControllerHelpers

  protect_from_forgery
  before_filter :load_categories, :set_user_or_guest_id, :set_locale
  after_filter :save_navigation

  private
  def load_categories
    @categories_menu = GImageCategory.select(:name).all
  end

  def set_user_or_guest_id
    session[:user_id] ||= SecureRandom.hex(15)
    gon.user_id ||= session[:user_id]
  end

  # Overwriting the sign_in redirect path method
  def after_sign_in_path_for(resource_or_scope)
    categories_path
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

  def save_navigation
    if !!current_user #user_signed_in?
      event = Event.find_by_name("navigation")   #find_or_create_by_name
      nav = Navigation.create(target_url: request.original_url.truncate(100))
      current_user.e_histories.create(date: Time.now, event_id: event.id, eventable: nav)
    end
  end

  def authenticate_admin_user!
    redirect_to new_user_session_path unless current_user.try(:admin)
  end

  def default_url_options(options={})
    { locale: I18n.locale }
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
