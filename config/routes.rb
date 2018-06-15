Rails.application.routes.draw do
  root 'top#index'
  resources :users
  resources :teams
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
end
