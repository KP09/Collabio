Rails.application.routes.draw do
  # Homepage
  root to: 'pages#home'

  #mounting attachinary => plugin for image upload
  mount Attachinary::Engine => "/attachinary"


  # Search results
  get '/search', to: 'pages#search'

  get '/questions/:id', to: 'questions#edit', as: 'question'
  patch '/questions/:id', to: 'questions#update', as: 'answer'

  # Users
  devise_for :users
  resources :users, except: [:index]

  # Projects
  resources :projects, except: [:index] do

    #questions
    resources :questions, only: [:create]

    # Participations
    resources :participations, only: [:create]
    delete 'participations' => 'participations#destroy', as: 'participation'

    # Contributions
    resources :contributions, only: [:create, :update, :destroy]

  end

  # Upvotes
  resources :upvotes, only: [:create, :destroy]

end
