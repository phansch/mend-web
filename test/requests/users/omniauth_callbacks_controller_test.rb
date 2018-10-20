# frozen_string_literal: true

require 'test_helper'
require 'minitest/mock'

module Users
  class OmniauthCallbacksControllerTest < ActionDispatch::IntegrationTest
    def fakeauth(email = 'foo@example.com')
      OpenStruct.new(
        provider: 'github',
        uid: '123456',
        info: OpenStruct.new(
          email: email,
          nickname: 'foo'
        )
      )
    end

    test 'if user is new should redirect to HOST' do
      Installation.stub(:find_in_github, {}) do
        get user_github_omniauth_callback_path, headers: {
          'omniauth.auth' => fakeauth,
          'devise.mapping' => Devise.mappings[:user]
        }
      end
      assert_redirected_to root_path
    end

    test 'if user already exists should redirect to root_path' do
      User.from_omniauth(fakeauth)

      Installation.stub(:find_in_github, {}) do
        get user_github_omniauth_callback_path, headers: {
          'omniauth.auth' => fakeauth,
          'devise.mapping' => Devise.mappings[:user]
        }
      end
      assert_redirected_to root_path
    end

    test 'if user does not have an installation yet' do
      User.from_omniauth(fakeauth)

      Installation.stub(:find_in_github, nil) do
        get user_github_omniauth_callback_path, headers: {
          'omniauth.auth' => fakeauth,
          'devise.mapping' => Devise.mappings[:user]
        }
      end
      assert_redirected_to 'https://github.com/apps/mend-rs-dev2/installations/new'
    end

    test 'if user could not be saved should redirect to root_path' do
      unpersisted_user = User.new
      User.stub(:from_omniauth, unpersisted_user) do
        get user_github_omniauth_callback_path, env: {
          'omniauth.auth' => fakeauth,
          'devise.mapping' => Devise.mappings[:user]
        }
      end
      assert_redirected_to root_path
    end
  end
end
