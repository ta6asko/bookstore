Rails.application.routes.draw do
  

  devise_for :users
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :books do
    resources :ratings
  end
  resources :categories
  resources :cart

  
  
  
  

  root 'books#index'

  
end
