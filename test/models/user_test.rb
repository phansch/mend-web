# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'can create user' do
    User.create(email: 'abc')
  end
end
