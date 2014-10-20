Rails.application.routes.draw do
  
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :books do
    collection do
      get "home"
      get "shop"
    end
  end

  root 'books#index'

  
end
