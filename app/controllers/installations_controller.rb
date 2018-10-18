# frozen_string_literal: true

require 'web_token'

class InstallationsController < ApplicationController
  def create
    i = Installation.create_from_installation_id(params.fetch(:installation_id))
    redirect_to edit_installation_path(i.id)
  end

  def edit; end
end
