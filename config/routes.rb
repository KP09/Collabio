Rails.application.routes.draw do
  # Homepage
  root to: 'pages#home'

  #mounting attachinary => plugin for image upload
  mount Attachinary::Engine => "/attachinary"

  #mounting Bootsy => plugin text edit
  mount Bootsy::Engine => '/bootsy', as: 'bootsy'


  # Search results
  get '/search', to: 'pages#search'

  get '/questions/:id', to: 'questions#edit', as: 'question'
  patch '/questions/:id', to: 'questions#update', as: 'answer'

  # Company namespace
  namespace :company do
    resources :dashboard, only: [:index]
    resources :projects, only: [:show]
  end

  namespace :account do
    resources :dashboard, only: [:index]
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

    #questions
    resources :questions, only: [:create]

  end

  # Upvotes
  resources :upvotes, only: [:create, :destroy]

  # Stars
  post '/contributions/:id/star', to: 'contributions#star', as: :star

end
