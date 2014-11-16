module SetAddress
  extend ActiveSupport::Concern
  
  private

    def set_address
      if user_signed_in?
        current_user.create_billing_address unless current_user.billing_address 
        current_user.create_shipping_address unless current_user.shipping_address 
      end
    end

end