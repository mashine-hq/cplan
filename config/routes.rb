Rails.application.routes.draw do
  root to: 'visitors#index'

  resource :dashboard
  resources :departments
  resources :sections
  resources :products
  resources :statistics do
    resources :reports, only: [:index, :create]
  end


  namespace :admin do
    resources :users
    root to: "users#index"
  end

  devise_for :users, controllers: {omniauth_callbacks: 'users/omniauth_callbacks'}

  resources :users
  get '/pages/*id', to: 'pages#show'

end
