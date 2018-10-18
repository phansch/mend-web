# frozen_string_literal: true

module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def github
      @user = User.from_omniauth(request.env['omniauth.auth'])

      if @user.persisted?
        # this will throw if @user is not activated
        sign_in_and_redirect @user, event: :authentication
        set_flash_message(:notice, :success, kind: 'GitHub') if is_navigational_format?
      else
        session['devise.github_data'] = request.env['omniauth.auth']
        redirect_to root_path
      end
    end
  end
end
