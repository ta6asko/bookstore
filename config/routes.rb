Rails.application.routes.draw do
  

  resources :payments

  resources :deliveries

  resources :shipping_addresses

  resources :billing_addresses

  resources :addresses

  resources :line_items
  devise_for :users, :controllers => { :sessions => "sessions" }

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :books do
    resources :ratings
  end
  resources :categories
  resources :carts do
    collection do
      get 'set_cart_to_user'
    end
  end
  resources :orders do
    collection do
      get 'delivery'
      get 'payment'
      get 'confirm'
      get 'complete'
    end
  end

  root 'books#index'

  
end
