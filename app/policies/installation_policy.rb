# frozen_string_literal: true

class InstallationPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def create?
    user&.persisted?
  end

  def edit?
    user&.persisted?
  end
end
