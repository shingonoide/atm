Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get 'operations', to: 'operations#index'

  get :statements, to: 'statements#index'

  namespace :operations do
    resources :deposits, only: [:show, :new, :create]
    resources :withdraws, only: [:show, :new, :create]
    resources :transfers, only: [:show, :new, :create]
  end

  devise_for :accounts

  # Defines the root path route ("/")
  root "operations#index"
end
