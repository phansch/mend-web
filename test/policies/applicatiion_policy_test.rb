# frozen_string_literal: true

require 'test_helper'

class ApplicatiionPolicyTest < Minitest::Test
  def test_index
    refute ApplicationPolicy.new(nil, nil).index?
  end

  def test_show
    refute ApplicationPolicy.new(nil, nil).show?
  end

  def test_create
    refute ApplicationPolicy.new(nil, nil).create?
  end

  def test_new
    refute ApplicationPolicy.new(nil, nil).new?
  end

  def test_edit
    refute ApplicationPolicy.new(nil, nil).edit?
  end

  def test_update
    refute ApplicationPolicy.new(nil, nil).update?
  end

  def test_destroy
    refute ApplicationPolicy.new(nil, nil).destroy?
  end
end
