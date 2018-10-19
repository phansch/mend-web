# frozen_string_literal: true

require 'test_helper'

class InstallationsControllerTest < ActionDispatch::IntegrationTest
  test 'should post create' do
    client_mock = Minitest::Mock.new
    client_mock.expect :create_app_installation_access_token, { token: 'some_token' }, ['123']

    Octokit::Client.stub(:new, client_mock) do
      get config_path, params: { setup_action: 'install', installation_id: 123 }
      assert_equal 123, Installation.last.external_id
      assert_redirected_to edit_installation_path(Installation.last)
    end
  end
end
