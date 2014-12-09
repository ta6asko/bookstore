class Ability
  include CanCan::Ability

  def initialize(user)
    can [:edit, :update], BillingAddress 
    can [:edit, :update], ShippingAddress 
    can [:edit, :update], Payment
    can [:index, :show], [Book, Category]
    can [:edit], Delivery 
    can [:create, :destroy], LineItem
    can [:cart, :empty_cart, :update, :index], Order
    can [:show, :confirm, :complete, :check_coupon], Order do |order|
      order.try(:user) == user
    end
    can [:index, :new, :create], Comment do |comment|
      comment.try(:user) == user
    end
    can [:show, :settings_update_billing_address, :settings_update_shipping_address, :update_email, :update_password, :destroy_user], Users do |us|
      us.try(:user) == user
    end   
  end
end
