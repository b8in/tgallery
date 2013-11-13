class ServicesController < ApplicationController
  before_filter :authenticate_user!, except: [:create]

  def create
    # get the full hash from omniauth
    omniauth = request.env['omniauth.auth']

    # continue only if hash exist
    if omniauth

      # map the returned hashes to our variables first - the hashes differ for every service
      omniauth['extra']['raw_info']['email'] ? email =  omniauth['extra']['raw_info']['email'] : email = ''
      omniauth['extra']['raw_info']['name'] ? name =  omniauth['extra']['raw_info']['name'] : name = ''
      omniauth['extra']['raw_info']['id'] ?  uid =  omniauth['extra']['raw_info']['id'] : uid = ''
      omniauth['provider'] ? provider =  omniauth['provider'] : provider = ''

      # continue only if provider and uid exist
      if uid != '' and provider != ''

        # nobody can sign in twice, nobody can sign up while being signed in (this saves a lot of trouble)
        if !user_signed_in?

          # check if user has already signed in using this service provider and continue with sign in process if yes
          auth = Service.find_by_provider_and_uid(provider, uid)
          if auth
            flash[:notice] = t('services.create.sign_in_success_via', provider: provider.capitalize)
            sign_in_and_redirect(:user, auth.user)
          else
            # check if this user is already registered with this email address; get out if no email has been provided
            if email != ''
              # search for a user with this email address
              existinguser = User.find_by_email(email)
              if existinguser
                # map this new login method via a service provider to an existing account if the email address is the same
                existinguser.services.create(:provider => provider, :uid => uid, :uname => name, :uemail => email)
                flash[:notice] = t('services.create.sign_in_success_and_add_service_to_account', provider: provider.capitalize, email: existinguser.email)
                sign_in_and_redirect(:user, existinguser)
              else
                # let's create a new user: register this user and add this authentication method for this user
                name = name[0, 39] if name.length > 39             # otherwise our user validation will hit us

                # new user, set email, a random password and take the name from the authentication service
                user = User.new :email => email, :password => email.downcase, :name => name

                # add this authentication service to our new user
                user.services.build(:provider => provider, :uid => uid, :uname => name, :uemail => email)

                # do not send confirmation email, we directly save and confirm the new record
                #user.skip_confirmation!
                user.save!
                #user.confirm!

                # flash and sign in
                flash[:myinfo] = t('services.create.create_service_account', provider: provider.capitalize)
                sign_in_and_redirect(:user, user)
              end
            else
              flash[:error] = t('services.create.wrong_service_account_without_email', provider: provider.capitalize)
              redirect_to new_user_session_path
            end
          end
        else
          # the user is currently signed in

          # check if this service is already linked to his/her account, if not, add it
          auth = Service.find_by_provider_and_uid(provider, uid)
          if !auth
            current_user.services.create(:provider => provider, :uid => uid, :uname => name, :uemail => email)
            flash[:notice] = t('services.create.sign_in_success_and_add_service_to_account', provider: provider.capitalize)
            redirect_to :back
          else
            flash[:notice] = t('services.create.service_account_alresdy_linked', provider: provider.capitalize)
            redirect_to :back
          end
        end
      else
        flash[:error] = t('services.create.return_invalid_data', provider: provider.capitalize)
        redirect_to new_user_session_path
      end
    else
      flash[:error] = t('services.create.error_sign_in_via_provider', provider: provider.capitalize)
      redirect_to new_user_session_path
    end
  end

  def destroy
    # remove an authentication service linked to the current user
    @service = current_user.services.find(params[:id])
    @service.destroy

    redirect_to :back
  end

end
