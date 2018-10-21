# frozen_string_literal: true

require 'event_consumer'
require 'signature_validator'

class EventsController < ApplicationController
  before_action :validate_signature

  def create
    authorize :event, :create
    event = request.env['HTTP_X_GITHUB_EVENT']
    data = request.body.read
    EventConsumer.new(event, data).eat
    head 202
  end

  private

  def validate_signature
    head 401 unless SignatureValidator.validate(
      request.env['HTTP_X_HUB_SIGNATURE'],
      request.body.read
    )
  end
end
