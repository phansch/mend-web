# frozen_string_literal: true

# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  namespace :admin do
    resources :users

    root to: 'users#index'
  end

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  devise_scope :user do
    get 'sign_in', to: 'devise/sessions#new', as: :new_user_session
    get 'sign_out', to: 'devise/sessions#destroy', as: :destroy_user_session
  end

  post '/event_receiver', to: 'events#create'
  get '/config', to: 'installations#create', constraints: { setup_action: 'install' }
  get '/config', to: 'installations#update', constraints: { setup_action: 'update' }
  resources :installations, only: :edit

  root to: 'home#show'
end
