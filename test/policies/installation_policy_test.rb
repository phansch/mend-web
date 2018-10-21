# frozen_string_literal: true

require 'test_helper'

class InstallationPolicyTest < ActiveSupport::TestCase
  test 'create_without_user' do
    refute InstallationPolicy.new(nil, nil).create?
  end

  test 'create_with_unpersisted_user' do
    refute InstallationPolicy.new(User.new, nil).create?
  end

  test 'create_with_persisted_user' do
    user = users(:one)
    assert InstallationPolicy.new(user, nil).create?
  end

  test 'edit without user' do
    refute InstallationPolicy.new(nil, nil).edit?
  end

  test 'edit with unpersisted user' do
    refute InstallationPolicy.new(User.new, nil).edit?
  end

  test 'edit with persisted user' do
    assert InstallationPolicy.new(users(:one), nil).edit?
  end
end
