class RegistrationsController < Devise::RegistrationsController

  def create
    if simple_captcha_valid?
      super
    else
      build_resource(sign_up_params)
      flash[:alert] = "You enter wrong captcha"
      clean_up_passwords resource
      render 'devise/registrations/new'
    end
  end
end