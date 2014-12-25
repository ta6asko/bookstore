class Ability
  include CanCan::Ability

  def initialize(user)
    can [:index, :show], [Book, Category]
    can [:edit, :update], BillingAddress do |address|
      address.try(:user) == user
    end
    can [:edit, :update], ShippingAddress do |address|
      address.try(:user) == user
    end
    can [:edit, :update], Payment do |address|
      address.try(:user) == user
    end
    can [:edit], Delivery 
    can [:create, :update, :destroy], LineItem 
    can [:cart, :empty_cart, :update, :index, :show], Order
    can [:confirm, :complete, :check_coupon], Order do |order|
      order.try(:user) == user
    end
    can [:index, :new, :create], Comment  
    can [:edit, :settings_update_billing_address, :settings_update_shipping_address, :update_email, :update_password, :destroy_user], User do |us|
      us == user
    end   
  end
end
