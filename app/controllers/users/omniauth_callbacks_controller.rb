# frozen_string_literal: true

module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def github # rubocop:disable Metrics/AbcSize
      @user = User.from_omniauth(request.env['omniauth.auth'])

      if @user.persisted?
        ensure_installation_exists!
        return if performed?

        # this will throw if @user is not activated
        sign_in_and_redirect @user, event: :authentication
        set_flash_message(:notice, :success, kind: 'GitHub') if is_navigational_format?
      else
        session['devise.github_data'] = request.env['omniauth.auth']
        redirect_to root_path
      end
    end

    private

    def ensure_installation_exists!
      installation = Installation.find_in_github(ENV.fetch('GITHUB_APP_ID').to_i)
      # User already created an account with us before and set up the
      # installation
      # We will just continue with the normal OAuth flow
      return if installation

      # User never set up the Installation before, redirect to the GitHub
      # installation setup page
      redirect_to 'https://github.com/apps/mend-rs-dev2/installations/new'
    end
  end
end
