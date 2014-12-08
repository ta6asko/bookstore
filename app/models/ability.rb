class Ability
  include CanCan::Ability

  def initialize(user)
    can [:edit, :update], BillingAddress do |address|
      address.try(:user) == user
    end
    can [:edit, :update], ShippingAddress do |address|
      address.try(:user) == user
    end
    can [:index, :show], [Book, Category]
    can [:edit], [Delivery] 
    can [:edit, :update], Payment do |payment|
      payment.try(:user) == user
    end
    can [:create, :destroy], LineItem
    can [:cart, :destroy], Order
    can [:index, :show, :confirm, :complete, :check_coupon], Order do |order|
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
