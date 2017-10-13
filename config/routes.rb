Rails.application.routes.draw do
  root 'sessions#index'
  get '/dashboard', to: "alerts#index"
  get '/signup', to: "users#new"
  post '/signup', to: 'users#create'
  get 'about', to: "static#about", as: "about"
  get 'search', to: 'alerts#search'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users do
    resources :alerts, shallow: true
  end
end
	