# frozen_string_literal: true

EventPolicy = Struct.new(:user, :create)

class EventPolicy
  def create?
    true
  end
end
