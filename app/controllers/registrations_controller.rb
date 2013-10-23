class RegistrationsController < Devise::RegistrationsController

  def create
    if simple_captcha_valid?
      super
    else
      build_resource(sign_up_params)
      flash[:alert] = t('registrations.create.wrong_captcha')
      clean_up_passwords resource
      render 'devise/registrations/new'
    end
  end

  def update
    if current_user.valid_password?(params[:user][:current_password])
      if params[:user][:password].blank?
        params[:user][:password] = params[:user][:current_password]
        params[:user][:password_confirmation] = params[:user][:current_password]
      end
      super
    else
      build_resource(params[:user])
      flash[:alert] = t('registrations.create.wrong_password')
      clean_up_passwords resource
      render 'devise/registrations/edit'
    end
  end
end