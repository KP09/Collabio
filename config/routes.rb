Rails.application.routes.draw do
  # Homepage
  root to: 'pages#home'

  #mounting attachinary => plugin for image upload
  mount Attachinary::Engine => "/attachinary"


  # Search results
  get '/search', to: 'pages#search'

  # Company namespace
  namespace :company do
    resources :dashboard, only: [:index]
    resources :projects, only: [:show]
  end

  # Users
  devise_for :users
  resources :users, except: [:index]

  # Projects
  resources :projects, except: [:index] do

    # Participations
    resources :participations, only: [:create]
    delete 'participations' => 'participations#destroy', as: 'participation'

    # Contributions
    resources :contributions, only: [:create, :update, :destroy]

  end

  # Upvotes
  resources :upvotes, only: [:create, :destroy]

end
