Rails.application.routes.draw do
  get 'sessions/new'

  get 'sessions/new'
  
  root to: 'plans#top'
  
  resources :sessions, only: [:new, :create, :destroy]

  resources :plans do
    collection do
      post :confirm
      get :top
    end
  end

  resources :users, only: [:new, :create, :show]
  
  resources :favorites, only: [:create, :destroy]

  resources :reviews, only: [:new, :create]
  
  # mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
