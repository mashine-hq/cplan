Rails.application.routes.draw do
  root to: 'visitors#index'

  resources :statistics do
    resources :reports, only: [:index, :create]
  end

  resources :departments
  namespace :admin do
    resources :users
    root to: "users#index"
  end

  devise_for :users
  resources :users
  get '/pages/*id', to: 'pages#show'
end
