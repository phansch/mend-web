# frozen_string_literal: true

OmniauthCallbackPolicy = Struct.new(:user, :omniauth_callback)

class OmniauthCallbackPolicy
  def github?
    true
  end
end
