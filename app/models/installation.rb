# frozen_string_literal: true

require 'web_token'
require 'octokit'

# Refers to a GitHub Installation
#
# See https://developer.github.com/apps/building-github-apps/authenticating-with-github-apps/#authenticating-as-an-installation
class Installation < ApplicationRecord
  validates :external_id, presence: true
  validates :access_token, presence: true, uniqueness: true

  belongs_to :user
  # client.list_app_installation_repositories

  def self.create_from_installation_id(id, user)
    jwt = WebToken.new.gen
    client = Octokit::Client.new(bearer_token: jwt)
    token = client.create_app_installation_access_token(id)[:token]
    create!(external_id: id, access_token: token, user: user)
  end

  def self.find_in_github(installation_id)
    jwt = WebToken.new.gen
    client = Octokit::Client.new(bearer_token: jwt)
    client.find_installations(accept: 'application/vnd.github.machine-man-preview+json').find do |i|
      i[:app_id] == installation_id
    end
  end
end
