Rails.application.routes.draw do
  

  resources :line_items

  devise_for :users
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :books do
    resources :ratings
  end
  resources :categories
  resources :carts
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
