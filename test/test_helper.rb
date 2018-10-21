# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
ENV['TEST_RUN'] ||= 'true'

require 'simplecov'

SimpleCov.start 'rails' do
  add_filter 'lib/tasks/lint.rake'
  add_filter 'app/jobs/application_job.rb'
  add_filter 'app/controllers/application_controller.rb'
  add_filter 'app/mailers/application_mailer.rb'
  add_filter 'app/channels/application_cable/channel.rb'
  add_filter 'app/channels/application_cable/connection.rb'
  add_filter 'app/dashboards/'
  add_filter 'app/controllers/admin/'
end

require 'minitest/focus'
require 'webmock/minitest'
require_relative '../config/environment'
require 'rails/test_help'

module AroundEachTest
  def before_setup
    OmniAuth.config.test_mode = true
    super
  end
end

module ActiveSupport
  class TestCase
    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    include AroundEachTest
  end
end

module ActionDispatch
  class IntegrationTest
    include AroundEachTest
  end
end
