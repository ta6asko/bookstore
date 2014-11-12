module SetAddress
  extend ActiveSupport::Concern
  
  private

    def set_address
      if user_signed_in?
        current_user.billing_address = current_user.create_billing_address if @billing_address == nil
        current_user.shipping_address = current_user.create_shipping_address if @shipping_address == nil
      end
    end

end