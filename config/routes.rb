Rails.application.routes.draw do
  resources :tags
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show]
  resources :tasks
  root 'sessions#new' 
  namespace :admin do
    resources :users
  end
end
