# frozen_string_literal: true

require 'test_helper'

class InstallationTest < ActiveSupport::TestCase
  test '.create_from_installation_id' do
    client_mock = Minitest::Mock.new
    client_mock.expect :create_app_installation_access_token, { token: 'some_token' }, [1]
    Octokit::Client.stub(:new, client_mock) do
      assert_difference -> { Installation.count }, 1 do
        Installation.create_from_installation_id(1)
      end
      assert_equal 1, Installation.last.external_id
      assert_equal 'some_token', Installation.last.access_token
    end
  end

  test '.find_in_github' do
    client_mock = Minitest::Mock.new
    client_mock.expect(
      :find_installations,
      [{ app_id: 123 }],
      [{ accept: 'application/vnd.github.machine-man-preview+json' }]
    )
    Octokit::Client.stub(:new, client_mock) do
      result = Installation.find_in_github(123)
      assert_equal({ app_id: 123 }, result)
    end
  end
end
