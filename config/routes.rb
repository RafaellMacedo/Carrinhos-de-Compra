require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  resources :products
  get "up" => "rails/health#show", as: :rails_health_check

  root "rails/health#show"

  get '/cart', to: 'carts#show'
  post '/cart', to: 'carts#add_product'

  get '/products', to: 'products#index'
  get '/products/1', to: 'products#show'
  post '/products/1', to: 'products#create'
  put '/products/1', to: 'products#update'
  patch '/products/1', to: 'products#destroy'
end
