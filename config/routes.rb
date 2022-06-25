# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      resources :campaigns do
        resources :investments, except: %i(create new)
      end
      resources :investments, only: %i(create new index)
    end
  end
end
