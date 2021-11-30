Rails.application.routes.draw do

  #routing
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/policy', to: 'static_pages#policy'
  post '/guest_sign_in', to: 'static_pages#guest_sign_in'
  get '/guest_sign_in', to: 'static_pages#guest_sign_in'
  root 'static_pages#home'
  get '/signup', to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users
  resources :contacts, only: [:new]
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :questions
  resources :answers
  resources :items


  # API controller
  namespace :api, format: 'json' do
    resources :users
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

  namespace :api do
    resources :password_resets, only: [:create, :update]
  end

  namespace :api do
    resources :account_activations, only: [ :edit ]
  end

  namespace :api, format: 'json' do
    resources :answers
  end

  namespace :api, format: 'json' do
    resources :questions
  end

  namespace :api, format: 'json' do
    resources :items
  end

end
