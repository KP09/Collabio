Rails.application.routes.draw do
  # Homepage
  root to: 'pages#home'

  # Search results
  get '/search', to: 'pages#search'

  # Users
  devise_for :users
  resources :users, except: [:index]

  # Projects
  resources :projects, except: [:index]

  # Participations
  resources :participations, only: [:create, :destroy]

  # Contributions
  resources :contributions, only: [:create, :update, :destroy]

  # Upvotes
  resources :upvotes, only: [:create, :destroy] 

end
