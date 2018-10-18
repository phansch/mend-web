# frozen_string_literal: true

require 'web_token'

# Refers to a GitHub Installation
#
# See https://developer.github.com/apps/building-github-apps/authenticating-with-github-apps/#authenticating-as-an-installation
class Installation < ApplicationRecord
  validates :external_id, presence: true
  validates :access_token, presence: true, uniqueness: true

  def self.create_from_installation_id(id)
    jwt = WebToken.new.gen
    client = Octokit::Client.new(bearer_token: jwt)
    token = client.create_app_installation_access_token(id)[:token]
    create!(external_id: id, access_token: token)
  end
end
