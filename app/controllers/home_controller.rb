# frozen_string_literal: true

class HomeController < ApplicationController
  def show
    authorize :home, :show?
  end
end
