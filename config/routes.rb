Rails.application.routes.draw do
  devise_for :users
  
  resources :events
  get '/home', to: 'events#index'

  resources :users, only: [:show]

  resources :events do 
    resources :attendances
  end 

  resources :charges

  resources :events do
    resources :event_pictures, only: [:create]
  end
end
