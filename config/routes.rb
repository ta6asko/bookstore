Rails.application.routes.draw do
  
  post '/rate' => 'rater#create', :as => 'rate'
  
  resources :payments do
    collection do
      get 'set_payment'
    end
  end

  resources :shipping_addresses
  resources :billing_addresses
  resources :line_items
  resources :categories
  
  devise_for :users do
    get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'    
    put 'users/:id' => 'devise/registrations#update', :as => 'user_registration' 
  end

  resources :users do
    patch 'update_email'
    patch 'update_password'
    patch 'destroy_user'
    patch 'settings_update_billing_address' 
    patch 'settings_update_shipping_address'
  end

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  resources :books do
    resources :comments do
      collection do
        get 'set_comment'
      end
    end
  end  

  resources :deliveries do
    collection do
      get 'set_delivery'
    end
  end

  resources :orders do
    collection do
      get 'set_cart_to_user'
      get 'check_coupon'
      get 'confirm'
      get 'complete'
      get 'index'
      get 'show'
      get 'cart'
    end
  end
 
  root 'books#index'

  
end
