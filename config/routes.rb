Rails.application.routes.draw do

  # welcome
  get '/' => 'welcome#index', as: 'root'

  # sessions
  get '/login' => 'sessions#new'
  resources :sessions, only: [:create]
  get '/logout' => 'sessions#destroy'

  # koala and facebook

  # users
  get '/users/:id/feed' => 'users#feed', as: 'user_feed'
  resources :users, only: [:new, :show, :edit, :create, :update, :destroy]
end
