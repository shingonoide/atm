Rails.application.routes.draw do
  get 'operations/deposit'
  get 'operations/withdraw'
  get 'operations/transfer'
  devise_for :accounts
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
