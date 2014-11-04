module SetAddress
  extend ActiveSupport::Concern
  
  private

    def set_billing_address
      @billing_address = current_user.billing_address
      if @billing_address == nil
        @billing_address = current_user.create_billing_address
      end
    end

    def set_shipping_address
      @shipping_address = current_user.shipping_address
      if @shipping_address == nil
        @shipping_address = current_user.create_shipping_address
      end
    end
end