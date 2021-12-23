Rails.application.routes.draw do

  root 'static_pages#home'
  #vue-routerで設定したurlをcontrollerに割り振り
  get '/contacts', to: 'static_pages#home'
  get '/about', to: 'static_pages#home'
  get '/policy', to: 'static_pages#home'
  get '/users/new', to: 'static_pages#home'
  get '/users/:id', to: 'static_pages#home'
  get '/users/:id/edit', to: 'static_pages#home'
  get '/users/:id/answers', to: 'static_pages#home'
  get '/users/:id/answers/:id/edit', to: 'static_pages#home'
  get '/users/:id/dictionaries', to: 'static_pages#home'
  get '/login', to: 'static_pages#home'
  get '/password_resets/new', to: 'static_pages#home'
  get '/password_resets/:reset_token/edit', to: 'static_pages#home'
  get '/admin_page', to: 'static_pages#home'
  get '/course', to: 'static_pages#home'
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:edit]

  # get '/contacts', to: 'api/contacts#new'
  # get '/users/new', to: 'api/users#new'
  # get '/users/:id', to: 'api/users#show'
  # get '/users/:id/edit', to: 'api/users#edit'
  # get '/login', to: 'static_pages#home'
  # get '/password_resets/new', to: 'api/password_resets#new'
  # get '/password_resets/:reset_token/edit', to: 'api/password_resets#edit'
  # get '/admin_page', to: 'api/questions#index'
  # get '/users/:id/dictionaries', to: 'api/items#index'
  # get '/course', to: 'api/answers#new'
  # get '/users/:id/answers', to: 'api/answers#index'
  # get '/users/:id/answers/:id/edit', to: 'api/answers#edit'




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

  namespace :api, format: 'json' do
    post '/login', to: 'sessions#create'
    delete '/logout', to: 'sessions#destroy'
  end

  namespace :api, format: 'json' do
    resources :password_resets, only: [:new, :create, :edit, :update]
  end

  namespace :api, format: 'json' do
    resources :questions
  end

  namespace :api, format: 'json' do
    resources :notices, only: [:index, :show, :create, :destroy]
  end

  match '*path', :to => 'application#error404', :via => :all
end
