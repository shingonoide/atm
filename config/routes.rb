Rails.application.routes.draw do
  # get 'operations/deposit'
  # post 'operations/deposit_create'
  # get 'operations/withdraw'
  # get 'operations/transfer'
  get 'operations', to: 'operations#index'

  namespace :operations do
    resources :deposits, only: [:show, :new, :create]
  end

  devise_for :accounts
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
