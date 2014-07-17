Rails.application.routes.draw do

  # welcome
  get '/'                       => 'welcome#index', as: 'root'

  # sessions
  get '/login'                  => 'sessions#new'
  get '/logout'                 => 'sessions#destroy'
  resources :sessions,          only: [:create]


  # users
  get '/users/:id/feed'         => 'users#feed', as: 'user_feed'
  resources :users,             only: [:new, :show, :edit, :create, :update, :destroy] do

    #events collection
    resources :events,          only: [:index, :new, :create]

    # gifts collection
    resources :gifts,           only: [:index, :new, :create]

    # friends collection
    resources :friends,         only: [:index, :create]
    get 'friends/search'        => 'friends#search', as: 'friend_search'

    # friend_requests collections
    resources :friend_requests, only: [:index, :create]

    # extra
    get '/fb_access'            => 'facebook#access_token'
  end



  resources :events,            only: [:show, :edit, :update, :destroy]

  # gifts member
  get '/gifts/search'           => 'gifts#search', as: 'gifts_search'
  resources :gifts,             only: [:show, :edit, :update, :destroy] do
      put '/claim'              => 'gifts#claim', as: 'claim'
      delete '/cancel'          => 'gifts#cancel', as: 'cancel'
  end

  # friends member
  resources :friends,           only: [:destroy]

  # friend_requests
  resources :friend_requests,   only: [:destroy]

  # extras
  get '/fb_error'               => 'facebook#fb_user_error', as: 'fb_user_error'

end
