# frozen_string_literal: true

require 'application_system_test_case'

class LogoutTest < ApplicationSystemTestCase
  test 'logging out the current user' do
    user = users(:one)
    login_as user

    visit root_path
    click_link 'Logout'
  end
end
