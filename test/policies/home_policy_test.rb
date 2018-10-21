# frozen_string_literal: true

require 'test_helper'

class HomePolicyTest < Minitest::Test
  def test_show
    assert HomePolicy.new.show?
  end
end
