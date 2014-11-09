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

  devise_for :users

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  resources :books do
    resources :comments do
      collection do
        get 'set_comment'
      end
    end
  end

  resources :categories

  resources :carts do
    collection do
      get 'set_cart_to_user'
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
      patch 'settings_update_billing_address' 
      patch 'settings_update_shipping_address'
    end
  end
 
  root 'books#index'

  
end
