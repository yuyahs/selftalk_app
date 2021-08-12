Rails.application.routes.draw do
  get 'users/new'
  get 'static_pages/home'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/policy', to: 'static_pages#policy'
  root 'static_pages#home'
  get '/signup', to: 'users#new'
  resources :users


end
