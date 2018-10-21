# frozen_string_literal: true

require 'test_helper'

class EventPolicyTest < ActiveSupport::TestCase
  test 'create' do
    assert EventPolicy.new(nil, nil).create?
  end
end
