# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # Needed for https://github.com/plataformatec/devise/wiki/OmniAuth:-Overview#using-omniauth-without-other-authentications
  def new_session_path(_scope)
    new_user_session_path
  end
end
