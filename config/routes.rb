Rails.application.routes.draw do

  # welcome
  get '/'               => 'welcome#index', as: 'root'

  # sessions
  get '/login'          => 'sessions#new'
  resources :sessions, only: [:create]
  get '/logout'         => 'sessions#destroy'

  # users
  get '/users/:id/feed' => 'users#feed', as: 'user_feed'
  resources :users, only: [:new, :show, :edit, :create, :update, :destroy] do
      get '/fb_access'  => 'facebook#access_token'
  end

  # Test login
  get '/test_login'     => 'tests#new'
  resources :tests, only: [:create]
  get '/test_logout'    => 'tests#destroy'

end
