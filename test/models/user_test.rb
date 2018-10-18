# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
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

  test '.from_omniauth' do
    user = User.from_omniauth(fakeauth)
    assert user.persisted?
  end

  test '.from_omniauth as admin' do
    user = User.from_omniauth(fakeauth('dev@phansch.net'))
    assert user.admin?
  end

  test '.from_omniauth already existing' do
    User.from_omniauth(fakeauth('dev@phansch.net'))
    User.from_omniauth(fakeauth('dev@phansch.net'))
    assert_equal 1, User.count
  end
end
