Rails.application.routes.draw do
  # get 'operations/deposit'
  # post 'operations/deposit_create'
  # get 'operations/withdraw'
  # get 'operations/transfer'
  get 'operations', to: 'operations#index'

  get :statements, to: 'statements#index'

  namespace :operations do
    resources :deposits, only: [:show, :new, :create]
    resources :withdraws, only: [:show, :new, :create]
    resources :transfers, only: [:new, :create]
  end

  devise_for :accounts
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "operations#index"
end
