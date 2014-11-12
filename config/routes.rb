Rails.application.routes.draw do
  
  post '/rate' => 'rater#create', :as => 'rate'
  
  resources :payments do
    collection do
      get 'set_payment'
    end
  end

  resources :shipping_addresses
  resources :billing_addresses
  resources :addresses
  resources :line_items
  resources :categories
  devise_for :users, :skip => [:registrations]
    as :user do
      get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'    
      put 'users/:id' => 'devise/registrations#update', :as => 'user_registration'            
    end

  resources :users do
    patch 'update_email'
    patch 'update_password'
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

  resources :carts do
    collection do
      get 'set_cart_to_user'
      get 'check_coupon'
    end
  end
  

  resources :deliveries do
    collection do
      get 'set_delivery'
    end
  end

  resources :orders do
    collection do
      get 'confirm'
      get 'complete'
    end
  end
 
  root 'books#index'

  
end
