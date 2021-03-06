Rails.application.routes.draw do
  root 'main#index'
  get '/signup', to: "users#new"
  post '/signup', to: 'users#create'
  get 'search', to: 'alerts#search'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/xalert', to: 'alerts#destroy'
  delete '/logout', to: 'sessions#destroy'
  resources 'alerts'
  resources 'users'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
