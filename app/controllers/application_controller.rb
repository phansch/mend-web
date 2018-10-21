# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  after_action :verify_authorized, unless: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # Needed for https://github.com/plataformatec/devise/wiki/OmniAuth:-Overview#using-omniauth-without-other-authentications
  def new_session_path(_scope)
    new_user_session_path
  end

  private

  def user_not_authorized
    flash[:alert] = I18n.t('not_authorized')
    redirect_to(request.referer || root_path)
  end
end
