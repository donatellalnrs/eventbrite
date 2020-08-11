Rails.application.routes.draw do
  devise_for :users
  
  resources :events
  get '/home', to: 'events#index'

  resources :users, only: [:show]
end
