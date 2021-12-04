Rails.application.routes.draw do
  
　#vue-routerで設定したurlをapi/controllerに割り振り
  get '/contacts', to: 'api/contacts#new'
  get '/users/new', to: 'api/users#new'
  get '/users/:id', to: 'api/users#show'
  get '/users/:id/edit', to: 'api/users#edit'
  get '/password_resets/new', to: 'api/password_resets#new'
  get '/password_resets/:reset_token/edit', to: 'api/password_resets#edit'
  get '/admin_page', to: 'api/questions#index'
  get '/users/:id/dictionaries', to: 'api/items#index'
  get '/course', to: 'api/answers#new'
  get '/users/:id/answers', to: 'api/answers#index'
  get '/users/:id/answers/:id/edit', to: 'api/answers#edit'

  #routing
  get '/about', to: 'static_pages#about'
  get '/policy', to: 'static_pages#policy'
  root 'static_pages#home'
  get '/signup', to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:edit]



  # API controller
  namespace :api, format: 'json' do
    resources :users
  end

  resources :users do  #answers, itemsのネストURL生成
    namespace :api, format: 'json' do
      resources :answers, only: [:index, :edit]
      resources :items, only: [:index]
    end
  end

  namespace :api, format: 'json' do
    resources :answers, only: [:new, :create, :update]
  end

  namespace :api do
    resources :items, only: [:create, :destroy]
  end

  namespace :api, format: 'json' do
    get '/guest_sign_in', to: 'guest_logins#guest_sign_in'
    post '/guest_sign_in', to: 'guest_logins#guest_sign_in'
  end

  namespace :api, format: 'json' do
    resources :contacts
  end

  namespace :api do
    post '/login', to: 'sessions#create'
    delete '/logout', to: 'sessions#destroy'
  end

  namespace :api, format: 'json' do
    resources :password_resets, only: [:new, :create, :edit, :update]
  end

  namespace :api do
    resources :account_activations, only: [ :edit ]
  end

  namespace :api, format: 'json' do
    resources :questions
  end



end
