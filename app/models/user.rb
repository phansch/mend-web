# frozen_string_literal: true

# Represents someone signed in as a User
class User < ApplicationRecord
  devise :omniauthable, omniauth_providers: %i[developer github]

  has_one :installation, dependent: :destroy

  # Add emails of GitHub users that should be Admins
  # FIXME(#7) Move whitelist to ENV
  ADMIN_WHITELIST = %w[
    dev@phansch.net
  ].freeze

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create { |u| new_from_github(u, auth) }
  end

  def self.new_from_github(user, auth)
    user.email = auth.info.email
    user.nick = auth.info.nickname # assuming the user model has a name
    user.admin = true if ADMIN_WHITELIST.include?(user.email)
    user
  end
end
