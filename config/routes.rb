Rails.application.routes.draw do

  # welcome
  get '/'                       => 'welcome#index', as: 'root'

  # sessions
  get '/login'                  => 'sessions#new'
  resources :sessions,          only: [:create]
  get '/logout'                 => 'sessions#destroy'

  # users
  get '/users/:id/feed'         => 'users#feed', as: 'user_feed'
  resources :users,             only: [:new, :show, :edit, :create, :update, :destroy] do
    resources :friends,           only: [:index, :create] do
      get '/search'               => 'friends#search', as: 'friends_search'
    end

    resources :friend_requests,   only: [:index, :create]
    get '/fb_access'              => 'facebook#access_token'
  end
  get '/fb_error'               => 'facebook#fb_user_error', as: 'fb_user_error'

  resources :friends,           only: [:destroy]
  resources :friend_requests,   only: [:destroy]

end
