Rails.application.routes.draw do
  
  get 'omniauth_callbacks/facebook'


  post '/rate' => 'rater#create', :as => 'rate'
  
  resources :payments, only: [:edit, :update] 
  resources :shipping_addresses, only: [:edit, :update] 
  resources :billing_addresses, only: [:edit, :update]
  resources :line_items, only: [:create, :update, :destroy]
  resources :categories, only: [:index, :show] 
  resources :deliveries, only: [:edit] 

  resources :books, only: [:index, :show] do
    resources :comments, only: [:index, :new, :create] 
  end  

  resources :users, only: [:edit]  do
    patch 'update_email'
    patch 'update_password'
    patch 'destroy_user'
    patch 'settings_update_billing_address'   
    patch 'settings_update_shipping_address'
  end

  resources :orders, only: [:index, :show, :update]  do
    collection do
      get 'check_coupon'
      get 'confirm'
      get 'complete'
      get 'cart'
      delete 'empty_cart'
    end
  end
  
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  devise_for :admins, :skip => [:registrations] 

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
 
  root 'books#index'
end
