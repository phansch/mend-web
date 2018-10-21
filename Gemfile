# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.2'

gem 'dotenv-rails'
gem 'faktory_worker_ruby', require: false
gem 'octokit', require: false
gem 'pg'
gem 'puma', '~> 3.11'
gem 'rails', '~> 5.2.1'

# Authentication and Authorization
gem 'devise'
gem 'jwt', require: false
gem 'omniauth-github', github: 'intridea/omniauth-github'
gem 'pundit'

# Frontend
gem 'active_link_to'
gem 'administrate'
gem 'bootstrap', '~> 4.1.3'
gem 'haml-rails'
gem 'sass-rails', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  gem 'cane', require: false
  gem 'pry-byebug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'

  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  gem 'guard'
  gem 'guard-minitest'
  gem 'guard-rubocop'

  # Linters
  gem 'brakeman', require: false
  gem 'bundle-audit', require: false
  gem 'haml-lint', require: false
  gem 'rubocop', require: false
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper'

  gem 'minitest-focus'
  gem 'simplecov', require: false
  gem 'webmock', require: false
end
