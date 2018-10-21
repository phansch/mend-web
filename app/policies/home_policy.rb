# frozen_string_literal: true

HomePolicy = Struct.new(:user, :home)

class HomePolicy
  def show?
    true
  end
end
